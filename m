Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF881F461
	for <e@80x24.org>; Sat,  4 May 2019 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfEDNXw (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 May 2019 09:23:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36895 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfEDNXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 May 2019 09:23:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so9816768wma.2
        for <git@vger.kernel.org>; Sat, 04 May 2019 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qxU8h1e7r4r2zo5QIB6hzs7GsyybuKtPaoE7OTrxuq8=;
        b=iScvseOpohhu27zhoicnu9s6H6qSWw35/Fpmbx5Dk6rnX2l2SfTzLAvrEbbYSPgNsh
         +AWFD1Fvu04SbS4UhjVmgb/Bp+Kj2UM691c36wa1Vp6v8UkxCcJFLYhW+3xNzTqe81fb
         F6xXQRh/rcPzjqlO0UhAX8orUCCVS76UWecaHXUkkOqcFkmHOgGJVrvsC2XAyNZ8AviJ
         QZWCPyJXIDk71AisxZfSYm2yYtqr2du8/z/rSWnasFjmOYvT21kf3J/mPc5Gci5jUJP7
         zJtacW/D+jL9ZYXX7E8plJ/bw6Xl4yfKFwO7r7WXqExY0dPb8LNvEInF9eddrl2HAG1c
         XQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qxU8h1e7r4r2zo5QIB6hzs7GsyybuKtPaoE7OTrxuq8=;
        b=K+SXmbwncZdjjFDYDggz3c1u65M9qILS6DSvJey+4+gvrcQJ1uJfRUbl1h+fQg6nIC
         7Sl3cFYI8P1yGofx9/9v2Ob/HBqRBDyirNJ5hmh0s2y5LqNUytTo3odllAch0fDAYbOx
         mnt1g0BaqjQCzvBUwUPgX2y/9aExdjlNuXoU+VpXFa3ZVpi4k8oekqVuEaejOR+Uf/nQ
         X7/nyFRWfbPyMaFa+a6wgHOMI4Ur1cSIbJuQW3R+nTZ3M34NYfL3PwDVrAWYI1bxTxm3
         uP7+fYODQU7Ns+cLkGJgbdc9SD3c+T7fwK8g5fcBsi3dtXD1T/+Yf8cyYnQcWk7ZYx6a
         olkA==
X-Gm-Message-State: APjAAAV92pdAksy1fYYhKcq4Dm28euqunp5L06VItn5v8hCxUlFVA8gW
        +smCcEL+CK3CCOhZCPMD7e4=
X-Google-Smtp-Source: APXvYqxTvHi2Nr3/Vm3MjTMGu2Cz5c8p0rgSg5j8vLng8c3iOZcHBlrmqSlGQip0esOFbgncYlIUCQ==
X-Received: by 2002:a1c:6704:: with SMTP id b4mr9929662wmc.108.1556976230420;
        Sat, 04 May 2019 06:23:50 -0700 (PDT)
Received: from szeder.dev (x4dbd09c8.dyn.telefonica.de. [77.189.9.200])
        by smtp.gmail.com with ESMTPSA id u14sm3418532wrn.30.2019.05.04.06.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 06:23:49 -0700 (PDT)
Date:   Sat, 4 May 2019 15:23:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190504132346.GK14763@szeder.dev>
References: <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
 <20190504013713.GC17551@sigill.intra.peff.net>
 <87a7g2iuem.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7g2iuem.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 04, 2019 at 08:52:01AM +0200, Ævar Arnfjörð Bjarmason wrote:
> As an aside this is the Nth time I notice how crappy that "Enumerating
> objects" progress bar is.

And don't forget that the commit-graph progress bar still prints
nonsense :)

  https://public-inbox.org/git/87ef6ydds8.fsf@evledraar.gmail.com/

