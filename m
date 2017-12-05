Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3F020A40
	for <e@80x24.org>; Tue,  5 Dec 2017 12:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdLEM2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 07:28:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47032 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdLEM2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 07:28:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so932218wme.5
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sq2qGIK0dmDBohZYfcv8MNO971WJ/u8SFQM596Gt+YI=;
        b=m9kk54PoO3mt0gnU7QI9NSk9TG8YZFgGMVhSmjvk8eWU9Kmia+aXZnSwQClLjcuyoe
         DUQk7PxrYZ5jYjKQPIS8HTA9BkpG5mFXb7mkKR8lppMR3q8RTlj5C9LtVZXhYwcTiEh4
         gaYd53vlcXjIm5MzBapDG8EGvgPxlzDJrGgdlggfLl9dsGS4o9sr9fA67Vjwv3S3kTjY
         YosRHWcqpef3JCXwjLRuKgmEtCsZz1F/MxCyIt0Qv3xvlOcSTAiRa2EgvJnjNc87AkeI
         U4DBf3ZqVKFa8nitZHmcgXn8h7z0Y2igDUrCmKLtme4tdGQ6nWYR15s1FCzVGWxjrnr/
         MQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sq2qGIK0dmDBohZYfcv8MNO971WJ/u8SFQM596Gt+YI=;
        b=YTuKTwSxfRuEje5wHFTDvgYvuXeqVuiGJIyOeKuZles49mQWvhcV+FsAa/9iXqNMS5
         iVoHpgBll2zsCPX/53ktkDr1x86NOTeMsRguUpBy6s3ZTq8CI5g8WcRfXQBZogGWGRJ2
         JBN3WmPuDTjxeZ1+Oh3E9TjL+ELw1NllPpGfft2dtrgfEduTCzIs9Y4cZWxwCqdncg+x
         j+BrqJeWytQzQdBK1IVwzq9/qLZsIDP8FK/yBDTn9Q20BYM9Fd6qD8VQtnUYA+dIw4Hr
         oQtLByAb076oUirnjGc4LCTTp79VutfJbzgd1gqnHhv746nItWDMAR6XzcYqp3OEeaEP
         XBug==
X-Gm-Message-State: AKGB3mL6nKrLAnJWBVsxxusLG2hEk/se+o4a+4ErnH2cm6OvWP6uRQ5V
        Vp+Pn/ysqgI3TAxpip+H4GE=
X-Google-Smtp-Source: AGs4zMYPen86wMHkNBPgOvEimODATbwv972/r1lF0EWsHEwlpJp7WPc+Mi2J0BWZE2EXNUoHhwChlQ==
X-Received: by 10.80.153.210 with SMTP id n18mr3611337edb.281.1512476903487;
        Tue, 05 Dec 2017 04:28:23 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b2sm167768edd.26.2017.12.05.04.28.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Dec 2017 04:28:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] progress: drop delay-threshold code
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CACBZZX63ZhOHXmgerpJHc+ri_-w=QUyOQ7feWHxyDwPhN8hnDg@mail.gmail.com>
Date:   Tue, 5 Dec 2017 13:28:21 +0100
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        lars.schneider@autodesk.com, Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05818F78-7A4C-4ABE-B1C5-87D6991C98D8@gmail.com>
References: <20171204220228.GA29422@sigill.intra.peff.net> <20171204220700.GB18828@sigill.intra.peff.net> <BBE0F8C1-2B9E-42B6-AE47-90C8A62A4F84@gmail.com> <CACBZZX63ZhOHXmgerpJHc+ri_-w=QUyOQ7feWHxyDwPhN8hnDg@mail.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Dec 2017, at 12:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> On Tue, Dec 5, 2017 at 11:37 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 04 Dec 2017, at 23:07, Jeff King <peff@peff.net> wrote:
>>>=20
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>> Since 180a9f2268 (provide a facility for "delayed" progress
>>> reporting, 2007-04-20), the progress code has allowed
>>> callers to skip showing progress if they have reached a
>>> percentage-threshold of the total work before the delay
>>> period passes.
>>>=20
>>> But since 8aade107dd (progress: simplify "delayed" progress
>>> API, 2017-08-19), that parameter is not available to outside
>>> callers (we always passed zero after that commit, though
>>> that was corrected in the previous commit to "100%").
>>>=20
>>> Let's drop the threshold code, which never triggers in
>>> any meaningful way.
>>>=20
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>> I tweaked your patch slightly to clean up the now-simplified
>>> conditional.
>>=20
>> Your first patch ("progress: set default delay threshold to 100%, not =
0%")
>> as well as the modifications to this one look good to me. Feel free
>> to add my "Signed-off-by: Lars Schneider <larsxschneider@gmail.com>".
>>=20
>> Thanks,
>> Lars
>>=20
>>=20
>> PS: How do you generate the commit references "hash (first line, =
date)"?
>> Git log pretty print?
>=20
> $ git grep -A5 'Copy commit summary' Documentation/SubmittingPatches
> Documentation/SubmittingPatches:151:The "Copy commit summary" command
> of gitk can be used to obtain this
> Documentation/SubmittingPatches-152-format, or this invocation of `git =
show`:
> Documentation/SubmittingPatches-153-
> Documentation/SubmittingPatches-154-....
> Documentation/SubmittingPatches-155-    git show -s --date=3Dshort
> --pretty=3D'format:%h ("%s", %ad)' <commit>

Thanks :-)=
