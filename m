Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C222047F
	for <e@80x24.org>; Wed, 26 Jul 2017 19:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdGZTG4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 15:06:56 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34638 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdGZTGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 15:06:54 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so71745501iof.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXN1SU3EbmgoqTJM1wv9vThDbqot5EYZSi6jVwrK3WA=;
        b=MGxHfOrHonVeh8AwtxHQSnMcaq9ILBJmesOCdbPXX3JvzQz1ORrCs1oAuevL4Rv2wH
         uUQxnttmOdwrNbT8jhN0/+296eOTcPGQpzS5TDZPdh5oJE8K6rEI3MxJwe9HNd4bsQeS
         q8Bx5Qo88SGkeNeMGWfVnihH7sspyn12t5aouDjPaVN3nJFuRd/aRpEgSE9Oal0qayMK
         CBs+sW44ga91JRkRZCslzwCj2kr2RTFIj9pMTyS9XoBbNiJv6re5jX1dPj/+miRzCxA+
         nFpPpJX+uo63s4fGNdXm6NU/F9pE6f4JbXbdnUY3p9Ipm5XQs5TvK2KhRK8h86sXHebb
         JF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXN1SU3EbmgoqTJM1wv9vThDbqot5EYZSi6jVwrK3WA=;
        b=AbURHP96JDhYkA67p1TmZRos94+oaFIrXpWOD/sUVPwCA9ZiP3q+Rp83pTLdQ1iFuv
         Bf9u9oD5KlY5V97Q3qfAXq6mwMQ6hf8KCVd7vQmNY/i9CQiVssNfkurXRkdYRlmTSC96
         Qxihj714+XYCmzOOFiF9S4YEfCwEyPtigGmG+XgRNnnYGG31t06bDUO/mTIlLvjKNKAJ
         Ik6qMWA+gvkfs8Oba10oAwLYysZ1/D1upyMhi/M+6fmdyJQXIT7KjmfCg+U39M+WTtVv
         ZMze1ZJx3otOBf52Lm9WWHoMd/cXNT2OaFE+r6oAAt0Vwjr32S7Mg5BxWtRIOxfyz4+9
         cRGA==
X-Gm-Message-State: AIVw1100GPUKF2JRleMIdK3o+CEp/liVI9bXg55DY059hitP+fWmuKrX
        cQa4cFAiv3ftEFli1EI=
X-Received: by 10.107.25.204 with SMTP id 195mr140687ioz.250.1501096013137;
        Wed, 26 Jul 2017 12:06:53 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id t5sm314331ita.22.2017.07.26.12.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2017 12:06:52 -0700 (PDT)
Subject: Re: [PATCH v2] contrib/rerere-train: optionally overwrite existing
 resolutions
To:     Junio C Hamano <gitster@pobox.com>
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
 <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
 <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
 <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Raman Gupta <rocketraman@gmail.com>
Message-ID: <32b61c4b-5e58-30d9-4345-8036bc805019@gmail.com>
Date:   Wed, 26 Jul 2017 15:06:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/17 02:05 PM, Junio C Hamano wrote:
> I haven't tried this patch, but would this work well with options
> meant for the 'git rev-list --parents "$@"' that grabs the list of
> merge commits to learn from?  e.g.
> 
> 	$ contrib/rerere-train.sh -n 4 --merges master
> 	$ contrib/rerere-train.sh --overwrite -n 4 --merges master
> 	$ contrib/rerere-train.sh -n 4 --overwrite --merges master
> 
> I do not think it is necessary to make the last one work; as long as
> the first two work as expected, we are good even if the last one
> dies with a sensible message e.g. "options X, Y and Z must be given
> before other options" (currently "X, Y and Z" consists only of
> "--overwrite", but I think you get what I mean).

You're right -- I didn't try all the cases. I wasn't able to figure
out how to get `rev-parse --parseopt` to deal with this situation, so
I did it manually. I'm not super-happy with the result, but it does
work. Look for PATCH v3.

Regards,
Raman
