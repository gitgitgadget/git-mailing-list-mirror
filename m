Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392741F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfJXWEW (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:04:22 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40418 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfJXWEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:04:22 -0400
Received: by mail-wm1-f50.google.com with SMTP id w9so191wmm.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9SzBMEPi/KSU6gWt/O9FsDBzqubgZpWVLUozxRCYDzQ=;
        b=KzOp6YvgVYkhTXmV5PBGx1xDfY/BMaaCyeaTfQpZI8eafLDjpcTQzF88oL2zXrRzce
         gnQvYYm7E6affEEMYGY3NO9kn9SEn9X7Y1iDxP7JGrNVu4Ub3wAkh6QhZpjeBjo9Xfzg
         jHxvFfk4fev+pJodYIZcv44qJEh6Dy4w+IvqDIrlDPAPEJqP1088qs3I2X21o5tEY2of
         hlfHqScjv2XCdBljXB4kFG7DD6GQdKRJR9og1QQdSpIbvYUR3K6v2zbcNkJvOzPnU0tK
         +Eesmcqe8R5m5zL9/Cj7h6dc0k1FLOPuZwChYNN/73m7u6CgU8tJlzTl7S4aL5Sc7nCF
         uEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9SzBMEPi/KSU6gWt/O9FsDBzqubgZpWVLUozxRCYDzQ=;
        b=jU5w7m+mzt39NN66GHzbF2uqz7EMoLGB4fTXaQ5vcRHJ/7F3B63zMncmdLtCtDWjGi
         PKCiYaQVeRu3ITx76kGFa1v/Y+0Bi02D4NJ6u7+IqDT0FL6gt13JePavWTnGSj8wgPi1
         WZfVlSD9LjyQ00/S9eIS1W54RdFeWZYoWH+sNIGNDek+OgNcvXuDUGHlpGtUH+eJoPx2
         EaI1r4VTp8+nCFo8Ofb6VSZ3r17cKQeJqHi2Q22h9uz9yw7fNaO2ZGX598iyfDuRDeMF
         ULLZoDnovIngEo+g1iKFKzBQTBILje+REpDtzPHM8YLkdmHFU4W1nu838Z9zYsCs4Atv
         JwgA==
X-Gm-Message-State: APjAAAWkHCEhkdQLupVuitEPonRmp4/B1NYFe/822ek/StnxcgFwtypy
        p2rLNsTKxgyMVrMuMHaxZ8fNbtb3pMw=
X-Google-Smtp-Source: APXvYqz0IUXT5wY22Bs9mgLKsl0Zuf09o0LXa8TrB7DtXJBGIv2DnBwzS+XGMcf6DETjcVmlkKtlQw==
X-Received: by 2002:a1c:4489:: with SMTP id r131mr434260wma.132.1571954655165;
        Thu, 24 Oct 2019 15:04:15 -0700 (PDT)
Received: from [192.168.1.100] ([213.195.101.79])
        by smtp.gmail.com with ESMTPSA id y3sm312838wro.36.2019.10.24.15.04.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 15:04:14 -0700 (PDT)
Subject: Fwd: Error messages are sent to stdout, not stderr
References: <9b73d6fa-5627-f2c2-0bff-628b03b95af5@gmail.com>
To:     Git <git@vger.kernel.org>
From:   Alberto Salvia Novella <es20490446e@gmail.com>
X-Forwarded-Message-Id: <9b73d6fa-5627-f2c2-0bff-628b03b95af5@gmail.com>
Message-ID: <c8b6144a-fec5-4a3f-1cb1-a704f25f97da@gmail.com>
Date:   Fri, 25 Oct 2019 00:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9b73d6fa-5627-f2c2-0bff-628b03b95af5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HOW TO REPRODUCE:
On a unchanged git folder, run:
git commit --message="Test" 1> /dev/null

RESULT:
No output, as the error message is sent to stdout not stderr.

By the way your list will filter the simplest HTML email.
Reply including me in the recipients.
Alberto <https://es20490446e.wordpress.com>
