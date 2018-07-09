Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D0D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeGIWmX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:42:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37298 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932993AbeGIWmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:42:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so22323984wmh.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PbLl+6PdfqEnyB3XWnDkwtdcjxHNJUHuY6OSuK2ZRlw=;
        b=sm2WPkvohdlXcJ+HkSYNMCgfb9kdSqxqalmUkRc+ngD/dIK0K5OgRO11zjd5AcagLe
         xHGj8VnAoPrIwFJ9JqFoRJ542GFRs5f7TG3KWG6KXmN1wP+SJc/Tv2a3FCMMHA+ho865
         r+sUvOccSERQxVNPzCiBhefXzPhHaaKNpCU49ZKSB9838MOviu3COJ4bMZlGyRFJ0oyF
         gG6rJSU9tjLqBGPDq2PZy1wTFP4tH8lhsGp9IczL251s8KKHJQHPBgRL5X5OuWKIZy60
         q6KMd/HrpaYtDzN91jGQvNqbaww6ivHCg53W8Cgw1zvvXWZdmSlHhT3Swo8uiIfEeDz6
         /Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PbLl+6PdfqEnyB3XWnDkwtdcjxHNJUHuY6OSuK2ZRlw=;
        b=AIi/tFWoIV8s7ll38WwgNv5OIQ6Y8eKnYwhq0qAuEvt352npTpvcTeHRDh/6xcgK05
         +9FvNS7IMc4xnj1PeZn1CNJ47t/SjGMsyYmyTAr0hcSKlA5ePH/+cVu/854K2hDwd43z
         0Scy1FDcbj2tNcnjq6IyO3+aePqUJYLWyeum2ReT/JMa9Qi2humKtrf3O3EZuuUqX/2X
         rITkDdyisiw1Yti8/lM8TD85CL/tFltEtTLMI+/Kpfk+qRxZKjnBzTkzyOncYpiCxIT4
         AKyFIN085UUnTaW/vmHLRTadbhBQjh8h5CJBAZjNCeAKKkI2zHUaS1+vLj+jSJSg0wv8
         5Nrg==
X-Gm-Message-State: APt69E1Z8cpvi1d1vLROqoXPhUC9C8t0l1LWl/6aFPv1sobRb8DYqYZ2
        GGNZWwlzktA2OzBzistzGFwJ2cxl
X-Google-Smtp-Source: AAOMgpcwGGSYYhavh5BXzmoUotJoxOPebLgig8yaB7e820zhFhDEdsSxwMTiBFvrr820i5En+BXGbA==
X-Received: by 2002:a1c:5cd:: with SMTP id 196-v6mr14179667wmf.114.1531176139670;
        Mon, 09 Jul 2018 15:42:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s11-v6sm12630193wrm.42.2018.07.09.15.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:42:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/4] Use oid_object_info() instead of read_object_file()
References: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
Date:   Mon, 09 Jul 2018 15:42:18 -0700
In-Reply-To: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Mon, 9 Jul
 2018 11:27:21
        +0300")
Message-ID: <xmqqva9o9gl1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

> Hello everyone,
> This is my new attempt to start using oid_object_info_extended() in
> ref-filter. You could look at previous one [1] [2] but it is not
> necessary.

Yup, it sounds like a sensible thing to do to try asking object-info
helper instead of reading the whole object in-core and inspecting it
ourselves when we can avoid it.

