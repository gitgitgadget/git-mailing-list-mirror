Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CFC433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D138861264
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 18:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDXSD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 14:03:57 -0400
Received: from marcos.anarc.at ([206.248.172.91]:59914 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhDXSD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 14:03:56 -0400
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id E5D6C10E23C; Sat, 24 Apr 2021 14:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1619287397;
        bh=XemDzbdZJBEvNc77k/w2DCYscirI90i/j6lIQ7eDmvs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=slxDPLzdkocc6D6VngOqkNvbXMvwJvbsJMKT05ezVu9u4h8QIhWKgzzxHlGyDbTuk
         pi4xffDtPEZua+luKj8wJ+tvkudshXox4soWodch2qNlbnQmf46/mq7D/LdxOsD+TC
         QsWXHdowuWkzSmwhvhAD6qCwIfHTIwV6hGB3LGB0/9MCqVHSt9u2syhqrQc8ch4qn1
         q+hEH+B4BY02Iot8xo+1wU4q+PvCXASs0gR7S8Cm4MveOuRESNMhbNALee+vvVq4ND
         O/TLOasBQCEJguMXwkPSXVCX4ryp37lKgS4F10Z/PVFuxEqnTYwDGngccD+m/mNzti
         sRLIgA2u2UJJA==
Received: by angela.anarc.at (Postfix, from userid 1000)
        id 9ACB6AC08C; Sat, 24 Apr 2021 14:03:17 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: how to rename remote branches, the long way
In-Reply-To: <YIRXem9ApAsqgl6D@camp.crustytoothpaste.net>
Organization: Debian
References: <87mttofs5t.fsf@angela.anarc.at> <YIRXem9ApAsqgl6D@camp.crustytoothpaste.net>
Date:   Sat, 24 Apr 2021 14:03:17 -0400
Message-ID: <8735vfa7bu.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-24 17:38:02, brian m. carlson wrote:
> On 2021-04-24 at 00:22:06, Antoine Beaupr=C3=A9 wrote:

[...]

>> Or, maybe, should this script be sent as a [PATCH] instead and just be
>> merged into git itself? Maybe in contrib/? I do see some Python in
>> there, so I don't feel too much like an heretic... Obviously, it could
>> be rewritten in C, but it would feel such a pain in the back to me... I
>> already rewrote it from this shell script, which is still available
>> here:
>
> In general, Git tries to remain neutral on forges and therefore we're
> probably not super likely to adopt tooling that's specific to a set of
> forges.  I do, of course, think this script has utility and serves a
> particular need for users, even though it's not likely that Git will
> host it itself.

Thanks. I have patched the script to avoid requiring the gitlab library
to run, with that in mind. Of course, there's some forge-specific code
in there, but if it's not available, it should work transparently, with
a "plain" SSH remote...

But I understand your perspective, thanks for the feedback.

a.
--=20
La d=C3=A9mocratie r=C3=A9elle se d=C3=A9finit d'abord et avant tout par la
participation massive des citoyens =C3=A0 la gestion des affaires de la cit=
=C3=A9.
Elle est directe et participative. Elle trouve son expression la plus
authentique dans l'assembl=C3=A9e populaire et le dialogue permanent sur
l'organisation de la vie en commun.  - De la servitude moderne
