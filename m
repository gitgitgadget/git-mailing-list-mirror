Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D1820248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfDOOfK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:35:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:48591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfDOOfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555338892;
        bh=/sBj8E9wQLpLbh24OumO8Qv7wsSfK42pPL6tAlPRvtg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RrLkdX1EQ3DHyl7+jjGQnwRa+ObGKQDimZjHn9d9I2qUWHPArXBryPJEz70V9a984
         lZGlNW2kCXgXpbZsyALkD6AFzxmVpa2Fn4JJ38ylYxV9bDEBZP39qFTHLIUa57UBwj
         AnlEMgmcH6o7UpXLLpIKe/xBjPmteaRes0PYHnpw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ME47n-1h4mxw3WaV-00HNCR; Mon, 15
 Apr 2019 16:34:52 +0200
Date:   Mon, 15 Apr 2019 16:34:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 01/10] config: initialize opts structure in
 repo_read_config()
In-Reply-To: <20190412035220.GA26967@google.com>
Message-ID: <nycvar.QRO.7.76.6.1904151629020.12614@tvgsbejvaqbjf.bet>
References: <pull.169.v2.git.gitgitgadget@gmail.com> <pull.169.v3.git.gitgitgadget@gmail.com> <ea8c199f911a84505b1aba5735a280ffc989e2a1.1554995916.git.gitgitgadget@gmail.com> <20190412035220.GA26967@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Sq/+oio8h0Pb5PXUTI66faGZQwqvYREkuyVjT7PMpv0Mr5Yhcqc
 f/UZd/WRW0DRcJi8VkRAcUXLhIzwH8t6MI9s86NFkig217cqbHZSjdYs6qiRgHWJxKbgtwP
 4BQBgrmp74+B0gKp7xqXYG2CjgkHb2WrLe7dM/NPKp2ah/uRPhRWnTJ7H6vjWZpCuu1xdOm
 yTFo4iuiHhNOcBSf0vt7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+L+Rs13tfw=:KA1OLzur8eErSoDGYPI8V5
 zK/x/R6+EyQJAUzo175ueDa0op/N3VGnW21JZMfVfA0f6upxoMXb1jGoVptx03vpsvAX0dohk
 7enN/t7UEfAB5OVWjspm8HhcSwLiQX3B43ntTbDC5STFCO9wUtH32fcaXHKUtsh+Vr0OdGn1s
 oNd5snpHesR4J9mzsETvuprI42k1jIinCgeAUkiZ5xR8P+j0NnZg4jPRNxU1M+zFVqnn8DaDg
 86eqVE094ZkRczWjY4Z3qjghbs+I57nxoNjEiAANJI5/oFWJqPCI3zqeHgNJf8J5PdnPSRT6E
 cF+doNGRoriUTrY7Lql8fhx0yYH+n4ofDG7AqG0FBlRechwoB9eWPv3wzNVXBBkcvES18xJEH
 hZgVi31Kh9ov3yN24CRx+U5R/IpA3Ge2nGoX2RDxdLM1nn0wH3rRB2ASpil/9UlwKdmnzv5BU
 jaN7wELpd5+gJLwPB+l+TQMheQXnqpjfkAMUEBDY4GVevmRVuBHwLEm2Q13PiRtGM72muTUH5
 Ww6cwr3lG//eTZGLAGsAb1VGVImWsp+oCBpBL3hzr/vY43P3jAtblzkyVu+n6B9ttf3K1+04X
 32MBY0gwGW8dUffR44xOeRZuDEfOJV0sseJsPT0/OZYm6vQfk4I4eTDQtwuJDceAQI6J6M7nt
 DvkPH1OXjk0jXY+7Oyr05bmkoSPrFuclBtvLWafPyPHKiELDGUxsNpp/uu3jlTDrVymK3wntZ
 RvYL0wra2Pi8dYHla0gZ8havKxc2OlG6isB3S/aJJWF305EY/vmXu73X16lEncGUqQyxg//cG
 Y56vrb/bacvQSfRSKBAAP6lZLX7Ynizt6OX54HSCA0UAfRj7C84ysHzhaUhqg+kX+UWTtjZ76
 Ox0ElRgUuOTbDq6xxnC88HLLUdEHc1ES51bBtKbEQu04+aVdRGH0lQ61Vvablv1LhwFBSqrbv
 xEHiwxORerw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 11 Apr 2019, Jonathan Nieder wrote:

> Jeff Hostetler wrote:
>
> > Initialize opts structure in repo_read_config().
>
> Good find.

Heh, it really was our CI that found it, and it was I (with valgrind's
help) who identified the problem and proposed the fix. So: thank you!

> I wonder if there are some flags we can turn on with
> DEVELOPER=3D1 to prevent this kind of issue going undetected in the
> future (or maybe this means we need to get the valgrind or ASan
> testing modes to be fast enough for people to consistently run them).

Sadly, I do not think that either is an option. Such uninitialized memory
is really hard to catch without in-depth analysis, so DEVELOPER=3D1 is out=
.
And `valgrind` (or the faster alternative, DrMemory) have to spend quite a
bit of time to do what they do, and it is unlikely that that could ever be
made faster.

A better approach might be static analysis (and I do not mean the diet
coke of static analysis that we run as part of our CI, but something as
powerful as Coverity).

Sadly, Coverity makes it super hard to switch off false positives
regarding e.g. our use of FLEX_ARRAY or strbuf's strbuf_slopbuf.

For quite a while, I wanted to play with [infer](https://fbinfer.com/), in
the hopes that it would be possible to do customize what cannot be
customized with Coverity. Alas, their use of OCaml (why do they make it so
hard?) puts quite the bit of a road block ahead of me in that endeavor.

Ciao,
Dscho
