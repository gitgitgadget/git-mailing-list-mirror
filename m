Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC76F200B9
	for <e@80x24.org>; Fri,  4 May 2018 05:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbeEDFnV (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 01:43:21 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33392 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEDFnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 01:43:20 -0400
Received: by mail-wm0-f49.google.com with SMTP id x12-v6so5546619wmc.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rL8UYqwQw7ACZKqfrGMRhaC0PGii23MXBZRMeYAfWUI=;
        b=aKwgBBwHWzW8J5OnKKA0Uz1j3jqvmshop57EgVuvJmO7OS0V0DmqBiWKHpUCGMV64H
         2YQgZdyO+P37lfqLiqGISpSnuNjmDYasyd48lr+HaKK44QRpIswSwDgijwh8axP9vaPS
         AZEGFJdAAFt31D9bWeOkD4CRKGes9wpHcRB8mKQMszfIULDt8MZ8EUALE1wlGNJMcAVB
         CfHkEpO9olOhu11W1w9y4bBKYJFhlSZNBUT6ompbQYmLGQQFfMgRK4LiRDsJu0a4HAQB
         5ljPwlQrGdIj+v6ZLTz5Gn0Z+BF0gtuyf6pP2G+yacYLQIdFCR33ULwAsHdMp+7chwnC
         jQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rL8UYqwQw7ACZKqfrGMRhaC0PGii23MXBZRMeYAfWUI=;
        b=rypPUJaCVuOe5OCJuVTCZ+M5n/ef/x9QJzi4wIYALRLsIcQfPx4ZfQBNwMSB8XlsXa
         t1DDdBSGq39zAhYmTePt6c9nvnVR1Bl2gSmtyDTUmLLAIKY21DqTZvtvrVumsLu1GWTH
         l1ZFkEkrjvp7C4coREsCkTU73uISJUn9nCFPTvmi88HriYZsQdk3jbf3tWdzlMNV6RQX
         fagDXu0229bcJ/Yzb10FjScbkXsQsixXW3+zdKat52kDIErpdhYGKekmayWQlLbWh/y8
         GcOt1dEykf0zM6EJnQQDBpIPTLnRa63LRKm5NuqGVuoG7rJDFzSRgGfk6bo3+gq+9euK
         BE2Q==
X-Gm-Message-State: ALQs6tDKKiWusMC9TVCzHwPTpbxc9b/3UsQlnpQe33Un0XAs+be/10JP
        YcKh1Vu8rNg22cnJi5dnY/frFVtT
X-Google-Smtp-Source: AB8JxZoMjV1I9JFLaK8Y5NqaBsE0/Pl7Kt/9wY9V9UwnF/1IwoRG44QBy+4B8Yt/flP2rZIVFrhTPw==
X-Received: by 10.28.170.84 with SMTP id t81mr16965527wme.130.1525412598830;
        Thu, 03 May 2018 22:43:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 77-v6sm1408223wmt.11.2018.05.03.22.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 22:43:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] git: add -P as a short option for --no-pager
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
        <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
        <CAPig+cR8M3NPrJdsinakLoiFWS=adv1B7QH7Bwp-9ePr_44N_g@mail.gmail.com>
Date:   Fri, 04 May 2018 14:43:17 +0900
In-Reply-To: <CAPig+cR8M3NPrJdsinakLoiFWS=adv1B7QH7Bwp-9ePr_44N_g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 3 May 2018 16:06:06 -0400")
Message-ID: <xmqqwowkrn62.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> available. Provide a short option, -P, to make the option easier
>> accessible.
>
> s/easier accessible/easier to access/
> --- or ---
> s/easier accessible/more easily accessible/
> --- or ---
> s/easier accessible/more accessible/
>
> The patch itself looks fine.

Thanks.  More easily accessible, it is.
