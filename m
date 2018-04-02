Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DDC1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeDBUeg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:34:36 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54573 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756412AbeDBUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:34:36 -0400
Received: by mail-wm0-f47.google.com with SMTP id h76so28381353wme.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L3o66JNpaWsPlVEEz/2WuvJoofjRq7E7aKopOIqBVP0=;
        b=FQ19C+jsar0hWqV9Al9TIuWsQggZ+8qlWoiDt2cNEuXEqDZBXOuxrT+UaBz0gFBXfP
         0RJVBULoAQDLxlh+gkXRR/xb5RtvIQWxbgx2fPeNK1d7E9aBm7MI6tRl2tfDbYgmyZfN
         6QVwuaIM9F0yLNm5Z2oLuYcreOhBI5vC3SsquHtrhMM8mEjfuxWUpOh8vPsyKqX7p7aS
         bFnRNOYCHbjbZscyPwu40uoZGN374j+5pL7Pqopn9Uf2mUACbyFm9ZmsIWoLy2UJCGZo
         ndORAZ58bA3ZPHcHWXXXWqlW6skbsidPkmuWKxKEiR+s6SbpqMkeCNgSoUXcV3xWH0om
         YU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L3o66JNpaWsPlVEEz/2WuvJoofjRq7E7aKopOIqBVP0=;
        b=lECz6KDdHYb99pN2sILPv1K1Jcf1Rgs64ww8aNOCZi6oLvaaBHKycDhbKCqfBxmAD4
         gZdO0iwKgBAcXyjSb58LVqnVkKhslT+Px2uXg3yExd2TKlQLJVXKNDesSciQQnqqix2l
         Atv/Rh89MkM6ku7n94iQU9w4vOMvy1jwrnoRQ+UsO7JBnCvbcjAuiC6YMHvMTHE4lwVI
         BvH1MS1aoeV7oYv3PrWou5EQAfPpttUOe6cHS5BX6d+UabtJca4zqEa37/E4EF6tu45N
         bgcPhDN9zSgBj6BKfd/B8NzD5QjZTU9e+1UHQzQPSlNUHzii7cRqeKwPMH4wVk2ukZJ/
         AESg==
X-Gm-Message-State: AElRT7GfsHjUI71F14cDjjq6IOY7tunLeSq2Fr6QcbGH+K0Ev9yg2Puq
        Vq8uq7VQpCaIB4Q29iNDZI0=
X-Google-Smtp-Source: AIpwx48Q+mC+PMRkhR99A+XiiEfEi9DKWrk71WJg5T83+bI1edV4IFTo2o+hwteZIkh2TrfTavpmEQ==
X-Received: by 10.28.198.77 with SMTP id w74mr2030855wmf.36.1522701274740;
        Mon, 02 Apr 2018 13:34:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m7sm883387wrb.61.2018.04.02.13.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 13:34:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/6] reset: introduce show-new-head-line option
References: <20180325134947.25828-1-t.gummerer@gmail.com>
        <20180331151804.30380-1-t.gummerer@gmail.com>
        <20180331151804.30380-3-t.gummerer@gmail.com>
Date:   Mon, 02 Apr 2018 13:34:33 -0700
In-Reply-To: <20180331151804.30380-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 31 Mar 2018 16:18:00 +0100")
Message-ID: <xmqqsh8dxs86.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +test_expect_success 'reset --no-show-new-head-line suppresses "HEAD is now at" output' '
> +	git reset --hard --no-show-new-head-line HEAD >actual &&
> +	! grep "HEAD is now at" <actual
> +'

As builtin/reset.c::print_new_head_line() does this:

	printf(_("HEAD is now at %s"), hex);

this needs to use "test_i18ngrep !" instead, no?

