Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E1B1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 19:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeCQT5M (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:57:12 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55949 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCQT5L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:57:11 -0400
Received: by mail-wm0-f45.google.com with SMTP id q83so8819393wme.5
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=s+XJU4CMA55Dw+/rb4ucv6Rrkva4eQjR3DaKM5sbVDQ=;
        b=Wv1jdX+xdP+W0Tk1OCITty3x2i9I6oO/MXrS0qzaEZwQcXs2kDTYdVib7/nC3rTYTs
         t6ipmngVl66n0DJYROZxx+iWfcclRxSk3qkBwrlE3cW8e44BEy1Rwol0frAlsR092KGH
         Emv1Sff9uSSdQycUKYVdiTvmkNTukFIupG21AMoK4A/fRQJ/1ZJDrdHcO6zJ1BuLYJUe
         pzL6sNuZMK6d2k68sb7lHSRcofmADZpt/env3v7/0t61+Gf82/PHIWuIhWTRlCbBicIt
         1xPhHf9UhbuMrn5K8nCfp4L1/GUMBVjB3Pr7R1HKdwfm4nNO7BN2JWDzXqAiXDDiRj0W
         5rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=s+XJU4CMA55Dw+/rb4ucv6Rrkva4eQjR3DaKM5sbVDQ=;
        b=uYm85W17Lm4nqAyoL8EvsC+sSzt+LUIpuBp+nvqMeIxB3qGNLnzFM8Fhw3WQKJIRjs
         JuASCEjkFIW17dLwwnRNfCdtaU0MKVIhdWjxYpwgeUJ2M/nAA8u2Oj1XwNYEFjtO0/xi
         Yp787gVn+1E+3uFJP6idKDo9VYNw1rz9+xEmVlYcZ7j4MA+sVM9E2e+e3CzOn30ne7Y+
         nKp6oQfWK/9ufEhg6mDQxbDRAot/Rb5qPR0G0CfNOEGRjOUIHiHFp7oOUI2OiTQy5q+D
         cO7j/aiYeu1/26XvLdjrODN9Yf1FXyDfmo+CygtWgzOyRwzVPlCOeBaek3e1x6y0AH6J
         bk1A==
X-Gm-Message-State: AElRT7FTDFYH6rBLMHJvMvjFy4remT4nkmClkDUGFfak/ANs/fPdJEjJ
        3BzmR/s4OGFgY3ugjVW2+V0=
X-Google-Smtp-Source: AG47ELvW/2JgTeDwS8kTgsfBCTPz88wMxsM/mPt5Xce/T1qrbJxooenw9v1rVNJi9OE11dFBcP/GTA==
X-Received: by 10.28.29.209 with SMTP id d200mr5196596wmd.149.1521316630081;
        Sat, 17 Mar 2018 12:57:10 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j137sm13546937wmd.17.2018.03.17.12.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:57:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 09/11] pack-objects: shrink size field in struct object_entry
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com> <20180317141033.21545-10-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180317141033.21545-10-pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 20:57:07 +0100
Message-ID: <87lgeqcw6k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Nguyễn Thái Ngọc Duy jotted:

> It's very very rare that an uncompressd object is larger than 4GB

s/uncompressd/uncompressed/
