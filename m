Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3121F770
	for <e@80x24.org>; Wed,  2 Jan 2019 11:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfABLIl (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 06:08:41 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:40422 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfABLIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 06:08:41 -0500
Received: by mail-io1-f50.google.com with SMTP id k2so1628589iog.7
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/OhrGGY7VjyJpPyZkl2U5ziMumXdvrQrt+rGV1cmww=;
        b=eFRFrSCygRhawTYLSKi/GQR43fxjmQ8HmLdpeanrEcRK2xojPZrluIhNlvfPY73WUl
         PVrSH1VLk1FjoJff8xE3OXUMdeGYk+TlP1Ixb7qlVnOa++hk3iSykZjIcawvVwoL8ccA
         FxCc3/ZEPxVHFgKZYjCzowsPqCW6YF7Y0WE3+Q4KD7zub7ChRKm5VmHBR9tH3WihMu5L
         Ay3p6IqRnyx3SeloTneiJE80Y3pyajZ7fliGPIk1nBjqlie3aeGm2nVQcR7r7O5l3Ewu
         xClNCDIQTrAgU7sx8qAjz8qQSGdYMpeuavufI4FgPapKXXtoEAnsd2teSDnHaPrjF+q+
         O0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/OhrGGY7VjyJpPyZkl2U5ziMumXdvrQrt+rGV1cmww=;
        b=Xsp7W21bVGIS5KMETcpNjKOMrPy8Wjqmld+a8Ek8z7IEz/PuNLAEC/sUgZ4bQeV3KQ
         Z8KDZ1R/W1nFhH7tfWj0hM3UBzVs2Uj4IJ3FbWd8cyLw3pFFvygxWO1xcMwKhJLO7Z5o
         gFxa1ncQO9XAajeeJTiKdBedV7hxOyRPZYtkgX7OXRaFhjqW+nii0F1FslzhwqykmmS8
         2A6DskehNrdREErvSY2TGTkjHI/fFeWwNKuzACjZ8fKZK1MIencuZt3uzBxakjUgAzQ0
         SsWS9f+/mefWejjEggWfoRzpijjVcZHsWvO1eu9++RWBx2+RT+Dsp0tzsiWTCJA7aAd9
         dE9Q==
X-Gm-Message-State: AJcUukf7Bk4LJ2BXGJE0ZYvXtgjt29DC/f2epy7nWM6GELNOLuB8YjSo
        1CPh+7PmqnYhTUdo7/BAco+SuAgqpvnmSE2/ueQViNYz
X-Google-Smtp-Source: ALg8bN6SnZMz8mynWvbYe3iJ5ZpjMFct8S3LBYUQjluhK8/bQhjro7j9Bg+pTUpKNaVuvUWxlIbRx0F0+FWKVAFzfpg=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr4597750ior.282.1546427320566;
 Wed, 02 Jan 2019 03:08:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
In-Reply-To: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 Jan 2019 18:08:15 +0700
Message-ID: <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 6:36 AM Anthony Sottile <asottile@umich.edu> wrote:
>
> Here's a simple regression test -- haven't had time to bisect this

I can't reproduce with either 2.20.0, 2.20.1 or 'master'. It would be
great if you could bisect this.

There are no suspicious commits from 2.27.1 touching
builtin/checkout.c. Though there are some more changes in
unpack-trees.c that might cause this (big wild guess).
-- 
Duy
