Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD3BC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28C320781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qdW86Gup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLSSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:18:40 -0400
Received: from mout.web.de ([217.72.192.78]:51569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgHLSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 14:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597256314;
        bh=H/Bun4J2oEJj/XXNILLKFXRZfiVo2VFU2QB4li6z/c4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qdW86GupOtfdvKAZ8SjEjXMf0TpI6ny/kEGN5yGDtO21jgvUrAlqGrvrRkDE3dT6T
         lInqMMbAQNY12YXi2YwUkJkM0NabhZMiKvc+J0twqGtNEuKtHf+dhJWKAphS3y/heW
         kjcsTA8bCspUd46GHjfDSNOvYjKyTDgw6Lc9jRe0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1kBS902DHw-00Y9wq; Wed, 12
 Aug 2020 20:18:34 +0200
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
 <20200812150611.GA33189@coredump.intra.peff.net>
 <20200812151038.GB33189@coredump.intra.peff.net>
 <045ea49b-7165-0f45-e670-a24bf648f880@web.de>
 <20200812170849.GA43566@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <13d0b147-3c62-5d73-630e-2305c08c3ab1@web.de>
Date:   Wed, 12 Aug 2020 20:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812170849.GA43566@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vg9G7GQ9stF7LWX5qyYIUKHfFEEq4VyQCKL+mckuoVWo837MuEc
 brC2g9jOSLEbDvCPw5+hfiJOf8UScQO0tpZmqLKjyZGfDbaHUudBxlkl3uXAplWRqiOW6HP
 W6/xp3gMey/3QtiIDD+P7tZXbrHhzZZlRxsiR4dLLT4SixZWjBkitBG6XHrvByebj/r7iOy
 mYeCZ2f2yqK7nrC1RouLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ioWmip4lyc=:vKo48jE48bWP3dUs0wozQl
 REAVgZqqURX7XERCH91Gt9g5riZMgsYACx7jjVEiYlozeAAsLcJ4Kiag5wagVroxBkJjMsJsv
 kcD5rBmffn44u3NLkfVkV8hjeQtfFbBdn+/A3y47qHMtbO7fXW4NTSfO8PuddUecXj7fR0DU2
 3CEI76HsCPv9Cap/qBbXwPuHQs5SidqNLdWCcLtqDWnmbxwjBlChsXA65Dy0SKaqFOevyRXP1
 8B8fU06cB+Y3VaeqnyOD3Yowv/eOCKPswiJN6U5SFINK5qh6Eh2rIR8mzgGJKzZ4OJbScVpQA
 gnOL+rn+E4viw82VQ98q9rJRO2EgZDjithuNVjUfSV013APwLz4Kq/i4p1aZincWH/F5U+Okw
 9mne9AyfxhM5R1pWQhOKQx46xkaqbD/WGgMiBqkDJ/BSMeJgZl2J0rmjVjFTNlzmN2sjDrXDo
 aQh0y3MhD2q+POZOan9z1wpOULa1wWBMcRFlxe5lw31Q3vQN/Kbd03kCsVtm+wSOBB+gBPime
 QcUIlg5C8zWa7xq27B8yblo1IxeyELlOY1qFcsxYXjXMj0S3tTBgkbQqOwePf68q3JzT8CgTB
 V23s/cR2cxqj2+0kWPdAS8z1QAC+QaCSraE+qgfcZhcFNmaO+q64uJz9leqsElSk00+d+OTPl
 /jH4ZvQ72yE3wXbiy/00HODsZstYJ8nSKKBE/L5w1LgyigB+LVTtADvpb0V2M6uo9ZiC9RnXV
 cbJlrALn0ZeKcDYTktpnDS6bXMEhf97+5ssERRwth4+q4lRFuCT1YmOxOel8ZGSe9YBQxI1t6
 yTyEcX8LOL/IftC+7HqJSlstROJ6Fczx47SpHSvBCBkFiura0BWbSp6XQ0kIyOyGcvrmrdlog
 klRUeguWnbILYfiEMIp1XkjfURMqchQZU5yATCfGl13u4g8qkXswJBH8LFxOonc1Ap64qgG5Z
 c8w/RhjiUPEV739gpAEezhdu9nsFEvQSj8VFME+K+onDgl4AeZNGTp70pHTvAmxgRRRwYzVfe
 /Y7T1gfHq6r5EVX/uXRd7Dla3PEiOon6C6fsuB4K/vvUNUsUIFivbu04x/0DRXreZk7uQkuG8
 l5hpo4bmmDSuHAhMcwEydQPyw5AD+AxaM9QF9XKN/z2iI+fOLRbVOFRqy7iFrGJRK+9TtfZAn
 BrvzB/YPAyfOKUisUotTiPLaGWBotl59fIgSPO9zmL9m7eigV23KZ9piejjpXArg9AeYskc2r
 RYEvwMPiQlzmbl1Z0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.20 um 19:08 schrieb Jeff King:
> Yeah, I've had various issues with the packaging. For a long time they
> had 1.0.7 in experimental, but with no python support. I wonder if it's
> worth starting to use python scriptlets in our coccinelle rules, as
> described in 4d168e742a (coccinelle: use <...> for function exclusion,
> 2018-08-28). They're faster and IMHO easier to understand.

The idea to use Python as a faster alternative to anything makes me
a bit uneasy.  That can't be right. ;-)

> Of course I tried it out and got some inscrutable errors:
>
>   SPATCH contrib/coccinelle/object_id.cocci
>   init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
>   Python path configuration:
>     PYTHONHOME =3D '/lib/x86_64-linux-gnu/..'

This looks bogus.  Can you try to unset this environment variable?
Or set it to "/usr"?

>     PYTHONPATH =3D '/usr/bin/../lib/coccinelle/python'
>     program name =3D 'python3'
>     isolated =3D 0
>     environment =3D 1
>     user site =3D 1
>     import site =3D 1
>     sys._base_executable =3D '/usr/bin/python3'
>     sys.base_prefix =3D '/lib/x86_64-linux-gnu/..'
>     sys.base_exec_prefix =3D '/lib/x86_64-linux-gnu/..'
>     sys.executable =3D '/usr/bin/python3'
>     sys.prefix =3D '/lib/x86_64-linux-gnu/..'
>     sys.exec_prefix =3D '/lib/x86_64-linux-gnu/..'
>     sys.path =3D [
>       '/usr/bin/../lib/coccinelle/python',
>       '/lib/x86_64-linux-gnu/../lib/python38.zip',
>       '/lib/x86_64-linux-gnu/../lib/python3.8',
>       '/lib/x86_64-linux-gnu/../lib/python3.8/lib-dynload',
>     ]
>   Fatal Python error: init_fs_encoding: failed to get the Python codec o=
f the filesystem encoding
>   Python runtime state: core initialized
>   ModuleNotFoundError: No module named 'encodings'

I got this instead:

=2D- snip --
init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
Py.find_library: unable to find the Python library [libpython3.8m.so retur=
ned Library not found] [/usr/bin/../lib/libpython3.8m.so returned Library =
not found] [libpython3.8.so returned Library not found] [/usr/bin/../lib/l=
ibpython3.8.so returned Library not found]
=2D- snap --

Then I did "sudo ln -s libpython3.8.so.1.0 libpython3.8.so" in
/usr/lib/x86_64-linux-gnu, and now it seems to be happy.

Ren=C3=A9
