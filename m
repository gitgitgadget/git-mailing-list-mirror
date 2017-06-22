Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3094C1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbdFVTwo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:52:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36102 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbdFVTwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:52:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so4405332pfd.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iNBv8VB3tgfYY0aTW7HKJ+4FMivfMXIp1Tfho+sbLg4=;
        b=AkihjGCiaAapQluXZAbaquVjz7E1ZN3vbcmFU+G0WWrpvMy31P6VutOfdu/+kn6D3I
         knClvLc4JcH99fsNphMUiozkEhtF7NyK4/morNVgPI8U0O9y8UeZAXSqzRmxOB0/3nW+
         fgg3UseQCZJXSl6VEzT41MQT30pXgA8aP/7mRTfoHiZpaECirtmVnzvCXgZVVI/QyUAh
         g0CeNGu2NcuwR1Xu8XVzxRDrq550+zaPFaZXEViW318olMI83666lG7IcbRudYfxmztZ
         8ZtazwFXV6KNdgHCCJsSxPHkl2pT47mBuV3zVs3hulIEkUjM4i++AzbNokK6POj1Fryd
         9wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iNBv8VB3tgfYY0aTW7HKJ+4FMivfMXIp1Tfho+sbLg4=;
        b=nvDNLcvYclZnLNhdW2SXZusX3B/iTzRnWfvdEcyM+rsaVi3xjth+P13ncNH66h+1UX
         ss0g/KTS8aXZK1s3S8vga6Tf2kYwEVNrAOt8i93AYgDF6F0wF/FSTixdExeUPqpH656T
         MWVJ+70RWed0aC748N12Pc0N3mxwOrG4J+Dx+GBuWIqD2MPO4roAoRCleC9YvHzj/vWK
         ZqZXz9U2WcbfbviBElARqyMSPa1/tQ1CiwBPISAAbKvJm1uaii5tinw1YHZghbjzugul
         fVp9Fn0zv+AdpCliHG2z3029zHqB+oqhgxRaZUSv5dcigkq5f7JgOZEVuj+T3uVCoECw
         /Jow==
X-Gm-Message-State: AKS2vOwGkZ4qNzoP//0OGo8KnDRoQY1XFABGqD8Y7F+YrsF9T6zibnYO
        Ck+4QqPluy02hA==
X-Received: by 10.84.174.67 with SMTP id q61mr4739476plb.60.1498161162700;
        Thu, 22 Jun 2017 12:52:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id x12sm4864298pgc.47.2017.06.22.12.52.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:52:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t1301: move movebits() to test-lib-functions.sh
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
        <20170622190158.13265-2-chriscool@tuxfamily.org>
Date:   Thu, 22 Jun 2017 12:52:41 -0700
In-Reply-To: <20170622190158.13265-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 22 Jun 2017 21:01:57 +0200")
Message-ID: <xmqq4lv7kdfa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> As the movebits() function can be useful outside t1301,
> let's move it into test-lib-functions.sh, and while at
> it let's rename it test_movebits().

Good thinking, especially on the renaming.
