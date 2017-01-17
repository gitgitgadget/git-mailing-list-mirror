Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336B220756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdAQRli (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:41:38 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34145 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdAQRlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:41:36 -0500
Received: by mail-qt0-f194.google.com with SMTP id a29so23115810qtb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVjVtCVkJYwGpcEoTAOBYYn9/XAjBJxFbr/jZgDQ8o0=;
        b=x1CR9yjdlo+Io+SgtVV27tteO6PA0jjH5cZx3TPnpP7SY0Xkk+OZhXxUnLYkgLFmiM
         8gF4RH0nciNClJRxR/bGF1vuDP3GzATr17yyUkYrwnZbKY/7c74SIKWVxOfY8owVf5iw
         uoy64PhZ2lWtcPhzOCjfDkiQX/6Qab5R6MRasAQhlqne6UkRt1JCdruBuuOYAtsERbx6
         QKLmpFary7Mt0KWscc3PWLMa0PpF+o3gkSplI1lcr0P3BhmRkzhg/ZxoKbbTE/QkWxe8
         aVxX1vieKgF2ZyxCB7GDglKw+cjeNOnAkEfd80D14rLv4biozl1ScB2g6kk4QIEdwmTf
         LLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVjVtCVkJYwGpcEoTAOBYYn9/XAjBJxFbr/jZgDQ8o0=;
        b=oym7R7bdhovqcKPE5AT6j+8YdEXTzTbjqRws/0UWEifjLEeJy9z7owobhdeKhxXuyq
         V6r4i9B+K4AfDNSlmcO1OqoO31enj7DII0YVfjIbzyjhDV9VH/SUDq6W/3B54I8hC0ye
         aeLmThOozVpZKR8KdO0nrEl/O7G7IU1fnzhv2K5e3u/LorZkiuN612mK1/5TffRUNbjQ
         bWL5TLm9JjOv8o42AZ9KKyVPb4MPoAaa+kaXmkk46xF0qVNlxssSb6GJKHB4nuJEC1Py
         ZRdMcJUnZFmadOLbvMQ5OuSiF/Hx/yJKU0Es6hubV6NCLSV9SotPw+Qk/TZO7NllIHkW
         z7ug==
X-Gm-Message-State: AIkVDXKkA7YF5+sN6oR0yAjQwtzyaIKro8rxoA8R4YA4skTAzBero0hO/YSJmOIGITdNdmQ6
X-Received: by 10.55.8.12 with SMTP id 12mr39379356qki.74.1484674427682;
        Tue, 17 Jan 2017 09:33:47 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id 34sm3369404qtx.16.2017.01.17.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 09:33:47 -0800 (PST)
Date:   Tue, 17 Jan 2017 12:33:46 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117173346.paqrsroauoskxpn6@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
 <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
 <20170117172531.bahjekbj3om43gtq@sigill.intra.peff.net>
 <20170117173003.sgipqc2cijpdrukb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ereilp4mgsdjoj5m"
Content-Disposition: inline
In-Reply-To: <20170117173003.sgipqc2cijpdrukb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


