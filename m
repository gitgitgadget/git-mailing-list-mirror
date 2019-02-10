Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EF81F453
	for <e@80x24.org>; Sun, 10 Feb 2019 08:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfBJIEd (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 03:04:33 -0500
Received: from mout.web.de ([212.227.15.4]:56727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfBJIEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 03:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549785858;
        bh=4R5nQXKqaMkbputge+oWp4RB9DXkaIktSv68d8IBeXU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WzWSAmt7qvBmxl7bO7IvlCLm7tDHEx8rBl6e+ekhM5Sf9EFvEI79wVSkvBCc8H6ja
         Dq3NSvid9xcmdcRx8bpzmbV8roVXSWeTIhCbNa4dfHRHv2rFI2b0dcllEGcJ2hjQdQ
         06+Q/dyxs2BxLspGUVswrLnL8lBrhZiAWx2Nb3c4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHt7-1ge7XT1m7B-00WDqH; Sun, 10
 Feb 2019 09:04:18 +0100
Date:   Sun, 10 Feb 2019 08:04:13 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        Rich Felker <dalias@libc.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190210080413.u56vr3fgoejjzjfm@tb-raspi4>
References: <20190209145732.GA14229@alpha>
 <20190209200802.277139-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209200802.277139-1-sandals@crustytoothpaste.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KL1dKkfaDTath6oVGl6PN83PQ1CPjULZISLReiVmMmOiPHfLRPM
 yV6LDe3ay66FifrGS4b6xPRI0cS5M6lOkmmo7tRBvPVSGkE0gYvwRLmOxg3laHIpHj4chWq
 nNcR4jHY/lm5v/z3GTVU3F0oy0CGihE+3uu79Sd22Zalx1P5w7gzxw73Fy164F1SF9aEge2
 6u0cGkKbdGZQq0YsE7IiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XmwO/vP1Mdg=:0PE7zL2Xfg513Awbu0up9a
 3J7kTQBR08QvzBF4Eizp8FA17RaYF5UKhEo5UIRgH78d9+aYx2ZJDRJHF7lUiz78NvKybrrXh
 J16iKTjphULgWVacNb9aiMbu6TaeoRH7Ru+mdJuy4yJTGRtXAiMtQaCkfj45qzaNvdmDyn7GJ
 1gWHppxvGqkI++EA3zLgxYOSdszZCr/dfZCdyzvOXjNYINrw7bnfbhEEzWjGtFa7tat/qGrEl
 JMRr/CwuCVXXCDCZMuk7TYmraULYV7eSvuCS1aR7/yMJL0oEVXgXWRNz2fxscs1bCY8fv6iqe
 Hl+yvCgiJL2+s+igBnP+xZ+224BXkIGRmK2tXisBYXfXEKtmXKm3fIwquVWCtTW30kbb2lrrp
 qzzwDH8VON7dhtmuCSEwgONX+dse2FXSyMBaX0ifFmOa8i26ISLHtTOM6eQJ0Q/pj+WP3h4K+
 BKqCdGUadxgGLDd//KWeTMdQV4ojY4bY2T3lTQiW/kHLHTNahHx7cxZDMhmWI9b3a4HrYRj0Q
 cCVD7KEzUAXgcMYxiB1UaUJGqFc9Qv95PnGrtubkFoUXVi0b6FYHp55FxuYfQYLwEDx8bJ01q
 ErpvuDlmov4UvyDgaGZl8TjZGPkjh7QTs2wz7S/iHkY2HTkVJrUHU0kL9Io/8syAeuRupCnvO
 LVuU3e150oCZv150OZOvJ3R4O3F3KZmfEqzOyttPfdBZUJzcWL1OHejkCVSJXzZjY/aiffLfe
 0H2LoQlHaGjhUzb40MmDfqGPzo0CuqBfxkhVAI4Xka2AgUtFVOYH8857lxbA0rTSoLxp4PJJ4
 Z7EZMn0ZKoS9oxOrroNPGqso+aHPXM9YwO+2k359jXsf++y0GX9KhAPufebIUFXEZ0B0O4TtV
 ECSRZDm4nxFwQPMv5F1ZTPf51SDFg8f5q8yJ2wzPx189UT/5XJvmTyJ0WDLw/E
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 09, 2019 at 08:08:01PM +0000, brian m. carlson wrote:
> When serializing UTF-16 (and UTF-32), there are three possible ways to
> write the stream. One can write the data with a BOM in either big-endian
> or little-endian format, or one can write the data without a BOM in
> big-endian format.
>
> Most systems' iconv implementations choose to write it with a BOM in
> some endianness, since this is the most foolproof, and it is resistant
> to misinterpretation on Windows, where UTF-16 and the little-endian
> serialization are very common. For compatibility with Windows and to
> avoid accidental misuse there, Git always wants to write UTF-16 with a
> BOM, and will refuse to read UTF-16 without it.
>
> However, musl's iconv implementation writes UTF-16 without a BOM,
> relying on the user to interpret it as big-endian. This causes t0028 and
> the related functionality to fail, since Git won't read the file without
> a BOM.
>
> Add a Makefile and #define knob, ICONV_NEEDS_BOM, that can be set if the
> iconv implementation has this behavior. When set, Git will write a BOM
> manually for UTF-16 and UTF-32 and then force the data to be written in
> UTF-16BE or UTF-32BE. We choose big-endian behavior here because the
> tests use the raw "UTF-16" encoding, which will be big-endian when the
> implementation requires this knob to be set.
>
> Update the tests to detect this case and write test data with an added
> BOM if necessary. Always write the BOM in the tests in big-endian
> format, since all iconv implementations that omit a BOM must use
> big-endian serialization according to the Unicode standard.
>
> Preserve the existing behavior for systems which do not have this knob
> enabled, since they may use optimized implementations, including
> defaulting to the native endianness, to gain improved performance, which
> can be significant with large checkouts.

Is the based on measurements on a real system ?

I think we agree that Git will write UTF-16 always as big endian with BOM,
following the tradition of iconv/libiconv.
If yes, we can reduce the lines of code/#idefs somewhat, have the knob alw=
ays on,
and reduce the maintenance burden a little bit, giving a simpler patch.

What do you think ?


diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encod=
ing.sh
index e58ecbfc44..ef19c98e67 100755
=2D-- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -13,7 +13,8 @@ test_expect_success 'setup test files' '
 	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
 	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM" >>.gitattr=
ibutes &&
 	printf "$text" >test.utf8.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	printf "\376\377"                         >test.utf16.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16BE >>test.utf16.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
diff --git a/utf8.c b/utf8.c
index 83824dc2f4..d3731273be 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -564,7 +564,8 @@ char *reencode_string_len(const char *in, size_t insz,
 		bom_str =3D utf16_le_bom;
 		bom_len =3D sizeof(utf16_le_bom);
 		out_encoding =3D "UTF-16LE";
-	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding)) {
+	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding) ||
+		   same_utf_encoding("UTF-16", out_encoding)) {
 		bom_str =3D utf16_be_bom;
 		bom_len =3D sizeof(utf16_be_bom);
 		out_encoding =3D "UTF-16BE";


>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Makefile                         |  6 ++++++
>  t/t0028-working-tree-encoding.sh | 25 ++++++++++++++++++++++---
>  utf8.c                           | 10 ++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 571160a2c4..b2a4765e5f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -259,6 +259,9 @@ all::
>  # Define OLD_ICONV if your library has an old iconv(), where the second
>  # (input buffer pointer) parameter is declared with type (const char **=
).
>  #
> +# Define ICONV_NEEDS_BOM if your iconv implementation does not write a
> +# byte-order mark (BOM) when writing UTF-16 or UTF-32.
> +#
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
>  # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
> @@ -1415,6 +1418,9 @@ ifndef NO_ICONV
>  		EXTLIBS +=3D $(ICONV_LINK) -liconv
>  	endif
>  endif
> +ifdef ICONV_NEEDS_BOM
> +	BASIC_CFLAGS +=3D -DICONV_NEEDS_BOM
> +endif
>  ifdef NEEDS_LIBGEN
>  	EXTLIBS +=3D -lgen
>  endif
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enc=
oding.sh
> index e58ecbfc44..bfc4a9d4dd 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -6,6 +6,25 @@ test_description=3D'working-tree-encoding conversion vi=
a gitattributes'
>
>  GIT_TRACE_WORKING_TREE_ENCODING=3D1 && export GIT_TRACE_WORKING_TREE_EN=
CODING
>
> +test_lazy_prereq NO_UTF16_BOM '
> +	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) =3D 6
> +'
> +
> +test_lazy_prereq NO_UTF32_BOM '
> +	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) =3D 12
> +'
> +
> +write_utf16 () {
> +	test_have_prereq NO_UTF16_BOM && printf '\xfe\xff'
> +	iconv -f UTF-8 -t UTF-16
> +
> +}
> +
> +write_utf32 () {
> +	test_have_prereq NO_UTF32_BOM && printf '\x00\x00\xfe\xff'
> +	iconv -f UTF-8 -t UTF-32
> +}
> +
>  test_expect_success 'setup test files' '
>  	git config core.eol lf &&
>
> @@ -13,8 +32,8 @@ test_expect_success 'setup test files' '
>  	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
>  	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM" >>.gitat=
tributes &&
>  	printf "$text" >test.utf8.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
> +	printf "$text" | write_utf16 >test.utf16.raw &&
> +	printf "$text" | write_utf32 >test.utf32.raw &&
>  	printf "\377\376"                         >test.utf16lebom.raw &&
>  	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
>
> @@ -223,7 +242,7 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtrip=
 encoding' '
>
>  	text=3D"hallo there!\nroundtrip test here!" &&
>  	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
> +	printf "$text" | write_utf16 >roundtrip.utf16 &&
>  	echo "*.shift text working-tree-encoding=3DSHIFT-JIS" >>.gitattributes=
 &&
>
>  	# SHIFT-JIS encoded files are round-trip checked by default...
> diff --git a/utf8.c b/utf8.c
> index 83824dc2f4..133199de0e 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -568,6 +568,16 @@ char *reencode_string_len(const char *in, size_t in=
sz,
>  		bom_str =3D utf16_be_bom;
>  		bom_len =3D sizeof(utf16_be_bom);
>  		out_encoding =3D "UTF-16BE";
> +#ifdef ICONV_NEEDS_BOM
> +	} else if (same_utf_encoding("UTF-16", out_encoding)) {
> +		bom_str =3D utf16_be_bom;
> +		bom_len =3D sizeof(utf16_be_bom);
> +		out_encoding =3D "UTF-16BE";
> +	} else if (same_utf_encoding("UTF-32", out_encoding)) {
> +		bom_str =3D utf32_be_bom;
> +		bom_len =3D sizeof(utf32_be_bom);
> +		out_encoding =3D "UTF-32BE";
> +#endif
>  	}
>
>  	conv =3D iconv_open(out_encoding, in_encoding);
