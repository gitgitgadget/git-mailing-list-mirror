Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706F31F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdB0ToF (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:44:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36092 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdB0ToE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:44:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id j5so2523535pfb.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r8+O9ZJZywi9trRgsdQW8T7wFQZM9U5EXOgfSfWcljs=;
        b=KGZx4GqoK1kVjallwaqoKxPdUnlbAd1O6Jo/HA5Wjj154jOWBZniKsjOrF539aTy45
         qODabaTgnUKQoAE34wjlSVydDX/eDp45OPjzVKGHDfhE1ADKrEroZ6XY3mjOuGU7/EaO
         8QRavJZRicCgAAE7FtnDttk5wbzmOPC03ihsp8FvLH9yzeZ1xQL6W5YficcNQDQQ2AJ5
         mGJloRZA2oVE7gRJQWzn3cIDgbdC/mXw0VXP/Euf5IbpwOidwhmgdEctny/8WrDyW8I0
         wuZs+GYUtol7ZzgXHW7IgdznfaSVjHD/ymcac+5OZhOHocdPFQH12+jXZreuwjPHCEat
         q5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r8+O9ZJZywi9trRgsdQW8T7wFQZM9U5EXOgfSfWcljs=;
        b=oz9rgwM0xkQ/tPc/z7YtV3n76ZvKEGcwchaARZO5NG0Ar5ulOcdoASGhFBL5Y+wJlm
         363VG28RALIaCOGtX251ZMQzfom40hpOKo4QA1T4IpoAHUDfaNsPs7tx8BmthG576so7
         WCEnxlu+KXUAYzgdIMfbJECocaWLbwTLFxpJjEoGPTfgXDal4u3H5OZ/PNt8GGsEHE33
         2oTg/8ShqkLEs2A/z4Kuc+47EmaQJ8vSbkekSSazDcAhjofk7MYrypvX6W8u0LpbHin1
         Gz2UM2MtvlY8tdskXsulgEolkVlNKJXqWg2FUIrEPIHsajS89LwIfnFyT2YpgBLAVPRE
         hw+g==
X-Gm-Message-State: AMke39kEpsW81R3iUWKxAVUKnTXaM2x/ZkZ2xilOpi/Dl/zGbgyU0GIcS9EW0LCmr+NiWQ==
X-Received: by 10.99.185.74 with SMTP id v10mr22790874pgo.98.1488224111969;
        Mon, 27 Feb 2017 11:35:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id f62sm32200647pfg.48.2017.02.27.11.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:35:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] cvs tests: When root, skip tests that call "cvs commit"
References: <20170227112628.10410-1-avarab@gmail.com>
Date:   Mon, 27 Feb 2017 11:35:10 -0800
In-Reply-To: <20170227112628.10410-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 27 Feb 2017 11:26:28 +0000")
Message-ID: <xmqqvarvwhox.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, makes sense.
