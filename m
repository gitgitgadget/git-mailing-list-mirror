From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for
 multiple options
Date: Mon, 4 Apr 2016 13:34:21 -0400
Message-ID: <CAPig+cSBNHu=V1awsv0Hq=VSg+_WJ=5iFo99du699vdh1J8hEw@mail.gmail.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Brodsky <corax26@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8OR-00016s-GH
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbcDDReY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:34:24 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35320 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633AbcDDReX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:34:23 -0400
Received: by mail-ig0-f177.google.com with SMTP id gy3so29625633igb.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=F3JbA6Zwd603owqUDMoXDoUu9aanHgMCKVbjiTlfjNQ=;
        b=Va3JUOKktFNdqiijI1vRGkE+33ksguNgD2WuxNFaH/zjxxiEwZZqYJZ1sB6S2PyeTd
         6nziIInzc7tAWK+ApwZi1Fk/gv+ilR1wLJIWZHxlXeHyfJVz6JZWn54OnubOpMYM40r3
         0wCpF8tccgoho//8PEUzdaogKFqVMf30pULYZSb+F7tbuXxA8jK6xSK+++5KkrONxOSc
         uT/41rgcIRlR8L+C+kb+oJmY7y2NlSWoOQ4FTMtxqmr9OLQCFcyzId3dF7cUE5vvPi8P
         CkP+UpGmRPGA3ZJYtfZxl40P9ey2qJ+F1XefJe8VMe+b0F8siYRXXeudZeCKIY1454gD
         VSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=F3JbA6Zwd603owqUDMoXDoUu9aanHgMCKVbjiTlfjNQ=;
        b=fx4AvjvbBJPsonS/NTc5GS+GuyStmNh6iL010c4ABdFhB23Ig7pjqStARps6ulZeMI
         9FRIYTXzD3FuhakI+BuIlblKiYAWVFTAqZo3hu3DPJfCAkWsphpTp9oQ6spixN4XWbLl
         Cgc4SNgm9/0E/VcLtpnk02fUnIgjDdo8a5H1pG4CbBAFDPigR6etXmx0zdebBG3aieSu
         2C/jfsgplPC9Ih3JVtzRCu6PxVuzkHAw7FCYwkVlnv0JzISLw8NHA7rnL/7zdFfG79xb
         EPd1hQzOWx0B13ecICX9pbbTL5nFSSaxEe4+/9MfchwIxwE2IzxchQb4Liovh6Ui8qLK
         L/AQ==
X-Gm-Message-State: AD7BkJJ3NjM3qerkeob0I7ZkX3EI5MZFpPfEAY/If6/1vBBwl7MyZ9BcSGC9YmETZcOPUy7UMTG/JV6dz9kOcA==
X-Received: by 10.107.47.41 with SMTP id j41mr16888196ioo.168.1459791261868;
 Mon, 04 Apr 2016 10:34:21 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 10:34:21 -0700 (PDT)
In-Reply-To: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: eC061OwwJ8PIjUMXfkQLrrFJaKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290705>

Ping?

On Sun, Mar 27, 2016 at 5:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> git-format-patch recognizes -s as shorthand only for --signoff, however,
> its documentation shows -s as shorthand for both --signoff and
> --no-patch. Resolve this confusion by suppressing the bogus -s shorthand
> for --no-patch.
>
> While here, also avoid showing the --no-patch option in git-format-patch
> documentation since it doesn't make sense to ask to suppress the patch
> while at the same time explicitly asking to format the patch (which,
> after all, is the purpose of git-format-patch).
>
> Reported-by: Kevin Brodsky <corax26@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> I haven't quite managed to trace the code yet, but git-format-patch
> oddly does recognize --no-patch, and it appears to act as an alias of
> --no-stat. At any rate, --no-patch seems rather senseless with
> git-format-patch, hence this patch suppresses it in documentation
> altogether.
>
> Documentation/diff-options.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 306b7e3..6eb591f 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -28,10 +28,12 @@ ifdef::git-diff[]
>  endif::git-diff[]
>  endif::git-format-patch[]
>
> +ifndef::git-format-patch[]
>  -s::
>  --no-patch::
>         Suppress diff output. Useful for commands like `git show` that
>         show the patch by default, or to cancel the effect of `--patch`.
> +endif::git-format-patch[]
>
>  -U<n>::
>  --unified=<n>::
> --
> 2.8.0.rc4.285.gc3ac548
