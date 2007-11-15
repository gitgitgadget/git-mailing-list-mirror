From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 14:01:26 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsmnH-0008RY-NI
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbXKOWCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbXKOWCY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:02:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33181 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765211AbXKOWCX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:02:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFM1Q28001431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 14:01:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFM1QZa017961;
	Thu, 15 Nov 2007 14:01:26 -0800
In-Reply-To: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65169>



On Thu, 15 Nov 2007, Jason Sewall wrote:
>
> find . -type f -exec dos2unix {} +

Oops.

You just ran "dos2unix" on all the *git* files!

Which certainly explains why all your old objects got corrupted!

> What's going on?

PEBKAC ;)

To avoid this error in the future, may I suggest using

	git ls-files -z | xargs -0 dos2unix

or similar. Please DO NOT write to the .git/objects directory.

		Linus
