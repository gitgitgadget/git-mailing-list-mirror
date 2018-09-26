Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA10D1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeI0DRA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:17:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35944 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeI0DRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:17:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id y13-v6so3789023wmi.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=SzO9abj+wG8ZnkT73kwiVP1SGa/zem8EIjqWzf0hfNA=;
        b=hBEQL2NlSRaUawzyqg4VhXnhBNRRaOyPrIJRlDg6d4N2TL7qR9lruKR5fTlPuGdDL8
         AIcCRfEaBMYfyvgw76KHXW1JbIUK2qG+iek6GX33EjW41cvX/w+ruERE2Qu8rNcI62r7
         jI7+h0NxerK/m/YkGBYrfPcOQnHOAHQ8isacinQztagB8JiWVroQfa0PpQRG0Q0zStRv
         OmSv5CH/mi/MLF4Q0DB+tH6mKq1gqrglxbzbfADskjJr6oz+C5UESqA1mvvDxCmSyw2D
         mTjdZH8R6HyAux5rB/eWcYGc3U873lHB7MSI8NZC3RAX0mwoqca0FZGt4p9ig2SbPPvk
         H8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=SzO9abj+wG8ZnkT73kwiVP1SGa/zem8EIjqWzf0hfNA=;
        b=Wr3M0d1JSGH1kX0niPQGGgrjgiGvwO/GGiRp4HvXkC9C3UQiNkxRXdmeSw6WKg57Kw
         m/3OZYbI018K6AfoyoJFX8R1L8jfTQ0BpfXsKYHeH4x8EAXG0ZUdD67XlkLzr2+nCWfr
         793tVrJXVU+DBb5/NYqqg3dkDebWLHcXYEsIOJ+lTIsl47BkV5Px7gsD1o6ccnxHbayq
         1wfwx52pAxc5UZpoN6uGNmMmWOjOfnY2CndDoghqamY2xfW8t6AofD+INNGHzgZHH6sq
         Ygd5UkXpJd98N5prMeDoHdERkZdmD3UX2QJYYR+DABtcu3FLgCdRbRl5VSgjc0aQrfhy
         kpAw==
X-Gm-Message-State: ABuFfoh4ruqRH2CEhKX9tBMuqYWBYg0x4Pw45q00HUyJAiYIFAlFwHoG
        J34+dhUONfN8/vnFPGJo9zz7K3bV
X-Google-Smtp-Source: ACcGV62RLlsT+Knr03u/ou/ezzp2EVgHPG69oABDR/rvmIGAJSO/BfZ3n1BLwap7DXGGWba9nFwKAQ==
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr5388803wmd.17.1537995728930;
        Wed, 26 Sep 2018 14:02:08 -0700 (PDT)
Received: from [192.168.1.103] (93-35-203-71.ip56.fastwebnet.it. [93.35.203.71])
        by smtp.gmail.com with ESMTPSA id x65-v6sm281743wmg.39.2018.09.26.14.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 14:02:08 -0700 (PDT)
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same
 target? how?"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <3c11c193-a978-69be-4b8e-4b59b270338e@gmail.com>
 <877ej8j7uf.fsf@evledraar.gmail.com>
From:   Andrea Stacchiotti <andreastacchiotti@gmail.com>
Message-ID: <d2a8619b-5110-0a03-5559-fd84cb7509b6@gmail.com>
Date:   Wed, 26 Sep 2018 23:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <877ej8j7uf.fsf@evledraar.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------C2E8328A8C9F946720EB9D54"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------C2E8328A8C9F946720EB9D54
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

I'm very sorry, I indeed forgot the `diff.renames=3Dcopies`.

The following script can reproduce the bug even with a blank config:

---------------------

# Make a test repo
git init testrepo
cd testrepo
git config user.name A
git config user.email B
git config diff.renames copies

# Add a file called orig
echo 'a' > orig
git add orig
git commit -m'orig'

# Copy orig in new and modify orig
cp orig new
echo 'b' > orig

# add -N and then commit trigger the bug
git add -N new
git commit

# Cleanup
cd ..
rm -rf testrepo

Il 26/09/18 22:56, =C6var Arnfj=F6r=F0 Bjarmason ha scritto:
>=20
> On Wed, Sep 26 2018, Andrea Stacchiotti wrote:
>=20
>> Dear maintainer(s),
>>
>> the following script, when executed with git 2.19 triggers the bug in
>> the subject line.
>> The problem seems to be the interaction between add -N and rename dete=
ction.
>>
>> The git binary used is the one currently packaged in Debian unstable.
>>
>> I have searched the list for the bug text and have found nothing,
>> apologies if the bug is already known.
>>
>> System information, script content and script output follow.
>>
>> Andrea Stacchiotti
>>
>> --------------------------
>>
>> andreas@trelitri:/tmp$ uname -a
>> Linux trelitri 4.17.0-3-amd64 #1 SMP Debian 4.17.17-1 (2018-08-18)
>> x86_64 GNU/Linux
>> andreas@trelitri:/tmp$ git --version
>> git version 2.19.0
>>
>> andreas@trelitri:/tmp$ cat bugscript.sh
>> # Make a test repo
>> git init testrepo
>> cd testrepo
>> git config user.name A
>> git config user.email B
>>
>> # Add a file called orig
>> echo 'a' > orig
>> git add orig
>> git commit -m'orig'
>>
>> # Copy orig in new and modify orig
>> cp orig new
>> echo 'b' > orig
>>
>> # add -N and then commit trigger the bug
>> git add -N new
>> git commit
>>
>> # Cleanup
>> cd ..
>> rm -rf testrepo
>>
>> andreas@trelitri:/tmp$ LANG=3DC ./bugscript.sh
>> Initialized empty Git repository in /tmp/testrepo/.git/
>> [master (root-commit) 5dedf30] orig
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  create mode 100644 orig
>> BUG: wt-status.c:476: multiple renames on the same target? how?
>> ./bugscript.sh: line 18: 22762 Aborted                 git commit
>=20
> I can't reproduce this on Debian AMD64 either 2.19.0 in unstable, or
> 2.19.0.605.g01d371f741 in experimental. I tried moving my ~/.gitconfig
> out of the way, do you have some config options there that might be
> contributing to this?
>=20

--------------C2E8328A8C9F946720EB9D54
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
s/96ylDZzy/L0Dc=3D
=3DZQCb
-----END PGP PUBLIC KEY BLOCK-----

--------------C2E8328A8C9F946720EB9D54--
