Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E2E1F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdLLKz5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:55:57 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45476 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLLKzz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:55:55 -0500
Received: by mail-wr0-f182.google.com with SMTP id h1so20603347wre.12
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L1dvxuFX1OoH4YTIACzSgvgaUodMR4NYeZtC35J2CwI=;
        b=kXTJy5PfwrbnxCZY6PYCGV9w3G2dMVNhkVY4EnsZi5ooOEmYG9cjBBm3g5eryKfybk
         mi6Xg1N3fdEc874b5/Ju7xE4cMHPVyXEBdT2WhFw7/jjcmxdYFVs7E2E2ZmIQbtmu3oG
         0B9BsWpMpCF39odAQUjH2pzHh+7eKa70MGxvpxe3b5z+foN2QnFrrpX5gXLrmgSKvGyX
         TU2KyAMx9ue5+hcLKc20B/Zmnt6hJw0tRifhIQKQMOoanVlSy59pf7bwkKGqARU3EtQ4
         bzbucRZ5IuYDCtGxjCqocVmJP4HB381e7TW673zqnuG7frtypiojGD+xwjshUXhHy9PA
         minA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L1dvxuFX1OoH4YTIACzSgvgaUodMR4NYeZtC35J2CwI=;
        b=OAXSmGoD98gN4q+8Pm0naCj8pSGtDiJqbaGbBKU5363UPtghVswfo3sTJ5SJfz+tix
         z4xE7p+OqrXaDf7pkN/hDNTYFwdL8AFDLhIPPjXhgnO1a84Udbc7tvHfZH0sSM2FTMW9
         9YgstKT1W2T/RFL//mJ20lDBotN4ycGjpnWG0fhiPmizEAizUcHd7nLbHUqNOJOk4haI
         BgiFM3Lonxn32qEuTaoUCe4K80wvLO4hgSfywF+wh1uaCV9kqkSJh6iTMWQ1BZh7R8aa
         IHRJu0oGLuXulLz8eoclgoAt2meix+5vxHP+WFmuNtQiY6w0cgly8N4rIZQpUWrXehAF
         vWBQ==
X-Gm-Message-State: AKGB3mKAPhVvaM7zFvmr4+MaOlAK2tOxkDgKDSWgvReXX68Qql2RcRyO
        gEna4U46MSHMZMzP/bmFcbw=
X-Google-Smtp-Source: ACJfBovgCo7as5yuwg3ehwAcbGTqKDZDtSZLXB3sl8zlwbNSy16ucFHSlqIRxoy7jVWWzdw86Ufb6A==
X-Received: by 10.223.139.199 with SMTP id w7mr3549346wra.282.1513076154513;
        Tue, 12 Dec 2017 02:55:54 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f69sm11889904wmi.46.2017.12.12.02.55.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 02:55:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
Date:   Tue, 12 Dec 2017 11:55:53 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        peff@peff.net, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org> <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com> <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com> <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 08:15, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 12.12.2017 um 01:59 schrieb Junio C Hamano:
>> Stepping back a bit, what does this thing do you are introducing?
>> And what does the other thing do that J6t is using, that would get
>> confused with this new one?
>> What does the other one do?  "Declare that the contents of this path
>> is in this encoding"?  As opposed to the new one, which tells Git to
>> "run iconv from and to this encoding when checking out and checking
>> in"?
>> If so, any phrase that depends heavily on the word "encode" would
>> not help differenciating the two uses.  The phrase needs to be
>> something that contrasts the new one, which actively modifies things
>> (what is on the filesystem is not what is stored in the object
>> store), with the old one, which does not (passed as a declaration to
>> a viewer what encoding the contents already use and does not change
>> anything).
>=20
> Well explained!
>=20
>> ...  perhaps "smudge-encoding" would work (we declare that the
>> result of smudge operations are left in this encoding, so the
>> opposite operation "clean" will do the reverse---and we say this
>> without explicitly saying that the other end of the conversion is
>> always UTF-8)?  Or "checkout-encoding" (the same explanation; we do
>> not say the opposite operation "checkin/add" will do the reverse).
>=20
> I would favor "checkout-encoding" over "smudge-encoding" only because =
"checkout" is better known than "smudge", I would think. I do not have =
better suggestions.

Thanks for your thoughts! "checkout-encoding" would work for me.
However, it might convey that Git "does change the files of the
user in some way" (which is true from Git's perspective but not
from the user perspective).

Patrick and I brainstormed a few more possible alternatives:

apply-encoding
blob-encoding
checkout-encoding
diff-encoding
encoding-hint
external-encoding
handle-as
internal-encoding
keep-encoding
present-as
preserve-encoding
source-encoding
text-conversion
text-encoding
treat-as=20
treat-encoding-as

Our favorite is "treat-encoding-as". Do you consider this better
or worse than "checkout-encoding"?

Thanks,
Lars


PS: Naming things is hard ;-)=
