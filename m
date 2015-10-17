From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: submodule: allow submodule directory in gitignore
Date: Sat, 17 Oct 2015 20:46:51 +0800
Message-ID: <CANYiYbHNX+j6BPahWdGQ2qVbvBV-wd-Bi=ZjDmRfbXCsboNXpg@mail.gmail.com>
References: <561B5372.7040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Aleksey Komarov <leeeeha@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 14:46:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnQsz-0007nN-VW
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 14:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbbJQMqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 08:46:53 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32998 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbJQMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 08:46:52 -0400
Received: by wijp11 with SMTP id p11so42787207wij.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xFXZiRuo/FWclFwfTCj+esyn7IjAmrJy0J8xoR+25Mg=;
        b=xoblt92IVCPWqa+Z+8ns7Toll30yOXWRWIoDWnwmdhOZ3+/0yspmYBVyAqsy+a5vbf
         3SpXYcINMzMuqk1vrbivrlaeLcXOdY70umycQbZDAenEJx6Wl7f8dGMpKP9kIRddsYu8
         /fFY0bHCtQtO7aKFqxThsNi9FiopeAi/Dx5YcLdtkXs2z6GNo3anuqGQRhPjT7xKchmb
         ffhFSlYunsnXkpR4G1AD8J+WJWTWzrWwUIuXwRlAahNfXOwVKuuUtHJdCLzqC9eI/bcP
         Lbl7uOU0H4yhAR6qxlyss4FBTLb/n2tOesM13pIIWhptISvMYx5VvELmiZbPMZ8s4DpJ
         8rcQ==
X-Received: by 10.195.12.164 with SMTP id er4mr23174855wjd.9.1445086011451;
 Sat, 17 Oct 2015 05:46:51 -0700 (PDT)
Received: by 10.194.246.193 with HTTP; Sat, 17 Oct 2015 05:46:51 -0700 (PDT)
In-Reply-To: <561B5372.7040508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279788>

2015-10-12 14:30 GMT+08:00 Aleksey Komarov <leeeeha@gmail.com>:
> Hi all!
>
> I'm sorry if the letter came twice. I have troubles with my post client.
>
> I want to organize my repository so its submodules would be located at the root
> of repository. I'm trying to create .gitignore to ignore all files and don't
> ignore directories at the same time:
>
> $ cat .gitignore
> *
> !*/
>
> Now, I'm trying to add a submodule to my repository, but fail to understand why
> my .gitignore prevents it from being added. I use the following command to check
> if my submodule will be ignored or not:
>
> $ git add --dry-run --ignore-missing c/
>
> I have noticed that result of this check is different when directory c/ already
> exists and when it still doesn't by the time of the check.
> The described behavior is illustrated by the following example:
>
> $ mkdir git_test
> $ cd git_test
> $ git init
> Initialized empty Git repository in D:/temp/git_test/.git/
> $ echo \* >> .gitignore
> $ echo \!\*\/ >> .gitignore
> $ git add --dry-run --ignore-missing c/
> The following paths are ignored by one of your .gitignore files:
> c/
> Use -f if you really want to add them.
> $ mkdir c
> $ git add --dry-run --ignore-missing c/
> $
>

To check how an entry (c/) is affected by .gitignore in different cases,
you can try this command:

    $ git check-ignore -v c/
