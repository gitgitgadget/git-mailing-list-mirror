Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99E51F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeB0L6w (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:58:52 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:45510 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeB0L6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:58:51 -0500
Received: by mail-pg0-f54.google.com with SMTP id i133so199892pgc.12
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vUQpJH5CiV/tTE6zRqi+9aXsuCwKpeZnag4EyZ4NO7E=;
        b=A5svQRuOa4itfrmcatjF5qvXLys2GSh3vanLfvUeeZN7oRkaf4BNGit2VSOV3sEGRK
         GkDlTXXgX2pKNVKRcEclbb4rSOS6AS0RTjEm3mU1BS+k02+jQ7H3jgYUWAAaDmfK7WMY
         Tsuivqm+3l2bPGW/Pi7hjDhkxP/XLw3B6YcJ0ISYMNmm8H+IIDX6vq7s+Y27TsqSdbMv
         aglOQYHh/MD4wJS7hAzRSuuyQv/2Yt2rBoHme4eKUjoIr02/6Zr3NnIi0wwt7RLBs9Mo
         9AY/0PJEb/4DikcWNM6naiqSOTaEb/khqjJPXio3KaNtqps6SGcACs04zh9dVpQn/I9y
         nFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vUQpJH5CiV/tTE6zRqi+9aXsuCwKpeZnag4EyZ4NO7E=;
        b=U8rvepaz3SqfUWz37hxndtYOsjogBRVKbh+C/1GHTWObINc8J5AodIydhrVtjaEcWv
         vmevdyQbDjvIjycR+dnofVfEt2dAO/ELta/FfFtnLuvDaGlfR3nNn9AeiZXIiGFsolva
         FlczoL4Ebw+Mf+FhUXfHG8NwRLfayp4DlbuleNu3IrP66EORTCQep2tWLTazi+Oorcp9
         9GvPcBOPYMqdP/gGsPOjecQQrWwFJwzNIbqbOdILzNQxjYhJjA/EvXKYsorotSNhPmxw
         BMwlBq3tjWEjyAY/UQqMXfwMcKI3Nc7PGmnbBATd/3Tv3OXRd4+5/qIW9trRXNLSCa5/
         oGSA==
X-Gm-Message-State: APf1xPCyVMfUd0KJAM02LJ+VY0Zzhkfypy/ZzsWG4Pl7QUCA3DmbBbsK
        qWHafBp8LcKDqgsTL4NhZZbd5NH5
X-Google-Smtp-Source: AH8x226vJUmOsGuZ7txAKyvguyHUJw/26cbq84w0AcZbyJfxjGM06xKBmro70YYCjTjbk1iy+WxOyQ==
X-Received: by 10.99.120.205 with SMTP id t196mr10792313pgc.392.1519732730256;
        Tue, 27 Feb 2018 03:58:50 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u22sm18843101pgv.77.2018.02.27.03.58.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 03:58:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 5/7] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cRtp5g0iDd3pHybZXd_VkGG2-a4CdCZdiqN55Cr1T5Zyg@mail.gmail.com>
Date:   Tue, 27 Feb 2018 12:16:56 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A3B1BD6-642C-467F-B80C-82853410C235@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-6-lars.schneider@autodesk.com> <CAPig+cRtp5g0iDd3pHybZXd_VkGG2-a4CdCZdiqN55Cr1T5Zyg@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2018, at 08:15, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> =
wrote:
>> Git recognizes files encoded with ASCII or one of its supersets (e.g.
>> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
>> interpreted as binary and consequently built-in Git text processing
>> tools (e.g. 'git diff') as well as most Git web front ends do not
>> visualize the content.
>>=20
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>> reverse the conversion.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
>> @@ -272,6 +272,84 @@ few exceptions.  Even though...
>> +Please note that using the `working-tree-encoding` attribute may =
have a
>> +number of pitfalls:
>> +
>> +- Alternative Git implementations (e.g. JGit or libgit2) and older =
Git
>> +  versions (as of March 2018) do not support the =
`working-tree-encoding`
>> +  attribute. If you decide to use the `working-tree-encoding` =
attribute
>> +  in your repository, then it is strongly recommended to ensure that =
all
>> +  clients working with the repository support it.
>> +
>> +  If you declare `*.proj` files as UTF-16 and you add `foo.proj` =
with an
>> +  `working-tree-encoding` enabled Git client, then `foo.proj` will =
be
>> +  stored as UTF-8 internally. A client without =
`working-tree-encoding`
>> +  support will checkout `foo.proj` as UTF-8 encoded file. This will
>> +  typically cause trouble for the users of this file.
>=20
> The above paragraph is giving an example of the scenario described in
> the paragraph above it. It might, therefore, be clearer to start this
> paragraph with "For example,...". Also, as an aid to non-Windows
> developers, it might be helpful to introduce ".proj" files as
> "Microsoft Visual Studio `*.proj` files...".

Agreed. How about this?

  For example, Microsoft Visual Studio resources files (`*.rc`) or
  PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.=20
  If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with=20=

  a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
  stored as UTF-8 internally. A client without `working-tree-encoding`
  support will checkout `foo.ps1` as UTF-8 encoded file. This will
  typically cause trouble for the users of this file.


>> diff --git a/convert.c b/convert.c
>> @@ -265,6 +266,110 @@ static int will_convert_lf_to_crlf(size_t len, =
struct text_stat *stats,
>> +static struct encoding {
>> +       const char *name;
>> +       struct encoding *next;
>> +} *encoding, **encoding_tail;
>=20
> Why does this struct need to be a linked-list since it contains only a
> name? In fact, why do the struct and linked list exist at all? Back in
> v1 when the struct held more members, it made sense to place them in a
> collection so they could be re-used, but today it just seems an
> unnecessary artifact which buys you nothing.
>=20
> Is the plan that some future patch series will add members to the
> struct? If not, then it seems that it should be retired altogether.

Absolutely! Thank you!


>> +static const char *default_encoding =3D "UTF-8";
>> +
>> +static int encode_to_git(const char *path, const char *src, size_t =
src_len,
>> +                        struct strbuf *buf, struct encoding *enc, =
int conv_flags)
>> +{
>> +       [...]
>> +       if (has_prohibited_utf_bom(enc->name, src, src_len)) {
>> +               const char *error_msg =3D _(
>> +                       "BOM is prohibited in '%s' if encoded as =
%s");
>> +               /*
>> +                * This advise is shown for UTF-??BE and UTF-??LE =
encodings.
>=20
> s/advise/advice/

Agreed!


>> +                * We truncate the encoding name to 6 chars with %.6s =
to cut
>> +                * off the last two "byte order" characters.
>> +                */
>> +               const char *advise_msg =3D _(
>> +                       "The file '%s' contains a byte order mark =
(BOM). "
>> +                       "Please use %.6s as working-tree-encoding.");
>> +               advise(advise_msg, path, enc->name);
>> +               if (conv_flags & CONV_WRITE_OBJECT)
>> +                       die(error_msg, path, enc->name);
>> +               else
>> +                       error(error_msg, path, enc->name);
>=20
> What is the intended behavior in the non-die() case? As implemented,
> this is still going to attempt the conversion even though it threw an
> error. Should it be returning 0 here instead? Same question for the
> couple additional cases below.

Good question. My intention was to print an error and then let iconv try
the conversion anyways. I agree that this is bogus. Let's return in case
of an error right away.


>> +
>> +       } else if (is_missing_required_utf_bom(enc->name, src, =
src_len)) {
>> +               const char *error_msg =3D _(
>> +                       "BOM is required in '%s' if encoded as %s");
>> +               const char *advise_msg =3D _(
>> +                       "The file '%s' is missing a byte order mark =
(BOM). "
>> +                       "Please use %sBE or %sLE (depending on the =
byte order) "
>> +                       "as working-tree-encoding.");
>> +               advise(advise_msg, path, enc->name, enc->name);
>> +               if (conv_flags & CONV_WRITE_OBJECT)
>> +                       die(error_msg, path, enc->name);
>> +               else
>> +                       error(error_msg, path, enc->name);
>> +       }
>=20
> For a function which presumably is agnostic about the working-tree
> encoding (supporting whatever iconv does), it nevertheless has
> unusually intimate knowledge about UTF BOMs, in general, and the
> internals of has_prohibited_utf_bom() and
> is_missing_required_utf_bom(), in particular. It might be cleaner, and
> would simplify this function, if all this UTF BOM-specific gunk was
> moved elsewhere and generalized into a "validate conversion" function.

Agreed! How about this?

	/*
	 * If we convert to an UTF encoding, then check for common BOM =
errors.
	 */
	if (!memcmp("UTF-", enc, 4))
		if (has_utf_bom_error(path, enc, src, src_len, =
die_on_error))
			return 0;


>> +       dst =3D reencode_string_len(src, src_len, default_encoding, =
enc->name,
>> +                                 &dst_len);
>> +       if (!dst) {
>> +               /*
>> +                * We could add the blob "as-is" to Git. However, on =
checkout
>> +                * we would try to reencode to the original encoding. =
This
>> +                * would fail and we would leave the user with a =
messed-up
>> +                * working tree. Let's try to avoid this by screaming =
loud.
>> +                */
>> +               const char* msg =3D _("failed to encode '%s' from %s =
to %s");
>> +               if (conv_flags & CONV_WRITE_OBJECT)
>> +                       die(msg, path, enc->name, default_encoding);
>> +               else
>> +                       error(msg, path, enc->name, =
default_encoding);
>> +       }
>> +
>> +       strbuf_attach(buf, dst, dst_len, dst_len + 1);
>> +       return 1;
>> +}
>> +
>> +static int encode_to_worktree(const char *path, const char *src, =
size_t src_len,
>> +                             struct strbuf *buf, struct encoding =
*enc)
>> +{
>> +       [...]
>> +       dst =3D reencode_string_len(src, src_len, enc->name, =
default_encoding,
>> +                                 &dst_len);
>> +       if (!dst) {
>> +               error("failed to encode '%s' from %s to %s",
>> +                       path, enc->name, default_encoding);
>=20
> The last two arguments need to be swapped.

Nice catch!


>> +               return 0;
>> +       }
>> +
>> +       strbuf_attach(buf, dst, dst_len, dst_len + 1);
>> +       return 1;
>> +}
>> @@ -978,6 +1083,35 @@ static int ident_to_worktree(const char *path, =
const char *src, size_t len,
>> +static struct encoding *git_path_check_encoding(struct =
attr_check_item *check)
>> +{
>> +       if (ATTR_TRUE(value) || ATTR_FALSE(value) || =
ATTR_UNSET(value) ||
>> +           !strlen(value))
>> +               return NULL;
>> +
>> +       for (enc =3D encoding; enc; enc =3D enc->next)
>> +               if (!strcasecmp(value, enc->name))
>> +                       return enc;
>> +
>> +       /* Don't encode to the default encoding */
>> +       if (!strcasecmp(value, default_encoding))
>> +               return NULL;
>=20
> You could handle this easy-to-detect case before attempting the more
> expensive loop just above. (Not necessarily worth a re-roll.)

True, but I delete the loop anyways when I removed the "encoding=20
linked list" as suggested by your comment above.


>> +       enc =3D xcalloc(1, sizeof(*enc));
>> +       /*
>> +        * Ensure encoding names are always upper case (e.g. UTF-8) =
to
>> +        * simplify subsequent string comparisons.
>> +        */
>> +       enc->name =3D xstrdup_toupper(value);
>> +       *encoding_tail =3D enc;
>> +       encoding_tail =3D &(enc->next);
>> +
>> +       return enc;
>> +}
>> diff --git a/t/t0028-working-tree-encoding.sh =
b/t/t0028-working-tree-encoding.sh
>> @@ -0,0 +1,226 @@
>> +test_expect_success 'ensure UTF-8 is stored in Git' '
>> +       git cat-file -p :test.utf16 >test.utf16.git &&
>> +       test_cmp_bin test.utf8.raw test.utf16.git &&
>> +
>> +       # cleanup
>> +       rm test.utf16.git
>> +'
>=20
> This cleanup won't take place if test_cmp_bin() fails. Instead,
> cleanups are typically handled by test_when_finished() to ensure that
> the cleanup action occurs even if the test fails.
>=20
>    test_expect_success 'ensure UTF-8 is stored in Git' '
>        test_when_finished "rm -f  test.utf16.git" &&
>        ...
>=20
> Same comment for remaining tests.

Agreed! That's the proper way to cleanup the tests. I'll fix my tests.


>> +test_expect_success 'check prohibited UTF BOM' '
>> +       printf "\0a\0b\0c"                         >nobom.utf16be.raw =
&&
>> +       printf "a\0b\0c\0"                         >nobom.utf16le.raw =
&&
>> +       printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw =
&&
>> +       printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw =
&&
>> +
>> +       printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw =
&&
>> +       printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw =
&&
>> +       printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw =
&&
>> +       printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw =
&&
>=20
> These resources seem to be used by multiple tests. Perhaps create them
> in a distinct "setup" test instead of bundling them in this test?

Good idea!


>> +       echo "*.utf16be text working-tree-encoding=3Dutf-16be" =
>>.gitattributes &&
>> +       echo "*.utf16le text working-tree-encoding=3Dutf-16le" =
>>.gitattributes &&
>> +       echo "*.utf32be text working-tree-encoding=3Dutf-32be" =
>>.gitattributes &&
>> +       echo "*.utf32le text working-tree-encoding=3Dutf-32le" =
>>.gitattributes &&
>> +
>> +       # Here we add a UTF-16 files with BOM (big-endian and =
little-endian)
>> +       # but we tell Git to treat it as UTF-16BE/UTF-16LE. In these =
cases
>> +       # the BOM is prohibited.
>> +       cp bebom.utf16be.raw bebom.utf16be &&
>> +       test_must_fail git add bebom.utf16be 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out =
&&
>> +
>> +       cp lebom.utf16le.raw lebom.utf16be &&
>> +       test_must_fail git add lebom.utf16be 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out =
&&
>> +
>> +       cp bebom.utf16be.raw bebom.utf16le &&
>> +       test_must_fail git add bebom.utf16le 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out =
&&
>> +
>> +       cp lebom.utf16le.raw lebom.utf16le &&
>> +       test_must_fail git add lebom.utf16le 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out =
&&
>> +
>> +       # ... and the same for UTF-32
>> +       cp bebom.utf32be.raw bebom.utf32be &&
>> +       test_must_fail git add bebom.utf32be 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out =
&&
>> +
>> +       cp lebom.utf32le.raw lebom.utf32be &&
>> +       test_must_fail git add lebom.utf32be 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out =
&&
>> +
>> +       cp bebom.utf32be.raw bebom.utf32le &&
>> +       test_must_fail git add bebom.utf32le 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out =
&&
>> +
>> +       cp lebom.utf32le.raw lebom.utf32le &&
>> +       test_must_fail git add lebom.utf32le 2>err.out &&
>> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out =
&&
>> +
>> +       # cleanup
>> +       git reset --hard HEAD
>> +'
>=20
> Clumping all these checks into the same test makes it difficult to
> determine which one failed (if one does fail). Also, the amount of
> copy/paste code is easy to get wrong and a bit onerous to review.
> Automating via for-loops would address these concerns. For instance,
> to check all combinations (not just 8 combinations tested above):
>=20
>    for i in 16be 16le 32be 32le
>    do
>        for j in 16be 16le 32be 32le
>        do
>            test_expect_success "check prohibited UTF BOM utf$i/utf$j" =
'
>                test_when_finished "git reset --hard HEAD" &&
>                cp bebom.utf$i.raw bebom.utf$j &&
>                test_must_fail git add bebom.utf$j 2>err.out &&
>                J=3D$(echo $j | tr bel BEL) &&
>                test_i18ngrep "fatal: BOM is prohibited .* UTF-$J" =
err.out
>            '
>        done
>    done
>=20
> Alternately, the test could be moved to a function and called for each
> combination:
>=20
>    check_prohibited_bom () {
>        i=3D$1
>        j=3D$2
>        test_expect_success "check prohibited UTF BOM utf$i/utf$j" '
>            ...
>        '
>    }
>    check_prohibited_bom 16be 16be
>    check_prohibited_bom 16be 16le
>    ...
>=20
> Same comment regarding copy/paste in tests below.

In general I share your concern about code duplication.
However, I don't want be "too clever" in testing code
as it becomes hard to read it. Therefore, I implemented
a loop over "16 32" which is a good compromise I think.

=20
Thanks you very much for this thorough review,
Lars=
