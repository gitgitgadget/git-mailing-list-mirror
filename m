Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381021F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfBHSEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:04:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52787 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfBHSEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:04:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so4555860wml.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WJagMhxki60o+xyR7BdLBXiEFjD2cMUPWtWrFXRw1A4=;
        b=vaKvBObXWjuN5ag0StZBjz1brDh+ufjtQmRmy7BIDd/0eureBzZ5922+PGQqYvGyod
         I9RH426zQdF1Qsw03j/Qkvo1jL/1qmv5NMcyI66H0gNMUA2KDy66j8Ngl5WDKI0cj1sZ
         0+52xLZF4gEjP/6k2QDvBIufYb/TNlMTD6ccx88C9ycrMcXKseppsQ2jRegbF/iQR05Q
         K4rfLQHrE9rCRKFRetNIuxP/Ot1e8/n4kLq9eFB66sb5IKlcb+5iPa2l76mVD0o+vtEU
         zYMySO3btWKe1na77Yg5wC2FHXnCHM/FpIW7Bt1rsyKDFXqyOa2eyQc7Zyo34GuIs2G/
         wXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WJagMhxki60o+xyR7BdLBXiEFjD2cMUPWtWrFXRw1A4=;
        b=nrwLS2Dp03O/oSvhpDailk7xeeT4qwwJpfaeO48hd4E4+1CtC/bWCfxDgLRX885BeY
         Tm00U5R3UpS7+t5VnJim+rI2OU5fUTjRhlaEMJC+QLVIK7484k13NnANdn4RbV+OTMzm
         HbXSiJtS42+QXsEXbPDL6PJl8RoUJrjubP8Vd63esa6VRXGgfmX2GDjGnHkouxhbgaQh
         7/grAE2Bbc2I4FQqKddvGLJh/uu1EnUAsFSAT9fDnfTifA6JhndjaGeucEw9w5Uv1qIS
         ch2ZIiIF0RAR2+aUMWjXpqr6LUnDQAbKTDt2ru1qayZLX2Dxp9YF5r0JRzo7ii9M5AWK
         2gQQ==
X-Gm-Message-State: AHQUAuZq0NBR7Yx/8PJQCedfm/YA3QjxZA9mZD9GU0j5zuVB74P2u0Xt
        KgSCa166UP3v8NpzX4hlji0=
X-Google-Smtp-Source: AHgI3IZ7uC+yk1uIWHuK+IUT2fHEiKPA3Ca5N4vveNhYBAep4tiDljvTHe79OQhWV/LOtSRBqTga6w==
X-Received: by 2002:a1c:c441:: with SMTP id u62mr1632477wmf.69.1549649047818;
        Fri, 08 Feb 2019 10:04:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h62sm3547310wmf.11.2019.02.08.10.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 10:04:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Todd Zullinger <tmz@pobox.com>, <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a question
References: <20190208031746.22683-1-tmz@pobox.com>
        <20190208093324.7b17f270@md1za8fc.ad001.siemens.net>
Date:   Fri, 08 Feb 2019 10:04:06 -0800
In-Reply-To: <20190208093324.7b17f270@md1za8fc.ad001.siemens.net> (Henning
        Schild's message of "Fri, 8 Feb 2019 09:33:24 +0100")
Message-ID: <xmqqimxukvhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> both patches look good to me. Killing the agent once should be enough,
> i remember manually killing it many times as i was looking for a way to
> generate certs and trust (configure gpgsm for the test). That is
> probably why i copied it over in the first place.

Thanks, both.  Will queue.
