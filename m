From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: File info from SHA ID
Date: Thu, 3 Apr 2008 10:16:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804031009280.14670@woody.linux-foundation.org>
References: <47F50CC5.20502@melosgmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 19:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhT6K-0006Xw-43
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 19:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbYDCRRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbYDCRRF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 13:17:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35596 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760877AbYDCRRD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 13:17:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m33HGUio022458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Apr 2008 10:16:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m33HGTuF013371;
	Thu, 3 Apr 2008 10:16:30 -0700
In-Reply-To: <47F50CC5.20502@melosgmbh.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.387 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78764>



On Thu, 3 Apr 2008, Christoph Duelli wrote:
>
> Given (only) a SHA ID (say from a file's $ID$ expansion), is it possible to
> determine the file's name, date of commit etc?

Not directly, no.

But you can get it indirectly with a number of variations on

	git whatchanged --raw --no-abbrev

and then just searching for that SHA1 ID in the result. That will also 
show you where in the history that SHA1 came to be or went away.

The SHA1 itself is _purely_ about the actual contents of the file, so it 
has no bearing on where that file actually exists, and two identical files 
in different places will have the same SHA1. So no SHA1 -> filename 
mapping can exist, but you can figure out where in the tree or history it 
existed if you just have the full repository.

			Linus
