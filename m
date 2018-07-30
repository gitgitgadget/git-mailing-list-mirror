Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4BBF1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 22:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeG3XtM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:49:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53798 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeG3XtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:49:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so923171wmh.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOD1uL+Y6WQv5G+XvvJSKTx7bAwkEC5KiSwIfTTwjJs=;
        b=mFksKYw9wC4/HelyWTQzGmtiWLM0b22RZ9S3vlJfIJm7ZUMgvujponFnO/j22D5CG6
         zJmfHJocBhyaO3gDW9HyaITb3Pxb16NtQVGMNTycI/wB12v+nhArBSbfs05vhBvUpgF9
         awp6K4Qy7N+eR0FEr6uNRGepJUwwUJpFXlgSj4UTxDkfKtuW3fBe57RmV+c4NT00nJu1
         5nkrbcDJZbCVpTCH0vRaJb3gqQSG+TDTMZF751OxhOKLpRQoq9WB833oPpF2PER/oP65
         wFDRn1gmB2ridpl0ZGvNrwyDf9+bOUC6xvJUXC4gtjO+4jp4Ikjp9wMEZgJvEvZ2yZXs
         8QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOD1uL+Y6WQv5G+XvvJSKTx7bAwkEC5KiSwIfTTwjJs=;
        b=sbTM3SsXLcUXRdoYolrW/4tCn7NebW0Ll/16ZvbPJDuEZs3ORYHYL+Isy0VH6GSCnH
         0wfL31d+FiPDZnCsjOgWAKc8tNQMOYscR/CEvDEi5SUeQMEzm5v3jzUNpzkaNXeosquT
         1ZQoUDLcwvkgfOpLYc0bjiuUoERwy1mNkRKSZ5BABhyArAXnEjTE+B1KogOljY8H30W5
         wdDv8IV8KGsH1d0ZNWyIWlJeWKiZJFdz6Ml4vLNM3HEp1HZRGOdPuexraLHA1f46v7t2
         XNFesVDgbxaq84VKlfJK/6c6nyoi3eO9+NrI4BRE1zgmQ1yx1ggvlS4/EWUmTu4D8KtX
         8vdg==
X-Gm-Message-State: AOUpUlHGcRbdxg8RXD420k+4geVp3IGC29uHVP8gnlawh5ARmIiugjlQ
        W4ToMOBgHEERQW5ZMR52DtWf9rNm
X-Google-Smtp-Source: AAOMgpfLDFe4GMRTHJzggEdATN7vCD0bWViUrdA3BLK46uRFQRIAOI4Hkdloi87IBuWxjJH37CWWjA==
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr575228wme.122.1532988728410;
        Mon, 30 Jul 2018 15:12:08 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.gmail.com with ESMTPSA id d21-v6sm44700wma.24.2018.07.30.15.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:12:07 -0700 (PDT)
Subject: Re: [PATCH] builtin.h: remove declaration of cmd_rebase__helper
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <36bfb2da-f163-67b9-4ddd-398ce137f85f@ramsayjones.plus.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <dce8c99b-51e9-4ed1-8ae4-28049cb6e7ec@gmail.com>
Date:   Tue, 31 Jul 2018 00:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <36bfb2da-f163-67b9-4ddd-398ce137f85f@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

Le 30/07/2018 à 00:44, Ramsay Jones a écrit :
> 
> Commit 94d4e2fb88 ("rebase -i: move rebase--helper modes to
> rebase--interactive", 2018-07-24) removed the definition of the
> 'cmd_rebase__helper' symbol, but forgot to remove the corresponding
> declaration in the 'builtin.h' header file.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Alban,
> 
> If you need to re-roll your 'ag/rebase-i-in-c' branch, could you
> please squash this into the relevant patch (commit 94d4e2fb88).
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  builtin.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/builtin.h b/builtin.h
> index aac8f5f340..6538932e99 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -206,7 +206,6 @@ extern int cmd_range_diff(int argc, const char **argv, const char *prefix);
>  extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
>  extern int cmd_rebase(int argc, const char **argv, const char *prefix);
>  extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
> -extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
>  extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
>  extern int cmd_reflog(int argc, const char **argv, const char *prefix);
>  extern int cmd_remote(int argc, const char **argv, const char *prefix);
> 

Thank you for pointing this out!  I will include it in my next reroll.

Cheers,
Alban

