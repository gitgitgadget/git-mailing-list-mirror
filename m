Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A90120401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdFUSSi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:18:38 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35155 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUSSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:18:37 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so29409315pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LBOgjo80iS24LVYZ0h7riQvx3rBT1l7P3iqnPUb5/Fs=;
        b=HmOsnjqohYvTi0+wVtOe9ROksKAEZiiAQI54YwydRiB4E04MkhdMqp81aYzHZGEX9y
         fBeaLcBvAvcnbt4SKXzNbshBalGNGtxPeqube55mtaaAAWjo40H2Ie7MqHeobhgWYywx
         jr+voz6wOXJKUIVpJ+1/RY50bKPqGk+L7tPO4Np8TSNaEHv22YkFYyVJAnUe1GAGTjrn
         lWns3whfpvFgAgfqXQYBqLlCVkBM9geNukXKW4J+72oxNt4qQnH3oUV1sEgpri7zpwSB
         AQDvSZbarPNX3ekqUREdU4p5I4RXAE0eWXsG4c3zrX7zkB7ojlZCpp8G/VWNSNqGjVVn
         q7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LBOgjo80iS24LVYZ0h7riQvx3rBT1l7P3iqnPUb5/Fs=;
        b=lQ0Ic6xzutJXU5+hQCh/xCjkv+aJNjjnL+iNdGSO6L5qwk+qpaQ4caxs039T8pBXsB
         CCyUYEv4qGvA5gihVgS7T0kvAAEYkG8i7XzfhhCRmMkQHtacIYRgrsfjJ/reR3whpEsJ
         dcdPGhyfsFZTEmmgHf+UVmsZGrJWSGAmLO+ebiUmEYGoqtwkgbXAXLOf5aSxEbkHXqDb
         BydKOaTWf4ozZT6+tMrs6epT0SAvnx2TjV9qWC7n10KPVUdtlVbVjAd/n3lGid6XNJG0
         GyJbW25bGY2Gb7D2Vuy/nmslNjE24Wr513bZgnHjQxEaquINMeWKMe1j1Pwles65/P5P
         jC2Q==
X-Gm-Message-State: AKS2vOxDeZoLRD958sFgXijRJJQTQ0xtnDfqVhqTt9fl/wWl8lO142bC
        Q4B/e8hzluBi8Q==
X-Received: by 10.101.88.13 with SMTP id g13mr38153163pgr.180.1498069116482;
        Wed, 21 Jun 2017 11:18:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id 84sm34426154pfq.125.2017.06.21.11.18.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:18:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 0/8] Improvements to sha1_file
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 11:18:34 -0700
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 19 Jun 2017 18:03:07 -0700")
Message-ID: <xmqq4lv9qk5h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Peff and Junio for your comments. Here's an updated version and
> ...
> Jonathan Tan (8):
>   sha1_file: teach packed_object_info about typename
>   sha1_file: rename LOOKUP_UNKNOWN_OBJECT
>   sha1_file: rename LOOKUP_REPLACE_OBJECT
>   sha1_file: move delta base cache code up
>   sha1_file: refactor read_object
>   sha1_file: improve sha1_object_info_extended
>   sha1_file: do not access pack if unneeded
>   sha1_file: refactor has_sha1_file_with_flags

If 3/8 came before 2/8 I wouldn't have been puzzled by the latter,
and I threw comments at a few minor details but overall I didn't see
anything glaringly wrong that require a major rewrite of the series.

Overall it was a very pleasant read.  Thanks.

