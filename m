Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494531F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFCVzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:55:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41029 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCVzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:55:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so1502724qkk.8
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLbRahN7EjCMX8sBIsXAQwhcEJANkYXMUHR/E6mbVL4=;
        b=pn0O7FNzOQ6WIQQAkhe9AtGYIjbwqaSwD8xPNNSvchf29htwyOFr9vr0P1MhAcBsOH
         7M8Cab8IzsWEzjuctCkcx7LqPS4EgOppBkXVxoTQo5YLX0VqpimpAoNjDu+AC0O8OfeV
         lcYh4I+LdIfgtO6Gd3ML31RrRdeOmnwQH8UOidLvDM12lTqkop9QKqvfL6M4t+Lh0pwE
         OTlY+7ZimLgdEOAvJhBmMDDvSCv/jIVTAMK5xzybHZEb5Kk5/0dCXqlXYh+xUYVqhl43
         O7itY1IHhxtVuJAxDBoeHK95Hw65dLUygBSlQ8Y+JjCHCqkOcDF89qdJsc+Pat9WHOvy
         xtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLbRahN7EjCMX8sBIsXAQwhcEJANkYXMUHR/E6mbVL4=;
        b=DRa+ZWj5mJgcWot/lPFJ2zYgOs+6Ga+gLXUfPSBGt0ME9KS7jvU9DrfpT4dwrbDfy4
         +UTo9zF0+2EP8kBvr/e0LSH6erOFsjGVKvQcEFKzoKOBjnN7HaeZsRKzK8UTZS7S3V+U
         VsaCA2baVKeI2APfQ/2V0U1lipDwKwPZ5IH5svCr3vEpwSO5PzvrCxz2H36iR65fwk+f
         vPJ596Qu+ptFiFRYaFU1wF8WeKXfKFNjUrcO5WC7AHUXqjLjw5jG4p87ew0ZZb9pOYw4
         mg4nVUGu2PpjLTvj3ArMrQtHvRWzbvncm4A7pviwjxbswOOlzwPlXPaO4fhu50a8+uNX
         0VlQ==
X-Gm-Message-State: APjAAAVYB/+GI3kUBdh+j1RR0fb28JowOWJs4OAQ5vSS3LvQroHvjM+v
        RurkQHVzTuu2WhpcrcltXfDiqicH
X-Google-Smtp-Source: APXvYqxVrxlkB9pvD6v7PXpPJNZEfukOsSkNwcB+fsaN9zr1in6SNqELC/faSUrxrPxMCzhaYByFXg==
X-Received: by 2002:ae9:ed48:: with SMTP id c69mr23490870qkg.114.1559595351269;
        Mon, 03 Jun 2019 13:55:51 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n48sm6983262qtc.90.2019.06.03.13.55.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:55:50 -0700 (PDT)
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update
 config defaults
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c8f4d8d6-d8b6-efad-4bfd-472af6617123@gmail.com>
Date:   Mon, 3 Jun 2019 16:55:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2019 4:18 PM, Derrick Stolee via GitGitGadget wrote:
>  1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
>     'large' as a value. 

I do want to point out that this "core.size=large" option is probably a
terrible name and could easily be replaced with something better. Please
consider alternatives that better describe the goals at hand (helping users
get performance boosts on upgrade without needing to pay close attention).

Thanks,
-Stolee
