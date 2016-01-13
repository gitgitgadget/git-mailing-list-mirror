From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/3] pull: allow interactive rebase with --rebase=interactive
Date: Wed, 13 Jan 2016 18:33:10 +0800
Message-ID: <CACRoPnS_CcAuu_jBo9zcjycSN4kvSQhCONNYnY1XRnarRF9Zmw@mail.gmail.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<cover.1452668201.git.johannes.schindelin@gmx.de>
	<2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 11:33:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJIk2-00024k-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 11:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933799AbcAMKdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 05:33:16 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35525 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbcAMKdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 05:33:12 -0500
Received: by mail-lf0-f66.google.com with SMTP id c134so6560913lfb.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XwgSWDoSlu3sqJm00EWcyXj1NAF4Rs/+PCLaBmmmQ04=;
        b=Z6nDArExDUB1bIcq5VmhbbUhQ7/Z1/zR8O8vMcu6Ws0yg4H/ZjYTDknifaNEtL23xn
         ioeaC3EajvpbAVqWB0L6uazb9mlch7A1IuwSKTzqo4K6GJ9hG0XZl6CpaDjCpl11yWbx
         6ypKJv3JVmvc8fh5mvvlXphjFCcItMDkb0faIJ2Su3+y6QgcwBCaXE6HripJ/uCJDBRt
         3UbbpyDeGlVkBXaMh7crtRTf3WF2Z7GORRtLhtDcvdU6m3iavvjzvBMOZt051aHic/Mz
         HHmzHx3im1z9/58SKv/NJo/Ts37HF67pLeSFvzt+ldYFlsj4l+VsgW9roMbXPziYywfW
         eZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XwgSWDoSlu3sqJm00EWcyXj1NAF4Rs/+PCLaBmmmQ04=;
        b=aMCCGEjRIzP/dr1QFLDmMl7LNOLBqn9lOCuwr6IRt2d9t9OcgRmGtSvzc8QC+ElNYW
         AWNQywFGa0mQV2LLM29uB7VQpaDmmA0SnbsejtNLfl5gen0vHL6ZSDGAaj7e2J+aYWWD
         O3+SmowEVlBmbBhxipehfAABnW1EZBnN1tpxTqtF+lEKbT2euOEwqWNjVlVNmMsQoO2c
         pMSYJs/EEnYR53wUBXqI/yuQWOzkI3kbtdCf6P5a/esxrycaIBfKVglmrOTmvTfddiYR
         xvVkiHMz5USAq7EMVjfGY4KmF4ZUX27NtAa+duA2/sLo3F/W9ZqAi9oF5DBgFjfnxvEb
         VF8w==
X-Gm-Message-State: ALoCoQnJblkteoDh8f7/E8fxCZyILjw3twrEX4pjXZtw7n/cZn5iwBN0dDZCg4xKBDMXJn7SRuNs+pEdRqyFOWccEegYlpNU7w==
X-Received: by 10.25.87.5 with SMTP id l5mr30178289lfb.146.1452681190821; Wed,
 13 Jan 2016 02:33:10 -0800 (PST)
Received: by 10.112.82.162 with HTTP; Wed, 13 Jan 2016 02:33:10 -0800 (PST)
In-Reply-To: <2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283898>

Hi Dscho,

On Wed, Jan 13, 2016 at 2:57 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 07f7a3b..e5897e9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -865,6 +865,7 @@ branch.<name>.rebase::
>         instead of merging the default branch from the default remote when
>         "git pull" is run. See "pull.rebase" for doing this in a non
>         branch-specific manner.
> +       When the value is `interactive`, the rebase is run in interactive mode.
>  +
>  When preserve, also pass `--preserve-merges` along to 'git rebase'
>  so that locally committed merge commits will not be flattened

I think this change needs to be repeated for the section on
"pull.rebase" as well.

> [...]
> --
> 2.6.3.windows.1.300.g1c25e49

Other than that, builtin/pull.c has the following option definition
that needs to be updated:

{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase, "false|true|preserve",
N_("incorporate changes by rebasing rather than merging"),

The "false|true|preserve" needs to be updated to
"false|true|preserve|interactive", I think.

Regards,
Paul
