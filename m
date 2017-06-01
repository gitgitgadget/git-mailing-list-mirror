Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544C32027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdFAJVh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:21:37 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37275 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdFAJVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:21:36 -0400
Received: by mail-wm0-f41.google.com with SMTP id d127so51890068wmf.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BrGmPIulq5aKslpTCpf1DatDtFv/lJVdZpRz8hZCUjk=;
        b=TB+Nzxac6T48DMujhuZA3m4b0H9og6eaCi1lX9pg/5XRd9xsFA7YfW6AKXkoTXCXUC
         caoPVbMImef473EFDCB84HLM+UaoGYcRsc1TLXI8Tt4BTpxWCC2E7KObRn3hKj8jfAO5
         4j39QvuD2O/EwOIq/m4rQ72lYw2dTmwUBsvLOc/NLPpdakTx9hgaBUILcEEC77iU2kFv
         E4AWIEyygHQy6ZTUxDrFpfjQ/rszc4Tzg0TnGZUIL2+xTc/2P4wbWS8FCZSHrxrPXVfT
         0UOxK0uGj/15MpnQ0Rsmd3FulgazrXoajokQVL/FwO3H7mSwwtVIMb/aaK2j2PGhoJ3t
         ZM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BrGmPIulq5aKslpTCpf1DatDtFv/lJVdZpRz8hZCUjk=;
        b=C0vn9hUd6o9zCFBteHJVIg2OEVHV9rjD7197wxVG9xob/wFhC0Bw1uoKufwtQW4CGd
         JXj3H0FJxd2UsmEY3Tr+HDPpBiNZjBnfW1atb8RfgFkCbysoxSWViZTrehMkmF8krBaD
         7H7ist/qM98DJU9qFghh894pfP2+moaBG+XZOE3vYAlPpm1Z9xMdLxt/+vTVMLLGQpZq
         UoSFtalU3XeAxtvqwGVpwDEq0e7brJxW3QVJCOJtp0/mDM0p6dgyxKT6d+AzeDi03CYo
         2Uu5i7h+lzlLwYMwSI8Kmusgy4nexVI//EGUJW+DbYTVSIMyrDYyNbC1Dde4AFSVMU79
         bUBA==
X-Gm-Message-State: AODbwcD0oxeujBGzABP/Pudg3WtmobuztuyusMeCq/EvXiJ9lRs0TRQ1
        4bogbP4KQbqBBw==
X-Received: by 10.80.144.14 with SMTP id b14mr1012832eda.36.1496308893944;
        Thu, 01 Jun 2017 02:21:33 -0700 (PDT)
Received: from [10.146.248.57] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g48sm8191385edc.8.2017.06.01.02.21.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:21:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Unaligned accesses in sha1dc
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <mvm4lw0un5n.fsf@suse.de>
Date:   Thu, 1 Jun 2017 11:21:31 +0200
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
References: <mvm4lw0un5n.fsf@suse.de>
To:     Andreas Schwab <schwab@suse.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Jun 2017, at 10:28, Andreas Schwab <schwab@suse.de> wrote:
>=20
> The sh1dc implementation is making unaligned accesses, which will =
crash
> on some architectures, others have to emulate them in software.

Is SPARC an architecture that would run into this problem? I think
there was a thread a few days ago about this...

What architectures are affected by this? I think I read somewhere
that ARM requires aligned accesses, too, right?

I wonder if it makes sense to emulate SPARC/ARM/... with QEMU on =
TravisCI [1].
Is this what you had in mind with "emulate" or do you see a better way?
If we compile and test in this environment - we should be able to catch
those bugs, right?

- Lars


[1] https://www.tomaz.me/2013/12/02/running-travis-ci-tests-on-arm.html=
