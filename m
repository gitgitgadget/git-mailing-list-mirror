Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2A01F453
	for <e@80x24.org>; Thu, 25 Apr 2019 00:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDYAIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 20:08:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35669 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfDYAIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 20:08:42 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so9369838itc.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E6nBiKRyXffqCtBRmGTwur8Xug/A0uLC58fw4Dd9G4Y=;
        b=qIJinNpVII7bdaH4hY8zg8/svLN9CVa01oWLGqe0ZW87CGJze0v2UrtArbhZ5vj7ij
         kPijGm0poxzF9SL1+JX6jLD2C3Sn7KlxgGlTgiorsNwVQIbysbn1Bfn0avgM/haZUIkz
         nnpHOkQGvre1BxZru/WbR8ihL7u6Phnwwjp1y32w017tA6fqZ8BtKbRU2XPjmq09T+eI
         52U3+Ir+jVPD+5YsY/yJ7A5LYyxOClfJclWYIpsuzvT36Zo3/V1acE7v2OoCmKw1Xso8
         sRbeN3Rl/58kpwsulfjs263mnyzmdhLZswIMBk2Vf9PEX7w2o2FR/WyX4gx/GHoiwSNj
         X39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E6nBiKRyXffqCtBRmGTwur8Xug/A0uLC58fw4Dd9G4Y=;
        b=mell/uo1VCqWCbuTHBvmqQlKqmbeevcq++BDPaobgIbMtypl0+bw/bEyQ4rUd91Rir
         3kY/g3kyvCNGQkSYiiv/fibg+7b0Xx6WFUeXxgs1XRG3dtVNqz71RoD9s4Jbq17XqWQk
         6lh54itvBgnwUu9Cs+SnW9NHziOXyEdTn3jvWTP8UCm9z/f8Y517uYnZgwnAcggXG9MO
         ZHDIe+7WLUT8oe5S9jSN1G2pxZp+AvLqmDiSzs4ISCn1nNT/IWOLG8o1IYt2JRDF2L4l
         x3goxMzW3II7ylCWRQgypLbmy+BGDDTZr7dQJyckJ0vEpcyOAeTkz4LnjqWSMI9DD2Km
         rQZA==
X-Gm-Message-State: APjAAAWepmfWE0SoxKE3kx10TdFVdV1Mg15+0vDJ20nj4aTNG/cICjbQ
        m1v+VsesUJJX1RzE7oy3K7iO54WK6k10LrswRtk=
X-Google-Smtp-Source: APXvYqxQLFDR37pSTQI/szFlr9J14xsPgsOyULeWo25lHgFBYe8OK0H+QQ5U6CjsH1G4Jth1bq6vRNAJJRHLRxWUQmQ=
X-Received: by 2002:a02:c64a:: with SMTP id k10mr17271849jan.30.1556150922105;
 Wed, 24 Apr 2019 17:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <CACsJy8CKwiNknEkEH_-DxuXYiBmpYvfdRAZvmSJCcqko_OYnTw@mail.gmail.com> <20190424234045.GN6316@genre.crustytoothpaste.net>
In-Reply-To: <20190424234045.GN6316@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Apr 2019 07:08:15 +0700
Message-ID: <CACsJy8CS-9339TFJHkwbK17mhS85g2KYg0ysr+8PxupSqps_Tg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Multiple hook support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 6:41 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Wed, Apr 24, 2019 at 04:49:54PM +0700, Duy Nguyen wrote:
> > Heh you beat me to it. My config-hooks branch [1] has not been updated
> > for half a year. I only skimmed through quickly so no useful comments,
> > but I went with a slightly different design, introducing
> > for_each_hook() instead (see run-command.[ch] in the last patch).
>
> If I grab code from this series, may I apply your sign-off to it?

Yes
-- 
Duy
