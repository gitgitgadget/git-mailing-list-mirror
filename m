Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54B31F576
	for <e@80x24.org>; Sun, 25 Feb 2018 07:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBYHPd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 02:15:33 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38555 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeBYHPc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 02:15:32 -0500
Received: by mail-qk0-f194.google.com with SMTP id s198so15629678qke.5
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YsXZOCT6iVpP+oC1XkhqeGzzBuz1g4xrWi18MV3NVGo=;
        b=U2Du/qVRZqyZz6zvpYqW5/7fYVym+UU0IKDiGreI4KPAh6wb22KNe61M4/eFBfxmZu
         BvXeJOhstqGWa8njYebGi5V/1oiiroUypQzdpXh3QJqe831dTVPHefB+mgbd9QWkEywn
         w5NzY9/bY3u8EIdOs9uQihpNVOzl9z+q+nGQrgBpCZ+8LUiiVrHe/yWv/gdFbooZk9xQ
         El9VdbjTj0oiKiAUtvBfRwJliMhkMXaYt7QRVndFvujihxk/azpOF1n9fJ+kLljRlJQ9
         B4/ig2in33XgCF9cIHSkJlgIyOKz9G7BfDDRlmEQeqsyg8y8J9YBnoAH9oG/+RDV0xLN
         zRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YsXZOCT6iVpP+oC1XkhqeGzzBuz1g4xrWi18MV3NVGo=;
        b=kL26t7PIjs21Wrs1YngRJE9pkvjoiar4QSiHeR8Iwn5SIFI5LX0iwlsoqEl4IX+yK2
         FK6/GAxbLrBX+73jvyazGahWu/BLF/Q6F78zDwxII2Wkcb7hmv41A/Wa72IsHu/eg/eJ
         1bF5buqjiSFnlOW6hgiqqgdsAtvo7dolMwE73wZ04e+fcmUabyxXC2SLRm7i4GpK79Qy
         RBLctVPA1iHX+k1itSvCbuwm/SIZAaDG2rW2EdJQrJpVsSMJuTfm0X7yVzoCr7sOXuSL
         nn09EfzDDvS+sBdu9vxm3Kyzk8fNIt/Ye/QB/YU2yl70GvY0T+9pyEv3Hf9qPgmnHIAh
         phLQ==
X-Gm-Message-State: APf1xPAL33mcpsg0ltF7Mtl289dwjOh8WkVNOws3es0ZJkMV4xEaaX17
        Vp0aO9WoP4PiMe1fgx2wyWkbdbn4fhovFU4OYdo=
X-Google-Smtp-Source: AG47ELs/ttwUmkZEeoOY23En9vs8xrSS3EkU6SarK9dBvEI/NCQ1LN3v8SdSPefau8x5CaZslRPpj8h8KAdJS7txPyI=
X-Received: by 10.55.132.67 with SMTP id g64mr11361573qkd.28.1519542931168;
 Sat, 24 Feb 2018 23:15:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 24 Feb 2018 23:15:30 -0800 (PST)
In-Reply-To: <20180224162801.98860-6-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-6-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Feb 2018 02:15:30 -0500
X-Google-Sender-Auth: hDbtg2u-zpa3Vp-QYdywRzEXiSA
Message-ID: <CAPig+cRtp5g0iDd3pHybZXd_VkGG2-a4CdCZdiqN55Cr1T5Zyg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> wrote:
> Git recognizes files encoded with ASCII or one of its supersets (e.g.
> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
> interpreted as binary and consequently built-in Git text processing
> tools (e.g. 'git diff') as well as most Git web front ends do not
> visualize the content.
>
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> @@ -272,6 +272,84 @@ few exceptions.  Even though...
> +Please note that using the `working-tree-encoding` attribute may have a
> +number of pitfalls:
> +
> +- Alternative Git implementations (e.g. JGit or libgit2) and older Git
> +  versions (as of March 2018) do not support the `working-tree-encoding`
> +  attribute. If you decide to use the `working-tree-encoding` attribute
> +  in your repository, then it is strongly recommended to ensure that all
> +  clients working with the repository support it.
> +
> +  If you declare `*.proj` files as UTF-16 and you add `foo.proj` with an
> +  `working-tree-encoding` enabled Git client, then `foo.proj` will be
> +  stored as UTF-8 internally. A client without `working-tree-encoding`
> +  support will checkout `foo.proj` as UTF-8 encoded file. This will
> +  typically cause trouble for the users of this file.

The above paragraph is giving an example of the scenario described in
the paragraph above it. It might, therefore, be clearer to start this
paragraph with "For example,...". Also, as an aid to non-Windows
developers, it might be helpful to introduce ".proj" files as
"Microsoft Visual Studio `*.proj` files...".

> diff --git a/convert.c b/convert.c
> @@ -265,6 +266,110 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
> +static struct encoding {
> +       const char *name;
> +       struct encoding *next;
> +} *encoding, **encoding_tail;

Why does this struct need to be a linked-list since it contains only a
name? In fact, why do the struct and linked list exist at all? Back in
v1 when the struct held more members, it made sense to place them in a
collection so they could be re-used, but today it just seems an
unnecessary artifact which buys you nothing.

Is the plan that some future patch series will add members to the
struct? If not, then it seems that it should be retired altogether.

> +static const char *default_encoding = "UTF-8";
> +
> +static int encode_to_git(const char *path, const char *src, size_t src_len,
> +                        struct strbuf *buf, struct encoding *enc, int conv_flags)
> +{
> +       [...]
> +       if (has_prohibited_utf_bom(enc->name, src, src_len)) {
> +               const char *error_msg = _(
> +                       "BOM is prohibited in '%s' if encoded as %s");
> +               /*
> +                * This advise is shown for UTF-??BE and UTF-??LE encodings.

s/advise/advice/

> +                * We truncate the encoding name to 6 chars with %.6s to cut
> +                * off the last two "byte order" characters.
> +                */
> +               const char *advise_msg = _(
> +                       "The file '%s' contains a byte order mark (BOM). "
> +                       "Please use %.6s as working-tree-encoding.");
> +               advise(advise_msg, path, enc->name);
> +               if (conv_flags & CONV_WRITE_OBJECT)
> +                       die(error_msg, path, enc->name);
> +               else
> +                       error(error_msg, path, enc->name);

What is the intended behavior in the non-die() case? As implemented,
this is still going to attempt the conversion even though it threw an
error. Should it be returning 0 here instead? Same question for the
couple additional cases below.

> +
> +       } else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
> +               const char *error_msg = _(
> +                       "BOM is required in '%s' if encoded as %s");
> +               const char *advise_msg = _(
> +                       "The file '%s' is missing a byte order mark (BOM). "
> +                       "Please use %sBE or %sLE (depending on the byte order) "
> +                       "as working-tree-encoding.");
> +               advise(advise_msg, path, enc->name, enc->name);
> +               if (conv_flags & CONV_WRITE_OBJECT)
> +                       die(error_msg, path, enc->name);
> +               else
> +                       error(error_msg, path, enc->name);
> +       }

For a function which presumably is agnostic about the working-tree
encoding (supporting whatever iconv does), it nevertheless has
unusually intimate knowledge about UTF BOMs, in general, and the
internals of has_prohibited_utf_bom() and
is_missing_required_utf_bom(), in particular. It might be cleaner, and
would simplify this function, if all this UTF BOM-specific gunk was
moved elsewhere and generalized into a "validate conversion" function.

As this series is already at v8, perhaps such cleanup could be done as
a follow-on series (by someone) rather than re-rolling.

> +       dst = reencode_string_len(src, src_len, default_encoding, enc->name,
> +                                 &dst_len);
> +       if (!dst) {
> +               /*
> +                * We could add the blob "as-is" to Git. However, on checkout
> +                * we would try to reencode to the original encoding. This
> +                * would fail and we would leave the user with a messed-up
> +                * working tree. Let's try to avoid this by screaming loud.
> +                */
> +               const char* msg = _("failed to encode '%s' from %s to %s");
> +               if (conv_flags & CONV_WRITE_OBJECT)
> +                       die(msg, path, enc->name, default_encoding);
> +               else
> +                       error(msg, path, enc->name, default_encoding);
> +       }
> +
> +       strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +       return 1;
> +}
> +
> +static int encode_to_worktree(const char *path, const char *src, size_t src_len,
> +                             struct strbuf *buf, struct encoding *enc)
> +{
> +       [...]
> +       dst = reencode_string_len(src, src_len, enc->name, default_encoding,
> +                                 &dst_len);
> +       if (!dst) {
> +               error("failed to encode '%s' from %s to %s",
> +                       path, enc->name, default_encoding);

The last two arguments need to be swapped.

> +               return 0;
> +       }
> +
> +       strbuf_attach(buf, dst, dst_len, dst_len + 1);
> +       return 1;
> +}
> @@ -978,6 +1083,35 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
> +static struct encoding *git_path_check_encoding(struct attr_check_item *check)
> +{
> +       if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
> +           !strlen(value))
> +               return NULL;
> +
> +       for (enc = encoding; enc; enc = enc->next)
> +               if (!strcasecmp(value, enc->name))
> +                       return enc;
> +
> +       /* Don't encode to the default encoding */
> +       if (!strcasecmp(value, default_encoding))
> +               return NULL;

You could handle this easy-to-detect case before attempting the more
expensive loop just above. (Not necessarily worth a re-roll.)

> +       enc = xcalloc(1, sizeof(*enc));
> +       /*
> +        * Ensure encoding names are always upper case (e.g. UTF-8) to
> +        * simplify subsequent string comparisons.
> +        */
> +       enc->name = xstrdup_toupper(value);
> +       *encoding_tail = enc;
> +       encoding_tail = &(enc->next);
> +
> +       return enc;
> +}
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> @@ -0,0 +1,226 @@
> +test_expect_success 'ensure UTF-8 is stored in Git' '
> +       git cat-file -p :test.utf16 >test.utf16.git &&
> +       test_cmp_bin test.utf8.raw test.utf16.git &&
> +
> +       # cleanup
> +       rm test.utf16.git
> +'

This cleanup won't take place if test_cmp_bin() fails. Instead,
cleanups are typically handled by test_when_finished() to ensure that
the cleanup action occurs even if the test fails.

    test_expect_success 'ensure UTF-8 is stored in Git' '
        test_when_finished "rm -f  test.utf16.git" &&
        ...

Same comment for remaining tests.

> +test_expect_success 'check prohibited UTF BOM' '
> +       printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
> +       printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
> +       printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
> +       printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
> +
> +       printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
> +       printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
> +       printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
> +       printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&

These resources seem to be used by multiple tests. Perhaps create them
in a distinct "setup" test instead of bundling them in this test?

> +       echo "*.utf16be text working-tree-encoding=utf-16be" >>.gitattributes &&
> +       echo "*.utf16le text working-tree-encoding=utf-16le" >>.gitattributes &&
> +       echo "*.utf32be text working-tree-encoding=utf-32be" >>.gitattributes &&
> +       echo "*.utf32le text working-tree-encoding=utf-32le" >>.gitattributes &&
> +
> +       # Here we add a UTF-16 files with BOM (big-endian and little-endian)
> +       # but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
> +       # the BOM is prohibited.
> +       cp bebom.utf16be.raw bebom.utf16be &&
> +       test_must_fail git add bebom.utf16be 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
> +
> +       cp lebom.utf16le.raw lebom.utf16be &&
> +       test_must_fail git add lebom.utf16be 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
> +
> +       cp bebom.utf16be.raw bebom.utf16le &&
> +       test_must_fail git add bebom.utf16le 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
> +
> +       cp lebom.utf16le.raw lebom.utf16le &&
> +       test_must_fail git add lebom.utf16le 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
> +
> +       # ... and the same for UTF-32
> +       cp bebom.utf32be.raw bebom.utf32be &&
> +       test_must_fail git add bebom.utf32be 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
> +
> +       cp lebom.utf32le.raw lebom.utf32be &&
> +       test_must_fail git add lebom.utf32be 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
> +
> +       cp bebom.utf32be.raw bebom.utf32le &&
> +       test_must_fail git add bebom.utf32le 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
> +
> +       cp lebom.utf32le.raw lebom.utf32le &&
> +       test_must_fail git add lebom.utf32le 2>err.out &&
> +       test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
> +
> +       # cleanup
> +       git reset --hard HEAD
> +'

Clumping all these checks into the same test makes it difficult to
determine which one failed (if one does fail). Also, the amount of
copy/paste code is easy to get wrong and a bit onerous to review.
Automating via for-loops would address these concerns. For instance,
to check all combinations (not just 8 combinations tested above):

    for i in 16be 16le 32be 32le
    do
        for j in 16be 16le 32be 32le
        do
            test_expect_success "check prohibited UTF BOM utf$i/utf$j" '
                test_when_finished "git reset --hard HEAD" &&
                cp bebom.utf$i.raw bebom.utf$j &&
                test_must_fail git add bebom.utf$j 2>err.out &&
                J=$(echo $j | tr bel BEL) &&
                test_i18ngrep "fatal: BOM is prohibited .* UTF-$J" err.out
            '
        done
    done

Alternately, the test could be moved to a function and called for each
combination:

    check_prohibited_bom () {
        i=$1
        j=$2
        test_expect_success "check prohibited UTF BOM utf$i/utf$j" '
            ...
        '
    }
    check_prohibited_bom 16be 16be
    check_prohibited_bom 16be 16le
    ...

Same comment regarding copy/paste in tests below.

Probably not worth a re-roll.

> +test_expect_success 'check required UTF BOM' '
> +       echo "*.utf32 text working-tree-encoding=utf-32" >>.gitattributes &&
> +
> +       cp nobom.utf16be.raw nobom.utf16 &&
> +       test_must_fail git add nobom.utf16 2>err.out &&
> +       test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
> +
> +       cp nobom.utf16le.raw nobom.utf16 &&
> +       test_must_fail git add nobom.utf16 2>err.out &&
> +       test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
> +
> +       cp nobom.utf32be.raw nobom.utf32 &&
> +       test_must_fail git add nobom.utf32 2>err.out &&
> +       test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
> +
> +       cp nobom.utf32le.raw nobom.utf32 &&
> +       test_must_fail git add nobom.utf32 2>err.out &&
> +       test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
> +
> +       # cleanup
> +       rm nobom.utf16 nobom.utf32 &&
> +       git reset --hard HEAD
> +'
