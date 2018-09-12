Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E6F1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeIMCem (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:34:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53695 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeIMCel (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:34:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so3912688wme.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xx+4itRAZ6MoOxb5hkeEjzOINLMyYN1TpeYuBqhvEJ4=;
        b=uQFdhx73TDpq0heDyfYs1gtvkX+oE1DJvbQdftMVfTNRorGdNhe/QK7Sq7dveS3IeG
         vXetYt/rYlSNHnfYg7+1rlgAz8R717p/MVF4SWLAX9SlRJXUPPvBdI8acE0BvO98CJW5
         Krzv411Vy0rJ+Veaag10RTMy5DdGv8q2YZB2Ks5I1+jY9jy1XQhhEcV4VeQAYy6RVnyU
         TBS/HC6E4zaJ+1wJ+cjJOkVF2Q4fZfrCM8ftzs0s7+ktLQRbJeVB0WawOLd0CyZCQe7l
         EoITU2bpeBq84j39lSK2NKG07VZYjnRdxOFoZnCS6K/nSs9HgkvSQeWP/fhjcWLH+KeB
         s30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xx+4itRAZ6MoOxb5hkeEjzOINLMyYN1TpeYuBqhvEJ4=;
        b=VCHzBsJfCPVu2dqC0DktbkDQUIHRNbIJ3Yna6cJVfpa1BLiVMppqk4UwAGMaSlqSph
         MmLW1ZpPHsPxCDZHy6ZsNvIOCom8GGIZqr/I/r1Td/WGh9uJfaAG/gjhDJBUdwlWkDGI
         Z8+g8O1Kj+bpCoQ4F0cjTNtHMCd1/yG7S524YGyv8zFGsaGG/+V1lEVBcfUC3VhiI+oF
         9RkD1nwDSaRinnZaz7410/X5/HObgl1mSGOrwKMJNOW0lyPDQYZZ/xreT6VDI+9lwDFi
         gTOZTZLOqwAWAVTXXzulYC4Vr9oAZ/TuF55e+WtocjLJoNPr0NR4DtRgMD/xUGNIuIYE
         +FrQ==
X-Gm-Message-State: APzg51DRGdlVOLVhq3eGMC80QNs+kEFCBN6M6boJDkKihPxwiPRQSGPy
        ZK5nPPRQnPVWurhjS4HLbLQ=
X-Google-Smtp-Source: ANB0VdZUOPs9TDSks3+7Gb8LPXwinciu6V1TX6+6LtEf8bwQocqCFOLqG72VsQL47OCfVKIPeRltgg==
X-Received: by 2002:a1c:ee97:: with SMTP id j23-v6mr2994816wmi.66.1536787696261;
        Wed, 12 Sep 2018 14:28:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v46-v6sm2949845wrc.63.2018.09.12.14.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 14:28:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 1/1] builtin/remote: quote remote name on error to display empty name
References: <20180912144504.7498-1-m.shulhan@gmail.com>
        <20180912144504.7498-2-m.shulhan@gmail.com>
Date:   Wed, 12 Sep 2018 14:28:15 -0700
In-Reply-To: <20180912144504.7498-2-m.shulhan@gmail.com> (Shulhan's message of
        "Wed, 12 Sep 2018 21:45:04 +0700")
Message-ID: <xmqqlg86jths.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shulhan <m.shulhan@gmail.com> writes:

> Rationale: consistent error format

You can and should drop this line.

> When adding new remote name with empty string, git will print the
> following error message,
>
>   fatal: '' is not a valid remote name\n
>
> But when removing remote name with empty string as input, git did not
> print the empty string with quote,

"git shows the empty string without quote" would be easier to
understand which part of the behaviour you are disturbed by.

>   fatal: No such remote: \n

After stating the above observation, you can say something like

	To make these error messages consistent, quote the name of
	the remote that we tried and failed to find.

at the end.

> ---

Needs sign-off.  See Documentation/SubmittingPatches.

>  builtin/remote.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 40c6f8a1b..f7edf7f2c 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -626,7 +626,7 @@ static int mv(int argc, const char **argv)
>  
>  	oldremote = remote_get(rename.old_name);
>  	if (!remote_is_configured(oldremote, 1))
> -		die(_("No such remote: %s"), rename.old_name);
> +		die(_("No such remote: '%s'"), rename.old_name);
>  
>  	if (!strcmp(rename.old_name, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
>  		return migrate_file(oldremote);
> @@ -762,7 +762,7 @@ static int rm(int argc, const char **argv)
>  
>  	remote = remote_get(argv[1]);
>  	if (!remote_is_configured(remote, 1))
> -		die(_("No such remote: %s"), argv[1]);
> +		die(_("No such remote: '%s'"), argv[1]);
>  
>  	known_remotes.to_delete = remote;
>  	for_each_remote(add_known_remote, &known_remotes);
> @@ -861,7 +861,7 @@ static int get_remote_ref_states(const char *name,
>  
>  	states->remote = remote_get(name);
>  	if (!states->remote)
> -		return error(_("No such remote: %s"), name);
> +		return error(_("No such remote: '%s'"), name);
>  
>  	read_branches();
