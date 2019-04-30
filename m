Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7821F453
	for <e@80x24.org>; Tue, 30 Apr 2019 16:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfD3Qk5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 12:40:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32780 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfD3Qk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 12:40:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so8596243qkc.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CphyJq7NrWFyiT21WM28OlRmV4gIL+iS6z6Xwn4mo0o=;
        b=hxIo1WgAqTJ2Ucql6W4uNW3mShaif6RHNumwWfznXrSJ9qMqDNcaqsNZ3Hhxrc+jYh
         GqC224wwjwCzs++SM+mZIkkQ61L7NPJY07Jr0mua0aLA8NRk4ymiXq4/HaXgEKq3PXZ5
         aXalvu0nEFHrETah63WmG17/Wv/rKXQfVggUZIa4w7tnL6U4YCTRfaFlGCA2w5LQE8As
         z0Jk7nEKzNwX4jhwQQs2zdiuacmETH9fsEm6PK3QHVb+qFKdXeiQHAZuqlHwn/QcuzjK
         woxlShiCnjemb7z4LHeMxg4Y6594WfSAnHXgtEo3NDygTrrwh4HyLxbNXgWFPHQ/tp1H
         Gjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CphyJq7NrWFyiT21WM28OlRmV4gIL+iS6z6Xwn4mo0o=;
        b=tq+FpV73WC9q5kzkVRNcB02VwT/g3v9Bj3RmAWZoGDd5fsYvDlr5oK0qB3ynzhs080
         DhIxK/jdiCUHIY5NTMabDlDKWKMYWB1HiOPDIdqtczu6dX+YsYUg8NZ65F8xVtz4+1cw
         iHCySBEpf5UNRKc+yjTmGHHJfbUgEtHTvKno+S9irmY2wLiQ1R0tvHKZvNx2OMq0nVW+
         f7iPB5oPo0IMpX7WXtRYKLhoA2UwgxUkIbftuPMfRQvUZDtVuyyfRTg3bAJ5FhLHvub+
         dhMpGi4FsOhfxlnZK8VUyyd0tF00aV58Eta5ujDfW1dsNAqhJkBPJSrbN1CYER0QZpJa
         au1w==
X-Gm-Message-State: APjAAAUqVT6aTz9xPXe1iRK7kMwCGhMFXVrr3/7uv5tuj0SQxkYpgzQG
        CONGsmb4n3z6O6VciqgntbjOc85Oxc8=
X-Google-Smtp-Source: APXvYqyRuZY7Tzp1ykh7ib8AOji/WaKMoreU2GXMo+/XA4yUywYC0DAyH0DDiXF9VJpoOGBYegVnHg==
X-Received: by 2002:a05:620a:1598:: with SMTP id d24mr17211681qkk.34.1556642455820;
        Tue, 30 Apr 2019 09:40:55 -0700 (PDT)
Received: from [10.0.1.5] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a57sm6485849qtk.63.2019.04.30.09.40.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:40:54 -0700 (PDT)
Subject: Re: [PATCH 3/6] config.c: add repo_config_set_worktree_gently()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20181227155611.10585-1-pclouds@gmail.com>
 <20181227155611.10585-4-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c8ff5919-5a27-8d1f-8583-241e94f0e196@gmail.com>
Date:   Tue, 30 Apr 2019 12:40:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20181227155611.10585-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/2018 10:56 AM, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/config.h b/config.h
> index ee5d3fa7b4..62204dc252 100644
> --- a/config.h
> +++ b/config.h
> @@ -103,6 +103,9 @@ extern int git_config_color(char *, const char *, const char *);
>  extern int git_config_set_in_file_gently(const char *, const char *, const char *);
>  extern void git_config_set_in_file(const char *, const char *, const char *);
>  extern int git_config_set_gently(const char *, const char *);
> +extern int repo_config_set_gently(struct repository *, const char *, const char *);
> +extern void repo_config_set(struct repository *, const char *, const char *);
> +extern int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
>  extern void git_config_set(const char *, const char *);
>  extern int git_config_parse_key(const char *, char **, int *);
>  extern int git_config_key_is_valid(const char *key);

I know this is an old thread, but the patch is still in 'pu'. These methods
do not appear to have any callers. Perhaps this patch should be dropped
until there is a reason to include it?

Thanks,
-Stolee
