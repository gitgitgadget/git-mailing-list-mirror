From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 12:20:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805111218520.3188@woody.linux-foundation.org>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>  <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>  <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>  <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
  <524f69650805110953t6561ff84t1867681bea093d35@mail.gmail.com>  <alpine.LFD.1.10.0805110957530.3330@woody.linux-foundation.org> <524f69650805111048v6033c2eajb7cc22b9c4fa6bc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve French <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 21:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvH6x-0005q8-3B
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbYEKTUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 15:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbYEKTUj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 15:20:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52243 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755474AbYEKTUj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 15:20:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BJKZSs032752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 May 2008 12:20:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BJKYdJ019826;
	Sun, 11 May 2008 12:20:35 -0700
In-Reply-To: <524f69650805111048v6033c2eajb7cc22b9c4fa6bc0@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.922 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81815>



On Sun, 11 May 2008, Steve French wrote:
>
> The rebase did fix up the obsolete commits ... but I still get the
> "warn: No branch of ..." message.  I think that will go away when
> there is another newer commit  in your tree.  It doesn't seem to be a
> problem - the list of commits is right.  See below:

No, see the warnings - they tell you exactly what the problem is:

> [sfrench@hera cifs-2.6]$ git-request-pull origin
> git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
> warn: No branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git is
> at:
> warn:   e691b9d: [CIFS] don't allow demultiplex thread to exit until
> kthread_stop is called
> warn: Are you sure you pushed HEAD there?

In other words: you didn't push the thing out to your public tree, so it 
says: "warn: Are you sure you pushed HEAD there?"

IOW, if I were to pull, I wouldn't actually get any of it, because you 
didn't push it out yet, which is why it says it hasn't been verified!

		Linus
