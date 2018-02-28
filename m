Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62941F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeB1TJx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:09:53 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39131 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeB1TJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:09:53 -0500
Received: by mail-wr0-f178.google.com with SMTP id w77so3575206wrc.6
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r2uP3wtI739OnYYmgPpVrGEVnncZE0Ih7eY/TSQNHus=;
        b=LlOxNnikpS6GsEl8mljPBHG7mKCYAH62XOXoZA6VNuC/HW6IPQZKYvNeq2EwkOa8ZU
         3KwiecSq3Os+jgBWoDs5eQjbMQ9wdWbXEbVi5oFSU4bmy5vVEcIlOta5AwfgV0B3P9Ah
         Gej3Jur8YGxVnkuXU9BtmWKzineJkIVghoyjsJ+LZVLuCmf6Pe6eIa37VUmNhaTjRelU
         cqbryf/LXRaIHYmx6nxSQZgt8qMFpnpBa8fy8xxwPE/C8HkdBreEmOz4IJvVvVmw0Bc8
         15xyjQHfmOHCF5RrQV2SHWr6s/QpzmZsiGWmxC7uS5vs2O5dnR4fqZPmJ33FGHINSvi5
         0Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r2uP3wtI739OnYYmgPpVrGEVnncZE0Ih7eY/TSQNHus=;
        b=UqPt+ezDE3hgsGaFlM81vvgNZ/xD6jOV/KLOEmVCDQiU+Cs0/UhhnMQf57R+DyJz8m
         m7jqlqB/GnB0jnvLhVByPrhlV1RzQgRCDtd2SlzvffJgYIq5+mIyPyh5yOksmgyxk9U2
         NB62AXh+gk7Dfg07EU2Aa8dwStndO7POPlDAk4CjTf6uPDgwSv6rIsJUPVBFd6pRDbXi
         xXufVXLwBVaJKHA0emHoRcgL+48LIRWOZasKpq2WO1ymumtHeUdBS9WpZdj/qjtSzoAn
         2av8O6TaMzmHyfdKLEH8g7wf8mrgZkdEQQk4sOc8F6/jQqfDU9lc+4Wz7lamspKLcTlT
         t2IA==
X-Gm-Message-State: APf1xPDhUpBVBfHrAJXTnmxkYqt0Ir44P4EhpcGEwfAT0TNp00LVhVw1
        ZiCZFvTTc6tXHlPHpYle83fmccq5
X-Google-Smtp-Source: AH8x225kB8VyCjIJ7BT9LJLt8szasdL6xQp+gkAops5RFg/lLc8u7TDFKuO3/MuTVwJs11NsUk1fWQ==
X-Received: by 10.223.133.140 with SMTP id 12mr16070803wrt.192.1519844991510;
        Wed, 28 Feb 2018 11:09:51 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x10sm2186783wrc.64.2018.02.28.11.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 11:09:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] Moving global state into the repository object (part 2)
References: <20180228010608.215505-1-sbeller@google.com>
        <20180228021530.GA20625@duynguyen.dek-tpc.internal>
        <xmqqy3jdknar.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaurxM+Daa43ZQ_LCn6HbiaXex_NtO73g2ip70RUpjM7A@mail.gmail.com>
Date:   Wed, 28 Feb 2018 11:09:50 -0800
In-Reply-To: <CAGZ79kaurxM+Daa43ZQ_LCn6HbiaXex_NtO73g2ip70RUpjM7A@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Feb 2018 10:59:05 -0800")
Message-ID: <xmqq371lkk1t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 28, 2018 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> Looking at the full-series diff though, it makes me wonder if we
>>> should keep prepare_packed_git() private (i.e. how we initialize the
>>> object store, packfile included, is a private matter). How about
>>> something like this on top?
>>
>> Yup, that looks cleaner.
>
> I agree that it looks cleaner. So we plan on just putting
> it on top of that series?

We tend to avoid "oops, that was wrong and here is a band aid on
top" for things that are still mushy, so it would be preferrable to
get it fixed inline, especially if there are more changes to the
other parts of the series coming.
