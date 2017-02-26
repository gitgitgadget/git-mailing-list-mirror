Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23482022D
	for <e@80x24.org>; Sun, 26 Feb 2017 19:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdBZTUw (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 14:20:52 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:35855 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdBZTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 14:20:51 -0500
Received: by mail-it0-f46.google.com with SMTP id h10so48375912ith.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=OU71Pgy04lTjbebd8yg/AlNsW458rTH5LrQ9XEC/5QM=;
        b=Qr7RpwHMZKFQIUn+JOU1/fF1ureStkJ2PofoKpzqdAnADMzDU+4intwd6GJLJzZsyQ
         ZhGHE/4u4FL30Lb087Dwql9EyTBj4P7yUYrwE+kCX8HhPseqmns03sMRo9QP25f0seJl
         SlRDSTwPWdCILMjiXnJfX4c5py2vc9nocTxHvSB4BxqJX1uozutRiCPrdIuCchW90lHa
         dZpH01xahEX/ZisT0xhJgMuEnZrDkyCD5zuDqsgJafURqbXSxpz6s8YOk0F1zQhfE4Hr
         ACqnHQJNgfB/0zpFbsSnaj8okjoPDI3HJh/OzTD4ygKzbuHYjzCwxcf5ybBamgMp0TGu
         7RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=OU71Pgy04lTjbebd8yg/AlNsW458rTH5LrQ9XEC/5QM=;
        b=VxqrJZd+mRlOns9SpuR+SMUDmy8xWoZ05D+yi573wZ/ufu51dB7y2a4rfRY51ZMsPD
         +DU9MF+TKvA70L+XF8JXc5eXchy9xF6fqoTzRYbLPECPdVe1+Ml+8z0xiDjH/W2NnilY
         guXmyn4I82NURbFBIU/Pb3LtqNup6vncPwyn5X9OJlNLDqmXWmAXtALUMfdDwbrk12HJ
         DTKgXSs+UcY/tAtaJbtkePK5RAUbqrKARD8vBOmHrjdIoUnKlJOJO9erB0Mj5Ju7WBBt
         A1kDDcpAOxgYP+91VjOLJeEAdjqyIpGlfXfxurfg8wMC/JsOY4xPGOiOdfh12bRRrYzd
         t8UQ==
X-Gm-Message-State: AMke39nkxAYlDVw6bzjs3NYub8ot4Vt3TMlWpDQKC0p4+FR0hTNPrQgmXqw/D9SsUYpxdy0fHtxRj+LNWiMEbQ==
X-Received: by 10.36.40.198 with SMTP id h189mr11330189ith.114.1488136288243;
 Sun, 26 Feb 2017 11:11:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Sun, 26 Feb 2017 11:11:27 -0800 (PST)
In-Reply-To: <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
References: <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com> <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com> <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com> <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net> <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Feb 2017 11:11:27 -0800
X-Google-Sender-Auth: rRFijhByDSFgGmh72VsfUOSS32k
Message-ID: <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 9:38 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> SHA-256:
>   Common, but cryptanalysis has advanced.  Preimage resistance (which is
>   even more important than collision resistance) has gotten to 52 of 64
>   rounds.  Pseudo-collision attacks are possible against 46 of 64
>   rounds.  Slowest option.
> SHA-3-256:
>   Less common, but has a wide security margin.  Cryptanalysis is
>   ongoing, but has not advanced much.  Somewhat to much faster than
>   SHA-256, unless you have SHA-256 hardware acceleration (which almost
>   nobody does).
> BLAKE2b-256:
>   Lower security margin, but extremely fast (faster than SHA-1 and even
>   MD5).
>
> My recommendation has been for SHA-3-256, because I think it provides
> the best tradeoff between security and performance.

I initially was leaning towards SHA256 because of hw acceleration, but
noticed that the Intel SHA NI instructions that they've talking about
so long don't seem to actually exist anywhere (maybe the Goldmont
Atoms?)

So SHA256 acceleration is mainly an ARM thing, and nobody develops on
ARM because there's effectively no hardware that is suitable for
developers. Even ARM people just use PCs (and they won't be Goldmont
Atoms).

Reduced-round SHA256 may have been broken, but on the other hand it's
been around for a lot longer too, so ...

But yes, SHA3-256 looks like the sane choice. Performance of hashing
is important in the sense that it shouldn't _suck_, but is largely
secondary. All my profiles on real loads (well, *my* real loads) have
shown that zlib performance is actually much more important than SHA1.

Anyway, I don't think we should make the hash choice based on pure
performance concerns - crypto strength first, assuming performance is
"not horrible". SHA3-256 does sound like the best choice.

And no, we should not make extensibility a primary concern. It is
likely that supporting two hashes will make it easier to support three
in the future, but I do not think those kinds of worries should even
be on the radar.

It's *much* more important that we don't waste memory and CPU cycles
on being overly "generic" than some theoretical "but but maybe in
another fifteen years.."

              Linus
