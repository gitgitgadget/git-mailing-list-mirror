Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7273F1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeBVUAw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:00:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33976 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:00:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so3929382wmd.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MItLN5iwO4lmntQDmAQK2SHObuBar5SVv8NmdUbA3yk=;
        b=hxoGEY3qCxc4w5OxGyOSTdVd1owWQQPTg6Do4XT+V4njYjnc2JnZcSdZsK4rLfG970
         mRz3yvOOotgF/zoJJyZ3TgHaI36sxb8ocJdyT1hjLYlG+k7W8m8qXV74naYBTcpUPjY3
         ijpGr7VhWLjGG7oWmIkn17UrmpRQkwEhbdsqROB81WefzpseAqRBGsEDOM/3ObIpPdLE
         WTH5JWnzJ98Z9/w08Zm0YorUnPKgoG2CYZdTJBGL/rpBu23RD9BDP4buokpsDYlUgqLD
         xzu+pUleNOoZhzkkRi8lCWFdiGreSaTPuQztG/Q95qLmE44iaL37+tquKfB84Heh75H/
         rkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MItLN5iwO4lmntQDmAQK2SHObuBar5SVv8NmdUbA3yk=;
        b=Ssxuf9lBn2UFV/nHNsajNv7mf8Vd8Cwz1qR+xxI4EQpAI705kabkaaz3fVkr4wZhPB
         o2adWFQEyuSn1QmNp0yz2HBVPPIefXD3zAqt24U0mOco8qiBUXhfdag5DRkqSB9n5eUA
         C3PSNcsJm83YonZJzZVxqRBDlM+vg/niWReirHaXAaRnlyeFowfu2mf9iw0+E4JM1iKk
         kYay6msG1Id4gNs7D7I5eGT1p6f6DuNIqKinqlP3qEqSePCNCRfJaN3hTXwpGfpeFlWL
         aw5eiS+CMSorDBCqGpxXaWBLWvGyiARnMJ+a9QL+ehXAVCHXIUycIl/paFvZ9+FXwgj7
         Zz7w==
X-Gm-Message-State: APf1xPDxTEyEKJghYwNuLXrcJIEXlSlSmIieVPP0GINQfwblDLsag8/3
        qoexWM2lhi4afqY6r84wN28=
X-Google-Smtp-Source: AG47ELtne8OjHkXyyf+0NSuk3aZzhzj5INUhs+rfNUp4O2oLe80N0Plx7pNROFzEJS3Mk0PZzQebyg==
X-Received: by 10.28.158.197 with SMTP id h188mr307302wme.72.1519329647266;
        Thu, 22 Feb 2018 12:00:47 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5A1D.dip0.t-ipconnect.de. [93.219.90.29])
        by smtp.gmail.com with ESMTPSA id c18sm215895wmd.18.2018.02.22.12.00.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Feb 2018 12:00:46 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180216165815.GA4681@tor.lan>
Date:   Thu, 22 Feb 2018 21:00:45 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, lars.schneider@autodesk.com,
        git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com> <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com> <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com> <20180216165815.GA4681@tor.lan>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2018, at 17:58, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On Fri, Feb 16, 2018 at 03:42:35PM +0100, Lars Schneider wrote:
> []
>>=20
>> Agreed. However, people using ShiftJIS are not my target audience.
>> My target audience are:
>>=20
>> (1) People that have to encode their text files in UTF-16 (for=20
>>    whatever reason - usually because of legacy processes or tools).
>>=20
>> (2) People that want to see textual diffs of their UTF-16 encoded=20
>>    files in their Git tools without special adjustments (on the=20
>>    command line, on the web, etc).
>>=20
>> That was my primary motivation. The fact that w-t-e supports any
>> other encoding too is just a nice side effect. I don't foresee people
>> using other w-t-encodings other than UTF-16 in my organization.
>>=20
>> I have the suspicion that the feature could be useful for the Git
>> community at large. Consider this Stack Overflow question:
>> =
https://stackoverflow.com/questions/777949/can-i-make-git-recognize-a-utf-=
16-file-as-text
>>=20
>> This question was viewed 42k times and there is no good solution.
>> I believe w-t-e could be a good solution.
>>=20
>=20
> If it was only about a diff of UTF-16 files, I may suggest a patch.
> I simply copy-paste it here for review, if someone thinks that it may
> be useful, I can send it as a real patch/RFC.

That's a nice idea but I see two potential problems:

(1) Git hosting services (GitLab, BitBucket, GitHub, ...) would still
    show these files as binary. That's a huge problem for my users as
    they interact more with these services than the Git command line.
    That's the main reason why I implemented the "UTF-8 as canonical
    form" approach in my series.

(2) You can only detect a BOM if the encoding is UTF-16. UTF-16BE and
    UTF-16LE must not have a BOM and therefore cannot be easily
    detected. Plus, even if you detect an UTF-16 BOM then it would be=20
    just a hint that the file is likely UTF-16 encoded as the sequence
    could be there by chance.=20

I still think it would be nice to see diffs for arbitrary encodings.
Would it be an option to read the `encoding` attribute and use it in
`git diff`?

- Lars


>=20
> git show HEAD
>=20
>=20
> commit 9f7d43f29eaf6017b7b16261ce91d8ef182cf415
> Author: Torsten B=F6gershausen <tboegi@web.de>
> Date:   Fri Feb 2 15:35:23 2018 +0100
>=20
>    Auto diff of UTF-16 files in UTF-8
>=20
>    When an UTF-16 file is commited and later changed, `git diff` shows
>    "Binary files XX and YY differ".
>=20
>    When the user wants a diff in UTF-8, a textconv needs to be =
specified
>    in .gitattributes and the textconv must be configured.
>=20
>    A more user-friendly diff can be produced for UTF-16 if
>    - the user did not use `git diff --binary`
>    - the blob is identified as binary
>    - the blob has an UTF-16 BOM
>    - the blob can be converted into UTF-8
>=20
>    Enhance the diff machinery to auto-detect UTF-16 blobs and show =
them
>    as UTF-8, unless the user specifies `git diff --binary` which =
creates
>    a binary diff.
>=20
> diff --git a/diff.c b/diff.c
> index fb22b19f09..51831ee94d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3192,6 +3192,10 @@ static void builtin_diff(const char *name_a,
> 			strbuf_reset(&header);
> 		}
>=20
> +		if (one && one->reencoded_from_utf16)
> +			strbuf_addf(&header, "a is converted to UTF-8 =
from UTF-16\n");
> +		if (two && two->reencoded_from_utf16)
> +			strbuf_addf(&header, "b is converted to UTF-8 =
from UTF-16\n");
> 		mf1.size =3D fill_textconv(textconv_one, one, &mf1.ptr);
> 		mf2.size =3D fill_textconv(textconv_two, two, &mf2.ptr);
>=20
> @@ -3611,8 +3615,25 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
> 			s->size =3D size;
> 			s->should_free =3D 1;
> 		}
> -	}
> -	else {
> +		if (!s->binary && buffer_is_binary(s->data, s->size) &&
> +		    buffer_has_utf16_bom(s->data, s->size)) {
> +			int outsz =3D 0;
> +			char *outbuf;
> +			outbuf =3D reencode_string_len(s->data, =
(int)s->size,
> +						     "UTF-8", "UTF-16", =
&outsz);
> +			if (outbuf) {
> +				if (s->should_free)
> +					free(s->data);
> +				if (s->should_munmap)
> +					munmap(s->data, s->size);
> +				s->should_munmap =3D 0;
> +				s->data =3D outbuf;
> +				s->size =3D outsz;
> +				s->reencoded_from_utf16 =3D 1;
> +				s->should_free =3D 1;
> +			}
> +		}
> +	} else {
> 		enum object_type type;
> 		if (size_only || (flags & CHECK_BINARY)) {
> 			type =3D sha1_object_info(s->oid.hash, =
&s->size);
> @@ -3629,6 +3650,19 @@ int diff_populate_filespec(struct diff_filespec =
*s, unsigned int flags)
> 		s->data =3D read_sha1_file(s->oid.hash, &type, =
&s->size);
> 		if (!s->data)
> 			die("unable to read %s", oid_to_hex(&s->oid));
> +		if (!s->binary && buffer_is_binary(s->data, s->size) &&
> +		    buffer_has_utf16_bom(s->data, s->size)) {
> +			int outsz =3D 0;
> +			char *buf;
> +			buf =3D reencode_string_len(s->data, =
(int)s->size,
> +						  "UTF-8", "UTF-16", =
&outsz);
> +			if (buf) {
> +				free(s->data);
> +				s->data =3D buf;
> +				s->size =3D outsz;
> +				s->reencoded_from_utf16 =3D 1;
> +			}
> +		}
> 		s->should_free =3D 1;
> 	}
> 	return 0;
> @@ -5695,6 +5729,10 @@ static int diff_filespec_is_identical(struct =
diff_filespec *one,
>=20
> static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
> {
> +	if (p->binary) {
> +		p->one->binary =3D 1;
> +		p->two->binary =3D 1;
> +	}
> 	if (p->done_skip_stat_unmatch)
> 		return p->skip_stat_unmatch_result;
>=20
> @@ -5735,6 +5773,7 @@ static void diffcore_skip_stat_unmatch(struct =
diff_options *diffopt)
> 	for (i =3D 0; i < q->nr; i++) {
> 		struct diff_filepair *p =3D q->queue[i];
>=20
> +		p->binary =3D diffopt->flags.binary;
> 		if (diff_filespec_check_stat_unmatch(p))
> 			diff_q(&outq, p);
> 		else {
> diff --git a/diffcore.h b/diffcore.h
> index a30da161da..3cd97bb93b 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -47,6 +47,8 @@ struct diff_filespec {
> 	unsigned has_more_entries : 1; /* only appear in combined diff =
*/
> 	/* data should be considered "binary"; -1 means "don't know yet" =
*/
> 	signed int is_binary : 2;
> +	unsigned binary : 1;
> +	unsigned reencoded_from_utf16 : 1;
> 	struct userdiff_driver *driver;
> };
>=20
> @@ -72,6 +74,7 @@ struct diff_filepair {
> 	unsigned is_unmerged : 1;
> 	unsigned done_skip_stat_unmatch : 1;
> 	unsigned skip_stat_unmatch_result : 1;
> +	unsigned binary : 1;
> };
> #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
>=20
> diff --git a/t/t4066-diff-encoding.sh b/t/t4066-diff-encoding.sh
> new file mode 100755
> index 0000000000..9bb3c70ada
> --- /dev/null
> +++ b/t/t4066-diff-encoding.sh
> @@ -0,0 +1,98 @@
> +#!/bin/sh
> +
> +test_description=3D'git diff with encoding attribute'
> +
> +. ./test-lib.sh
> +
> +printf '\303\244rger\n\303\266se\n\303\274bel\n' |
> +	iconv -f UTF-8 -t UTF-16 >UTF-16
> +printf '\303\266se\n\303\274bel\n\303\245st\n' |
> +	iconv -f UTF-8 -t UTF-16 >file2
> +
> +test_expect_success 'setup' '
> +	cp UTF-16 file &&
> +	git add file &&
> +	git commit -m "add file in UTF-16" &&
> +	test_tick &&
> +	echo "file encoding=3DUTF-16" >.gitattributes
> +'
> +
> +test_expect_success 'diff against local change' '
> +	cp file2 file &&
> +	test_tick &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/file b/file
> +	index 26acf09..e98d27a 100644
> +	a is converted to UTF-8 from UTF-16
> +	b is converted to UTF-8 from UTF-16
> +	--- a/file
> +	+++ b/file
> +	@@ -1,3 +1,3 @@
> +	-=E4rger
> +	 =F6se
> +	 =FCbel
> +	+=E5st
> +EOF
> +	git diff file >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --binary against local change' '
> +	cp file2 file &&
> +	test_tick &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/file b/file
> +	index =
26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa=
7828290f 100644
> +	GIT binary patch
> +	literal 28
> +	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
> +
> +	literal 32
> +	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
> +
> +EOF
> +	git diff --binary file >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'commit local change' '
> +	git add file &&
> +	git commit -m "add file V2 in UTF-16" &&
> +	test_tick
> +'
> +
> +test_expect_success 'diff HEAD against HEAD^' '
> +	cat >expect <<-\EOF &&
> +	diff --git a/file b/file
> +	index 26acf09..e98d27a 100644
> +	a is converted to UTF-8 from UTF-16
> +	b is converted to UTF-8 from UTF-16
> +	--- a/file
> +	+++ b/file
> +	@@ -1,3 +1,3 @@
> +	-=E4rger
> +	 =F6se
> +	 =FCbel
> +	+=E5st
> +EOF
> +	git diff HEAD^ HEAD -- file >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --binary HEAD against HEAD^' '
> +	cat >expect <<-\EOF &&
> +	diff --git a/file b/file
> +	index =
26acf09b0aad19fb22566956d1a39cb4e2a3b420..e98d27acfb90cfcfc84fcc5173baa4aa=
7828290f 100644
> +	GIT binary patch
> +	literal 28
> +	ecmezW?;ArgLn;Fo!ykquAe{qbJq3!C0BHb{ln3Pi
> +
> +	literal 32
> +	icmezW?+HT@Lpnn$kmO?c#!w7oaWVX1NCMJ1Ko$VA_z0~4
> +=09
> +EOF
> +	git diff --binary HEAD^ HEAD -- file >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/utf8.h b/utf8.h
> index 6bbcf31a83..a2184d0300 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -16,6 +16,17 @@ int utf8_fprintf(FILE *, const char *, ...);
> extern const char utf8_bom[];
> extern int skip_utf8_bom(char **, size_t);
>=20
> +static inline int buffer_has_utf16_bom(const void *buf, size_t len) {
> +  const unsigned char *text =3D (unsigned char *)buf;
> +  if (!text ||  len < 2)
> +    return 0;
> +  if (text[0] =3D=3D 0xff && text[1] =3D=3D 0xfe)
> +    return 1;
> +  if (text[0] =3D=3D 0xfe && text[1] =3D=3D 0xff)
> +    return 1;
> +  return 0;
> +}
> +
> void strbuf_add_wrapped_text(struct strbuf *buf,
> 		const char *text, int indent, int indent2, int width);
> void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, =
int len,

