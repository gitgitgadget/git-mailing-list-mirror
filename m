Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988DE1FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbdJIBa7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 21:30:59 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:52252 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbdJIBa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 21:30:58 -0400
Received: by mail-ua0-f181.google.com with SMTP id i35so11245206uah.9
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=o7O6Nm5GYjoZNarZ1ZF22xfTeJMRE/y6SUE40FzhNIw=;
        b=MPLYfT4+4Id5PdseFdmqZvzsNAeZrM3MXySBafnyw3yD08Jbc/zAJzUYqb8AHBZvDa
         u19n14mmv9DSsTXXcmVq/UScqeIkkDy0CvQNMrHJsHw0WVCa5/3JaxroR3tsxpiyBt7A
         KLeQsw5DYy9vzpc0ihoNwnvBBHUj3WThwZw2YrzHthwNb7SOMlG6Pb5KmOfh/S68qB7u
         dvvJhqqo7BcfHl4KyurB/c8iWG5BDl1g8Gdp3ZNUgEELZWudA9EJmBm//XYm9VxxQM/I
         1lICG3oA0G4Gpf5KmTcK/uhq/5nWb7OWvB/bKftxC9Iu/HPwCITH5YDk1G2bNDwnzL3I
         kwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=o7O6Nm5GYjoZNarZ1ZF22xfTeJMRE/y6SUE40FzhNIw=;
        b=Dw3ZIDrXNf01tMU6zrZeXC8Jcsbl5TWlTrsl2nEdDfIRvae9twd/BedLlkUca2+ZLX
         gZw51GEoY1DuRlFUuc5Jf5UB/K/O1kJt2wMPR3lw456ZMXVikWbMDT0m3L/2hvFKKS5m
         N1aDVPcs9xfNC3I9S2f0CvZz0aSDG7hcdDrJ/is9/An8zXYz07uZXE4wue4UVgN0k+Xc
         kHFNlVD6VbyO5QLsR2AUbTsd9GlMge5x052NIEl21TyljbbyA+zuD05jjvo86LSsv8SN
         P3vn4BVsC3NJek63YMzB5O9MkQjCnscUSz4o9CJCpOTXb/4mQBDQmfybyyUEmK1AoiVR
         kgzA==
X-Gm-Message-State: AMCzsaVyy6Aod1HZjzsDue6UqheYjn2tCK49lW3i4JfUvt3E5QfxBrPk
        2kpNsg7shKn1sjvaI8yIeoojzm3tIdpSQvNlv2k=
X-Google-Smtp-Source: AOwi7QCrvppPtnzhsL82CFqWzTsG+vb0lruMjdjz+PfkcArMU3IYhY8abEcJSuUYSdeWb1NE3kZK9TdW1WuSVWwbsXo=
X-Received: by 10.176.6.195 with SMTP id g61mr5050286uag.161.1507512657512;
 Sun, 08 Oct 2017 18:30:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.124.141 with HTTP; Sun, 8 Oct 2017 18:30:37 -0700 (PDT)
In-Reply-To: <20171009005137.4qwvkpedjslvbkca@genre.crustytoothpaste.net>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <20171008084824.5331-1-martin.agren@gmail.com> <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
 <20171009005137.4qwvkpedjslvbkca@genre.crustytoothpaste.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 9 Oct 2017 10:30:37 +0900
X-Google-Sender-Auth: 4dhmwtOljYVMRwXSHc7Wf85Av0U
Message-ID: <CAPc5daVk+sPLmw4G_AghOVFeO5myKTADQjKr823U3xaQZK+43g@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2017 at 9:51 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Oct 08, 2017 at 10:32:35AM +0100, Philip Oakley wrote:
>> From: "Martin =C3=85gren" <martin.agren@gmail.com>
>> > - die(_("submodule entry '%s' (%s) is a %s, not a commit"),
>> > -     cb->path, oid_to_hex(oid), typename(type));
>> > + die(_("submodule entry '%s' (%s) is not a commit"),
>> > +     cb->path, oid_to_hex(oid));
>> Bikeshed,
>> maybe:
>> "submodule entry '%s' (%s) is not a commit. It is a %s"
>> This puts the two parts in separate sentences?
>
> Languages with multiple grammatical genders are going to have problems
> with this.  In French, "a tree" is "un arbre" (masculine), but "a tag"
> is "une =C3=A9tiquette" (feminine).  We don't currently have a Spanish
> translation, but this would break there as well.
>
> Splitting the article out with the type name is still problematic for
> languages where articles vary by case, like German, since the
> translation might be reused in another place requiring a different case.

While all of the above is correct, would we really need to subject typename=
()
to translation? IOW, can't we just treat 'blob', 'tree', 'commit' and
'tag' as-is,
as terms of art (i.e. with a specific or precise meaning within a
given discipline
or field and might have a different meaning in common usage)?
