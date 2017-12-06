Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC3C20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdLFPI3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 10:08:29 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:43927 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbdLFPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 10:08:26 -0500
Received: by mail-qt0-f176.google.com with SMTP id w10so9587937qtb.10
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HUZIZt9tIGS2zE/S6Sx971Y/ugw3LJwH014TnHgxfmE=;
        b=rLfSb9BcsynwCi6kqJJHFVLqE8uIShFXz5rCMwAJbg1Pl7VA7OCLAl+UtCenY/xxb0
         TjkSH6iToUh0HC0z64lSzXo3+JUUnd/KjwO+DzdEO8H5tL5Z+z5bDcSoHsIS+brGTh8r
         i/CA1+GUK6/XCpU8quBo5jFhs3DE+kvtNPjK3fGahNNyvj9A8K30rWpmAHJYNrB7zzDn
         DPYe1xYs7rcLkoDyWa/8PwR7fGLELzbOO3grZ+6do2JmA2CS5qjG9NFpxqUR8gBBJUkr
         9BRFUxgNOnRP2S7U9Q3rzEK6etXyMoXk7B9jFHMMBiVnsoFpovTayQKufgR/XYcO/gSO
         hePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HUZIZt9tIGS2zE/S6Sx971Y/ugw3LJwH014TnHgxfmE=;
        b=WNVdGlhDGuL93HlsWV+X3m8JB9jUpRMatCaAdiw9c0ZtjSarCtm9dv2OooH0lGECr6
         phSNiT5tzG4SAo/BhfX/Me2HEQMkQOyY2haWWFfXloXfptaKgvy1zCFtMVEbXMy8fKS+
         HpztrZI1ydEL+J7c9GnZiORLqvU30jSTpKnRGdQaTRStGfg7FE+K4WqM9sMV7vAVvEd1
         Gqf2bcaJo70p2xEXAkORnirT4rjaAbnkxgl2bwiZD5B6TNw6BTrdDRp4kZlGptlBxnvc
         CMSq44ix+6JFdI2HPwPviyRbgtLrgoWK8qfzx8HQy+87Bksv8JbQWHVQPPSX/C63lHwS
         gMWQ==
X-Gm-Message-State: AKGB3mL9SG1uHNqQGePkezlMfl76tkPUI9kPdACQmAHaMg5Dsv49DiV8
        kc7Rr5CpHw5R51PG0P61j8M=
X-Google-Smtp-Source: AGs4zMYiWb5emj3ogOz2RQ/eRbw4iphdUcOgBIYNAh5bDRU35BEQ771yc/ZfsKOpGPc2aftnQV3I9A==
X-Received: by 10.55.15.90 with SMTP id z87mr24989736qkg.141.1512572905401;
        Wed, 06 Dec 2017 07:08:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b140sm1518521qkc.0.2017.12.06.07.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 07:08:24 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: [RFC] 'unsigned long' to 'size_t' conversion
Message-ID: <a660460d-b294-5113-bfaf-d98bcf99bad5@gmail.com>
Date:   Wed, 6 Dec 2017 10:08:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several places in Git where we refer to the size of an object 
by an 'unsigned long' instead of a 'size_t'. In 64-bit Linux, 'unsigned 
long' is 8 bytes, but in 64-bit Windows it is 4 bytes.

The main issue with this conversion is that large objects fail to load 
(they seem to hash and store just fine). For example, the following 
'blob8gb' is an 8 GB file where the ith byte is equal to i % 256:

$ git hash-object -w --no-filters blob8gb
5391939346b98600acc0283dda24649450cec51f

$ git cat-file -s 5391939346b98600acc0283dda24649450cec51f
error: bad object header
fatal: git cat-file: could not get object info

An existing discussion can be found here: 
https://github.com/git-for-windows/git/issues/1063

The error message results from unpack_object_header_buffer() which had 
its most-recent meaningful change in 'ea4f9685: 
unpack_object_header_buffer(): clear the size field upon error' (in 2011).

In my opinion, the correct thing to do would be to replace all 'unsigned 
long's that refer to an object size and replace them with 'size_t'. 
However, a simple "git grep 'unsigned long size'" reveals 194 results, 
and there are other permutations of names and pointer types all over.

This conversion would be a significant patch, so I wanted to get the 
community's thoughts on this conversion.

If there are small, isolated chunks that can be done safely, then this 
may be a good target for a first patch.

Thanks,

-Stolee

