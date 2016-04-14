From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Cannot checkout a branch / worktree shows multiple branches for
 the same directory
Date: Thu, 14 Apr 2016 19:12:10 -0400
Message-ID: <CAPig+cQXxOLg37au9FQcCC_+=QFnvBRdG6OLBFOTeb5V6rjCiA@mail.gmail.com>
References: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Krzysztof Voss <k.voss@usask.ca>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:12:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqqQs-0003v3-S1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 01:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbcDNXMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 19:12:13 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:32871 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbcDNXML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 19:12:11 -0400
Received: by mail-ig0-f195.google.com with SMTP id g8so872381igr.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=7vuQCdifYJAxYANEcCsBgj8BmzqRZD2nHJvfmnyGLXg=;
        b=ZdnwNjq2jqyBOufLhGr6+RSILm+Aziw9VqMGEEvKvAyiAn0wKrCU+Gi2dYaAPrDkiq
         KZX/+o0WZM0+8m+Y3nxDyGCgCEXt+4Jok6J1pW4xy8a33OFyvuzKSXiUPwDs+tzqqGF3
         jxGb5u+AvQa7Fv2eBQaWKf23jmpFiDrTWrhN5NH3Y92muaZrcJh5bT4ZwERKeWw9CHmp
         VY8KVBbe5hkYm2HRHhXeWCnYCXSkINPoKfYBDcnJ+gm+Rvu0ndKeDkapVuvkKjfglgkX
         oi9y3Edn9gLMZN7/p+yK6DgIcj21Dp0+6KKM4/B5gxko7PTQwcD5j72MvPGJoPCYrut1
         yafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7vuQCdifYJAxYANEcCsBgj8BmzqRZD2nHJvfmnyGLXg=;
        b=jIaY6HohsKPvOLfYtLH0ytnuZyR+Qe7RVllNdgEfprNkDzuZfGP+7DNc+KPpn98np4
         v7X1os83TsA0fBFSgjAZrwZQGxeyF8+Rk1SuJyWrt00daS2Dm0oSpZxd1Up9SxebZYgK
         L2c/COiqgs6+xV9HKJNBc1bWYfLkCpBE73NbguMztau4ocL17ooW8EXxSFXVaoAScJPz
         8ziYeyJ6dxzUM0cR2RlQ5uc2xVoHgwwfCWvSD5vjaTftwX9sFXnX/dD2zIUGOP4gX2jm
         1P1kHWC+JyJzCbLqk78dwvxeYFlPFmuAaPkOy5Cy/jd7am0KPqQ40WD/CMnvEW5RcVlO
         WgHA==
X-Gm-Message-State: AOPr4FWh5nO4nrDgLs5fB34izI0qbz8szJldKDMlWc/UQUzx/bXcIZuUUfdBCeBuUtO9Mexk8qPCvZCEs8DwHQ==
X-Received: by 10.50.77.107 with SMTP id r11mr1300445igw.91.1460675530672;
 Thu, 14 Apr 2016 16:12:10 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Thu, 14 Apr 2016 16:12:10 -0700 (PDT)
In-Reply-To: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
X-Google-Sender-Auth: yMc5CWIulp5zNYElfsMdbvPe7gQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291578>

On Thu, Apr 14, 2016 at 3:51 PM, Krzysztof Voss <k.voss@usask.ca> wrote:
> I stumbled upon an interesting problem when checking out a branch.
> I had to switch to a testing branch to merge in some changes from yet
> another branch, but when I tried to check out the testing branch I got
> a message saying that I'm already on the target branch.
>
> I used worktree a few times, but the checkouts were always in their
> own directories.
> It crossed my mind that this behaviour may be related, so I took a
> look at the worktree list and noticed that according to that list
> there are three branches at the same time in one directory.
>
> It may be a conicidence and I have no confidence in saying that these
> issues are related.
> Can someone shed some light on this issue for me?
>
>     $ git --version
>     git version 2.7.0.235.g07c314d
>
>     $ git worktree list
>     /home/k/workspace/moyo  7c5edaa [ticket-22444]
>     /var/home/k/moyo-lsf  349613d (detached HEAD)
>     /home/k/workspace/moyo  265b7f9 (detached HEAD)
>     /home/k/workspace/moyo  c852282 [testing]

Did you manually move any of your worktrees? If so, perhaps this a
manifestation of the problem where .git/worktrees/<id>/gitdir got
incorrectly "refreshed" following the move. This issue was "addressed"
by 618244e (worktree: stop supporting moving worktrees manually,
2016-01-22)[1], which is in git 2.7.2.

Unfortunately, if your gitdir files are already corrupt, upgrading to
git 2.7.2 won't recover them; you'll have to fix them manually as
described by the documentation update included with 618244e[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/284284/focus=284551
