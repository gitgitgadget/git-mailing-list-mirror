Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34ADF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBGTAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:00:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfBGTAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:00:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so980146wrn.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tUE/KGxO7Wmbm/DU0++ex9PFi1qzsWo9VY+u+cV/ETg=;
        b=ibS/1gzNC2oqWLi7JqSZcHZ7vq5asbo3qdL7kREU6lLaDtasdoXmMlMvSXVrpkbaVG
         +P1H5ere6XCh+P3ZWeghsj1TnugdGr3VoAGmyYKuX4YfZBTSMCDwBT37QLMf/zXydU2m
         2bGM02bjT1vpg/raRN7wfSCnTD724sM9hEM2LL7VMoZ05tTE1oQt7RJvhtX2rlenc2dk
         1krWdeDHLyRcDqPzThry7DLW5b5H6us8DSCzfTFztgfJARVhbJk/iJLydCiSo4KGD83D
         KvYRX9omEsPCVPLA6II12hR1i8rL5uUYI6taVRh3F4toQHfidNh8dC9By68xhwWDQ3pu
         7K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tUE/KGxO7Wmbm/DU0++ex9PFi1qzsWo9VY+u+cV/ETg=;
        b=EUksB6pZdnliUPoKCfrZMd93ZPx0kpJjcFgYuFsBLrEL3EREQWHlvXyKZAMDXJ7sEj
         mT4r8zBEJGaOTkRJLOYMBjdq3UvLu1VarSSEinbh6DpiyTI1XKFf3UG4omoqP4yscPZF
         TnAEDhlHpFCbma3YRxP/hPd73reR1EIFwKjCvE/bsJWjuOAjKvBJvwYI6C5GI6P3juON
         X9R2bywBarYPw5yRrK8DSqzKfFXmJxo3EvS4oj0jTqpgYgfbsFH38GB0j5ADV/AHQU9U
         WEga3ErXBKPEiP6wibw5GCb/vuvfAPAQ3cW/NNt3AeZ8rYN4mplR7yUI6TlOMvXdUeO0
         SkAg==
X-Gm-Message-State: AHQUAuYbAIidwmr6Io7+sQhfxLAn24P2PofAnoSpsLQTD/RS/lJgc4PU
        vcU4hrutTFsCJ8l4pCf23YA=
X-Google-Smtp-Source: AHgI3IbwdtHr26nimuKmC2PtH0E+t5qqQxBupk5tWqLq075p52XUkKKm9NbTKR+qAGAxHjFDGaIAnA==
X-Received: by 2002:adf:b243:: with SMTP id y3mr13965701wra.184.1549566016258;
        Thu, 07 Feb 2019 11:00:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z26sm194660wmf.11.2019.02.07.11.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:00:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
References: <20190207183736.9299-1-szeder.dev@gmail.com>
Date:   Thu, 07 Feb 2019 11:00:14 -0800
In-Reply-To: <20190207183736.9299-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 7 Feb 2019 19:37:36 +0100")
Message-ID: <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Append to MAKEFLAGS when setting the compiler to use, to ensure that
> the number of parallel jobs to use is preserved.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 16f4ecbc67..cee51a4cc4 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -185,4 +185,4 @@ GIT_TEST_GETTEXT_POISON)
>  	;;
>  esac
>  
> -export MAKEFLAGS="CC=${CC:-cc}"
> +export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

Makes sense.  Thanks.
