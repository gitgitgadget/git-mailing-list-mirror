Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C6120756
	for <e@80x24.org>; Tue, 17 Jan 2017 16:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAQQ52 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 11:57:28 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35211 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdAQQ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 11:57:27 -0500
Received: by mail-qt0-f195.google.com with SMTP id f4so22876320qte.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K05SZqggVzK6aMu9Eg9urRz8T2lFE9qxpWelrcts2iA=;
        b=TaZ9y0Q2A6znFHIeK9U3FSdQq53hD4fwiJL6V7DkPCEKzOrR/6pTepIqTxiixrdd5e
         3iviT2irBeZTSTl1x0vXDAPRi40Cv/Xe+6MgxUJP8Frao5J2KvrfwgmQn76qSa5oN1zE
         8wpqD+txHSolIZYNrQqtbEvEUMsZ7lRmLh1HtOScX+bryfT03zLDxrFeTarMKtXGM4kr
         YSfE3VPFF5yCYkrUYPzp+B1eOzMYGjbvG/xLpi5uIsCjgb+2mCiCGSWGxual6xiBUI5n
         oGvrn0vzM8lgNGK+6o+hkQTQ1zYJOLSMnC2w4139HoMAkpvr2j2QSOS6VUcGolE/uNgi
         k/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K05SZqggVzK6aMu9Eg9urRz8T2lFE9qxpWelrcts2iA=;
        b=r9B/+JSXBTNI92Nj4Ma5DsZ0CBbN2Ms8HCfayctRZ/u1RJxt5+Bqp1xfNwrtWONBd/
         EzOj08GKOT+QhlX4JwEXqRx+TicPU5bQWZ2SlaPznEYVsgfGaHEHZKR370wtjwSUzhUN
         orl1KfNx9xV8l8xOxWn8xiE0tni7uTCwEhFpf7jWoFO/MocEVH8RgfwASKLd1ncBRHnc
         Ux3+LpgTycMljT0UVZ5KBKqflc3kSSZ4hwPQfkpFJWSoNt4LiiJDCULE35828NyvdvRH
         Sxbcr+XoL8AykyOyYcvdzqQEaGbml7i/iq4eCg5ATSHwWz1dA6vLZAgStoPrsomgFf14
         Iwag==
X-Gm-Message-State: AIkVDXLuSui8bJrfVqtIpZHQ2ad6UO6rmHVcT/oWTT5tHmAHJ1N9HYuQ6zB8u9Mc+e3Dy8zM
X-Received: by 10.200.47.100 with SMTP id k33mr33406418qta.241.1484672246435;
        Tue, 17 Jan 2017 08:57:26 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id q88sm19341774qkq.21.2017.01.17.08.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 08:57:25 -0800 (PST)
Date:   Tue, 17 Jan 2017 11:57:25 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otiegmmlpu5pslfh"
Content-Disposition: inline
In-Reply-To: <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


