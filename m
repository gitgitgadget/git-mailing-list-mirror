Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F411F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeGIWim (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:38:42 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:45859 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIWij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:38:39 -0400
Received: by mail-pg1-f181.google.com with SMTP id n9-v6so1250607pgp.12
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-original-authentication-results:x-gm-message-state:resent-from
         :resent-date:resent-message-id:resent-to:date:from:to:cc:subject
         :message-id:references:mime-version:content-disposition:in-reply-to;
        bh=0zcY8VySo8AZQl28/EGWGxFSl+mGTBB53XWP1iBIwvI=;
        b=E7qKCjkUrXr7cxgS1B9td4CwG/wFgJpp9ovsc7noheVUMNrJguUgZNnDE5moEGtJsx
         U2Kyblo43IZERd+X6v2mdI+kCYMhtSwa7crK0k40asSeym8OcTLDNuIdjOqQFp1T+Yyw
         v5fEK4qc4RCOVBDori2jxJP8chQxTj2PKOzAIgNkpGP/BUXGgkDLz7dVxqZdKaNMH9tW
         AvdSTNXte/PgCuMAydtrx7FR5AZfbTxCR8M50BeZrpEBFD7Fytmgv/P1yCp+bO1un8RR
         pp50Dk6e+YBaYJKFsULnaCBrIWhzcJ6vPBPzMQJxnC84vDz8EtRAIUxcUoDukMzkTDnP
         DcrA==
X-Original-Authentication-Results: peff.net; auth=none
X-Gm-Message-State: APt69E0qqqSFMMv4yoBLMdZ3sRcDqePRsHDRUGDqKsenJIgzmCpLHzQY
        R3ra7Syjpg/lNF2+f9d+XdaNd/3F
X-Google-Smtp-Source: AAOMgpc6hwo4qPn8vOTZtoNX0dYBgegoPwc7rPoWzVEkbvQBBj7qa2JJVtyt552DbUopZtFrjhZDqg==
X-Received: by 2002:a63:5e45:: with SMTP id s66-v6mr20250844pgb.151.1531175918835;
        Mon, 09 Jul 2018 15:38:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a15-v6sm4410106pfe.32.2018.07.09.15.38.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:38:38 -0700 (PDT)
Authentication-Results: peff.net; auth=none
Authentication-Results: cloud.peff.net; auth=none
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp1238366iof;
        Tue, 3 Jul 2018 06:36:48 -0700 (PDT)
X-Received: by 2002:a0c:f002:: with SMTP id z2-v6mr16055062qvk.160.1530625008361;
        Tue, 03 Jul 2018 06:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1530625008; cv=none;
        d=google.com; s=arc-20160816;
        b=AifIcWBarKCwgX6uu5ZXKktw6NbDy9cJD8Ykrhn+9ZlGahiPa0fyKfP3svBJiDMxt+
         HY/Q0qoRZy0fU0t1+TrD7WTkYQ2DTLtew9Qgh/Zrdv5bUtZhdY4KI/KTy40qnjHL0KfE
         IqMZilsPXSBf1562cyqXeiWN/R4CojyroWUrpb90+rnmO94qie2Orm4mRDg/GZaE9rF0
         yiRDtavyvtufGjmt+1o34QyVtKdUVs1n3QFzUC8AS0uAaW3DwFihk+KbKs+weV7itjoB
         +toVQgD+9ZnuEhjISIOl6eyRjcyP+cnG1yYJav1k1wYI2N7W74n9Xvopc251LYe1nCsX
         9gYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=0zcY8VySo8AZQl28/EGWGxFSl+mGTBB53XWP1iBIwvI=;
        b=By0kOBX0eJEfSAn6TWAnEVWz58nx2PhpGRdPmuD/x0XGrpKlBKrp+rD5FgjI0Ip64Q
         GDx4zQooZJZeWwUkuS3AY564ce/nw7Y70r55vyTsWJLeM330XWTSWShY0kKzm3znXec+
         pIp30ffJtCvkiLAWVOIHl/ZMYneYdDUIHz1Q4Fae3sx2+KKpHZpBF4+GsAHDwXyt0MKa
         9PiSNFIRc9PZh02qOJdG7sQkssiQAwobay3AmxRaMwWoOVCYLtnwM86dIUi4v4Pd9G3E
         BGsqmBb7JhiJuRzpRwJIXUlDvNb/8u0foWvMgS8OlB33xvg18kzRcKiJVc9v48Xtl5p5
         Ri8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) smtp.mailfrom=peff@peff.net
Received: from cloud.peff.net (cloud.peff.net. [104.130.231.41])
        by mx.google.com with SMTP id w44-v6si1100922qtg.179.2018.07.03.06.36.48
        for <jrnieder@gmail.com>;
        Tue, 03 Jul 2018 06:36:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) client-ip=104.130.231.41;
Received: (qmail 18794 invoked by uid 109); 3 Jul 2018 13:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 13:36:47 +0000
Received: (qmail 1836 invoked by uid 111); 3 Jul 2018 13:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 09:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 09:36:46 -0400
Date:   Tue, 3 Jul 2018 09:36:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180703133645.GA20316@sigill.intra.peff.net>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 02, 2018 at 01:15:19PM -0700, Jeremy Huddleston Sequoia wrote:

> > I hope that maybe they're also interested in reducing the overall
> > diff between upstream Git and what ships with XCode. Last time I
> > looked (which was admittedly a while ago), a lot of the changes
> > seemed like things that could probably be considered upstream.
> 
> I'm very very interested in having reduced differences between what we
> ship in Xcode and what is upstream.  I've been maintaining a repo with
> our patches that I rebase as we move forward, in the hope that these
> changes might be useful to others and a derivative of them might
> eventually be accepted upstream.  See
> https://github.com/jeremyhu/git/commits/master for the current set of
> changes that are in our shipping git (currently on top of 2.17.1).

Thanks for sharing. Skimming over it, I see:

 - several of the changes look related to run-time relocation. There was
   a series that shipped in v2.18.0 related to this, so that may reduce
   your diff once you rebase.

 - The xcode_gitattributes() bits aren't likely to go upstream as-is.
   But possibly these could ship as a default $sysconfdir/gitattributes?

 - the rest look like assorted little fixes that probably could go
   upstream

-Peff
