Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E135F1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeAXUmN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:42:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34916 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:42:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id t12so4042937pfg.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ef9Zvi9TWVxidvbmuaJKnmurI2xXzh5gZV4cxg2OW/k=;
        b=JA74N+BDghVflprG2zvQ3A2YGtNUL3GbJA1p/jqteohxkA/c+D7P36OJfc4dtlYOMU
         4D3fbbCI0va1DufkuzWoF2lTAR6YG3CTO0LMMVsVpkXix2fgIZRMd5gpe7svNk0+bBoN
         rJLmQjrEBr4E2ZXrKqMPKyT42hwlFpm1z63DY5wLDdw//6xetTLJLFrzFA+734gi8BTE
         1JIYvCBiR2IIMUCK0mqT57Fv+GWKQTn3yJUBoGqUBLwS61UbkW76x63rhxZeH32tPrN1
         FBq+R2Q6Ec5CpQ9C8kTDLCPX52Gwlo/tWRwb1qhu8+aYBp1+oyMLNoLVBEAnqpjMjrIQ
         g7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ef9Zvi9TWVxidvbmuaJKnmurI2xXzh5gZV4cxg2OW/k=;
        b=ZHTPkeJX3iHb5uF5WW3DkdUhuirzzBEasemjxBgSGEzpjFf+XoWcmj+QLVPVhzExMF
         EHKNp+w7YNY58hf+4eyolw7Ofpzag7pT5xxlLS91OW5fsjUIgEz8QrbalTasnidO2ETO
         7C3OOskQsX9M3ySdzCgLXdUITt+qRwB+LMMJpVhtwM7gs2W12Zp8jvL4iP1AyJihs+Wi
         3CEPAzK6IXj75P5By6QJGrhzhb7P6S+vHRfiUi0EfbMgp2mxejXyBA2lCy/fxvGeO5/Y
         Uc/pipU46zxGGFAe4OO7oQw8XY3/vNtubX2WZcr8AFtYcHmUKuQXXx4T4imIQWqYRb0g
         vEIw==
X-Gm-Message-State: AKwxyte/H/9UEA6LasIAWcyzVJi09GZtrNRsKDMVqUCQkplyBCiIHn/+
        d4g+VvWuMvVapJa2WAjMnAkGLi36F1E=
X-Google-Smtp-Source: AH8x224f+udmYiEanyLFIg78GNmXslnu/veIS40/28IS+MB8J93NoOa+PVfkZMWz7biRJ5cAf0nK4A==
X-Received: by 10.98.70.18 with SMTP id t18mr14094446pfa.14.1516826531416;
        Wed, 24 Jan 2018 12:42:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id i20sm11057835pfj.58.2018.01.24.12.42.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:42:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 0/7] nd/worktree-move reboot
References: <20180124095357.19645-1-pclouds@gmail.com>
Date:   Wed, 24 Jan 2018 12:42:09 -0800
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 24 Jan 2018 16:53:50 +0700")
Message-ID: <xmqqshavc7ku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This series adds two more commands "git worktree move" and "git
> worktree remove" to do those things. I think I have addressed all
> comments from the mail threads referenced in "What's cooking" mails. I
> also added the ability to remove a worktree if its worktree area is
> already deleted.

Thanks for moving this forward.

