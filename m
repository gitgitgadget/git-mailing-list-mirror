Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822AE1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 04:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeDPEvP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 00:51:15 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38292 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbeDPEvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 00:51:14 -0400
Received: by mail-wr0-f174.google.com with SMTP id h3so9454289wrh.5
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wL+gbIjD+DTXaBiwKvfNLID6ZkeEot8wFjUopSOnNJM=;
        b=qacjtSZxYa1qhptGYOKrdr5h62wee3/Hg//IOUpkX2R+8yKoWkWtMxwo8m4KEb2/P4
         i2K3uww2CxxBSb8JPl/TeadCfFU8fIK0I46SGWg23OCCdRDZQYxwUtuoBr6grmNEx2C9
         2XNEd8UrpXAwyl6zMg/Ut06qnnvdwGFLdBillNYXdckteZmad5rmF4SVKwrA767mrL5A
         2mussH/1ShWudwu7d1SGig4kHmJDhSc9FBuSCF58RTQYmhF7W9EyIqB4zWVOf/+KKmh+
         jLkNYAHITxe+3vR/ty+wBLksmq9GEZwfvzawVCWWKdcs4hBZZy2dhEg+gIUbRokhl4zk
         kuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wL+gbIjD+DTXaBiwKvfNLID6ZkeEot8wFjUopSOnNJM=;
        b=LVsHV/NcLlKXFFDA4/oir8b0h24kdHj4Vhu462VXCIdAHwHFFkADXmxk1MD/EJPwv2
         504ZrkeMKawDShmmB8PBsz5niznv33bEOg2zRfK6X284pC64HANtGlw2dDcfqm7Swqyf
         ydmYwIcTJW3d/QQtEp9dATx7LzZjxHPUX+Ucauc0XQyJQDsOeRC54IuVQyVag4rJcn5f
         NoZLD/qUVh+Y9yICT8FGSI10RfBsHDNAlaes7GoX6MPsLe5h4cYaG+CtNmkvilwoHpR9
         Y1AgsaoBWRNAMioSWhpR7+ZzBUPnRvClwYuPLNS4UFCWiYJe4u4jmQSb0V5NIPKpZIpD
         xJgg==
X-Gm-Message-State: ALQs6tA+MpIi9PFbSji5P33z7lkBoPD+Tcc8ammPW+cfQz0d+vdlGRrc
        U+CALrXGft3z+Cur1Ays1DM=
X-Google-Smtp-Source: AIpwx48PsNFueNr8WFf6menVJ6soCwtZSir5dvdDd1/5QjneZyAr2zAojZ4K1YYGfEW1rj8hbvAq5A==
X-Received: by 10.28.174.10 with SMTP id x10mr4005829wme.102.1523854272646;
        Sun, 15 Apr 2018 21:51:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m20sm5564224wmd.7.2018.04.15.21.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 21:51:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/7] nd/repack-keep-pack update
References: <20180414152642.4666-1-pclouds@gmail.com>
        <20180415153618.32019-1-pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 13:51:11 +0900
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 15 Apr 2018 17:36:11 +0200")
Message-ID: <xmqqmuy3ycsg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> On Sat, Apr 14, 2018 at 9:47 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> The only (trivial) issue I found in the patches themselves was that
>> between 4/5 and 5/7 you're adding an empty line to config.txt in 4/7
>> just to erase it in 5/7, better not to add it to begin with, but
>> hopefully Junio can fix that up (if he cares).
>
> Fixed (and is the only change in v2) in case Junio has not picked up
> the last round and fixed it himself yet.

Thanks.
