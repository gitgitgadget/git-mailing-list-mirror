From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Sat, 12 Nov 2011 12:32:34 +0400
Message-ID: <20111112123234.17ab4426@zappedws>
References: <1321044904175-6986736.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 09:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP915-0000Nt-7K
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 09:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab1KLIcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 03:32:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53736 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1KLIcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 03:32:41 -0500
Received: by bke11 with SMTP id 11so4013498bke.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 00:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=60psm+PcZUte+O7epGv8r7CGpQa/8inKeVNO/VR5IuU=;
        b=XLoaE3uVuxtIrbAgZwroPbHIYejq5z3AvHGklphBVesgLU5O8ULLhKTmcPsvI3enqo
         r+wOY0eBJk6VFjXO+U1pXvLMw4IVA+iulX+bAimPtK5wt/5axAV/LkXqLFwoS5qgwqe9
         LwlSWIeSp6PPTrjcG6X3Siuw09+8zqNBNOXis=
Received: by 10.204.155.141 with SMTP id s13mr11147896bkw.40.1321086758537;
        Sat, 12 Nov 2011 00:32:38 -0800 (PST)
Received: from zappedws (ppp91-77-47-119.pppoe.mtu-net.ru. [91.77.47.119])
        by mx.google.com with ESMTPS id z15sm16479530bkv.4.2011.11.12.00.32.36
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Nov 2011 00:32:37 -0800 (PST)
In-Reply-To: <1321044904175-6986736.post@n2.nabble.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185305>

the same situation and question were discussed and explained one
month earlier
take a look
http://thread.gmane.org/gmane.comp.version-control.git/183464

> Unexpected git behaviour
> 
> ---
> # First create a local git repo
> 
> $mkdir gitexample
> $git config --global user.name "my name"
> $git config --global user.email "me@me.com"
> $git init
> $git add .
> $git commit -m 'initial commit'
> 
> # Create/Edit an empty file
> $vi readme.txt
> 
> # add a single line: "this was added in the master branch."
> $git commit -a
> 
> # create and checkout a new branch (from master)
> $git branch test
> $git checkout test
> 
> # edit the readme.txt file and do not commit
> # add the text:  "this was added in the test branch.", save and exit
> $vi readme.txt
> 
> #now switch back to master
> $git checkout master
> $cat readme.txt
> 
> #You will see both lines in the master.  
> 
> Question #1:
> 	Why was this line added in the *master branch?
> 
> 
> --- even further surprising
> In the master branch, now do a commit
> $git commit -a
> 
> cat readme.txt ( you will see the line in the master now that was
> added in the test branch )
> 
> Question #2:
> 	Why did this happen?
> 
> # Now switch back to the test branch
> $git checkout test
> $cat readme.txt
> 
> You will only see the one line: "This was added in the master branch"
> 
> Question #3:
> 	Why did this happen?
> 
> and NOT the line added in that branch: "this was added in the test
> branch" <= this line is gone
> 
> What is the reason for this?
> 
> 1) Why do I see uncommitted changes in the branches made off master
> in the master branch?
> 2) Why, if I commit them in the master, do the disappear in the
> branch in which they were made?
> 
> This is confusing, I would think the * master branch would be left
> untouched.  This would solve issue #2.
> 
> 
> --
> View this message in context:
> http://git.661346.n2.nabble.com/Git-Unexpected-behaviour-tp6986736p6986736.html
> Sent from the git mailing list archive at Nabble.com.
