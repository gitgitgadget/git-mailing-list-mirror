Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86E91F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfBVJqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:46:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38687 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfBVJqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:46:50 -0500
Received: by mail-io1-f68.google.com with SMTP id p18so1271249ioh.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FhCILuFoa1sZYpDECAO/FTHwmse9u5AFxgTreZ+F3gU=;
        b=nfkM/IvZ0ld0IQkCLaxgI3n7a6Yj9kwtF3XRIcx7dve5i5+icHN9V5D4aEmOty0uR3
         XnvlZVeRhtZk/Ftgl0XFqJzj4pWgnAaw2f3nLOC4x9/rLUrKLK4pg7mAd9i/teo3D2kM
         2fL++UrFilso1AEhqcz69UvfcEcURFET0V/cyS2cIHGnFndPMuM8j7Zmu4S/ZUkPqFtI
         NYV7ogHpIXNZ52vsNr9XzubN5mfdyyfVZKQrKdwbfPIS+R9e0fxq51aFe2C/cbBJfoqR
         PeBxRRTKLUteyoRJZFP3FeGN3hnIUFqu4j3BA5MOlQGmVHHb5yCIB078D9gQ0lFWZjmj
         pahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FhCILuFoa1sZYpDECAO/FTHwmse9u5AFxgTreZ+F3gU=;
        b=An4oikLQgdOCBj9UvRo+rtXfzj1g2Ym5ieTYdCcFML4XJQ/4i7xtmE+00VfRVpviWC
         BD/m9LNUJYy24QYFIEFI1IEsiy/yw88fUTJtuFqaqiL/+5hPcs2ip3wr2A+1hzJtaSGg
         0hCpUSt/+Sa+Y7njKJOWP3xZQy8v/UBtZ+BXdv3vwgmpu62zAD5zmumjTjh04Nyoxr0q
         pnKFGQB/pp0bvr8x7pKUgml/gCXRAbxUx8Nw+peH4cM7Go+Tih3WPbrYdy7T+YWUORIf
         FD6VHmVfi4t+/6vGYHQPjanqbKWuxnGjdq/7BDB62HrXSzicFaIqVUOS6RCmMYAcNiLa
         VzYA==
X-Gm-Message-State: AHQUAuakvm/hOdXLlFLVVGH81hxwJB7cohORDQMjgpMg5BROJPT95v9G
        +g5auC/ceLoow/0H+8CTz2CWiBhRscnH7xJvPS0=
X-Google-Smtp-Source: AHgI3IbCpXWpY2pgzOmrIvkA+vTFZqmlnW2pQc2JRN2cVxKGY2KZv7Hi10HjnAPEOLwAPnnkrwoIo5JC+J08/WzImpQ=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr1812016ioj.118.1550828809640;
 Fri, 22 Feb 2019 01:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com> <87h8cy6cme.fsf@evledraar.booking.com>
 <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com> <B168DCB1-7A69-4729-89C7-B513464DD468@gmx.net>
In-Reply-To: <B168DCB1-7A69-4729-89C7-B513464DD468@gmx.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:46:23 +0700
Message-ID: <CACsJy8C377NmLv9edNYjinKAQf-P1y5+Nwhdj3vRkz_E__x43Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 6:11 PM Clemens Buchacher <drizzd@gmx.net> wrote:
> >And requiring to mark trashable files manually duplicates a
> >lot of ignore patterns. Have a look at any .gitignore file, the
> >majority of them is for discardable files because "ignored" class was
> >created with those in mind (*.o and friends). So now you would need to
> >add more or less the same set of ignore rules in .gitattributes to
> >mark them trashable, and gitignore/gitattributes rules are not exactly
> >compatible, you can't just blindly copy them over. Every time you add
> >one more .gitignore rule, there's a good chance you need to add a
> >similar rule for trashable attribute.
>
> I agree that ignored precious files are typically a small subset of the i=
gnore files. Maintaining separate rules for ignored files and for trashable=
 files would result in a lot of duplication.
>
> On the other hand, how frequently do we really have to trash ignored file=
s? Trashing a file should only be necessary if a tracked file overwrites an=
 ignored file. When does this happen? I don't think it will happen for *.o =
files. So in most cases, there is simply no need to specify which files are=
 precious. The default could simply be that all files are precious.
>
> To support more complex use cases, we could specify precious files in add=
ition to ignored files. Only if we specify precious files (and/or enable th=
e ignored-are-trashable config option on a repository level), all other fil=
es become trashable.
>
> Functionally this is equivalent the newbie option which you suggest, but =
I think it is not an issue of newbie vs experienced users but an issue of c=
ommon vs special use cases.

So far the two conflicting cases are "git checkout/merge" and "git
clean". Ignored files are valuable by default in the former, while
it's expendable by default in the latter.

So if you add this ignored-are-trashable config key (defaults to
false), git-clean -if will not do anything anymore. We _could_ advice
the user to turn the config on (with all the consequences). I don't
know if we have any other use cases that deserve the same advice.

Another option is simply leave the expendable/precious nature of
ignored files undefined like it is now and handle case by case:

 - git-clean learns to use a new attribute "clean". Undefined
attribute is seen as +clean. To keep some files "precious" you update
.gitattributes and add -clean rules.
 - git merge/checkout learns another attribute,
checkout-overwrite-ignore? Undefined attribute is seen as
-checkout-overwrite-ignore (i.e. abort the operation).

We stay away from any generic attribute name in this direction to make
clear it's only applicable to specific use cases.
--=20
Duy
