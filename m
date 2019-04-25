Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30A41F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfDYP1I (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:27:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45522 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDYP1H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:27:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id k92so216590edc.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HGxegTF5hZP7+f7YMERNwoNJtnQLckDZhJMwooShGfE=;
        b=r3vyDQ0FAORda1WKgbbNRdJn9To8amlbICMoj8Xm923O6EYMrv1Pqh/ka3jQiuolaJ
         4s4+VFIIcZadBiGGU14UdeLW4wTEmujUVPmUb5uINWg2R+scL/kkR+dCe7N8hYGKo1uD
         hB59MtQnK+gms3vejpImFWMEBv4thI8I2wgF/duZxqbg0tnzRhREEot/JQ/strjQDL5A
         WWLPNuNqDCCiA0lOV88EbxJ8xt2cmUDBufnFO/k/ZVbBSGERTHddfEBat8695cw5eSPv
         S6sZpG5jm33hgvCGkEWjPVgup5w5txL/n9xfxbJ8/tVn2PiqOnYUHt6e5Ix0qkz1iOA8
         LKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HGxegTF5hZP7+f7YMERNwoNJtnQLckDZhJMwooShGfE=;
        b=r6sbgCwhVwx6r9hCU9AVxK54DGBCh4KKkkwXuM2rQtxuK8bBxc1T9Tqd/dbu16M2Zt
         zHKc8vKmB4aLmgn0sp/ByJcYO+xUgIbD3UBI8ngEhlPTy7FjH0MQKfLmLc2DpCxgNoBZ
         6gheCqYqI038dx/H3w5K+NBY8/pAtNtZTgupFUQ9aXCPuQqs3T6GB8l3mOURbkMwDeLS
         tbpoZSB/XcfDEEgkHqVh+Nf5Seylejb2gM+nwQ3O/dZOsw3Hfw6XaMR5iyQaimp0Z9Lj
         fqVZsDSZXTsKrUF6aKtkgXnzGiZdSOV/FXzCIQejmqq/iF3/vLlJCqIDsC4a7j6Pvf+k
         ujrQ==
X-Gm-Message-State: APjAAAXyUnGApDgEK5ydjtxJNrG8oBQQ18HYoXmrqKiis8rmJ2W8bfgQ
        HvGm7OpMztkgj3ZhFU2jKUw=
X-Google-Smtp-Source: APXvYqwb33PMp8IZvhfkpQGDq8dtgS/1vJMS0d17/zxqPujUBpGN2hbAfkm77kmMo1eejTxdAxZLwg==
X-Received: by 2002:a17:906:1dc5:: with SMTP id v5mr19284985ejh.66.1556206025811;
        Thu, 25 Apr 2019 08:27:05 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id b1sm4123734eje.7.2019.04.25.08.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:27:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net> <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com> <74ea0269-3e4f-1f6a-c060-c5ac969b91e8@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <74ea0269-3e4f-1f6a-c060-c5ac969b91e8@google.com>
Date:   Thu, 25 Apr 2019 17:27:01 +0200
Message-ID: <87d0lartq2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Barret Rhoden wrote:

> Hi -
>
> On 4/25/19 10:36 AM, Jonathan Nieder wrote:
>> Hi,
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> Because we don't have some general config facility for this it keeps
>>> coming up, and various existing/proposed options have their own little
>>> custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blame
>>> skip commits" feature
>>> https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
>>> (b.t.w. I*meant*  /dev/null in that E-Mail, but due to PEBCAK wrote
>>> /dev/zero).
>> I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
>> That is, I thought the intended behavior is always
>>
>>   1. For single-valued options, last value wins.
>>   2. For multi-valued options, empty clears the list.
>>   3. When there is a special behavior triggered by not supplying the
>>      option at all, offer an explicit value like "default" that triggers
>>      the same behavior, too.
>>
>> and that any instance of a command that isn't following that is a bug.
>
> Not sure if it's meant to be the standard, but I just went with the
> style used by credential.helper.  This was suggested to me by Johannes
> in [1]:

Just to be clear I'm not picking on your patch, I think doing it that
way makes perfect sense in the current system.

Just as noted upthread using it as an example (that was fresh in my
mind...) of a case where we want this, but it's a bespoke thing for
every use-case, and not consistent (i.e. just supported for your new
thing, but not for the existing fsck code that's mostly the same).

> On 2019-01-18 at 10:47 Johannes Schindelin <Johannes.Schindelin@gmx.de>
> wrote:
>> A better idea IMHO would be to use an OPT_STRING_LIST() for
>> `--ignore-revs-file`, too, and to allow for multiple
>> `blame.ignoreRevsFile` config entries (with our usual trick of handling =
an
>> empty setting by resetting the list of paths that were accumulated so
>> far, see e.g. how `credential.helper` is handled).
>
> [1]
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1901181038540.41@tvgsbejva=
qbjf.bet/
>
> Barret
