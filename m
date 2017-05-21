Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FFB2023D
	for <e@80x24.org>; Sun, 21 May 2017 06:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdEUG6r (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 02:58:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33916 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdEUG6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 02:58:46 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so10918238iol.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9TjQNrm/7mx8FYDhwd+2+FcZh3rUbAV8eSpTl43rZwg=;
        b=IOIpmAD+5EJsTZMcJQlAOmeVOVsNPWaomJGDYtP+GXtYBziOSatvWVC2c3WRS1vuNR
         oyogtujV2CUsRhasa5dJLnpDgJvyNj3DHJd5CuYP8n1VlgaArXJXoQPKWB2JZpCFq7Cl
         gDJ9MhFTTdjPmeWnDGDMZKztU7C5gcO93ldh/J12577cwphns/Rx+WuL9of/lF9M0zYA
         0YHsS7nbC2AS3i26AGk4/b/bzZHcDBSUISt5KsOtg83yZSnooeIC7a6GSyilRDlo7VrR
         c98Gowk+bOcffYJsPeSTfDY0NqMlszCA2scv5w0RdQhCoxYEDYijmEXOIlRVf1Z9Ou0U
         LfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9TjQNrm/7mx8FYDhwd+2+FcZh3rUbAV8eSpTl43rZwg=;
        b=ndZLgFc2eDcOb73Voy6o/ItysXXa9FMLn6vVub3Wz3BRkDwz2uOndAsfJjkLN1onU/
         QCGiopLnrCmp6ntomhpT+ztMFg6sifzSZCjMsx03uEQ1kpSeRC8BHRZak8XRBZ6FDf/H
         mQY0sxedTxjfZJU/H8ck7IxBNiMNalPo/4Rxs3co7voTNDUPz5gsKSBLm87weZz/UYz+
         rjchb+0WM1f60PmPy1ccrRuKtvbykJQwuiJ4orvMDcbRXctbXFZva+0hvwZecNiufj7D
         vZnWMaKBR/k8A7hcHBpwf1wvVaRs0FA9N00TNznKJeHksiKyg9bbLtvbJ5lT9d1OLvMu
         8VZg==
X-Gm-Message-State: AODbwcASJAEACJ0JXCpwd/A6qhSn/XZAtQQ7ICIHekmkbbJcMywlbYrP
        vw3KPfEHwu9w+Neu7j0AHV2bnSgPMw==
X-Received: by 10.107.178.12 with SMTP id b12mr16166056iof.50.1495349925202;
 Sat, 20 May 2017 23:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 20 May 2017 23:58:24 -0700 (PDT)
In-Reply-To: <xmqqlgprqe9j.fsf@gitster.mtv.corp.google.com>
References: <20170520214233.7183-1-avarab@gmail.com> <20170520214233.7183-6-avarab@gmail.com>
 <xmqqlgprqe9j.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 21 May 2017 08:58:24 +0200
Message-ID: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
Subject: Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with --perl-regexp
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 21, 2017 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Make the --regexp-ignore-case option work with --perl-regexp. This
>> never worked, and there was no test for this. Fix the bug and add a
>> test.
>>
>> When PCRE support was added in commit 63e7e9d8b6 ("git-grep: Learn
>> PCRE", 2011-05-09) compile_pcre_regexp() would only check
>> opt->ignore_case, but when the --perl-regexp option was added in
>> commit 727b6fc3ed ("log --grep: accept --basic-regexp and
>> --perl-regexp", 2012-10-03) the code didn't set the opt->ignore_case.
>>
>> Change the test suite to test for -i and --invert-regexp with
>> basic/extended/perl patterns in addition to fixed, which was the only
>> patternType that was tested for before in combination with those
>> options.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  revision.c     |  1 +
>>  t/t4202-log.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
>>  2 files changed, 56 insertions(+), 5 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 8a8c1789c7..4883cdd2d0 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1991,6 +1991,7 @@ static int handle_revision_opt(struct rev_info *re=
vs, int argc, const char **arg
>>       } else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")=
) {
>>               revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYP=
E_ERE;
>>       } else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-=
i")) {
>> +             revs->grep_filter.ignore_case =3D 1;
>>               revs->grep_filter.regflags |=3D REG_ICASE;
>>               DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
>>       } else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) =
{
>
> Looks good.
>
> I however wonder if it is a better approach in the longer term to
> treat the .ignore_case field just like .extended_regexp_option
> field, i.e. not committing immediately to .regflags but commit it
> after config and command line parsing is done, just like we make the
> "BRE? ERE?" decision in grep_commit_pattern_type().

I started hacking up a patch to fix the root cause of this, i.e. the
users of the grep API should only set `.ignore_case =3D 1` and not care
about setting regflags, but it was more than a trivial change, so I
didn't include it in this series:

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..be28c37265 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1151,8 +1151,6 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)

        if (!opt.pattern_list)
                die(_("no pattern given."));
-       if (!opt.fixed && opt.ignore_case)
-               opt.regflags |=3D REG_ICASE;

        compile_grep_patterns(&opt);

diff --git a/grep.c b/grep.c
index 47cee45067..7b13ee1043 100644
--- a/grep.c
+++ b/grep.c
@@ -435,12 +435,11 @@ static void compile_fixed_regexp(struct grep_pat
*p, struct grep_opt *opt)

 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-       int icase, ascii_only;
+       int ascii_only;
        int err;

        p->word_regexp =3D opt->word_regexp;
        p->ignore_case =3D opt->ignore_case;
-       icase          =3D opt->regflags & REG_ICASE || p->ignore_case;
        ascii_only     =3D !has_non_ascii(p->pattern);

        /*
@@ -456,12 +455,12 @@ static void compile_regexp(struct grep_pat *p,
struct grep_opt *opt)
         * want to use kws.
         */
        if (opt->fixed || is_fixed(p->pattern, p->patternlen))
-               p->fixed =3D !icase || ascii_only;
+               p->fixed =3D !p->ignore_case || ascii_only;
        else
                p->fixed =3D 0;

        if (p->fixed) {
-               p->kws =3D kwsalloc(icase ? tolower_trans_tbl : NULL);
+               p->kws =3D kwsalloc(p->ignore_case ? tolower_trans_tbl : NU=
LL);
                kwsincr(p->kws, p->pattern, p->patternlen);
                kwsprep(p->kws);
                return;
@@ -480,6 +479,8 @@ static void compile_regexp(struct grep_pat *p,
struct grep_opt *opt)
                return;
        }

+       if (p->ignore_case)
+               opt->regflags |=3D REG_ICASE;
        err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
        if (err) {
                char errbuf[1024];
diff --git a/revision.c b/revision.c
index 4883cdd2d0..30c23a1098 100644
--- a/revision.c
+++ b/revision.c
@@ -1992,7 +1992,6 @@ static int handle_revision_opt(struct rev_info
*revs, int argc, const char **arg
                revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYPE=
_ERE;
        } else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i=
")) {
                revs->grep_filter.ignore_case =3D 1;
-               revs->grep_filter.regflags |=3D REG_ICASE;
                DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
        } else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
                revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYPE=
_FIXED;

But an even better solution is to get rid of passing the regflags
field in grep_opt entirely, this conflicts with some of my later
patches:

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..be28c37265 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1151,8 +1151,6 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)

        if (!opt.pattern_list)
                die(_("no pattern given."));
-       if (!opt.fixed && opt.ignore_case)
-               opt.regflags |=3D REG_ICASE;

        compile_grep_patterns(&opt);
diff --git a/grep.c b/grep.c
index 47cee45067..1bde7037ba 100644
--- a/grep.c
+++ b/grep.c
@@ -34,7 +34,6 @@ void init_grep_defaults(void)
        memset(opt, 0, sizeof(*opt));
        opt->relative =3D 1;
        opt->pathname =3D 1;
-       opt->regflags =3D REG_NEWLINE;
        opt->max_depth =3D -1;
        opt->pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED;
        opt->extended_regexp_option =3D 0;
@@ -156,7 +155,6 @@ void grep_init(struct grep_opt *opt, const char *prefix=
)
        opt->linenum =3D def->linenum;
        opt->max_depth =3D def->max_depth;
        opt->pathname =3D def->pathname;
-       opt->regflags =3D def->regflags;
        opt->relative =3D def->relative;
        opt->output =3D def->output;

@@ -179,25 +177,25 @@ static void grep_set_pattern_type_option(enum
grep_pattern_type pattern_type, st
        case GREP_PATTERN_TYPE_BRE:
                opt->fixed =3D 0;
                opt->pcre =3D 0;
-               opt->regflags &=3D ~REG_EXTENDED;
+               opt->extended =3D 0;
                break;
         case GREP_PATTERN_TYPE_ERE:
                opt->fixed =3D 0;
                opt->pcre =3D 0;
-               opt->regflags |=3D REG_EXTENDED;
+               opt->extended =3D 1;
                break;

        case GREP_PATTERN_TYPE_FIXED:
                opt->fixed =3D 1;
                opt->pcre =3D 0;
-               opt->regflags &=3D ~REG_EXTENDED;
+               opt->extended =3D 0;
                break;

        case GREP_PATTERN_TYPE_PCRE:
                opt->fixed =3D 0;
                opt->pcre =3D 1;
-               opt->regflags &=3D ~REG_EXTENDED;
+               opt->extended =3D 0;
                break;
        }
 }
@@ -415,10 +413,9 @@ static void compile_fixed_regexp(struct grep_pat
*p, struct grep_opt *opt)
 {
        struct strbuf sb =3D STRBUF_INIT;
        int err;
-       int regflags;
+       int regflags =3D REG_NEWLINE;

        basic_regex_quote_buf(&sb, p->pattern);
-       regflags =3D opt->regflags & ~REG_EXTENDED;
        if (opt->ignore_case)
                regflags |=3D REG_ICASE;
        err =3D regcomp(&p->regexp, sb.buf, regflags);
@@ -435,12 +432,12 @@ static void compile_fixed_regexp(struct grep_pat
*p, struct grep_opt *opt)

 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-       int icase, ascii_only;
+       int ascii_only;
        int err;
+       int regflags =3D REG_NEWLINE;

        p->word_regexp =3D opt->word_regexp;
        p->ignore_case =3D opt->ignore_case;
-       icase          =3D opt->regflags & REG_ICASE || p->ignore_case;
        ascii_only     =3D !has_non_ascii(p->pattern);

        /*
@@ -456,12 +453,12 @@ static void compile_regexp(struct grep_pat *p,
struct grep_opt *opt)
         * want to use kws.
         */
        if (opt->fixed || is_fixed(p->pattern, p->patternlen))
-               p->fixed =3D !icase || ascii_only;
+               p->fixed =3D !p->ignore_case || ascii_only;
        else
                p->fixed =3D 0;

        if (p->fixed) {
-               p->kws =3D kwsalloc(icase ? tolower_trans_tbl : NULL);
+               p->kws =3D kwsalloc(p->ignore_case ? tolower_trans_tbl : NU=
LL);
                kwsincr(p->kws, p->pattern, p->patternlen);
                kwsprep(p->kws);
                return;
@@ -480,7 +477,11 @@ static void compile_regexp(struct grep_pat *p,
struct grep_opt *opt)
                return;
        }

-       err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
+       if (p->ignore_case)
+               regflags |=3D REG_ICASE;
+       if (opt->extended)
+               regflags |=3D REG_EXTENDED;
+       err =3D regcomp(&p->regexp, p->pattern, regflags);
        if (err) {
                char errbuf[1024];
                regerror(err, &p->regexp, errbuf, 1024);
diff --git a/grep.h b/grep.h
index 267534ca24..d9d603deb1 100644
--- a/grep.h
+++ b/grep.h
@@ -129,7 +129,6 @@ struct grep_opt {
        char color_match_selected[COLOR_MAXLEN];
        char color_selected[COLOR_MAXLEN];
        char color_sep[COLOR_MAXLEN];
-       int regflags;
        unsigned pre_context;
        unsigned post_context;
        unsigned last_shown;
diff --git a/revision.c b/revision.c
index 4883cdd2d0..67240d38af 100644
--- a/revision.c
+++ b/revision.c
@@ -1362,7 +1362,6 @@ void init_revisions(struct rev_info *revs, const
char *prefix)
        init_grep_defaults();
        grep_init(&revs->grep_filter, prefix);
        revs->grep_filter.status_only =3D 1;
-       revs->grep_filter.regflags =3D REG_NEWLINE;

        diff_setup(&revs->diffopt);
        if (prefix && !revs->diffopt.prefix) {
@@ -1992,7 +1991,6 @@ static int handle_revision_opt(struct rev_info
*revs, int argc, const char **arg
                revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYPE=
_ERE;
        } else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i=
")) {
                revs->grep_filter.ignore_case =3D 1;
-               revs->grep_filter.regflags |=3D REG_ICASE;
                DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
        } else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
                revs->grep_filter.pattern_type_option =3D GREP_PATTERN_TYPE=
_FIXED;

But as all this code cleanup isn't needed for fixing this bug, and I'd
really like to get this series merged into next/master ASAP so I can
start submitting the grep/pcre patches that are actually interesting,
let's leave this orthogonal code cleanup for now.
