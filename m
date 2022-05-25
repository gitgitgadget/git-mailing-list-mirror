Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86348C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 07:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiEYHN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiEYHN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 03:13:56 -0400
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E279F3D
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:04:08 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 24P746rY015107
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 May 2022 09:04:06 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 24P746rY015107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1653462246;
        bh=u7Q91263cnDN2jXGuVY3z2PxEdU/yFxz+r7rSYGvZyM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eCO0rRY2QMbvplRbq43C3XbOzjCnFQVBFC8fTfz3O9PrJ7rqU9oafSGq+Pz7WDojK
         SwceETv3Z8+QklrMHZ6NXh1WszEbQD17oN0v62gNOCQilt8qAVb0ml0iJ2xGnMjQbh
         tpp3wIkPy5a59he08sh9SDMPyhsyF1CA2MCEDFBuoJ86fisNc6fmA/f6qvXuxAdvwg
         R5aMsKS2J2L1Xx38QU23Am0PKaYWfyFAx/OPHkeEjJW3BQJwS2i9f7s8XjRZeDogoa
         EhN38XBooi0h2/o0ZsulKcS7v+ka3KCgnzhFYjfDG1AuWe/NDIEa8tTta+x86PRDne
         wH5SsmNN2HjKw==
Received: from corpappl17775.corp.saab.se (corpappl17775.corp.saab.se [10.12.196.82])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 24P7460W3136491
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 09:04:06 +0200
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17775.corp.saab.se (10.12.196.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 25 May 2022 09:03:51 +0200
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.026; Wed, 25 May 2022 09:03:51 +0200
From:   Olsson John <john.olsson@saabgroup.com>
To:     Kevin Daudt <me@ikke.info>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Error handling when giving empty command line
 arguments
Thread-Topic: [EXTERNAL] Re: Error handling when giving empty command line
 arguments
Thread-Index: Adhvbv33EYLm80KPScCjpHIHZomAfwAcfUuAAAjvWvA=
Date:   Wed, 25 May 2022 07:03:50 +0000
Message-ID: <8940ab846c1a4b8385a4def64a905bc3@saabgroup.com>
References: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
 <Yo2zfxP4hII+iwfb@alpha>
In-Reply-To: <Yo2zfxP4hII+iwfb@alpha>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.124]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-26914.006
x-tm-as-result: No-10--14.260300-5.000000
x-tmase-matchedrid: VfovoVrt/obK19rKCr/Ovgrcxrzwsv5uXPK9y3z82Gsli8Y5a0svL6YD
        xfmcVMRm9jB17ZyEjRpSVS5utHGcmoCoSWHZmQrD8eSmTJSmEv0ZskwWqoib3C5SnAtH4tjp3aC
        KrnFF0wt78BsGsXGHoY+Yc8GmOXzD9RYy+aTqMwXwgrvJFY9E0aTzJo0CZl8hFQeLCdFhgJrVvs
        ynKEaYxfw1tRrx5LTocg8WiKFz7npEmmhct6O0TUcvveJlm0fmBGvINcfHqhcwAYdq1VTXozKaj
        G44eqIMhns1b54F+qhftuJwrFEhTbew1twePJJB3QfwsVk0Ubv+efAnnZBiL8z+Ba7+nv3uJm/K
        g8WbE+UqgyDLSFqRiZM7zv28zJwOyE+dit6U4uR+3BndfXUhXQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--14.260300-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-26914.006
x-tm-snts-smtp: 9FCBD666FAAF1D29377D38BFC9813E8E4841C7F5649D5897D88B80B61F1F706C2002:B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You are running into this issue because you use "$(force}" instead of ${f=
orce}. In the latter case, if $force is empty, the shell will not pass an e=
mpty string as an argument to git.

Yes, I know. I'm so used to always expanding variables within double quotes=
 to avoid word splitting. And it doesn't help that I'm using shellcheck tog=
ether with flycheck in Emacs so it constantly nags me about the danger of e=
xpanding variables without using double quotes. ;)


> This does mean that it is subject to word splitting, but that can be an a=
dvantage as well if you decide you need more arguments than just '--force'.=
 You should only use that in case you control what $force contains.

Yes, I agree with you here.

-----Original Message-----
From: Kevin Daudt <me@ikke.info>=20
Sent: den 25 maj 2022 06:42
To: Olsson John <john.olsson@saabgroup.com>
Cc: git@vger.kernel.org
Subject: [EXTERNAL] Re: Error handling when giving empty command line argum=
ents

On Tue, May 24, 2022 at 01:25:43PM +0000, Olsson John wrote:
> I have so far only seen this behavior with 'git fetch' command, but it mi=
ght be more general depending on how command line parsing is implemented.
>=20
> In a Bash script I had something similar to (but more complicated than=20
> what I show below)
>=20
>   git fetch "${force}"
>=20
> where $force is either an empty string or '--force'. Due to that you=20
> usually want to expand all variables within double quotes when writing=20
> Bash scripts I did not realize that I had made a mistake here. Instead=20
> I got this strange error message and spent a couple of hours chasing=20
> it
>=20
>   fatal: no path specified; see 'git help pull' for valid url syntax
>=20
> This problem eventually turned out to be of the trivial kind once I reali=
zed why I got it, and also very simple to reproduce. Just do
>   $ git fetch ""
>   fatal: no path specified; see 'git help pull' for valid url syntax
>   $
>=20
> That is, 'git fetch' does not check if the given string is an empty strin=
g before writing the error message. The empty string is completely unrelate=
d to any path/URI and in this case it was not that helpful.
>=20
> What do you say? Wouldn't it be better with a more specific error message=
 when an option value/argument is an empty string? Or should perhaps empty =
strings be ignored by the git commands?
>=20
>=20
> /John
>=20

Hello John,

You are running into this issue because you use "$(force}" instead of ${for=
ce}. In the latter case, if $force is empty, the shell will not pass an emp=
ty string as an argument to git.

This does mean that it is subject to word splitting, but that can be an adv=
antage as well if you decide you need more arguments than just '--force'. Y=
ou should only use that in case you control what $force contains.

Hope this helps,
Kevin
