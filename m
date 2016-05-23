From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5] worktree: add "lock" command
Date: Mon, 23 May 2016 00:36:05 -0400
Message-ID: <CAPig+cRSROJw74K0cu1qApNnuVJY3=YphgVVCYfU1_nh+STMAg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522104341.656-1-pclouds@gmail.com>
	<20160522104341.656-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hbB-0006Eu-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbcEWEgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:36:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34856 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcEWEgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 00:36:07 -0400
Received: by mail-io0-f194.google.com with SMTP id 190so10211822iow.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=KD1CdyLFpuQl82hvVaVY9nTjJ6PEECrUtk9Fi3QrwDw=;
        b=JKdPK4YQMJ2+wTXtIEutmi9o8kDkKTcUmcOHfnDJIh/2xmKhXNHgfwlCd5xaTzjyQW
         4jaSUScPnjnVz/WksXoyGob+KYAp7cRPBQwsj/pplhg9PtZkkzNPeFTM5lAWCWpyfOFb
         1niEA43p4hfDnFJgjxZYW0fCIQY4+Zd4hAvmd5Jz+lD4J/j4szklG2qXVNH4AMrlJcaW
         2i8N8rgzhoV2mpWNUxAp1Tqhy9psUoDNE2cI0kPDjlZacecAK6IGMr+QYDzsXuRJaHbP
         5qkTlvvaTs+wUNU2sjXrXeZadBGn7Kef+DFaQC8CISnEXlYudo+NCA2Oj8/7AkMOVJJy
         AsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=KD1CdyLFpuQl82hvVaVY9nTjJ6PEECrUtk9Fi3QrwDw=;
        b=aeLFPsx2ZJzTEwIQjgy4GIaP7BlYHKxjthtDDq+GgMeiL0P0p8VGJp/PrQHI2korqV
         Xht7FXHj3DPc+FZI+RlVpXX4ZVGLkFwRBNV0TX9wgL2vEFaQU2rTcEEHd5USPvR8Pf0c
         xNGL0okmb+x1bmOPdmvwLMGbd70U2rQyTQxwHY+M8kE+qSA+3mM59h8HaCVXptLYBBEi
         FZK69IriKZ+s0eDjWQvSsWQv+Z/990gCuxWU9HbdfmOtZ5/6K84P1DrVTJQMKCWz6G98
         /84p2f/dTwr5s3aoUSf27hU1k5NZ1drtSB5hBE3LTbfcu/QF5UjUs7jeS/roEOypraR8
         5bng==
X-Gm-Message-State: AOPr4FVJLxwdRs+vXTwS0v0G820lqwOuWpmSG+wIsC5Rrwrzlp3qiDMQG8dhNYsUPx4RsNMwncjl7mzcSOXDCw==
X-Received: by 10.107.47.37 with SMTP id j37mr10422976ioo.168.1463978165957;
 Sun, 22 May 2016 21:36:05 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:36:05 -0700 (PDT)
In-Reply-To: <20160522104341.656-5-pclouds@gmail.com>
X-Google-Sender-Auth: JqeNbSBBRFV5M1_tSmnj-zSL9Gk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295306>

On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> @@ -150,7 +161,8 @@ instead.
>
>  To prevent a $GIT_DIR/worktrees entry from being pruned (which
>  can be useful in some situations, such as when the
> -entry's working tree is stored on a portable device), add a file nam=
ed
> +entry's working tree is stored on a portable device), use the
> +`git worktree lock` comamnd, which adds a file named

s/comamnd/command/

>  'locked' to the entry's directory. The file contains the reason in
>  plain text. For example, if a linked working tree's `.git` file poin=
ts
>  to `/path/main/.git/worktrees/test-next` then a file named
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -0,0 +1,54 @@
> +test_expect_success 'lock linked worktree from another worktree' '
> +       rm .git/worktrees/source/locked &&
> +       git worktree add elsewhere &&
> +       (
> +               cd elsewhere &&
> +               git worktree lock --reason hahaha ../source

Could use "git -C elsewhere worktree lock ..." and drop the subshell,
but not worth a re-roll.

> +       ) &&
> +       echo hahaha >expected &&
> +       test_cmp expected .git/worktrees/source/locked
> +'
> +
> +test_expect_success 'lock worktree twice (from the locked worktree)'=
 '
> +       (
> +               cd source &&
> +               test_must_fail git worktree lock .

Likewise, -C.

> +       ) &&
> +       echo hahaha >expected &&
> +       test_cmp expected .git/worktrees/source/locked
> +'
