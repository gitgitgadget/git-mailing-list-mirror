Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF465201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdF3Qoj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:44:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34436 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdF3Qoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:44:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so3055303pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HKYdhPKtA2PPYhn8ec5M/DgJ0NCXRX4q+GrJHtNn61w=;
        b=BoF3oy8WPu/I7FCczO7JKTY12gNIIWKp1xIL8Y6Y6ViPGjFa26snED+SUUvGM+xXJp
         ayfqx9gt8JMs/zengz0qAOW7C8gNuO17l5KXQF9zmPhGOjaXRiTggMoKmx0cAZ8W5re8
         rFnsjXiSjYnjbBmnIxjAqhO8puDyIPOY98qC+Q575ynKCk/TrTWjwZSNsPSXZ0V6vlHO
         alNMQeg3jBsg3HW3dmNr9q8/jmzkqbT5My9bSGkyq1YdJwI7q7Q/rzSeH7MOx8fibtAW
         YsogJcVkeEAzJfC6XNveitqSF7UbKQ2KE9mbbcHTiNr3CNth5YA1wmm8ooL5lx45zB9f
         qxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HKYdhPKtA2PPYhn8ec5M/DgJ0NCXRX4q+GrJHtNn61w=;
        b=h/EKbLHLbxmkrI4NzJ4cl8zSwqRK7PGItxLeHK+KDB68xalWAVByCof2s6gJcIXq2l
         ZYLOb3IQNKpMbpcKKSLLmhQ7mpEZ/sYvhIBSJh/N/oMBzs0ksZvwY0NGlItmrgqXTDX2
         r0Ge+tVBocZ1ibkIiDAmaunLo5HrSu7gKx4Dy4Fh9QXdCSvAsQ4Wtx8wWdEIvV6fFYoX
         E22orAV4SMUQdSgpWN0PKysLF5sZr1RDtTNoBc8Xw7bofFraSmCuh4slcHB9F57LeNp7
         kI6FeCyU2lONX1Py4EPmuTe8t7j6m+DktLzqSR1LSOIzyD1sz3yAjf++784afs1iFS6l
         bkDQ==
X-Gm-Message-State: AKS2vOw0KdsqGlARBeqq5BSLrNy6Xp1ZNSIArEtQn5CKBYpJViejGZYG
        KOJRmHP03WPjfLV2H14=
X-Received: by 10.101.70.137 with SMTP id h9mr22311241pgr.50.1498841062966;
        Fri, 30 Jun 2017 09:44:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id v3sm19171505pfi.73.2017.06.30.09.44.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 09:44:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
Date:   Fri, 30 Jun 2017 09:44:21 -0700
In-Reply-To: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Fri, 30 Jun 2017 21:13:06 +0530")
Message-ID: <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The sample hook to prepare the commit message before
> a commit allows users to opt-in to add the signature
> to the commit message. The signature is added at a place
> that isn't consistent with the "-s" option of "git commit".
> Further, it could go out of view in certain cases.
>
> Add the signature to the top of the commit message as it's
> more appropriate and consistent with the "-s" option of git
> commit.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  The change might seem to be bit of an hack, but it seems
>  worth it (at least to me). I hope I haven't used any
>  commands that aren't portable.

It does look like a hack.  I was wondering if "interpret-trailers"
is mature enough and can be used for this by now.  Also the big
comment before these examples say that this one you are updating is
"rarely a good idea", though.

By the way, the one that is still actually enabled is no longer
needed.  The commit template generated internally was corrected some
time ago not to add the "Conflicts:" section without commenting it
out.

Have you tried "merge", "cherry-pick" and "commit --amend" with this
patch on (meaning, with the "add sob at the top" logic in your actual
hook that is enabled in your repository)?

>  templates/hooks--prepare-commit-msg.sample | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index 86b8f227e..3c8f5a53d 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -33,4 +33,7 @@ case "$2,$3" in
>  esac
>  
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> -# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
> +# SOB_TO_ADD='
> +#
> +# '$SOB
> +# grep -qs "^$SOB" "$1" || (echo "$SOB_TO_ADD" | cat - "$1" >temp-template && mv temp-template "$1")
