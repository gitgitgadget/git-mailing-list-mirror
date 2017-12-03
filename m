Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B50120C11
	for <e@80x24.org>; Sun,  3 Dec 2017 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdLCQjO (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 11:39:14 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40009 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdLCQjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 11:39:13 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so4259059wmf.5
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2S32Xc+7aK1/IqtjtG69aC//Zcm1xlf30fZkcKZQBUQ=;
        b=S9DLREelaPWAtP16tMI2C/8M5kWiaZ1Nqyiq0Fxh87OlyeSZvhlA4WazpZVPvSLxXm
         CmNGabb5/7PLLtS0KDrFMFK2gTnS3ifKyjEEez2O+2ra/OsPc3M3ebQU8qYnG5IzyliO
         7Tfg1ZzJuJmDxseTjKFn1hCvenQ5Vw5WbQrkBQ3skxQcsgVnYw7rCfoE2G17wba8n6n/
         zIlAFkKOaQdktP9TT32Ot60SrCClSONTD5mwEpoeWjvVIUCcLZ2EOebpMwtZJl4VSVFS
         5JJOpRRJkjAoAkuqJczV5nZtyJ2yf8UaGZgIcMCb6QsXlCAfEJgTiGqh9qSrqa/OAUmy
         MSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2S32Xc+7aK1/IqtjtG69aC//Zcm1xlf30fZkcKZQBUQ=;
        b=kR0sI07+Wf/K1jDyyg2mHn2rlXcARhY/k/B1oa3K+IqQy9lFWja+9zIEinHPNM40Fs
         LF0MprvSZ5EDeHSqXekIzn8vxu0B9UwTNPFlqeaiS1UWaStE3tj8Qa2/dTVPE+fl1j2f
         pnX8dTqltc0K9T2vz8y36Vo8DHkgwy8MRoUG05kPHom6jI/nBqMM9DLuoj+fjc3233b4
         MD3fUcOz+kZsYgf9Rp/U8GWBasR31HIuQic4HO2cKLiWpKVLicwcw2GhQ6x7lA21KW1/
         rJgJTk7Jkd79OPKWYPQrUCPVCjWrLEuqzVAtBbuwQnfsrI0SMO/CnEErzCJE/A+DBTPN
         utpw==
X-Gm-Message-State: AKGB3mLrkZXJxXDD03bc+kK0QJiJA5TZhSLqfqDDqR1wEGMAY22IoAjz
        jSRj31aSnh00wP5bZiIaxXI=
X-Google-Smtp-Source: AGs4zMaO66GEXkOL/6e46xV4VC6K48V5Xz0CQKzLx1YZ9AnBKkhw37kGmgzEVqtIam43U9nDdMVOCw==
X-Received: by 10.28.7.133 with SMTP id 127mr1129750wmh.31.1512319151894;
        Sun, 03 Dec 2017 08:39:11 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6E6A.dip0.t-ipconnect.de. [93.219.110.106])
        by smtp.gmail.com with ESMTPSA id x17sm9714842wrg.82.2017.12.03.08.39.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Dec 2017 08:39:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
Date:   Sun, 3 Dec 2017 17:39:10 +0100
Cc:     Jeff King <peff@peff.net>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net> <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com> <20171201182924.GB27688@sigill.intra.peff.net> <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Dec 2017, at 04:45, Kaartic Sivaraam =
<kaartic.sivaraam@gmail.com> wrote:
>=20
> On Friday 01 December 2017 11:59 PM, Jeff King wrote:
>> On Fri, Dec 01, 2017 at 01:52:14PM +0100, Lars Schneider wrote:
>>>=20
>>> Thanks for the review :-)
>> Actually, I meant to bikeshed one part but forgot. ;)
>>> +                       fprintf(stderr, _("hint: Waiting for your =
editor input..."));
>> I found "waiting for editor input" to be a funny way of saying this. =
I
>> input to the editor, the editor does not input to Git. :)
>> Maybe "waiting for your editor finish" or something would make more
>> sense?
>=20
> May be the good "Launched editor. Waiting ..." message, that was used =
in a previous version, itself makes sense?

Perfect bikeshed topic :-)

I would like to add "for your input" or "for you" to convey=20
that Git is not waiting for the machine but for the user.

    "hint: Launched editor. Waiting for your input..."

Would that work for you?

Thanks,
Lars=
