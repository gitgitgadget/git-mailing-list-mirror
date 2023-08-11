Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C1C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbjHKVqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHKVqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:46:37 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF0271B
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:46:37 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37BLiLhK884544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 21:44:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Mun Johl'" <Mun.Johl@wdc.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>        <034501d9cc91$069bd360$13d37a20$@nexbridge.com> <xmqqr0o9qpon.fsf@gitster.g> <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com> <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
In-Reply-To: <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source code
Date:   Fri, 11 Aug 2023 17:46:28 -0400
Organization: Nexbridge Inc.
Message-ID: <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYfaIzxiLvNNliA6NGPhsdV5ubsQMKIH4jAmvty4sCHttM2gLYUX00sBTVNNA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 11, 2023 5:15 PM, Mon Johl wrote:
>> On Friday, August 11, 2023 4:39 PM, Junio C Hamano wrote:
>> >Subject: Re: "fatal: Not a git repository" issued during 'make' from
>> >source
>> code
>> >
>> ><rsbecker@nexbridge.com> writes:
>> >
>> >> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
>> >>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When
>> >>>I run
>> >> 'make
>> >>>prefix=/usr/local all doc', I get the following error:
>> >>>
>> >>>fatal: Not a git repository (or any parent up to mount point
>> >>>/tools)
>> >>>
>> >>>Which I infer means that I need to do the build within a git repo.
>> >>>Is
>> that
>> >> correct?  Or
>> >>>have I missed some basic step in the build process?
>> >>
>> >> Yes, you must be in the cloned git repository in order to run the
build.
>> >
>> >Shouldn't we be able to build out of a tarball?
>>
>> I don't get the impression he started with a tarball, so subsequently
>> sent the doc ref for that. Using just "make" is not sufficient from a
>> tarball.[Mun]
>
>[Mun] Thank you both for the information you have provided!  It turns out I
did in fact
>start from the tar-ball "git-2.41.0.tar.xz" which I downloaded from
>https://mirrors.edge.kernel.org/pub/software/scm/git/ .  And then I ran the
'make'
>command.  The process went something like this (basically identical to what
Junio
>documented):
>
>$ tar xf git-2.41.0.tar.xz
>$ cd git-2.41.0
>$ make prefix=/usr/local all doc
>
>And with the above 'make' command I got the fatal error.
>
>I consulted the Getting-Started-Installing-Git web page that rsbecker
referenced, and
>it basically matches the above--except it uses the 'make configure'
process.  So I tried
>that method as well, but when I got to the 'make all doc info' step, I
again got the
>same fatal error.
>
>Due to some "security precautions", I am unable to use 'git clone
>https://git.kernel.org/pub/scm/git/git.git' to download the source code.
But I can try
>to figure out a workaround for that if that is my only option at this point
to
>successfully compile git.

Did you run 'make configure' before using 'make prefix=/usr/local all doc' ?

