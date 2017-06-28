Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5842023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdF1VnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:43:01 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38742 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdF1Vm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:42:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id b184so72287616wme.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ctrcZhaPx34Mvsr9/HrkV9hyDbxHep/zj2Ev5FNB9FI=;
        b=YUoSpqi2CpSjv+ZA0rbt/Kc9kk4omRybUVyCJ3sc4ynPb8wJDKT/fDGML+Xq9yU7Y3
         sXTFiqeaIxoiVexfceVmDP4XT2/Ix9xPT+tbCSUIvlOlLRfO1EBryHi+1T6f+C12pL1C
         ENjw5rTKY51RZno+RO0XCNxuJGgFO6ASZKmL7RbrP0eadXhdaaFx8Esvmt/7JkW0DHCD
         M5XT3Qu0w2jw5HReYaSLLPFfmB1u/eohoKh+AkJs1gncfaGwUp3BbDl1u39picv6quCU
         aIMWIEEBRmxVP+fgwlPxGeiA+xTl3hIQ3eXUzXOc6Ar8SDNAffBezGC5uf6UlazMA0qJ
         KjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ctrcZhaPx34Mvsr9/HrkV9hyDbxHep/zj2Ev5FNB9FI=;
        b=qvCVjwRg5jvwn63/muigHXUIwxlA4wnczXQqUnMl2hFX9nW7Xj/FfhBfePnzYFNIjQ
         E41D2VTg8Su3udj5zb+DXeYO8/I/vaFpOgt9nOcOKYhXsvF6HHrISmaQNEi2jQoKc4fh
         RfB7BjXK1a3J2CMsTSDNzp76mvskLBGUZ6P4Ih2BLzYN/xXojklAo1bqeqsqy6Lu/8hp
         zD3pJQlKliFBhsHgcTQKdhdKVpcrN1FY2YOZmFjDWQOtGVCDrVoHgbOtxANJTFzQTgmx
         2LISAZOeq4xYM6qH7PzKZpP/xh9i/JMEC8lz1uO+2GMpfQn+PH3jm3tFY59EdZ7Yxosz
         ykjg==
X-Gm-Message-State: AKS2vOzxLI1TbhZ3/g9EWZE9rWntwCnD9hhQqn1nAxIsVwrgL3LJ1sw5
        UbphHJhFb//AMA==
X-Received: by 10.80.182.48 with SMTP id b45mr9327505ede.157.1498686176620;
        Wed, 28 Jun 2017 14:42:56 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id k49sm3462297eda.45.2017.06.28.14.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:42:55 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQKje-0003jp-CZ; Wed, 28 Jun 2017 23:42:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        SODA Noriyuki <soda@NetBSD.org>
Subject: Re: [PATCH v2 0/3] update sha1dc from PR #36
References: <20170627121718.12078-1-avarab@gmail.com> <20170627203348.19827-1-avarab@gmail.com> <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 28 Jun 2017 23:42:54 +0200
Message-ID: <87h8yzkcv5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> A v2 addressing comments to the v1, tbdiff below. Just fixes the
>> subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
>> for Solaris, we can just use __sparc (and indeed we did before this).
>
> Thanks.  Let's have this tested by minority platform folks to help
> the upstream digest your pull request.  The change since the last
> round makes perfect sense to me.

Just a brief update. This has been found not to work on some BSDs (with
older GCC), but there's a patch being discussed at
https://github.com/cr-marcstevens/sha1collisiondetection/pull/34

The discussion is sorted out, just waiting on n-soda to submit a patch
(or to tell me he'd like me to), then the known issues will be fixed &
it should be merged quickly, then I'll submit a v3.
