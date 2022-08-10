Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B8C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiHJRgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiHJRgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:36:04 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D806110D
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660152956;
        bh=uDQBGP+V326WM2+7iA+JhdahqhafiWop9S2+hruz4zs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lmIxnx3EwtuneQxHq9QFwDLjvTORMrFfDMQ0h4jf6YM/85pMF7l26Ebe8sfmWdOFG
         H1Px3+dDjZ1LDWou0HSEzfrnBAYU1u+GgcdHA2JLPRwzXOAE3ZH/uE4OLPTB+PhEbA
         EmFZxqnnFP5HGeC6PE7c2iUpxOvRWf+erMSvPoks=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1ngfy52HAD-00lW7j; Wed, 10
 Aug 2022 19:35:56 +0200
Date:   Wed, 10 Aug 2022 19:35:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Alexander Meshcheryakov <alexander.s.m@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
Message-ID: <20220810173554.sl3bxtosnszygs5f@tb-raspi4>
References: <20220809182045.568598-1-calvinwan@google.com>
 <xmqqsfm4prqk.fsf@gitster.g>
 <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
 <xmqqiln0p01z.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqiln0p01z.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Lkvrnnw7tmlNQitn+cUb2ynlkhdV4duySefD6lHle4+EqUbL7x0
 2YWhtg1IDJBl2HyAoiUg2BOw96qjbg5dWLLyHSO28wdwMFqnzsJ1TpBe70ZNWDvrMGrfdTK
 UZZWIXv/U5qynyo6QYUFyZ3WwPanaQeY9Yqs9IfokCuMCI1UeLlgMNVNZ58EkWHdJ2yWuaF
 5zJTveBK2JVo+f2uweNIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMLiEC8OSs0=:YJNrZjpLrfd8rhYxPr3TdL
 BYTuLfExLd6kFqsyM7DcublNisqPjzLPOytyym85R06787rRY5w/NqAxPbVGO+a3PLyZ8iPfd
 //Vclnaur92kotpMryHHW7rZbSGWaVnxxF+YsY54NlygbalewWc95J0njIQAQkdbkb+dL5llO
 e33yvQSVvbi94JELZZSAI+OJjJK76N3BWQj1DkKkFxtGgAxWb/xJAoEu564bx1N6z33ZM1dXH
 2JB2epx+orpXOhVvFcTEHgtxmU+woE2qk7UWhKjZ64wKnhPjvZUCZLzZsc66ujz68/P3lYn9v
 NC91gdxiS1b/WiljH+jPJhIjceKvEPCTC09/7PxG5Rq/k6fDgzkJiCDFvGiswiTuBLLCsCeMC
 2v6VT3J6aJYkn8U8J12cH1wJruT8pyoxfeVAYWzUeFiAaJnrMwQyPaCYUyV/3+EkpC8E/m8Vw
 Hd3WV+7ab/CUuy7/Pp0pnw8VnYd/QaLnSvJk9zh6P+iVZrMZp5tiX3lTiQIsLMkbjMC+RDY71
 gO/6BkkTkzl8XaslsvPs+DHUJwdiVxXUYaaJVKmxHMezkz4Po8wcFdSSYambroSc3PBPDW9NV
 SgKJUL2PEi2H8tQ5wgOb/rqdifLK916YnrOnCArGIWUvr667jI36anclkRYBN/cou2pEOoOAb
 tNYKmxsTaJvIM2ED9JG79XOs1ta0PPXITreQhwyx2f5LBVws5VG+iDprsuPW0tNsHCz5o6yZA
 dN0I3q0OZRtTAk4rJzFrxoMtNIjzj1QhTGxXreFSBJu585Vir6Q1YxKQK5hSt2ApMwUNkKtC9
 XspzCtE3C9xa/tfL87wmJQPF0YAIPov364rQiF2X0uX4ntoLjZCjMQSsHNvTQfat4D9H4TSyf
 6iSDV+2zADusan/2LIeRV00BUmXHO56eO9ESwcGSUR2SLNjSXHwQJ20V0Ilw9zkY6bfqqHFXw
 kyJ2I2rouN6Y94MPoju2gB3bo6EDOmPpxQ8qap8d5xOvQ3Wc9nSW2Hpja6GhBN2cW386nn6Jl
 Gb1juj0pYh507Z2NLZ4P1YBO+0AzGtrzftu3ZqpX3MJmZ/lwkqvZvcYiSen3d5Y36S5uXYtIn
 2On5O5i5TEmbWaEwhr9dKAtJbh4Cc4pfNWjtCmeETKheB2fYy6Hij0n0g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 08:53:28AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> >  git log --stat
> > [snip]
> >  Arger.txt  | 1 +
> >  =C4rger.txt | 1 +
> >    2 files changed, 2 insertions(+)
> >
> > From this very first experiment I would suspect that we use
> > strlen() somewhere rather then utf8.c::git_gcwidth()
>
> Yeah, that does sound like the case, and quite honestly, knowing
> that the diffstat code is way older than unicode-width code, which
> was added by you in mid 2014, I am not all that surprised if we used
> to use strlen() throughout and we still do by mistake.
>
> Thanks for a doze of sanity.

Some 2 updates here:
- The strlen() needs a replacement.
  It looks as if the following patch helps:

/* somewhere in diff.c */
static size_t screen_utf8_width(const char *start)
{
       const char *cp =3D start;
       size_t remain =3D strlen(start);
       size_t width =3D 0;

       while (remain) {
               int n =3D utf8_width(&cp, &remain);
               if (n < 0)
                       return strlen(start); /* not UTF-8 ? Use strlen() *=
/
               width +=3D n;
       }
       return width;
}

@@ -2620,7 +2635,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
                        continue;
			                }
					                fill_print_name(file);
							-               len =3D strlen(file->print_name);
							+               len =3D screen_utf8_width(file->print_name);
							                if (max_len < len)
									                        max_len =3D len;

@@ -2743,7 +2758,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
                 * "scale" the filename
		                  */
				                  len =3D name_width;
						  -               name_len =3D strlen(name);
						  +               name_len =3D screen_utf8_width(name);
						                  if (name_width < name_len) {


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Let's see if I can make a proper patch out of it.

The second problem, and I hoped it wasn't, seems to be related to what
you had digged out earlier.

>Sounds like a symptom observable when the width computed by
>utf8.c::git_gcwidth(), using the width table imported from
>unicode.org, and the width the terminal thinks each of the displayed
>character has, do not match (e.g. seen when ambiguous characters are
>involved, https://unicode.org/reports/tr11/#Ambiguous).

That needs a second patch, probably after some more digging,
how unicode is rendedered on the different systems
