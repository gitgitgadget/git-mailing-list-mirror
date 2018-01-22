Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164241F404
	for <e@80x24.org>; Mon, 22 Jan 2018 12:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeAVMf3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 07:35:29 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43881 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeAVMf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 07:35:28 -0500
Received: by mail-wm0-f52.google.com with SMTP id g1so15999286wmg.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYM844yn5t1EKkeoQjTt0OfswxuZ5aMjHypYmll4yEg=;
        b=ZGJV9E3fBK5eQv6Wkp8z/l+mx0WpqHN31faZtm4auv45s8MSqx/9Z3xZH//R9mxYOw
         C4Sl8y8pz1myRDUD7FyV2ZNRyt1ouGINWO/E9hhnenkCJm1Z3tiapbKK26VqAExtg0//
         Y2cpuSvwz0UIkJWsUq9Tp0z7q5myIsf3qn3PP69fggc1Ynz449lxEC9CgpDITdXoQ2oo
         5/lazOjRRusxqhXjhZarNzUPGGiGNAAkpaqpYK18/r9Yt9TAkm7Y8qpykLeJPQaG1l4z
         awUjYaqLiNY5RYVCVUl7YE5JUp3H/oMYm9NxQSJme7Q3hOH6k5WzMEwiOEanp72wS8RV
         34Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYM844yn5t1EKkeoQjTt0OfswxuZ5aMjHypYmll4yEg=;
        b=Gm6Dnhiohqj/bT2ACWiIk95ISayuKy6GjNtcIFXpbrPHI38kVDe7G2HAnnglu5FDR7
         btyaF1N47udn/M/dyavjP7jl2EyqYh0yM4AK3yuB7NgMO4lZxt+oqN7HoYRyltPVtYMR
         xIrLNdFFiDrnfb50KvzFWqpB6BP7aAQgP6JueJPl4clUAfnl6e3GRSWKWoDLTzNbPM6K
         Pn3BNnyOevhcpbmhcEd4kNRjknO55A2+mUbmyOVRwC3+cKBl1pRUh5pfZMQsREdO7Jlx
         guTEzuzSxqfE8v9c4xn2VTJLgaLWENgsl+JcRiEx3TISxL6ttb07XOI13VtsMG+0wlRE
         OLDg==
X-Gm-Message-State: AKwxytfVTW8lbrx/tPVTArHXcM5w4smPxE1N7dzR4EM7Z8GEsJZD1UGl
        AAiu8o37y31GOoyjh2LyOwQ=
X-Google-Smtp-Source: AH8x224yY0m5+MYnIONoUZgevcGGeRXQwI5hb3OsqqkxnYpYcZA4gX/lYwuP+sN5kDKglFQj37qr8A==
X-Received: by 10.28.173.130 with SMTP id w124mr4567116wme.18.1516624526967;
        Mon, 22 Jan 2018 04:35:26 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u27sm12576466wrf.77.2018.01.22.04.35.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 04:35:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180121142222.GA10248@ruderich.org>
Date:   Mon, 22 Jan 2018 13:35:25 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
References: <20180120152418.52859-1-lars.schneider@autodesk.com> <20180120152418.52859-6-lars.schneider@autodesk.com> <20180121142222.GA10248@ruderich.org>
To:     Simon Ruderich <simon@ruderich.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Jan 2018, at 15:22, Simon Ruderich <simon@ruderich.org> wrote:
>=20
> On Sat, Jan 20, 2018 at 04:24:17PM +0100, lars.schneider@autodesk.com =
wrote:
>> +static struct encoding *git_path_check_encoding(struct =
attr_check_item *check)
>> +{
>> +	const char *value =3D check->value;
>> +	struct encoding *enc;
>> +
>> +	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) =
||
>> +	    !strlen(value))
>> +		return NULL;
>> +
>> +	for (enc =3D encoding; enc; enc =3D enc->next)
>> +		if (!strcasecmp(value, enc->name))
>> +			return enc;
>> +
>> +	/* Don't encode to the default encoding */
>> +	if (!strcasecmp(value, default_encoding))
>> +		return NULL;
>> +
>> +	enc =3D xcalloc(1, sizeof(struct convert_driver));
>=20
> I think this should be "sizeof(struct encoding)" but I prefer
> "sizeof(*enc)" which prevents these kind of mistakes.

Great catch! Thank you!

Other code paths are at risk of this problem too. Consider this:

$ git grep 'sizeof(\*' | wc -l
     303
$ git grep 'sizeof(struct ' | wc -l
     208

E.g. even in the same file (likely where I got the code from):
=
https://github.com/git/git/blob/59c276cf4da0705064c32c9dba54baefa282ea55/c=
onvert.c#L780

@Junio:=20
Would you welcome a patch that replaces "struct foo" with "*foo"
if applicable?


>> +	enc->name =3D xstrdup_toupper(value);  /* aways use upper case =
names! */
>=20
> "aways" -> "always" and I think the comment should say why
> uppercase is important.

Would that be better?

	/* Aways use upper case names to simplify subsequent string =
comparison. */
	enc->name =3D xstrdup_toupper(value);

AFAIK uppercase and lowercase names are both valid. I just wanted to
ensure that we use one consistent casing. That reads better in error =
messages
and I don't need to check for the letter case in =
has_prohibited_utf_bom()
and friends in utf8.c


>> +test_expect_success 'ensure UTF-8 is stored in Git' '
>> +	git cat-file -p :test.utf16 >test.utf16.git &&
>> +	test_cmp_bin test.utf8.raw test.utf16.git &&
>> +	rm test.utf8.raw test.utf16.git
>> +'
>> +
>> +test_expect_success 're-encode to UTF-16 on checkout' '
>> +	rm test.utf16 &&
>> +	git checkout test.utf16 &&
>> +	test_cmp_bin test.utf16.raw test.utf16 &&
>> +
>> +	# cleanup
>> +	rm test.utf16.raw
>=20
> Micro-nit: For consistency with the previous test, remove the
> empty line and comment (or just keep the files generated from the
> "setup test repo" phase and don't explicitly delete them)?

I would rather add a new line and a comment to the previous test=20
to be consistent.

I know we could leave the files but these lingering files could
always surprise writers of future tests (at least they surprised
me in other tests).


Thank you very much for the review,
Lars=
