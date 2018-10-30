Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E571F453
	for <e@80x24.org>; Tue, 30 Oct 2018 07:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJ3QZo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 12:25:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeJ3QZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 12:25:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17-v6so11061005wre.11
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hw6LtknH2J+2EzR/fD6654g9IYEmX/vwySwiModFRPo=;
        b=TFR0MEbRo/u9zlxxQ3Ip5IwcSxwCURBsorXWeNqOLTrK4vZxzqAfaRWNCaE3w+2Mb9
         i3SJxWmbAzcaChjEd3C/B9V393Aalal5OxYykHNAgphks7pps2d8nUCx6LhQiqUFVYl0
         CeD+9tf0ZxnCsA80a+eIZs0zKF6btvGvWlYsH7Cfk1yNWM/gzQG5J36lveLV3JcRVvcy
         YRi25+YpS5LKOFrdIAV1VdjjrubJD7MdINj4/sh+GZy27jzTR+4+9PRwoGj1tykbUhac
         wyOX5g8hPOEFCcsAFIVLpg35qZkO/c/uUSWEtOzufjGCEleasePs5Lm8en4xVezdIfkp
         xMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hw6LtknH2J+2EzR/fD6654g9IYEmX/vwySwiModFRPo=;
        b=aNTgK0y/Qn8dkjpiDWf+ylFmtBOErzrymqPnPpUGUqLzfwd1+JdhY4Wkew7kNg0A1S
         E3XlPI2Gs04OlXPKN+UcpBfl7rAOFeI9uLSKwJjtaNxnXa5xnzvC0J0BrWHixJbYbE4E
         DwWgHr8OMs6T1ueZbqCUCc6AlSOt4X0U7J/7ZVlgAeke3MsP1LnkzFopoICYaMqn/5yP
         VHNCRKwDY4qtBTR4PDZC7GZYr1/QxJQVNv8CDmLEhZ2elCFg+sWWMKNXvIkqpMMhB+eO
         8bRGIh+O2IrsVgeGHAt79zOVkkM8TYi+X69p3vxYrnE5wmBjgASARJtN+axuOSKJ92Q8
         wnqA==
X-Gm-Message-State: AGRZ1gKsCON1Wg8C6NvPbHNf+RFqgj25/uiuHgVJnbkiU1AwqZqRFXcT
        WaWE5HOg2lT4K9J2mNB++ZA=
X-Google-Smtp-Source: AJdET5co81/DNi6MalR7J8jly8TSltbYZqEvuzs1oemgTI2gm9FG/8Oti/vKURvavtE3Gokuzgv1Yw==
X-Received: by 2002:a5d:4a48:: with SMTP id v8-v6mr16130966wrs.259.1540884802493;
        Tue, 30 Oct 2018 00:33:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d15-v6sm16768827wre.25.2018.10.30.00.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 00:33:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
        <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
Date:   Tue, 30 Oct 2018 16:33:20 +0900
In-Reply-To: <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 30 Oct 2018 02:38:00 -0400")
Message-ID: <xmqqo9bb28jj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This patch offloads completion functionality for format-patch to
> __gitcomp_builtin. In addition to this, send-email was borrowing some
> completion options from format-patch so those options are moved into
> send-email's completions.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> I ran t9902-completion.sh on this patch and it seems to pass. Thus, this
> should address the concerns about losing some completion options in
> send-email.

Thanks.  I added those who were involved in the review thread of the
original patch last week to CC.  Let's see how well this round is
received.

> ---
>  contrib/completion/git-completion.bash | 34 +++++++++++---------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d63d2dffd..cb4ef6723 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1531,15 +1531,6 @@ _git_fetch ()
>  	__git_complete_remote_or_refspec
>  }
>  
> -__git_format_patch_options="
> -	--stdout --attach --no-attach --thread --thread= --no-thread
> -	--numbered --start-number --numbered-files --keep-subject --signoff
> -	--signature --no-signature --in-reply-to= --cc= --full-index --binary
> -	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -	--output-directory --reroll-count --to= --quiet --notes
> -"
> -
>  _git_format_patch ()
>  {
>  	case "$cur" in
> @@ -1550,7 +1541,7 @@ _git_format_patch ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "$__git_format_patch_options"
> +		__gitcomp_builtin format-patch
>  		return
>  		;;
>  	esac
> @@ -2080,16 +2071,19 @@ _git_send_email ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> -			--compose --confirm= --dry-run --envelope-sender
> -			--from --identity
> -			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
> -			--no-suppress-from --no-thread --quiet --reply-to
> -			--signed-off-by-cc --smtp-pass --smtp-server
> -			--smtp-server-port --smtp-encryption= --smtp-user
> -			--subject --suppress-cc= --suppress-from --thread --to
> -			--validate --no-validate
> -			$__git_format_patch_options"
> +		__gitcomp "--all --annotate --attach --bcc --binary --cc --cc= --cc-cmd
> +			--chain-reply-to --compose --confirm= --cover-letter --dry-run
> +			--dst-prefix= --envelope-sender --from --full-index --identity
> +			--ignore-if-in-upstream --inline --in-reply-to --in-reply-to=
> +			--keep-subject --no-attach --no-chain-reply-to --no-prefix
> +			--no-signature --no-signed-off-by-cc --no-suppress-from --not --notes
> +			--no-thread --no-validate --numbered --numbered-files
> +			--output-directory --quiet --reply-to --reroll-count --signature
> +			--signed-off-by-cc --signoff --smtp-encryption= --smtp-pass
> +			--smtp-server --smtp-server-port --smtp-user --src-prefix=
> +			--start-number --stdout --subject --subject-prefix= --suffix=
> +			--suppress-cc= --suppress-from --thread --thread= --to --to=
> +			--validate"
>  		return
>  		;;
>  	esac
