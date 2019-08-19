Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C7F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 11:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHSLxY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 07:53:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34898 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSLxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 07:53:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so1110938qke.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTKIZqjBL3tgQJx9pAh3eONKZ8q6pD1SSuXnatrBU8A=;
        b=IPFtVgWPh8i8+HiUWUwRKEM1x6KFNlKmfjiJhyNXgKCxEaPEak5Sys8iBzIGEY4Clt
         YAhPbBU9YxBB0MYL2maMVG83Idqda1NIfR4qz71CWV4swpcqISTnkOh/X/7xM1w7m4/n
         H2NSoWopy8iU/sQthkSCo8LaUJN/D6DBvXcNees1cnGv0pPbKasZ6hawCW1jgTZ9Z5wI
         rdlo+LdOAbr1I4vvxW+IkR9LUHThj3qKNA30sEYwKRHN8buW8TKW8een1Ml+EKz0ihyV
         XN4G8doYogb7eaQBNtX9Y5+WtMAgYmIsAIzKUThm4hDuMAR358YqMmx8p7PBXyyC2hAE
         yJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTKIZqjBL3tgQJx9pAh3eONKZ8q6pD1SSuXnatrBU8A=;
        b=gSlXiDqAH0wV7gnbvGzhS1PkSi9zRxG9njDD12hgG+kQDk6CTSZZTmeRk9uSC2Lt1X
         HPjztUcHkMpzntkhk2OGA/3DjrbdL5XrZ77mZSsxrTSkuW6kbmD2CSXnIKOkdzUTJQFh
         Zr91+Y0VxHF3bTHqfdkoa7OYVapq3tVh7GvYxeYzseqH8CRjNrsEIB8CsEWwSLahznpX
         h/45hZGImS6Zvu1/XiqaYrKY9wbM7/U0Lme3dNO82VyE3024JOwpgxYPdRx6+LDrEWYN
         8eWPHjSeEXfWWKwQopmOy3qWLvhzeqTxwlJwXPvsNRIL0WTmlKXYBMqcsgVPOmHADKTQ
         pChw==
X-Gm-Message-State: APjAAAVC1WeyyQDnJbtvsE2hR4vh56vHVqKgvQhD8A+US8mTuEsfQWER
        kXTtmQqJAWpZldYkE5/L0hM=
X-Google-Smtp-Source: APXvYqxZgUckWBIUP+fIDTzzdrXm3BYD6JsMR+q46+AgKsP0ZL5YAr2R6ec5pCVzJYKA3CduQn7YxA==
X-Received: by 2002:a37:4f46:: with SMTP id d67mr19485414qkb.367.1566215602982;
        Mon, 19 Aug 2019 04:53:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3cc4:beea:5454:ae58? ([2001:4898:a800:1010:edf9:beea:5454:ae58])
        by smtp.gmail.com with ESMTPSA id i12sm6411772qki.122.2019.08.19.04.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 04:53:22 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] line-log: remove unused fields from 'struct
 line_log_data'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <20190818182801.7580-3-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8893430f-e83c-85ab-2058-14e49580242b@gmail.com>
Date:   Mon, 19 Aug 2019 07:53:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190818182801.7580-3-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2019 2:27 PM, SZEDER Gábor wrote:
> Remove the unused fields 'status', 'arg_alloc', 'arg_nr' and 'args'
> from 'struct line_log_data'.  They were already part of the struct
> when it was introduced in commit 12da1d1f6 (Implement line-history
> search (git log -L), 2013-03-28), but as far as I can tell none of
> them have ever been actually used.

Good cleanup! 

-Stolee
