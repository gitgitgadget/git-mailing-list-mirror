Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185A01F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBBSmJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:42:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38499 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeBBSmE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:42:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id 141so14239707wme.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wIrAHs5SvQfoUqX2ZKl5MUrJ2Hp2Ff01wXrZZzlqP+Q=;
        b=S1zwF22oOxUAjkGpQgRSkm27gK6kiJAe0FhgGEir1e8Bvx+l0ZoqzxPdfL38FIjfTJ
         nQAIbubK7KKgeuxRajLh7STVLaTNXRIBmtPn/VyHHohKDx8QDPOqISOnspspZ8MOlsFO
         cx9hJ4n8m6jNucu/3orRNCLxEkcFwlhbr3adBwmkKpetgl03h6GTHx6uBhYkB4yaMkGm
         6avh0dS1912fZ64qQ0BALw1/7Vd7qW6o9CtAfVmpID/jMxjZGoFIGeBH+YTcBLjY8b25
         Z2StPolaDRtp6WJR/lMEYwM+N5phPOl594+VP8YZ5vf0SPvFzyRupUdD9QtY0PrtUdMa
         nLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wIrAHs5SvQfoUqX2ZKl5MUrJ2Hp2Ff01wXrZZzlqP+Q=;
        b=C3Phhq5otTyFlhLDmiy4S/KnEzt1+W97PSKmifxkpuEdfDeHIlny7OnIlgkMm8glO4
         vVPEZ4FboaoIQtjOUDNYLw/QvE9kOd8AsugnHpMjSfT2vqXW5QV7zAFg4vlBcVtVRJYR
         ANjSNC8o6FoHtFcgla1K+h9Y1C8Vey3cDjBIVHbp2HS5Z50u9PBtnTXc6mdIbtAvWs7p
         KWizEvut0cpK07oI6pPimkcoqew0cTqIAJKKNGTnkq3EdCRahWiDS7uTQe5eCI5XBSVF
         Figw5FME39srikokHBQeg4dNcY7hPQiVRKTg2vhXSnpwC8+HpSn6A8il+AezfsBt1kF7
         cztQ==
X-Gm-Message-State: AKwxyteh6d0hzNd+rSHnZmjgVZEyq5YBfHF9t+w8A8HibbKKuLlFSjTl
        eb1ThjNJHoAivBH0u7FpZb1psWIs
X-Google-Smtp-Source: AH8x226n/HKoEd5pqIXPVqXvrB/dpTvQxCzl/GR+xhmG1u/ZI9HyGfKwP9ekDCKxDxT1Sbp17uZ4oQ==
X-Received: by 10.28.184.82 with SMTP id i79mr3112961wmf.6.1517596922498;
        Fri, 02 Feb 2018 10:42:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t4sm1258512wmt.16.2018.02.02.10.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 10:42:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/2] wrap format-patch diffstats around 72 columns
References: <20180125115927.16196-1-pclouds@gmail.com>
        <20180201124750.15032-1-pclouds@gmail.com>
Date:   Fri, 02 Feb 2018 10:42:00 -0800
In-Reply-To: <20180201124750.15032-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 1 Feb 2018 19:47:48 +0700")
Message-ID: <xmqq7ervdyiv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v3 fixes tests in 2/2 that I overlooked (but Jeff didn't). Interdiff:
> ...
> Nguyễn Thái Ngọc Duy (2):
>   format-patch: keep cover-letter diffstat wrapped in 72 columns
>   format-patch: reduce patch diffstat width to 72

Thanks, will replace.  I think we are pretty in good shape with
this change now.

