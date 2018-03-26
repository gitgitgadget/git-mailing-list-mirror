Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21351F404
	for <e@80x24.org>; Mon, 26 Mar 2018 02:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeCZCQN (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 22:16:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40784 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeCZCQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 22:16:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id z8so17259194wrh.7
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 19:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=08UktxqT+yeSRSXMemddNrN+5XBUnQxUOwnxjNSKAFk=;
        b=fPkJu0zEzv41uzxqfFaxJRfbpymCTYNK78Pkqzelvr0JLiztsI8KenO5v5jkxQdhl2
         KP7W/gcquEbe7OyRcYXRBamjHHjA1himg9kJft9siT6urbvU6xvc1vTkJUYWQm7ako9s
         nCJtXeflu/Jl1w/EmgbXF33i5m6rURvTkETnoccr9AZZrjYLEn3D7fO4qsO+tpisU+r6
         gNMF591utdbyLwF9IzTJuv08heAuATYXiENc3j92uRwWQ3rNK5V3mTU0AOzDKxwaHuu4
         DYx5OgbLYC9VSz2+R/HkUESU0NBzYWMrQWTu6DP6W04IS9VtFCuWvSt65qXaE3gyU5Bq
         FQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=08UktxqT+yeSRSXMemddNrN+5XBUnQxUOwnxjNSKAFk=;
        b=aEgtyhWBMJ899hlxv3GChdEm7Cll/ul4sqgY4Hlg6LOYKsjn02KM/9GEiGXkP9zdI5
         fOr3Rb6+U0L+qnviGkigFk1gE5DPz8fP+hagHlheV3QXCCYKB5SStj49x9onmw0vBPL2
         x7kcHr70RoJ2oBFAzzwLnJiC739GUey8bqnrp+3nnjdLE8QJ8CtoxYG/AltKE5LViIOd
         XNBj3qkrZFAt46YEy1Cj3HHPxRgFIVA0U34Z/KNYh54Gti9IJMeZYI2rfhxhsNY4JHLK
         nw7Glf2MXhIIf9FGXcvEdHu2jlS7xJppWEgjeuFbC2/ON4+S/XT3yh4yWoGc8Wso0gig
         ON5Q==
X-Gm-Message-State: AElRT7Hcood2nw/xzCfxBfm8EDn0g+Dseur4hMDJO5miZ8HVtErBpB6+
        1tvbdsm1MdhrAo4MNgM0F+s=
X-Google-Smtp-Source: AG47ELvXk1k7jD/I5LIxLhhXO4bwkPI8KLBFM+jloaxHu6/P6uMy3q4vhsYJ2CWP4AIv2MdmcJcciw==
X-Received: by 10.223.177.145 with SMTP id q17mr26488249wra.26.1522030571518;
        Sun, 25 Mar 2018 19:16:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s125sm13948356wmf.4.2018.03.25.19.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 19:16:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
References: <20180317075421.22032-1-pclouds@gmail.com>
        <20180324074505.19100-1-pclouds@gmail.com>
Date:   Sun, 25 Mar 2018 19:16:10 -0700
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 24 Mar 2018 08:44:29 +0100")
Message-ID: <xmqqd0zreg45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v2 fixes a couple of typos in commit messages and use the cmd__ prefix
> for test commands instead of test_, which avoids a naming conflict
> with the existing function test_lazy_init_name_hash
>
> [the previous v2 send out was aborted because I messed it up with some
> other patches]

Yeah, I was wondering if the 7 v4 patches for --keep-pack should be
picked up, or I should just wait for a proper resubmission under its
own cover letter.
