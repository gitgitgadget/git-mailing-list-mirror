Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5CF20248
	for <e@80x24.org>; Sun,  3 Mar 2019 09:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfCCJzD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 04:55:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40071 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCJzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 04:55:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so1905150wmh.5
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=gk+eIYqNEfUN48b81VFUvTuXOSSseenSVV4qJuZ600o=;
        b=BezCVjqt0t4a4CzWiFzis8JMT4syX7xZaIhlU7j/JkTwaSqvPc3V2eGgUhtmMzqcJB
         uDkh8+tcuohA5RXsAEj5ja6fI4Fd2+OiTy2jU2gHcz9UPfwTiN7nJYIg9ILEgmjuk4Cj
         9vsXQo6zbG4sBXRypH0UFncYF6rA/2jxuzm23yEdMN/+TBSQuzaSthY+W8Gd08XQCUA9
         aik5sfu8EF5zM6SRMjBA2L+OTWPMg0yPYvxlIHLJFI56MNmqLirEV5/uCaLX2rSyXWJ8
         HNtCHU6Cnc/2rwCpoAyqGGtH2vgEBAXzHJ17XLRHy30fq5HAtKBevk1QY+mDkLAJfCW/
         q0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=gk+eIYqNEfUN48b81VFUvTuXOSSseenSVV4qJuZ600o=;
        b=To9b9uThBmuYaqg1viIpe3jD+j5Z5ycy6S3UaxsZvZbiZXLH7NpoeeiybnEc9ICvf4
         doklaqol2yIUSJU1c+7f/ohiZqlTdUGrp5n6rVgpuopOyjVlaGhU/KXnteDV+RftUZR7
         w6TAfj8bvk/ZMHVLXriUvIjfHetJV8zlsguE7r42C0dH51IF6L0y1P0baBsgJFPys1d8
         hm08fLfh3gag3QyE/17weDAjy+VQSokMHvdwcqyrbu+jBiIz43G24JwyPvy23bHwHgm/
         nvEMj1Tqs28f530RSKR9MtWeULhoFj8eHfaf4itkBqoXGiPoocvFmmZNtgZ5euQqjmT3
         8WDQ==
X-Gm-Message-State: AHQUAuZltJjZIetnUOCPwb0iUlYnv9YYfB3f3Zs9eT2kkvVRc+SQwh2e
        v5dN9C1nrgMe0mWDvrU0L1Q=
X-Google-Smtp-Source: AHgI3IaEG1ZdSIbyyRWMFNjCN9aGB2BvNFY3u3XeVJZsMR56UM0ZHYP8tDrjTwBVpBdbv619UBSKPQ==
X-Received: by 2002:a1c:d049:: with SMTP id h70mr8009647wmg.81.1551606900895;
        Sun, 03 Mar 2019 01:55:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f6sm2723653wrt.87.2019.03.03.01.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 01:55:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: let --stress-limit=<N> imply --stress
References: <pull.155.git.gitgitgadget@gmail.com>
        <16c6508c4b38933945126ffe27445c999aa3e59e.1551561582.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Mar 2019 18:54:59 +0900
Message-ID: <xmqqo96s1dvw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It does not make much sense that running a test with
> --stress-limit=<N> seemingly ignores that option because it does not
> stress test at all.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4e7cb52b57..ab7f27ec6a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -153,6 +153,7 @@ do
>  		esac
>  		;;
>  	--stress-limit=*)
> +		stress=t;
>  		stress_limit=${opt#--*=}

Good thinking.

>  		case "$stress_limit" in
>  		*[!0-9]*|0*|"")
