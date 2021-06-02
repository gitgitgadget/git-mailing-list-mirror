Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE17C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE37613E6
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 19:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFBTPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:15:42 -0400
Received: from mout.web.de ([212.227.15.3]:59147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBTPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 15:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622661226;
        bh=iEGbciPEBiNVEWuAo2TjMoqiW3udDN1ndI7OUrlGey4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UdwDHH7sNXekOvAR5f94YlKPwnyc/ybA4T11cuAgh5Wy/x++Rz+YfaAIxsnbqyBq0
         YFmQxBe9osTivCv6Ic2v1r5C717URLqy8CieLDS1sw2v19kKlQI+9UNY3w0nAkvGo7
         IvjNzJ9/QCrySCUpWNFDd4ZeZJFI7pgglORiowAc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPowc-1ljYV61Fac-0051ql; Wed, 02
 Jun 2021 21:13:46 +0200
Date:   Wed, 2 Jun 2021 21:13:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: UTF-BOM was: [PATCH] t2080: fix cp invocation...
Message-ID: <20210602191344.assal4vuajln2sbz@tb-raspi4>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
 <87pmx47cs9.fsf@evledraar.gmail.com>
 <YLdqDn9vCBc7sPDN@danh.dev>
 <87mts875d3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87mts875d3.fsf@evledraar.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:YmOeN0uQdRNGtCy4sGL7BjO2ATQ3WYZ1vevBGR1TuuSeDehne5X
 5m1OIt+lwWdLahWsSFoOdnLZ9VNbjP/XZDUG+o/Amgik1qX3hy7P3UDoL6iOXy3dKWG2j2t
 W3cK6RWez+iRWosjyNXzQddqqjxFPH9eiFikMwTomDrxqL5RdKyJzEb054SWpV+9j8QjbU7
 0JURmcs6MvAsdLU1x+Qeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mU7DVkLJZGU=:2b3BP5rEpqs5vuNVwh9G9E
 TjzrgenJUFp7zOZX5cCEuLviYCtCmzX1JQJEPlwCztHsQbf1OcX79Qlxh0g8mEFJ1QLpN5u9e
 rLJnid5bbcCS9s/0pTqnn/bSC4u1iMt0WfuhirFsS5XgFNmHUM3ZMDmBM87B9bYTQJ8SdfUyd
 XVhYfd0U/ampnO4SbnjegBjLYt0QcU8bR70NpriCdFzgze7RACGwKR5BGJH1VjV1ADHEfIWGm
 50JSZ5+7wGumnnq5dQQeoKAghcKIvqYcjuhqwtaZVgQ02v+r7vnoDsI6u2USqxmTvL7FN03Dm
 NrJJdb4M3tz2kZnD4u+6MyuzPjerDS0gnieIqpIwvLqDwH9FFhTccu5NV9sdFaWz/zwdoemUT
 pkPRNsGOfAf7FFfHZXxj0L3leAmA9WQ2CNQ/SZTmK3zfIgJydckp44aWUXqFN2ojh59TuDFNv
 iXKGuFmT7beZZ1/9WgUk85vpEgxUcpP4Sc9Q6YlXeCiS6agaFvMV6lgn01rg5xvFex549byuq
 YgHi4hBZZDf1kdwpOGezrrSdti80dG1LaBzo1gmY2cpxAZPF8XCzPbYj1CM9gHTgxH33ZM7OA
 ngbZK5/HfAetnbrXzseV4rjYYjv8PZ4lYpKJQiVkU8/vMPxnfKLt0jGSJiM9JQfXk1MyucukP
 3hZy/rWIU+5m3F1EpON2LE8oaiKPO7d/CNwqGegFKyTchBSNb0WHt53HVeEwB57D2EGp2RQs3
 QCsOA0J8x9JYZg7Bg67u7rdcDk5yJ6AVlLCfk/se2GUbOdrPwYPrdH/3WiQYNAZhdtf2cV0NX
 f9aO6o3qWC4OMNcv2NmsXRpY1biLS9mS2EZx7c7dQ2+gSsm/VRzft7lazxVw7Oa5cg/OZjAMG
 T45L81Gx7q1B34uPNZJH8dtUM1tP5a3xXHLTcolRS3OFCyB0GI/ysaf5OBFotBjLUHKb12g1q
 6UxgPcujsU8x//OLLbW6RjGyIzPra69UzOEZyhHeYqLOXBOeb/0mKZfQkneHZfZyCOEYaLAdw
 9ZkZXDpMEvOiK3LjWRv3iCCNl1aDJmM5b9acjriz40RRfaIzvgovLlo250nl61jcMC8z7hvYn
 fLf6mDvFZGjNCirinRU7SeAmhepr6K9Wue9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 03:36:57PM +0200, =C6var Arnfj=F6r=F0 Bjarmason wr=
ote:

> >> >> There's still a failure[1] in t2082-parallel-checkout-attributes.s=
h
> >> >> though, which is new in 2.32.0-rc*. The difference is in an unexpe=
cted
> >> >> BOM:
> >> >>
> >> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"'=
 trash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal
> >> >>     efbbbf74657874
> >> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"'=
 trash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text
> >> >>     74657874
> >> >>
> >> >> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.s=
h also
> >> >> fails similarly[2], so perhaps it's some old/iconv/whatever issue =
not
> >> >> per-se related to any change of yours.
> >> >
> >> > The 0xefbbbf looks interesting, it's BOM for utf-8.
> >> >
> >> >> I tried compiling with both NO_ICONV=3DY and ICONV_OMITS_BOM=3DY, =
both have
> >> >> the same failure.
> >> >
> >> > I didn't check the code-path for NO_ICONV=3DY but ICONV_OMITS_BOM=
=3DY only
> >> > affects output of converting *to* utf-16 and utf-32.
> >> >
> >> > So, I think AIX iconv implementation automatically add BOM to utf-8=
?
> >> >
> >> > Perhap we need to call skip_utf8_bom somewhere?
> >>
> >> I debugged this a bit more, it's probably *also* an issue in our use =
of
> >> libiconv, but it goes wrong just with our test setup with
> >> iconv(1). I.e. on my boring linux box:
> >>
> >>     echo x | iconv -f UTF-8 -t UTF-16 | perl -0777 -MData::Dumper -ne=
 'my @a =3D map { sprintf "0x%x", $_ } unpack "C*"; print Dumper \@a'
> >>     $VAR1 =3D [
> >>               '0xff',
> >>               '0xfe',
> >>               '0x78',
> >>               '0x0',
> >>               '0xa',
> >>               '0x0'
> >>             ];
> >>
> >>
> >> On the AIX box to get the same I need to do that as:
> >>
> >>     (printf '\376\377'; echo x | iconv -f UTF-8 -t UTF-16LE) | [...]
> >
> > FWIW, my Linux with musl-libc also need to be done like this.
> >
> >> I.e. we omit the BOM *and* AIX's idea of our UTF-16 is little-endian
> >> UTF-16, a plain UTF-16 gives you the big-endian version.
> >
> > Per spec, plain UTF-16 *is* big-endian. [1]
> >
> > 	In the table <BOM> indicates that the byte order is determined
> > 	by a byte order mark, if present at the beginning of the data
> > 	stream, otherwise it is big-endian.
> >
> >> To make things
> >> worse the same is true of UTF-32, except "iconv -l" lists no UTF-32LE
> >> version. So it seems we can't get the same result at all for that one=
.
> >
> > Ditto for UTF-32
> >
> >> So from the outset the code added around 79444c92943 (utf8: handle
> >> systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
> >> careful (although this looked broken before), i.e. we should test exa=
ct
> >> known-good bytes and see if UTF-16 is really what we think it is,
> >> etc. This is likely broken on any big-endian non-GNUish iconv
> >> implementation.
> >
> > Linux with musl-libc on little endian also thinks UTF-16 without BOM i=
s UTF-16-BE
> >
> > I still think we should strip UTF-8 BOM after reencode_string_len
> > I.e. something like this, I can't test this, though, since I don't hav=
e any AIX box.
> > And my Linux with musl-libc doesn't output BOM for utf-8
> > It doesn't write BOM for utf-16be and utf-32be, anyway.
> >
> > -----8<----
> > diff --git a/utf8.c b/utf8.c
> > index de4ce5c0e6..73631632bd 100644
> > --- a/utf8.c
> > +++ b/utf8.c
> > @@ -8,6 +8,7 @@ static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
> >  static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
> >  static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
> >  static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
> > +const char utf8_bom[] =3D "\357\273\277";
> >
> >  struct interval {
> >  	ucs_char_t first;
> > @@ -28,6 +29,12 @@ size_t display_mode_esc_sequence_len(const char *s)
> >  	return p - s;
> >  }
> >
> > +static int has_utf8_bom(const char *text, size_t len)
> > +{
> > +	return len >=3D strlen(utf8_bom) &&
> > +		memcmp(text, utf8_bom, strlen(utf8_bom)) =3D=3D 0;
> > +}
> > +
> >  /* auxiliary function for binary search in interval table */
> >  static int bisearch(ucs_char_t ucs, const struct interval *table, int=
 max)
> >  {
> > @@ -539,12 +546,13 @@ static const char *fallback_encoding(const char =
*name)
> >
> >  char *reencode_string_len(const char *in, size_t insz,
> >  			  const char *out_encoding, const char *in_encoding,
> > -			  size_t *outsz)
> > +			  size_t *outsz_p)
> >  {
> >  	iconv_t conv;
> >  	char *out;
> >  	const char *bom_str =3D NULL;
> >  	size_t bom_len =3D 0;
> > +	size_t outsz =3D 0;
> >
> >  	if (!in_encoding)
> >  		return NULL;
> > @@ -590,10 +598,16 @@ char *reencode_string_len(const char *in, size_t=
 insz,
> >  		if (conv =3D=3D (iconv_t) -1)
> >  			return NULL;
> >  	}
> > -	out =3D reencode_string_iconv(in, insz, conv, bom_len, outsz);
> > +	out =3D reencode_string_iconv(in, insz, conv, bom_len, &outsz);
> >  	iconv_close(conv);
> >  	if (out && bom_str && bom_len)
> >  		memcpy(out, bom_str, bom_len);
> > +	if (is_encoding_utf8(out_encoding) && has_utf8_bom(out, outsz)) {
> > +		outsz -=3D strlen(utf8_bom);
> > +		memmove(out, out + strlen(utf8_bom), outsz + 1);
> > +	}
> > +	if (outsz_p)
> > +		*outsz_p =3D outsz;
> >  	return out;
> >  }
> >  #endif
> > @@ -782,12 +796,9 @@ int is_hfs_dotmailmap(const char *path)
> >  	return is_hfs_dot_str(path, "mailmap");
> >  }
> >
> > -const char utf8_bom[] =3D "\357\273\277";
> > -
> >  int skip_utf8_bom(char **text, size_t len)
> >  {
> > -	if (len < strlen(utf8_bom) ||
> > -	    memcmp(*text, utf8_bom, strlen(utf8_bom)))
> > +	if (!has_utf8_bom(*text, len))
> >  		return 0;
> >  	*text +=3D strlen(utf8_bom);
> >  	return 1;
> > ---->8------
> >
> > 1: https://unicode.org/faq/utf_bom.html
>
> That's getting us there, now we don't fail on the 2nd test, but do start
> failing on the third "re-encode to UTF-16 on checkout" and other
> "checkout" tests.
>
> The "test_cmp" at the end of that 3rd tests shows that the difference in
> test.utf16.raw and test.utf16 is now that the "raw" one has the BOM, but
> not the "test.utf16" file.

What I can read from all of this, is that "the iconv" does not handle BOMS
correcttly. When going from UTF-16 or UTF-32 to UTF-8 the BOM should be re=
moved.
But that is not the case here, as it seams.
The patch from above for utf8.c in Git will fix this - OK so far.

For t2082-parallel-checkout-attributes.sh and t0028 we may be able to prep=
are
the "right" versions of the expected data on e.g. Linux box and add that m=
aterial
to the test case.
Aad remove the invocation of a potential broken iconv binary completely fr=
om
the test scripts.


