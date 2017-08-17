Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC67120899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbdHQVej (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:34:39 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37866 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdHQVeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:34:36 -0400
Received: by mail-wr0-f176.google.com with SMTP id z91so46172761wrc.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+5ZdoffbrURrJVLaWmdh+em6m4jrPrjBYGkjBQPfaWg=;
        b=s9tnXaP8WAvVpi2lucPTd4OufFx9uoZ7IESR/bNkidVSoz5Cz6Nvya+1Dp06cUdZLX
         iJbXDRlP/bjJvrgxa7Oa0IX9Cd65g7kxfjnDAdgYcch5eYItoBw5ENkZia3TqHettRLS
         HgK65kiipmFswFoK+vX+0Brg3nGSMwYRuxDXks0cauuGA0yqH5doJg99GR81Pcwl5Znp
         gMnPJDCkn+q81V8q7RP0gBLCYVP3mdNjVqzPIAAaL/OCmk7n9FlWiAkX9PMJK9gwbWhI
         Y09RpM4Jt2cAFVXuHCTqx9NSpxK/xPegTq59j1khTXYefF2a0QN9cLQKsFMMG0YZp7F2
         j+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+5ZdoffbrURrJVLaWmdh+em6m4jrPrjBYGkjBQPfaWg=;
        b=PJPsDELPAu8TrwaF/fUhYvcDujaRLr3vmcM4dvcOFXJgUBgD8muFWu9sL02AtmtGNl
         YtCgSr9X780BuStxR3A+c5D+uhY/hFw70m+a3md1PD9CGny5/tOZVOIoq+Si7tCGGIQm
         7FDnGOyOi2xY8Qm7mEimwwdke7UMQFs1D2VORJWuic4Hb0IVMrEboBfoyy+z5/X6Faz6
         +L63K8Outwx3OsK2oq4DCitxXdYKNI/UsC0GyVXHPNw/g0f2wXGHQwefw5oS6XP5/kDY
         eUDkWjv6kYJCLwlsM6ICj6lN6aCl40btIZFuW3YcW3etrR19n4ypu1bxT6/QEeokbv86
         tqRg==
X-Gm-Message-State: AHYfb5isS1sHLkBPLIAz8uQD2l/Rs3wzTqx9NDJMhpp7kAJzNyob+ZE1
        iz+y4j8wpcdT0A==
X-Received: by 10.28.211.145 with SMTP id k139mr113476wmg.130.1503005674837;
        Thu, 17 Aug 2017 14:34:34 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6AA8.dip0.t-ipconnect.de. [93.219.106.168])
        by smtp.gmail.com with ESMTPSA id b125sm3681152wmc.41.2017.08.17.14.34.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 14:34:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqbmndgb8w.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 17 Aug 2017 23:34:33 +0200
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25BB25E4-DD3F-46A5-8CD5-D784CBAB6F52@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org> <20170815111725.5d009b66@twelve2.svl.corp.google.com> <20170816002257.GG13924@aiede.mtv.corp.google.com> <CAP8UFD2jLdR7HTi-T6J_xWvxKyoQf_6pUTX1CWsd9v3TXh9FXw@mail.gmail.com> <xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com> <CAP8UFD1H4Pb5e2_pioQ5neROc+64e55RfvRhiyz5Df5AwJg-FQ@mail.gmail.com> <xmqqbmndgb8w.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Aug 2017, at 23:01, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Christian Couder <christian.couder@gmail.com> writes:
>=20
>> ... but I think we should then emphasize more in our test
>> scripts (maybe by giving a good example) and perhaps also in the doc
>> that the filters/sub-processes should really pay attention and not
>> output any capability that are not supported by Git.
>=20
> Oh, absolutely.  If you know there is such a breakage in our test
> script, please do fix it.
>=20
> Thanks.

Junio's reasoning [1] is spot on from my point of view.

I intentionally did not add the negotiation to the test code to keep
the test as simple as possible. However, I wrote this in the
gitattributes docs [2]:

  After the version negotiation Git sends a list of all capabilities =
that
  it supports and a flush packet. Git expects to read a list of desired
  capabilities, which must be a subset of the supported capabilities =
list,
  and a flush packet as response:

Maybe we should revive "Documentation/technical/api-sub-process.txt" [3]
after all to explain these kind of things?

- Lars


[1] =
https://public-inbox.org/git/xmqq8tijpkrv.fsf@gitster.mtv.corp.google.com/=

[2] =
https://github.com/git/git/blob/b3622a4ee94e4916cd05e6d96e41eeb36b941182/D=
ocumentation/gitattributes.txt#L408-L411
[3] =
https://public-inbox.org/git/20170807102136.30b23023@twelve2.svl.corp.goog=
le.com/=
