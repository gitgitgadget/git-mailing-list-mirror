Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C9C49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703E760E0B
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 12:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFTMzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 08:55:33 -0400
Received: from mout.web.de ([212.227.15.4]:60729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhFTMzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 08:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624193592;
        bh=bzhDM3l0tA/uUPBNhSOynPwupDF0RhIZd6044osa9sg=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=fSIMAW4GY91u5w2Ddz7Vtn72SSSqtc4mvpPDo5RtS0KKa+7xB1EA/pgTk0wCol+rh
         8Ed2sefBofsp4Haq1H9CHYlmGNiOa7UY7kvkwWsD4HqoT3GhAemMTAJ3EiCqWHhO0K
         7OoADfmFxA7UrpnQzhW/cCZwKQxFIG5ZleSiv+aU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MbTH3-1lJPLC3SDB-00bciX; Sun, 20 Jun 2021 14:53:11 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
 <20210618170550.GE6312@szeder.dev>
Message-ID: <648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de>
Date:   Sun, 20 Jun 2021 14:53:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618170550.GE6312@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ramh3j/mVWdvtRrpB2L/jgCvGl3s6/2qRgMPVTXR9oy8Xw0LodY
 3iLFps0BGBj8Hr9X1lM0a15LCQRfrFQgP4G75E25+soKLa/jP+EckNCd7YZYdLGmy+536Cm
 3M6LPuyQns0j2i3h+Dloqmmqn2Osgw5zppq+h4DVH3YGFJuQf2yLpVMHCi4Tm1DrZzWtapT
 39A8r8Bx9vOPrlBcl1O5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dk12KCD51qg=:NHAtwPJR2RlmZqcpW9fix9
 tgqONsAT0wF5YOiNGlBZmtQFFhNFT9teWdjqFr2WDOu6tDBrwneTMDEfb4VFbl41ctlo7A2Uy
 LxiydoK2P0IW1MkJ/IbJRo+KMV7cJEftg1/gUaGmsx7JxzeFG8GDfcqaUooBA9HChYhNbMcDV
 I9SZmBu/9elWsMStplh6mYPBcbUrMQN18lYc56Gc7yYTuV9uQ04eg3FnEg0lXm6ZHQEkOyI/j
 gX9ypHGPSpQgeJt3UDafW5mzBjUt/+5rTJuDemG5hCPJOVQHSo/65fYjeNPVyzFQ85gHsmtmV
 36h+Dm79wlEg0FXMkcnwgwxY09FMwpcTLHgE0WHyKl1T5JUjwHR0rSIDIZhynHeKG1MpD4P20
 6nQFgmlTurMyR2Me7FdSNmSMlHVp6AEmezKbdSrzaSLpy7iJ4AY5WE+qQs5/yqiqxbwZMLPOh
 MgkvXn+XiplLLvK/eSuYkRG03W9ykV3JeMUZLxn1CM1ptF/AnoPvUUnby0NIvJ1AzOkVEzt8H
 ddMDyLG31CNAndXVqZRHt4DxK/KJo5PechSi6MCnJ5T8Q4k4BlodMolsPyCPVR4ObnRHbVBEa
 HZ2WaO4aXt7FDztX2wb0YGHh2NDgv8TXVzxZygozZYq3Vjp5bieEE34gmjOSf+I3aqMmY6VNJ
 lsyfblWDrp4/8ldf48+wDWOrwujhXLZ+KodcJFZCywGL5+iSPSBruRw7MoN2cRhUkPay89zqb
 Z+uYQIa24nMPeO1NpFu29NrTcqeI2nujc50Cx7gcbagYT98RkLVMMd79o1nMh9miF0vPCkgRI
 ht8k3rjrknVMqZM2j3t7jNOz465+JPJxUig204psBJ+/a9rm8mZ/h0T2SqOgXcUt+7gsxQhfJ
 FaNVYiZhohMJ5CLTuvvKvqf70xqlKSdaBf4mFkdQJShATrFKD3yJ6yATNFlPiM5F7EhsEUrWR
 wnHBZblgIRfV6H+I6GYSXlHK0hUmnlo0iJyIUlBx2HbbCzgQrC+H2Q7ZrFNMFA0EnOT8YY0NC
 Q/wjETPdY3J/xpqYN0vpCbt320TLXRaWmV/ZW6tjie+bzGGEtRLv+PL/CYyhj9oxIZwydZzKr
 CKFsjwsIY4xfhTA8R+CZidUE0fMdTc7IGt+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.21 um 19:05 schrieb SZEDER G=C3=A1bor:
> On Thu, Jun 17, 2021 at 12:09:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
>> new file mode 100755
>> index 0000000000..5a3f7f849c
>> --- /dev/null
>> +++ b/generate-hooklist.sh
>> @@ -0,0 +1,24 @@
>> +#!/bin/sh
>> +
>> +echo "/* Automatically generated by generate-hooklist.sh */"
>> +
>> +print_hook_list () {
>> +	cat <<EOF
>> +static const char *hook_name_list[] =3D {
>> +EOF
>> +	perl -ne '
>
> Why Perl?
>
> At the moment I can run 'make' and get a functioning git even when
> Perl is not installed.  With this patch that wouldn't work anymore.
>
> Both 'generate-cmdlist.sh' and 'generate-configlist.sh' can process
> the documentation into a header file with a long list in it without
> resorting to Perl; I'm sure that hooks could be processed without Perl
> as well.
>
>> +		chomp;
>> +		@l[$.] =3D $_;
>> +		push @h =3D> $l[$. - 1] if /^~~~+$/s;
>> +		END {
>> +			print qq[\t"$_",\n] for sort @h;
>> +		}
>> +	' <Documentation/githooks.txt

How about something like this?

	sed -n '/^~~~~*$/ {x; p;}; x' Documentation/githooks.txt |
	sort |
	sed 's/^.*$/	"&",/'

sed is already used by generate-configlist.sh.

>> +	cat <<EOF
>> +	NULL,
>> +};
>> +EOF
>> +}
>> +
>> +echo
>> +print_hook_list

