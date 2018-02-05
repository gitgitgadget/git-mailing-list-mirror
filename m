Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776461F404
	for <e@80x24.org>; Mon,  5 Feb 2018 17:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeBERzQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 12:55:16 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35723 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeBERzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 12:55:14 -0500
Received: by mail-pg0-f65.google.com with SMTP id o13so19195457pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ethN6VfLLFP2KkvTTFXYMMl5ItLRPLr7JfLbTM/jdvE=;
        b=eUh1LZsDPs3VXlUl4qNKd5m9EqaIswdLPm+I45ap1frpeAFdUYoxLkX3sis6MS/7WR
         fpY/yZj5xqLhPWPDWT00Kd4wPWCozis9CePj/kM67/2jqz8e1XNEyH4vXWpylxoR//K/
         HcCGkvCy40tngsIwGcU2UbFSWQZRNH0e4RVeWFLonFAd97ssnBMp5irVHEouhxH1aGhW
         NM4tmY8EAgN0b3JjRXnD0PlLd3LOVUHHHtkoa0YRGjQ6aAK3dJMFvrt2NixUCOIcrkjd
         DvTHSQO2wmo3fY79IBaimXzOD46evAKNJonnRDOaWrgWB5SIPkFT40ANbK43lYF8QESB
         kxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ethN6VfLLFP2KkvTTFXYMMl5ItLRPLr7JfLbTM/jdvE=;
        b=sZhoiqN5d5r0KAqtb3lacar/dJfAh2jCwfp1EL0KdapmUqo8WV3Ye2HBfuNp/TZqC6
         VA+PJErQSSCwvw5YSpYsmkzTLix9ZusywLsmhq5ThmRHf4Efn60bMnpETh9gLfQw51cS
         mkakVG5TxW5z4hseYRNCLqZgrFL4RHmA6tOQWPiRhkfEzWY2htg54ZSVhv7PXSr8Iqo8
         psTmzhTmg/8YSqgqfa4XjiHGNQFuSb5e3kKSUm0dG2tQo166QvgUuSk6BtIkidKgCvKh
         b2/lNTk2KZ0aBVeWHqMoWQZqfE85HPcucYPiteKDpM6r8db7YKG9kGin9qI3eVHMeRVa
         iCGA==
X-Gm-Message-State: APf1xPBmhjh6hpOHyLLkS6zBE09qIQWo3Pv4DVIG0D+CyIhP3tuIIuN9
        J/Naq7+s03RNTTI2+8isCYFkHFFw
X-Google-Smtp-Source: AH8x225IjjY6l7B0++Y2obaKrn2LryRS7yyAln4akxt3TQ8dQQdaAQXLr1bl7sK9CmP9b84waRM/RQ==
X-Received: by 10.98.143.1 with SMTP id n1mr7847369pfd.126.1517853313764;
        Mon, 05 Feb 2018 09:55:13 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 63sm3476400pgi.71.2018.02.05.09.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 09:55:13 -0800 (PST)
Date:   Mon, 5 Feb 2018 09:55:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Yangfl <mmyangfl@gmail.com>
Cc:     873424@bugs.debian.org, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: git: handling HTTPS proxy w/ password inappropriately
Message-ID: <20180205175500.GA104086@aiede.svl.corp.google.com>
References: <CAAXyoMOp2OdgTVZN2FyP-u1ha9PjwHkTDq-pyu-4GrjP91X70A@mail.gmail.com>
 <CAAXyoMMxuF=LUTWJkPL8GmFCgL-xacPBAgRE2Qr97CgF7yppgA@mail.gmail.com>
 <handler.873424.D873424.151784496817038.ackdone@bugs.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <handler.873424.D873424.151784496817038.ackdone@bugs.debian.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yangfl <mmyangfl@gmail.com> wrote[1]:

> not affected any more

Can you say a little more about this?  Do you mean that newer versions
of Git are working better for you or that your proxy setup changed?

This looks similar to
https://public-inbox.org/git/CAHnnmh6QCnHTycbMDLjfFYoXW4dErTZoTHsPrkYdhZKnXcHHYQ@mail.gmail.com/
to me, which makes me fear it hasn't been fixed.

Thanks,
Jonathan

[1] http://bugs.debian.org/873424
