From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git pull" throws away dirty state
Date: Sun, 16 Mar 2008 11:24:59 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaxZB-0001ww-PM
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 19:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYCPSZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYCPSZ4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 14:25:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45170 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134AbYCPSZz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 14:25:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GIQ5HV032052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 11:26:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GIOxJ2008003;
	Sun, 16 Mar 2008 11:25:00 -0700
In-Reply-To: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.294 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77369>



On Sun, 16 Mar 2008, Linus Torvalds wrote:
> 
> Ok, this is distressing, and I suspect it's another bug of mine due to 
> unpack-trees changes, but before I delve into it deeper I thought I'd 
> report it here and see if others see it too, and maybe it's due to 
> something else..

Nope, I bisected it down to

	34110cd4e394e3f92c01a4709689b384c34645d8 is first bad commit

	Make 'unpack_trees()' have a separate source and destination index

and I'm trying to figure out what part of that triggered this bug.

		Linus
