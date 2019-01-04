Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705B61F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 12:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfADMiZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 07:38:25 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54470 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfADMiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 07:38:25 -0500
Received: by mail-wm1-f47.google.com with SMTP id a62so1015770wmh.4
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rDYdapoZh/mWqobDcI4u6Te7Mfx3K3EJnGAcau8i+3E=;
        b=qeqHA2Bt+qanY9qQGBTEJkcGcde8P3BnsJgRwFjJXjX4YlKcDpRfpMvlogOf33j+nB
         45H9HJSN7FI+eWjlDPNUucvjuY8hJ5bkEj7aW+X7R0kDEzFEprTzVoIfu81PdsCUM+0M
         VlHg97DCTFlLY2/qjKn2EpwexOaaRafwdpbbS1iviEpi5motiQWGHdZY1dT0c/w/OdtM
         AcQ5Z2GYuGWDKRGZYbOwo5Y3N70OUp1Q1vlJiL4G788pGpPe84bxG0nCIAneXinttnwc
         xmPUlOvUEt+3sczKzczInYs3rhovG7o6R8gxO4SUv4+j5T9w3P+pkB97ZmSxcY8/wAFc
         Zu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rDYdapoZh/mWqobDcI4u6Te7Mfx3K3EJnGAcau8i+3E=;
        b=BF9zncyYHBUQD3ljEPGd6XLGAI1+dlSW1lSRmLFTEBG/l2BGZfOPhlDsZ61AgJk4lo
         RQ/ZLxdgVCoELSxL6jEucMSZuakSzNQ+iVO5K6T9xTMi5xRBy1tnZRhMpWL8lkv/4B+T
         cIN35LvcNm1fxbF8BSWwYohmVQF/pcgXNFWPK8A6LGkKLoaiF09zsa3s85Kke6O859YH
         9gWHvBaqYPFRflqde4iiVbe0K6NJyZrelQaE7O5dXLfdnQ7LmiQVbF9hIkVVXNz1ZST6
         glqPMwesPMz0aFAXIb6aB+G/+57LG6+K74YuTtaj6eDF8clzlSFDAtIDeb359tvk45SG
         46Vw==
X-Gm-Message-State: AJcUukctuUiLtAGtwHo2DSwbwxS4LZ4uI9/0/+TQyBe0ioH7ip3cD8a0
        kYliuaf4XzlOMpA5NEnAQUI=
X-Google-Smtp-Source: ALg8bN4lpVvAmXOFdyFEC4CiNLYySC1omtEwMAdNBvgKp/TwHvOsehJCDh+PXJlarqBkZr1rq6mN2A==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr1255115wmb.115.1546605501744;
        Fri, 04 Jan 2019 04:38:21 -0800 (PST)
Received: from szeder.dev (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id 1sm1012019wmx.48.2019.01.04.04.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 04:38:20 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:38:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using
 shell arrays
Message-ID: <20190104123819.GD4673@szeder.dev>
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
 <20190103114317.11523-1-szeder.dev@gmail.com>
 <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com>
 <20190104093015.GC4673@szeder.dev>
 <xmqq5zv4fyuy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5zv4fyuy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 04, 2019 at 03:25:57AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Thu, Jan 03, 2019 at 12:29:35PM -0800, Junio C Hamano wrote:
> >> Let's treat this as an independent and more urgent fix-up.  I think
> >> it is sufficient to apply it to 2.20.x track, even though we could
> >> go back to 2.17.x and above.
> >> 
> >> And then let's tentatively kick the "stress test" series out of
> >> 'pu', and have that series rebuilt on top of 'master' and this
> >> patch.
> >
> > I rebased my '--stress' patch series on top of
> > 'sg/test-bash-version-fix', and the result is the same as what's at
> > the tip of 'sg/stress-test' at 1d1416a34b.
> 
> Yeah, sorry for not reporting what I did after pushing the
> integration result out.  I ended up rebasing the stress series on
> top of the updated fix with eval myself.

No problem, it still saved me from writing a cover letter :)

Note that I didn't actually test either of these patches on NetBSD,
though both "Should Work".  Carlo sent a Tested-by for v1; I hope
he'll be able to get around and test v2 as well.

