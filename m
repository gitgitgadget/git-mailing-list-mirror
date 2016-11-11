Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451C32021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756223AbcKKJ3C (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:29:02 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32935 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbcKKJ3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:29:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so8091900wmu.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ScB842rECA0Shz3M8AuAxbs1ejFkppGgUJUcih5wbh0=;
        b=x6JsIBMEFO/5Jdmh1PkSqKbLrrEzMrBy4MxX2et18rTceq3cWfnXKQQ/fpsCX+zGEN
         SaJbi6GYBe291QO2KNhdl2QUCPC0qNlnl1GIvysXmPD9ulBwaVWJtQN8sNgisduovOJw
         phRJoCfFcMiiJinp3VDEUCCkxg6bjM05EQuXAsiBcCp+nfNPxtmgTHQuCNK925QFaVpK
         /AqhFE488xaCXmaTy/xQcidiAq+WQQWfLkrZapLy9ptvobXo0dGBC1dYTOdQf2zSTgpi
         pbEly5wHUZazWQtuU/oFeHTjj5ZJqnKk58R2FyMmLBhpKMI9B0RrJi36GK/W/rPmSBSG
         qMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ScB842rECA0Shz3M8AuAxbs1ejFkppGgUJUcih5wbh0=;
        b=abVKVrihWhdOopneDNmuZQ/knkgQrXWI3BMbJMXfP1I0tv28QEDSIGJ+VrhqjRFkvq
         KYvwA3gKH3V2Wk97xOo3c+F6BaVjjmpx/32cUfBnBclbWGe+ta8lHp9BblKFwPC6quUq
         f4oZuRY4PfnEUxQcfMrBTzTg9aoAMYnLx0h+8QKq9FAf+IXZ5Z7CAzYj5BizDN9hy/H3
         uiJL1I3Bx3aYsWbQxl2MyENjg8gVDyczWGo6JkNeUrzALqh5FYwzId1hqxGkdDuQtavj
         5SyrxPT1VKJk0XyJII6KM7Ng5YrzH0VDmDywR3dibXfl0auYrrqqpaNEMtOhqJXEKeFF
         DNqA==
X-Gm-Message-State: ABUngvdd2UX12azs7EXozJ95DrhvAq1/KdIgc0NCcGh+MkpUdYUC+kReqmjSkSCS6IuDvA==
X-Received: by 10.194.60.195 with SMTP id j3mr8232022wjr.149.1478856538709;
        Fri, 11 Nov 2016 01:28:58 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id ba10sm10326029wjb.32.2016.11.11.01.28.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 01:28:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] Add way to make Git credentials accessible from clean/smudge filter
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
Date:   Fri, 11 Nov 2016 10:28:56 +0100
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com> <vpqoa1n1qom.fsf@anie.imag.fr> <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10 Nov 2016, at 17:08, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 10, 2016 at 01:10:17PM +0100, Matthieu Moy wrote:
>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>> I haven't looked at an implemenation approach at all. I wonder if =
this could
>>> be OK from a conceptional point of view or if there are obvious =
security=20
>>> problems that I am missing.
>>=20
>> Did you consider just running "git credential" from the filter? It =
may
>> not be the perfect solution, but it should work. I already used it to
>> get credential from a remote-helper (git-remote-mediawiki). When
>> prompting credentials interactively, it grabs the terminal directly, =
so
>> it work even if stdin/stdout are used for the protocol.
>=20
> Yeah, that is the solution I was going to suggest. The credentials are
> totally orthogonal to the filters, and I would rather not shove them
> into the protocol. It's an extra process, but with the new multi-use
> smudge filter, it's one per git invocation, not one per file.

The trouble with "git credential" is that it works only if the =
credential=20
helper is setup correctly. Although I assume that most people have setup =
this,=20
I have also worked with a number of people who prefer to enter their =
passwords=20
every time Git makes a network connection.

- Lars=
