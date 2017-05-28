Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05E320D09
	for <e@80x24.org>; Sun, 28 May 2017 01:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdE1BSe (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 21:18:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32948 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdE1BSd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 21:18:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so2699791pgc.0
        for <git@vger.kernel.org>; Sat, 27 May 2017 18:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ompae9wzy/tkAy6HxrlcypWviEeKWFYm/UEnIG9I1dQ=;
        b=J92DATCX9xK8tJ83eYflh08pCPekFbEMrotECZMMuix2lo+8eaUVaOm9a8/+VVeHNQ
         9iOzzLzKQ9NEnUJfe6bfa/holRdNBI0WVRB6Ys5rY46RPdTcrdenuA0xOL4pn7T9nDn6
         q8Nu3276AHZZKYNROVybRTa+TowLUKzCO6doN9l9BuCOTwc/F9H6f7qySY2wy2cmtCw8
         NqrLLvnb8CwzlsTVX/iPWoQwcvoCwTRiF7uVWfgaFjLenUbKNOjGUsVLPm/smLrvRi1X
         Wi6ju+hxch8mWCkrPTB/OMNOQcaE6gWXFnC38EErkTVOh4tQ8ZZV8WzG0I27J1bPyJoN
         4H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ompae9wzy/tkAy6HxrlcypWviEeKWFYm/UEnIG9I1dQ=;
        b=dibyeX62h2hY/fdbyCqq4Z7xUC1haaetmj7GagYZlqbfiTiq8+YJKr05QS8kl/3lLd
         ths9gL4P+zg2pZDg3+E2ps3tD/h3Y3E1d5YWpg91wUVmpirmKIomgbY7HEvp6qX/Kbm1
         St2oLUtp8unEgiP+uDCTZEHBI25LvhSuNLcwvtGIyBMFsCRGDYNCDuHhPdidPJmYQUQL
         Em638esut0IyBg//+TtEw7eA17qauBb5INq+RTe+bVlLHGa1z040u+x0GOK5/t6RyfA8
         Y5SRZemKdIfKgAJU7hhhoXNYmAaNADpeV6Y29FGKC2MoMBdOwqPInXbItPZH9mVqLs8Q
         j4+Q==
X-Gm-Message-State: AODbwcB7oaSpy28p67U4xH4MRj3FchNcNbRm/Bc7E2Fr4+bnBS4x9V8/
        00yntSJkaILHvg==
X-Received: by 10.99.130.73 with SMTP id w70mr10897941pgd.119.1495934312862;
        Sat, 27 May 2017 18:18:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id 184sm9689124pgd.12.2017.05.27.18.18.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 27 May 2017 18:18:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
References: <20170527111032.30897-1-avarab@gmail.com>
Date:   Sun, 28 May 2017 10:18:31 +0900
In-Reply-To: <20170527111032.30897-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 27 May 2017 11:10:32 +0000")
Message-ID: <xmqqy3thaie0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The plan, subject to RFC feedback is to:
>
>  * Add a new config variable `core.version`. E.g. `core.version =
>    2.14.0` With this the user can specify that they'd like
>    new/experimental features introduced in that version (and below),
>    as well as immediately getting new deprecations added in that
>    version as errors.
>
>    This is similar to perl's "use v<VERSION>".

As long as this does not require very new version like v3.0.0 of Git
to pretend as if the user is still running an ancient v2.14.0, it is
a sensible proposal, I would think.

>  * Add a deprecated() function to to mark deprecated features.
>  * TODO: Add an experimental() function to mark experimental features.

Having burned by bitter experience during v1.6.0 transition, I do
welcome an attempt to make it easier to communicate deprecation
plans to end-users.
