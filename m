Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A861F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJJTol (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:44:41 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41737 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:44:41 -0400
Received: by mail-wr1-f51.google.com with SMTP id x12-v6so5482208wru.8
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bxYCkWyVcv5U1y2VEi1gtK2luWCgt3Jfz03tFWcdK7M=;
        b=LSgtgWXkd9OqZle93ppQ/ue35Cz0mTPPjHtpEzm98NoVnc0Ez6r9reIQbg/PDlKCDv
         jy2iFutLPUAJl5xr9sWfpiMUcvqWkplRT9rlnC9gm4Kb7AuZkJ3hVB3AqqsroZHXaKSt
         5LJcGe/z4nhyL7UJskr9cd8DzfQUwbGzoAoJz/5qKnTiEg92Btlho20WWs5E7/A5K3wi
         aPX1fOGcHr3b2uRpDtde8/eQdthX8lm2PBfMZSq83yCqonaUWn/IZ4kMW+3gGn2ZeTvj
         fe1hdcKrmCfLx+/Bwp47Nj94VekoBS5rc7FC75lelHFyXs7AgroG/r0j3U3Fjk2kxcfY
         HtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bxYCkWyVcv5U1y2VEi1gtK2luWCgt3Jfz03tFWcdK7M=;
        b=TbmTmCmDiCpxsgvBKqC/Y3I95pFQjEdCSTaWyEWuT+eoi9orxJvZU9ZjNxO/8nYYnJ
         kawObqqTeP3kt73KzyJ2Mt+ZFckQCV1Bdd+8iywL0GXr+qNvK+O/QTb/Yy1DMqol9FWj
         4Z8sV0h0osPdrW8G1zvJiao2Yq6S8XX7Ao75UGytM3PSFpNbshJUYJPj5HpyOGrJMrky
         /hE9L35gqwzXAvuVbOqYJi+c+nM/19bVZPOnP/TN3cGzrpUitXZLXl5PMv4XFh/trgp8
         NZelTJlUFLXWffwLk/AZWDyFt07MsCnwMmaaSTmJSGrFcSYNSS5kzfSzWqLafcry0oqD
         8ecw==
X-Gm-Message-State: ABuFfogmXqnU6w33BTGidk1BF7auPEwWu/yVG+fYclxtvZeG2FioJMqs
        8J7wcCT1woIEqICFxXuTPsW4tiw6ovY=
X-Google-Smtp-Source: ACcGV61IzVNdQ9GdXGGM0opuzP+znktcs/EXUfRmrUka188KKUjBMhRLy08cpgubT4EbDfizfHLOvQ==
X-Received: by 2002:adf:f941:: with SMTP id q1-v6mr4866089wrr.151.1539174164424;
        Wed, 10 Oct 2018 05:22:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h18-v6sm20535045wrb.82.2018.10.10.05.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:22:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, ananyakittu1997@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h in header files
References: <20181008170505.GA13134@manohar-ssh>
        <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
        <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810100856570.2034@tvgsbejvaqbjf.bet>
        <xmqq4ldumbo1.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD1_CH-OGytqcLya0GdFAM3=TLpgwiXQCO__9GSR6SXe_Q@mail.gmail.com>
Date:   Wed, 10 Oct 2018 21:22:42 +0900
In-Reply-To: <CAP8UFD1_CH-OGytqcLya0GdFAM3=TLpgwiXQCO__9GSR6SXe_Q@mail.gmail.com>
        (Christian Couder's message of "Wed, 10 Oct 2018 11:13:46 +0200")
Message-ID: <xmqqva6akn3h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> So I think one solution to this problem is already proposed on our web site.

OK, that's a good start.  The next step is to make those who are
involved in these education programs to be more aware of it ;-)
