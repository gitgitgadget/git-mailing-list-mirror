Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1099620281
	for <e@80x24.org>; Tue, 23 May 2017 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760224AbdEWNGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 09:06:43 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33462 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760033AbdEWNGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 09:06:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so114387105pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4//5SKygMA39x+TvRu6/NPImz6wrXwGFdWeERGY1Ppk=;
        b=Tas4WzhVqZXlLCWQH/0L2ddcE3Wp/MNkXexolYkkILe4CMBjMmfi15TMq1wb5BHsZd
         yBOiXEwI4zhf9qbzsbbWDpHeD/+GNwjt5NBgjl0jzCJ80s7MfKR8qbr5CQe0VkY9URux
         HelYr3T4vQZQdt2f2r6Gx/AHm1VlhcOrOW616YZ2yV4Nq6NMZ8kVX71M6fqVtvPnVhJJ
         MgRW6q2DZ1YF490SoZS/NxN24i/8gx2B+/A8QyB31r4mWwzAsVKcCUCxALP4R8FrwDag
         lxb62Nbu66CPQzT9UV8YywFm3keSf/XBWYftdqW+H6/jDNyEIwtR6cTHErfb07kiafp8
         A2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4//5SKygMA39x+TvRu6/NPImz6wrXwGFdWeERGY1Ppk=;
        b=qJR2hFOnr0nMN95mWmT8TnjUgM3Hm19xEJaTICFAfdXEZG7Yx0TQBz40PLcZxCta+i
         vL23h8Ac82tnXYzNQscb2xZD3pi4CrnE7cDp0uQePoA9FvmTZkypPB0C0qLM7TrW6fvU
         AtyZ5OC/qy+jvt0BtSZxve2mE7S6R9Tsgxhfu5N2+zp+dHEnjJwjfYWHP8hXAH/AOrPG
         jZrRX+9rAQply9uDS4bT8KraqsTKyk1OrDrPcA7qmJziy8+zdaKpHtYoQ+jCtBfCj3xO
         G1NwXBjHrLd/BbQujUdAStEGQDTPdoxEiYJAOHETYgTG/iWwG6Pxcb+lhA6+nSHaSDcs
         WFIQ==
X-Gm-Message-State: AODbwcAuItLIpT8Tflw11ESOedB/bdZAjwOJDn+UwbxmpclB1A8ua/Gw
        x+lOq226wRgofVux/+f9NQ==
X-Received: by 10.99.42.199 with SMTP id q190mr31531119pgq.13.1495544791316;
        Tue, 23 May 2017 06:06:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id r64sm1649965pfr.38.2017.05.23.06.06.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 06:06:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-1-avarab@gmail.com>
        <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4d4-EGiUtJQT8cvuMzm0c5DUu5sxUb11kUnJu3ocuSHw@mail.gmail.com>
Date:   Tue, 23 May 2017 22:06:29 +0900
In-Reply-To: <CACBZZX4d4-EGiUtJQT8cvuMzm0c5DUu5sxUb11kUnJu3ocuSHw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 May
 2017 12:55:15
        +0200")
Message-ID: <xmqqo9ujk9ii.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Seems like it would be useful to have a way to ex-post-facto say "past
> history should use these URLs". i.e. if all git.git mirrors go down
> and we have to re-host, then you can just clone git.git and off you
> go, but the same isn't true of past submodule urls, or is it?

I do not know how heavily you are used to use submodules, but I
think submodule's URL is copied to the config of the superproject,
and that URL is what will be used from there on, so "past history or
future history will use that URL" is already the case, no?
