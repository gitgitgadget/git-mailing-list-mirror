Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8A81F576
	for <e@80x24.org>; Fri, 16 Feb 2018 19:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbeBPTlm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:41:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39774 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeBPTlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:41:39 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so3971223wrc.6
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DgLCfXhjVnEP1T4cRGYTKIdBswzmBwAi2FdUFfJCCUo=;
        b=LJyCLxixCH0YURHW7WxQj4e8LslR9wIpZzOBh51AknKf0YItlhwtTsiUYGPeprN9N4
         Byd523bW4YSx/eu3icYdSpILlaUm9a7cxhYFs9ZbSbvgAiJpitNhvbrOyHHQoWt76Ii7
         +9qcF3oVanAnPQx/TVZQt2Sg9oD0D8Ac0qw0nAShgdxhahp5RKReEfug1pI8QXe7e1rt
         R4JURvgEjV48+41fPGXa5MCRN8ajj+AGvgAQTGlo9N8gvOgmz5Bctbdxf9RjlIXLE96V
         80hw/bFpHhC2PnyNaigDPTbt23qqlTc8bxXmb33XhEBnqW0NYaBelfEo2bxF4dIY/6/X
         hNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DgLCfXhjVnEP1T4cRGYTKIdBswzmBwAi2FdUFfJCCUo=;
        b=CycKDb+O+INEPJ9MlUus97Yp984y3XS6lMT9gmbO3hhz4Fu8rWJvVXEupzPqXVYlCA
         u/+qnIZIWjPgbIYh+ajgRTfR5PhN9KbO/Sym1Oq4bTaU1xxccohvTXRffX6ZXrkviFF+
         V5JkbXmFPmbQUx29CESv3KY/Uvr2Vosn892qj1TPjcUV7qXF23nej0JbVc9nDoL92Mx5
         G6MmO/vTjWmXuU589CGMTtNQELOOFo75KeGvTpv1Yitqchg/08V2NPf5siNNa5pPQHzx
         PFCM/4Fqaw8Ip2Unv7wPThx8ICPzEJySCF9octahWcDXUUVYwhxN3wbuvnzpGMisgmkD
         mjgg==
X-Gm-Message-State: APf1xPDNNak7lJTRKDq4i3aQ7p6zD2QZ4c6lK8dIS1t02/SB0syuZIA3
        mKMJU1HD/cXKdO1ASOvJhwg=
X-Google-Smtp-Source: AH8x227NZhTEV/r8NHfkTAzszVOVtvOYRQcAWYxlULFWmoTwwWWMWOI8fehK5jEtQEvUWfdELfvjyA==
X-Received: by 10.223.197.139 with SMTP id m11mr7243716wrg.0.1518810097654;
        Fri, 16 Feb 2018 11:41:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l73sm11022343wma.15.2018.02.16.11.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 11:41:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
        <20180215220952.GA23970@sigill.intra.peff.net>
        <xmqq606w7oht.fsf@gitster-ct.c.googlers.com>
        <20180216192541.GA22993@sigill.intra.peff.net>
        <20180216192727.GA23249@sigill.intra.peff.net>
Date:   Fri, 16 Feb 2018 11:41:36 -0800
In-Reply-To: <20180216192727.GA23249@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Feb 2018 14:27:27 -0500")
Message-ID: <xmqqk1vc67tb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In which case yeah, I could see choosing an in-repo encoding to possibly
> be useful (but it also seems like a feature that could easily be tacked
> on later if somebody cares).

Yes, I think we are on the same page---in-repo-encoding that is a
natural counterpart to w-t-e attribute can be added later if/when
somebody finds it useful, and it is perfectly OK to declare that we
cater only to UTF-8 users until that happens.
