Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05091F453
	for <e@80x24.org>; Tue,  2 Oct 2018 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJBQ0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 12:26:18 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37774 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJBQ0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 12:26:17 -0400
Received: by mail-lf1-f48.google.com with SMTP id a82-v6so932130lfa.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=OFO7fVmKVJ/EFpMCsEf542jgvMNSQkRH266Jo7JlsEc=;
        b=vZh5s2dY5amxVcbrErSy4WgE0tZG+JKQ7CT5tKanAP59z6FhUKHs9oN+fiObAAOD6d
         IhtkEkxkpQerLkGQTf1dmKeWIbPJCEggiJjy6F6hLNVytNDiULEk1cPR8WdfTybLYv90
         e+MtjFU1KGU/0A+GqYHuARLZCefTC7nfYFBw5wjBYxMqXobEqwRebIJyVkXFKACteCLw
         1X0gxaHkKjk15pa3LUzZw8rW4zq7zQMA0sdXEFCPSk/ilXGrvEb3sYdrNKAPJcvhSdqU
         Fpyum/duvDHxLdH5qkYxmKtbNwKUeL0q84Qy5vdgvNouQPRMPILIQlBdl7RCMQl9h27D
         umjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OFO7fVmKVJ/EFpMCsEf542jgvMNSQkRH266Jo7JlsEc=;
        b=fv5y/cYJHCF5UHu1YHwS2Sb6FU39avwuMV+JfSUQsbrgztFEYtk+C0+xscHWDiaiGl
         ZHyv8/6XpYvLoGRXxBxtzSrnWyya6gZEEfSddO5jA+GWTiiHPFFtXOE+WM+ytshQZBMj
         6YchQ/HY9jKIMsFEpaD2rlvpvsHbdC+Gu2is6mLcEFEdtY2sv1fIXHqlOzIHLAtS935r
         5pAvD/smNU6LTCQmg5yJyLJ3Y+TK58uNuPNb9wJw3w/DKIM5noyGXvFgaVO/S6Y2siTq
         TC7gS56C5lrHl7XKYDzUgGzd00mc+UM4VWaM+FNNEYuXaB3wUNw8RLi4gwPkDNXcfkp0
         jOPw==
X-Gm-Message-State: ABuFfojPAbOrAe3sMGlWDGzU/gX2nl4sp7e0E/J4vMkF2JRq8tUCgKJR
        2zzW+LSMwpNN3mccXULrw81uUcxc
X-Google-Smtp-Source: ACcGV620bmfgOitNDY3u1JylEJ8N6T0+JgHBxoABraPLSD0fLo6xNpUxX6AaLSE/2rn7wKq4ne109A==
X-Received: by 2002:a19:be46:: with SMTP id o67-v6mr7543081lff.139.1538473432658;
        Tue, 02 Oct 2018 02:43:52 -0700 (PDT)
Received: from ?IPv6:2a01:110f:d32:a800:abd5:65cf:ddaa:57c7? ([2a01:110f:d32:a800:abd5:65cf:ddaa:57c7])
        by smtp.gmail.com with ESMTPSA id u6-v6sm3277303ljk.62.2018.10.02.02.43.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:43:52 -0700 (PDT)
Subject: git-remote-helper list command question
References: <e63531d2-d0d9-7b37-480b-b7f2a40782e4@gmail.com>
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Stanis=c5=82aw_Drozd?= <drozdziak1@gmail.com>
X-Forwarded-Message-Id: <e63531d2-d0d9-7b37-480b-b7f2a40782e4@gmail.com>
Message-ID: <384e746b-4ca4-1f5e-0c58-accac06ffaf9@gmail.com>
Date:   Tue, 2 Oct 2018 11:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e63531d2-d0d9-7b37-480b-b7f2a40782e4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to write a fast-import-based git remote helper, but I'm not sure what the output of the `list` command should look like. How can I find an example of the format in action?

Thanks,
Stan

