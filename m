Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16A71F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeGWOZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:25:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35873 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWOZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:25:25 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so557155qtn.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2PIishLHdXGNzNG2U+p3iwMyTWBMa4MNx+DeVZWmXWw=;
        b=Xqy9GSM3EcFpA2lVRuxfk2l7FIwOFUuUFbBuV7iT15TGeJWZ6bGomw4Xzy5gE7buYF
         AJmh/jgXVMU5qbZpfoDnARn+WhZJTiMKh1S8RvGxsqbJLi0gP6RlOwUwX53LFMRCvJM3
         ToULodI+VN8sH8lk85S2/eNc/qEP8LRJmkkMxAUBzkuhRHQRtW4Weq2FPx6CirB797h7
         q2yaYl6iCochAOy9SOLkslZxxMcvel4aho8oLp0+aUb4hyqXyMJ1rTltQkTditNmBjc+
         2/oH59yQUgU/VL3cfyZ/hHnWmy6MTfyHPNpFV2H2ikijTlSBLYYHq3mgE9/C3etfcY5/
         zNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2PIishLHdXGNzNG2U+p3iwMyTWBMa4MNx+DeVZWmXWw=;
        b=rDMzFr36YjmFNBE2HBJEhab59/tjR2Alg0B/6dolmNwUeyhosFCzbvZtNXTadoC0tO
         XlQndoPS/Hld3g03aoxwBw4xxFcOe1tAriM83dTpKkSCnrVtB3rDy8MzbXNuiXaB8Np5
         AASNgFQnDZcbQlSxfv8xfXLH5jThfBse504b27U/R7BsVD7B3cA/3sJxu5VC/Ko+gqKb
         wkbKBbqh9NCUD/PfVL6DoK2XT8iwop3Jf0mTN6PZdxaHfozKClgxE/oR6DvmvoPq5X01
         9A8upwzDbWi66Auhfkfzgyc/rlfXeZxXUP5By0AeLwe54QJLyT9+Ki/u08wbtBtxtbmV
         NhLQ==
X-Gm-Message-State: AOUpUlF7qUd/Yvd464SEkceKa1qE+5M7udtvXelVy6ZlbbirfkD3bl5C
        3RXn6/T/YNWlkN+vANsqD/1kmFBk
X-Google-Smtp-Source: AAOMgpdRiASJ51PkTiRmyoxReVkA+MW4K/uSsuwxk1Vi9NChppwJTb23ARzQdjHgrSJNNKWjQPFwww==
X-Received: by 2002:ac8:166c:: with SMTP id x41-v6mr11826686qtk.245.1532352250986;
        Mon, 23 Jul 2018 06:24:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id 49-v6sm6399976qtu.0.2018.07.23.06.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:24:10 -0700 (PDT)
Subject: Re: [PATCH 3/2 for pb/bisect-helper-2] squash! bisect--helper:
 `bisect_start` shell function partially in C
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
 <20180723130603.22703-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bcecc802-099e-7e7f-d977-e6f545ff2fee@gmail.com>
Date:   Mon, 23 Jul 2018 09:24:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723130603.22703-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:06 AM, SZEDER Gábor wrote:
> bisect--helper: use oid_to_hex()
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   builtin/bisect--helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index fc02f889e6..eac4c27787 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -547,7 +547,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>   		if (!get_oid(head, &head_oid) &&
>   		    !starts_with(head, "refs/heads/")) {
>   			strbuf_reset(&start_head);
> -			strbuf_addstr(&start_head, sha1_to_hex(head_oid.hash));
> +			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
>   		} else if (!get_oid(head, &head_oid) &&
>   			   skip_prefix(head, "refs/heads/", &head)) {
>   			/*

This patch looks obviously correct. Thanks!

-Stolee

