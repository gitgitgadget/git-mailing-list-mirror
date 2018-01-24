Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD291F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeAXV2S (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:28:18 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40532 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeAXV2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:28:17 -0500
Received: by mail-pg0-f66.google.com with SMTP id g16so3613551pgn.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+1C7OhFOuRTfHL4Jxza7w5m8rBZe8fJPPzlGDu69KC4=;
        b=Kkk0snMYDF7kdJ8eA1WcqcHWw0W9ym3Pf0/HhJBtFRAdLTVK1VIdZYFAAriN4Aw0V2
         KXcwgL55ar+fKGWpyd2vEPhY1fb19y4RqlkeAgZHFWMhfMqFD4jMk9XcQgvR7MXVSrfx
         Lcdgpx3b07nInGdJEppCX3ib6nbir/19/fpAxbtnmjogn3cimA8nZ7LsRIQXm/U5dDRN
         2aG35RloMFjJwDYSSQbcsxebYmcnL6r6nFAdiUup0RazUKZcDViBkYIkB9JJB1Nqvc//
         Cr8Y/gL0z3/pTLNRXa5zbrQzVKppjDWoB9MCs9FeFCuc0IkC70cTEEkY2prk/izaNhD1
         83Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+1C7OhFOuRTfHL4Jxza7w5m8rBZe8fJPPzlGDu69KC4=;
        b=gbY1ZJarZj7C1/R4JyWm0U+ifH7gzhX+vXfx+nxcF91sBHveLNtRalghgleECriHzI
         MqqwfyQUOwotD4dXKK4jjVP3WEjEBnKglhnR807q/qO3/FpSWK2pYsjjCwqfh9yoMywA
         aIG2M0Zb3rrvPXbwdvcdyoQ3ziSSoihHRB2rI0ooZ7TZHGYcXDycx/NpOLpt5UO3Ha15
         x7SxFEjhIJ/C/8rNQeo+jh7Q25zxnvSLoVEilqULcWzeozQbi8v3H8UfDGF6/sdh7ynq
         OG+M7NSPd13eigZZDjhRYSTex7sui4JnzZ4mHPSK2D3tqfwuEs+fg7I0S93WLtuwSQBz
         6Snw==
X-Gm-Message-State: AKwxytfg1CNbUu9PlWADe9Hv91p9u4JW2oYqJYfljJqhGgu65H9v+ZPq
        q/0EHfBadF8bNVF8XJyvQKFV8KQO4lk=
X-Google-Smtp-Source: AH8x224jVlo+czJqdtoRMsXEQcbTbPAK3IWKx/A7xRSTpsJv5b7fAovtRKufuUV7fQecaZmnUPzTKg==
X-Received: by 10.101.65.9 with SMTP id w9mr11664417pgp.214.1516829297063;
        Wed, 24 Jan 2018 13:28:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id 65sm12177634pfm.152.2018.01.24.13.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:28:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/14] Some fixes and bunch of object_id conversions
References: <cover.1516617960.git.patryk.obara@gmail.com>
        <cover.1516790478.git.patryk.obara@gmail.com>
Date:   Wed, 24 Jan 2018 13:28:15 -0800
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com> (Patryk Obara's
        message of "Wed, 24 Jan 2018 12:11:52 +0100")
Message-ID: <xmqqr2qfaqvk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Compared to v2:
>
> * rebased to latest master
>
> * patch 1 and 2
> I kept them in, but if Junio prefers them separately then I'll send
> them as separate patches.

It's not just me, but I think they should be separated out (I can
just queue them separately, and there is no need to resend them
unless/until they need to be updated for their own reason).

