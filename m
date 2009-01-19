From: Neil Macneale <mac4@theory.org>
Subject: Re: [HELP] A local branch has disappeared
Date: Sun, 18 Jan 2009 21:37:54 -0800
Message-ID: <A9C9E16F-B1CC-4E0A-AEF1-426ABEF60BDF@theory.org>
References: <488807870901181954p558756f5v94c8a6681125e8bb@mail.gmail.com>
Reply-To: Neil Macneale <mac4-git@theory.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johnny Lee <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 06:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmwz-0005pY-0x
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbZASFoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZASFoE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:44:04 -0500
Received: from in.theory.org ([64.147.163.250]:50021 "EHLO tesla.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522AbZASFoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:44:01 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 00:44:01 EST
Received: from tesla.theory.org (localhost [127.0.0.1])
	by tesla.theory.org (Postfix) with ESMTP id 2114824C16D;
	Sun, 18 Jan 2009 21:37:55 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tesla.theory.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.4
Received: from [10.0.1.200] (c-76-28-158-148.hsd1.wa.comcast.net [76.28.158.148])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by tesla.theory.org (Postfix) with ESMTP;
	Sun, 18 Jan 2009 21:37:55 -0800 (PST)
In-Reply-To: <488807870901181954p558756f5v94c8a6681125e8bb@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
X-Envelope-From: <mac4@theory.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106326>


On Jan 18, 2009, at 7:54 PM, Johnny Lee wrote:

> Hi all,
>
> Today I found my current branch (named cupcake) has disappeared.
> git@tomato:~/golf$ git branch -a
>  htc_cupcake
>  tmo_cupcake
>  origin/HEAD
>  origin/cupcake
>  origin/device
>
> As you can see, there is no "*" to mark the current branch.
>
> But when I check the HEAD, it still pointed to the cupcake branch
> git@tomato:~/golf$ cat .git/HEAD
> ref: refs/heads/cupcake
>
> But when I check the ref/heads, the cupcake is missing
> git@tomato:~/golf$ ls .git/refs/heads/
> htc_cupcake  tmo_cupcake
>
> And the cupcake in still in the config:
> git@tomato:~/golf$ cat .git/config
> [core]
>        repositoryformatversion = 0
>        filemode = true
>        bare = false
>        logallrefupdates = true
>        sharedRepository = 1
> [remote "origin"]
>        url = /home/rick/golfresort/device/.git
>        fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "cupcake"]
>        remote = origin
>        merge = refs/heads/cupcake
>
> I'm confused:
> 1. I didn't do any aggressive operations. Why the branch has
> disappeared? Normally I have done these operation for this repo:
>   i. pull from parent repo
>   ii. cloned by children repo
>   iii. pulled by children repo
>   iv. pushed from children repo
> 2. Is there any way to resume the cupcake branch? Can I manually add
> the cupcake to ref/heads?

I don't know why the cupcake branch would be gone, but you can  
probably get something from the logs:

$ cat .git/logs/refs/heads/cupcake

The last line should tell you what commit you were at before it was  
destroyed. Then you can create the branch again.

$ git checkout -b cupcake <hash in the log>

Hope that helps,
Neil
