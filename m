From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 10:02:43 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com> 
 <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
 <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, ae@op5.se,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYCu-0004sc-AX
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbXKISC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXKISC7
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:02:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52019 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755234AbXKISC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 13:02:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9I2je0015746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 10:02:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9I2hCJ025391;
	Fri, 9 Nov 2007 10:02:44 -0800
In-Reply-To: <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64235>



On Fri, 9 Nov 2007, Yossi Leybovich wrote:
> 
> Ok, tried that and unfortuantly the SHA1 number is apear only one
> 
> [mellanox@mellanox-compile ib]$ git log --raw --all --full-history --
> SymmK/St.c  | grep 4b9
> :100755 100755 308806c... 4b9458b3786228369c63936db65827de3cc06200 M  SymmK/St.c

Actually, that's not at all "unfortunately", because that implies that 
it's the very *latest* version of that "SymmK/St.c" file. I really think 
you already had it checked out, but didn't try my first suggestion of just 
doing "git hash-object -w SymmK/St.c" which likely would have fixed it 
already (unless you had changed it in your working tree, of course!)

		Linus
