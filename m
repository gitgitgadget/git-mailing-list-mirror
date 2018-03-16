Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B441F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeCPRue (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:50:34 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38344 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPRud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:50:33 -0400
Received: by mail-wr0-f172.google.com with SMTP id l8so12536886wrg.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LnSRm7H3xVqD93njgMhLeMz5oEkqPBDQQgqJqiSeN3Q=;
        b=jTepgAXsNGLNbGQeWvS54AXw+u469czjP8GRohTRzSeF1hGsXFRFE0Ll14KZgIjSbS
         RGyf+BhRu7izD3H5X2X/LvKbmppDp+bVenOunZB2tW5WEUKvex4T4bphZA7PicV0O8eY
         L0jrFtSE7vfjRmMPQ9RQcngI+rkhvP07wm+FSBWE1WHXf/f9xAKtgiQZ3PqARHsMbLtk
         CJEfd9wkejBgbXbtW83fxJ5q5WcV0uNewxO0q9qERwu7LTPWDm5M5yZXi6+GR3rGAPy4
         kEbji5566Snx1RWACR5CC24v0k/f5kgvLEX3/MTPWc28f36H9Pg5OCoI0g8hlXl6BoE3
         N9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LnSRm7H3xVqD93njgMhLeMz5oEkqPBDQQgqJqiSeN3Q=;
        b=F5s9bTCMV+/DpK7eoYBgD1wN6nOljvFKkblQNt30R59jfe5AqDVfhXCkh8YtXfP2MD
         syLRg4oxjsC0tiXv6MvKfSOu9RRRfIcroCw5+k7efw1DenhVZF7UIc1oXOQlEZ98z+v5
         68zweIp1bKHyXRMUTubO64TfHwkrbHHBMuimv2sKvJvLn2mrQiEjK6FNzt8wo7TTLsvg
         HBriXbtF45ALotXd6uqk+MDnTHD9YdsbhYe2X6NShkCHddzEQt6NekVTLg6aztfkWF9U
         OfpodH0ubrHDDyDUyP5xBINIVeMHSdQkDM/QH4Q2VDb2B9zO1IHhHrujBJqsEwoP5HUO
         vnBg==
X-Gm-Message-State: AElRT7Hc1DG2kosukWywvCouEaOvw2eJkCjDxPz1GFUT784FY2274y8v
        pu85rNdWxwBPbyAPxUQVSO0=
X-Google-Smtp-Source: AG47ELvQ+tIKU7m19tW8w8evmDS7E5kInK8g0XZ7TQjcCc9clriz7GcSJtHI09kYVeRRVkV1oExffA==
X-Received: by 10.223.171.79 with SMTP id r15mr2271098wrc.208.1521222631540;
        Fri, 16 Mar 2018 10:50:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u89sm6932584wma.10.2018.03.16.10.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 10:50:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF encoding names
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
        <20180315225746.18119-5-lars.schneider@autodesk.com>
        <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
        <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com>
        <CAPig+cQpDKHwzjCHpka+v1uGaJNfJGSmXpAVwPWVXSf5F1pR-g@mail.gmail.com>
Date:   Fri, 16 Mar 2018 10:50:30 -0700
In-Reply-To: <CAPig+cQpDKHwzjCHpka+v1uGaJNfJGSmXpAVwPWVXSf5F1pR-g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 15 Mar 2018 19:54:44 -0400")
Message-ID: <xmqqfu4z3o61.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, I'm having a tough time imagining cases in which callers
> would want same_encoding() to return true if both arguments are NULL,
> but outright crash if only one is NULL (which is the behavior even
> before this patch). In other words, same_encoding() takes advantage of
> is_encoding_utf8() for its convenience, not for its NULL-handling.
> Given that view, the two explicit is_encoding_utf8() calls in
> same_encoding() seem redundant once the same_utf_encoding() call is
> added.

So... does that mean we'd want something like this, or do you have
something else in mind?

	int same_encoding(const char *src, const char *dst)
	{
		static const char utf8[] = "UTF-8";

		if (!src)
			src = utf8;
		if (!dst)
			dst = utf8;
		if (same_utf_encoding(src, dst))
			return 1;
	 	return !strcasecmp(src, dst);
	}
