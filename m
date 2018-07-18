Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4C51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeGRTEb (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:04:31 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34673 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeGRTEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:04:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so4154836lfi.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xr0js/suIVN/B3/PQti49BX7U3af+WCIeMf1P1fIXJk=;
        b=NbYn6M/XzQUa/kKlcz46YkTsae6r78FHksKF1JZu9ibcVuM86QgL/MLij6s8jcT7jx
         D0FCNqA/djA79AdxWIAIXXefEkjaRf2nSPc3CzwHEAEHvLHq10GDTLeRm/U4MeyOZEGW
         JzGzPvMUce+tK0Mf9dQnrU9lMXr9Zq5XI3do4+fB9NC1BDH7qdZ4q3tP+6fvHr6eCdtr
         Y4LENc3sj/BOZRFgk9JTpBOOkrAwgHqJXAfeBUUEOBdwQ5KUjDwT8OAcZYKgU/G4TLzW
         hfoKDHb4zp+DBxjwghf+FaMxjCVdSH7EJI4TELsOzV9ptkJy3y0i7EYjDFkh1GWnzuu5
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xr0js/suIVN/B3/PQti49BX7U3af+WCIeMf1P1fIXJk=;
        b=iIYJnuq8Uxco5F8HmkfuivW/ZddmILuEbToYgC4FD0iLoj5jPU39NlQsEliwyhiKSI
         cB34hALM/g/ljksRfHUH6XBoXUoFpWZhmyJHKNExUM9JcmJbRPKAeC3K9L47fdJWqQ22
         Lrzn1qm825hum7VnWr7Ddh8e0JwPX8qCzU66HLeewP/cBWZHWP9SSinvw5wI6rp/bm0Y
         8OdamhFAj6BpbZHxKsqFCU/etVlk+jmTOW7Vyi9a4wW//BWXufbcpTeG4cTLsFjD9m0+
         0X7b6tDwjgAmwHY1Q2Se5ze6Tyw6pJB1sXenZ2oOKGdRkCOPjwBMSgKZTpwv2ehHo0MZ
         ZfLA==
X-Gm-Message-State: AOUpUlHTkV1X51ag5Rb8dl716hAEUEdSAmkb2Z9Nuku/Vu2pW9uddxpq
        DYvbA6fF8/ggC7sxa/IcIoo=
X-Google-Smtp-Source: AAOMgpfknZF01/grqtbbHMTO8iLapzG10XUS2ZfSCtq32pyZXQdlozkm0NmCvp+tz1vLx9CVqI4DmA==
X-Received: by 2002:a19:2c4f:: with SMTP id s76-v6mr4920387lfs.25.1531938322376;
        Wed, 18 Jul 2018 11:25:22 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id b22-v6sm726637ljj.93.2018.07.18.11.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 11:25:21 -0700 (PDT)
Subject: Re: [PATCH 9/9] diff.c: add white space mode to move detection that
 allows indent changes
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20180716230542.81372-1-sbeller@google.com>
 <20180716230542.81372-10-sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <1f7b84aa-5ddb-431a-baa9-16ebb5020670@gmail.com>
Date:   Wed, 18 Jul 2018 20:25:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716230542.81372-10-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-07-17 01:05, Stefan Beller wrote:
> 
> This patch brings some challenges, related to the detection of blocks.
> We need a white net the catch the possible moved lines, but then need to

The s/white/wide/ was already suggested by Brandon Williams in previous
iteration, but it seems this also needs s/the catch/to catch/

> narrow down to check if the blocks are still in tact. Consider this
> example (ignoring block sizes):
> 
