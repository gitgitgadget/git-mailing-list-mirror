From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/5] Import wildmatch from rsync
Date: Tue, 2 Oct 2012 16:07:00 +0200
Message-ID: <CACBZZX6CLZAcUG2GjBt4brF9dGr1Zvj1HMTV=U-AXFZhzR=39Q@mail.gmail.com>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com> <1348658741-8146-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Wayne Davison <wayned@samba.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 16:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ38J-000640-22
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 16:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab2JBOHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 10:07:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38384 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab2JBOHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 10:07:21 -0400
Received: by oagh16 with SMTP id h16so6240042oag.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EK6O33PHwGagWVd4vpbWAWSQE/hcZbd6CN82m6e7bSY=;
        b=l1QAHxrAQ/fEue8V9rBmTdZ4M0ucxt7hdd3aEdtGp2uJBuY0/jwzRjOQvB8/FCpDNI
         Da8rKIFXg5uD1tw83HBg2NkNHj+9CzWsbJ+kkxOBw1UliuH3DCQpqURye9V1C8yFz5V2
         S3yopaZYYFBErBclduu0809kJguzLCTR9lD8QDmUxeFEiVk5EGO/OHPXP8o4H+c3ze7F
         1G4tspoh1goyojHbYbeD+AiUn27R1L0+3rfWBHB6wLnwQxBRW95KVoNUmKnfTX3oid9W
         jTx0i/ZeTB1Z2GZyTvqvOk8DTzL3CVKhog2074JROfCmdUhyLDt/bctWqEuJrH+7jxpL
         913A==
Received: by 10.182.0.1 with SMTP id 1mr14181892oba.18.1349186840475; Tue, 02
 Oct 2012 07:07:20 -0700 (PDT)
Received: by 10.60.34.226 with HTTP; Tue, 2 Oct 2012 07:07:00 -0700 (PDT)
In-Reply-To: <1348658741-8146-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206797>

On Wed, Sep 26, 2012 at 1:25 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> These files are from rsync.git commit
> f92f5b166e3019db42bc7fe1aa2f1a9178cd215d, which was the last commit
> before rsync turned GPL-3. All files are imported as-is and
> no-op. Adaptation is done in a separate patch.

Perhaps Wayne Davison (added to CC) wouldn't mind giving us permission
to use the subsequent changes to these files under the GPLv2?

rsync.git $ git --no-pager log --pretty=3D"%h %an %s\n" --reverse
f92f5b166e3019db42bc7fe1aa2f1a9178cd215d.. -- '*wild*'
4fd842f Wayne Davison Switching to GPL 3.\n
8e41b68 Wayne Davison Tweaking the license text a bit more.\n
d3d07a5 Wayne Davison Include 2008 in the copyright years.\n
adc2476 Wayne Davison Output numbers in 3-digit groups by default
(e.g. 1,234,567). Also improved the human-readable output functions,
including adding the ability to output negative numbers.\n
b3bf9b9 Wayne Davison Update the copyright year.\n
fd91c3b Wayne Davison Fix two unused-variable compiler warnings.\n


>
> rsync.git           ->  git.git
> lib/wildmatch.[ch]      wildmatch.[ch]
> wildtest.c              test-wildmatch.c
> wildtest.txt            t/t3070/wildtest.txt
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3070/wildtest.txt | 165 +++++++++++++++++++++++
>  test-wildmatch.c     | 222 +++++++++++++++++++++++++++++++
>  wildmatch.c          | 368 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  wildmatch.h          |   6 +
>  4 files changed, 761 insertions(+)
>  create mode 100644 t/t3070/wildtest.txt
>  create mode 100644 test-wildmatch.c
>  create mode 100644 wildmatch.c
>  create mode 100644 wildmatch.h
>
> diff --git a/t/t3070/wildtest.txt b/t/t3070/wildtest.txt
> new file mode 100644
> index 0000000..42c1678
> --- /dev/null
> +++ b/t/t3070/wildtest.txt
> @@ -0,0 +1,165 @@
> +# Input is in the following format (all items white-space separated)=
:
> +#
> +# The first two items are 1 or 0 indicating if the wildmat call is e=
xpected to
> +# succeed and if fnmatch works the same way as wildmat, respectively=
=2E  After
> +# that is a text string for the match, and a pattern string.  String=
s can be
> +# quoted (if desired) in either double or single quotes, as well as =
backticks.
> +#
> +# MATCH FNMATCH_SAME "text to match" 'pattern to use'
> +
> +# Basic wildmat features
> +1 1 foo                        foo
> +0 1 foo                        bar
> +1 1 ''                 ""
> +1 1 foo                        ???
> +0 1 foo                        ??
> +1 1 foo                        *
> +1 1 foo                        f*
> +0 1 foo                        *f
> +1 1 foo                        *foo*
> +1 1 foobar             *ob*a*r*
> +1 1 aaaaaaabababab     *ab
> +1 1 foo*               foo\*
> +0 1 foobar             foo\*bar
> +1 1 f\oo               f\\oo
> +1 1 ball               *[al]?
> +0 1 ten                        [ten]
> +1 1 ten                        **[!te]
> +0 1 ten                        **[!ten]
> +1 1 ten                        t[a-g]n
> +0 1 ten                        t[!a-g]n
> +1 1 ton                        t[!a-g]n
> +1 1 ton                        t[^a-g]n
> +1 1 a]b                        a[]]b
> +1 1 a-b                        a[]-]b
> +1 1 a]b                        a[]-]b
> +0 1 aab                        a[]-]b
> +1 1 aab                        a[]a-]b
> +1 1 ]                  ]
> +
> +# Extended slash-matching features
> +0 1 foo/baz/bar                foo*bar
> +1 1 foo/baz/bar                foo**bar
> +0 1 foo/bar            foo?bar
> +0 1 foo/bar            foo[/]bar
> +0 1 foo/bar            f[^eiu][^eiu][^eiu][^eiu][^eiu]r
> +1 1 foo-bar            f[^eiu][^eiu][^eiu][^eiu][^eiu]r
> +0 1 foo                        **/foo
> +1 1 /foo               **/foo
> +1 1 bar/baz/foo                **/foo
> +0 1 bar/baz/foo                */foo
> +0 0 foo/bar/baz                **/bar*
> +1 1 deep/foo/bar/baz   **/bar/*
> +0 1 deep/foo/bar/baz/  **/bar/*
> +1 1 deep/foo/bar/baz/  **/bar/**
> +0 1 deep/foo/bar       **/bar/*
> +1 1 deep/foo/bar/      **/bar/**
> +1 1 foo/bar/baz                **/bar**
> +1 1 foo/bar/baz/x      */bar/**
> +0 0 deep/foo/bar/baz/x */bar/**
> +1 1 deep/foo/bar/baz/x **/bar/*/*
> +
> +# Various additional tests
> +0 1 acrt               a[c-c]st
> +1 1 acrt               a[c-c]rt
> +0 1 ]                  [!]-]
> +1 1 a                  [!]-]
> +0 1 ''                 \
> +0 1 \                  \
> +0 1 /\                 */\
> +1 1 /\                 */\\
> +1 1 foo                        foo
> +1 1 @foo               @foo
> +0 1 foo                        @foo
> +1 1 [ab]               \[ab]
> +1 1 [ab]               [[]ab]
> +1 1 [ab]               [[:]ab]
> +0 1 [ab]               [[::]ab]
> +1 1 [ab]               [[:digit]ab]
> +1 1 [ab]               [\[:]ab]
> +1 1 ?a?b               \??\?b
> +1 1 abc                        \a\b\c
> +0 1 foo                        ''
> +1 1 foo/bar/baz/to     **/t[o]
> +
> +# Character class tests
> +1 1 a1B                [[:alpha:]][[:digit:]][[:upper:]]
> +0 1 a          [[:digit:][:upper:][:space:]]
> +1 1 A          [[:digit:][:upper:][:space:]]
> +1 1 1          [[:digit:][:upper:][:space:]]
> +0 1 1          [[:digit:][:upper:][:spaci:]]
> +1 1 ' '                [[:digit:][:upper:][:space:]]
> +0 1 .          [[:digit:][:upper:][:space:]]
> +1 1 .          [[:digit:][:punct:][:space:]]
> +1 1 5          [[:xdigit:]]
> +1 1 f          [[:xdigit:]]
> +1 1 D          [[:xdigit:]]
> +1 1 _          [[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph=
:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
> +#1 1 =E2=80=A6         [^[:alnum:][:alpha:][:blank:][:cntrl:][:digit=
:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
> +1 1            [^[:alnum:][:alpha:][:blank:][:digit:][:graph:][:lowe=
r:][:print:][:punct:][:space:][:upper:][:xdigit:]]
> +1 1 .          [^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lowe=
r:][:space:][:upper:][:xdigit:]]
> +1 1 5          [a-c[:digit:]x-z]
> +1 1 b          [a-c[:digit:]x-z]
> +1 1 y          [a-c[:digit:]x-z]
> +0 1 q          [a-c[:digit:]x-z]
> +
> +# Additional tests, including some malformed wildmats
> +1 1 ]          [\\-^]
> +0 1 [          [\\-^]
> +1 1 -          [\-_]
> +1 1 ]          [\]]
> +0 1 \]         [\]]
> +0 1 \          [\]]
> +0 1 ab         a[]b
> +0 1 a[]b       a[]b
> +0 1 ab[                ab[
> +0 1 ab         [!
> +0 1 ab         [-
> +1 1 -          [-]
> +0 1 -          [a-
> +0 1 -          [!a-
> +1 1 -          [--A]
> +1 1 5          [--A]
> +1 1 ' '                '[ --]'
> +1 1 $          '[ --]'
> +1 1 -          '[ --]'
> +0 1 0          '[ --]'
> +1 1 -          [---]
> +1 1 -          [------]
> +0 1 j          [a-e-n]
> +1 1 -          [a-e-n]
> +1 1 a          [!------]
> +0 1 [          []-a]
> +1 1 ^          []-a]
> +0 1 ^          [!]-a]
> +1 1 [          [!]-a]
> +1 1 ^          [a^bc]
> +1 1 -b]                [a-]b]
> +0 1 \          [\]
> +1 1 \          [\\]
> +0 1 \          [!\\]
> +1 1 G          [A-\\]
> +0 1 aaabbb     b*a
> +0 1 aabcaa     *ba*
> +1 1 ,          [,]
> +1 1 ,          [\\,]
> +1 1 \          [\\,]
> +1 1 -          [,-.]
> +0 1 +          [,-.]
> +0 1 -.]                [,-.]
> +1 1 2          [\1-\3]
> +1 1 3          [\1-\3]
> +0 1 4          [\1-\3]
> +1 1 \          [[-\]]
> +1 1 [          [[-\]]
> +1 1 ]          [[-\]]
> +0 1 -          [[-\]]
> +
> +# Test recursion and the abort code (use "wildtest -i" to see iterat=
ion counts)
> +1 1 -adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1  -*-*-=
*-*-*-*-12-*-*-*-m-*-*-*
> +0 1 -adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1  -*-*-=
*-*-*-*-12-*-*-*-m-*-*-*
> +0 1 -adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1  -*-*-=
*-*-*-*-12-*-*-*-m-*-*-*
> +1 1 /adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1  /*/*/=
*/*/*/*/12/*/*/*/m/*/*/*
> +0 1 /adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1  /*/*/=
*/*/*/*/12/*/*/*/m/*/*/*
> +1 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt              **/*a=
*b*g*n*t
> +0 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz             **/*a=
*b*g*n*t
> diff --git a/test-wildmatch.c b/test-wildmatch.c
> new file mode 100644
> index 0000000..88585c2
> --- /dev/null
> +++ b/test-wildmatch.c
> @@ -0,0 +1,222 @@
> +/*
> + * Test suite for the wildmatch code.
> + *
> + * Copyright (C) 2003-2009 Wayne Davison
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, visit the http://fsf.org website.
> + */
> +
> +/*#define COMPARE_WITH_FNMATCH*/
> +
> +#define WILD_TEST_ITERATIONS
> +#include "lib/wildmatch.c"
> +
> +#include <popt.h>
> +
> +#ifdef COMPARE_WITH_FNMATCH
> +#include <fnmatch.h>
> +
> +int fnmatch_errors =3D 0;
> +#endif
> +
> +int wildmatch_errors =3D 0;
> +char number_separator =3D ',';
> +
> +typedef char bool;
> +
> +int output_iterations =3D 0;
> +int explode_mod =3D 0;
> +int empties_mod =3D 0;
> +int empty_at_start =3D 0;
> +int empty_at_end =3D 0;
> +
> +static struct poptOption long_options[] =3D {
> +  /* longName, shortName, argInfo, argPtr, value, descrip, argDesc *=
/
> +  {"iterations",     'i', POPT_ARG_NONE,   &output_iterations, 0, 0,=
 0},
> +  {"empties",        'e', POPT_ARG_STRING, 0, 'e', 0, 0},
> +  {"explode",        'x', POPT_ARG_INT,    &explode_mod, 0, 0, 0},
> +  {0,0,0,0, 0, 0, 0}
> +};
> +
> +/* match just at the start of string (anchored tests) */
> +static void
> +run_test(int line, bool matches,
> +#ifdef COMPARE_WITH_FNMATCH
> +        bool same_as_fnmatch,
> +#endif
> +        const char *text, const char *pattern)
> +{
> +    bool matched;
> +#ifdef COMPARE_WITH_FNMATCH
> +    bool fn_matched;
> +    int flags =3D strstr(pattern, "**")? 0 : FNM_PATHNAME;
> +#endif
> +
> +    if (explode_mod) {
> +       char buf[MAXPATHLEN*2], *texts[MAXPATHLEN];
> +       int pos =3D 0, cnt =3D 0, ndx =3D 0, len =3D strlen(text);
> +
> +       if (empty_at_start)
> +           texts[ndx++] =3D "";
> +       /* An empty string must turn into at least one empty array it=
em. */
> +       while (1) {
> +           texts[ndx] =3D buf + ndx * (explode_mod + 1);
> +           strlcpy(texts[ndx++], text + pos, explode_mod + 1);
> +           if (pos + explode_mod >=3D len)
> +               break;
> +           pos +=3D explode_mod;
> +           if (!(++cnt % empties_mod))
> +               texts[ndx++] =3D "";
> +       }
> +       if (empty_at_end)
> +           texts[ndx++] =3D "";
> +       texts[ndx] =3D NULL;
> +       matched =3D wildmatch_array(pattern, (const char**)texts, 0);
> +    } else
> +       matched =3D wildmatch(pattern, text);
> +#ifdef COMPARE_WITH_FNMATCH
> +    fn_matched =3D !fnmatch(pattern, text, flags);
> +#endif
> +    if (matched !=3D matches) {
> +       printf("wildmatch failure on line %d:\n  %s\n  %s\n  expected=
 %s match\n",
> +              line, text, pattern, matches? "a" : "NO");
> +       wildmatch_errors++;
> +    }
> +#ifdef COMPARE_WITH_FNMATCH
> +    if (fn_matched !=3D (matches ^ !same_as_fnmatch)) {
> +       printf("fnmatch disagreement on line %d:\n  %s\n  %s\n  expec=
ted %s match\n",
> +              line, text, pattern, matches ^ !same_as_fnmatch? "a" :=
 "NO");
> +       fnmatch_errors++;
> +    }
> +#endif
> +    if (output_iterations) {
> +       printf("%d: \"%s\" iterations =3D %d\n", line, pattern,
> +              wildmatch_iteration_count);
> +    }
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +    char buf[2048], *s, *string[2], *end[2];
> +    const char *arg;
> +    FILE *fp;
> +    int opt, line, i, flag[2];
> +    poptContext pc =3D poptGetContext("wildtest", argc, (const char*=
*)argv,
> +                                   long_options, 0);
> +
> +    while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> +       switch (opt) {
> +         case 'e':
> +           arg =3D poptGetOptArg(pc);
> +           empties_mod =3D atoi(arg);
> +           if (strchr(arg, 's'))
> +               empty_at_start =3D 1;
> +           if (strchr(arg, 'e'))
> +               empty_at_end =3D 1;
> +           if (!explode_mod)
> +               explode_mod =3D 1024;
> +           break;
> +         default:
> +           fprintf(stderr, "%s: %s\n",
> +                   poptBadOption(pc, POPT_BADOPTION_NOALIAS),
> +                   poptStrerror(opt));
> +           exit(1);
> +       }
> +    }
> +
> +    if (explode_mod && !empties_mod)
> +       empties_mod =3D 1024;
> +
> +    argv =3D (char**)poptGetArgs(pc);
> +    if (!argv || argv[1]) {
> +       fprintf(stderr, "Usage: wildtest [OPTIONS] TESTFILE\n");
> +       exit(1);
> +    }
> +
> +    if ((fp =3D fopen(*argv, "r")) =3D=3D NULL) {
> +       fprintf(stderr, "Unable to open %s\n", *argv);
> +       exit(1);
> +    }
> +
> +    line =3D 0;
> +    while (fgets(buf, sizeof buf, fp)) {
> +       line++;
> +       if (*buf =3D=3D '#' || *buf =3D=3D '\n')
> +           continue;
> +       for (s =3D buf, i =3D 0; i <=3D 1; i++) {
> +           if (*s =3D=3D '1')
> +               flag[i] =3D 1;
> +           else if (*s =3D=3D '0')
> +               flag[i] =3D 0;
> +           else
> +               flag[i] =3D -1;
> +           if (*++s !=3D ' ' && *s !=3D '\t')
> +               flag[i] =3D -1;
> +           if (flag[i] < 0) {
> +               fprintf(stderr, "Invalid flag syntax on line %d of %s=
:\n%s",
> +                       line, *argv, buf);
> +               exit(1);
> +           }
> +           while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
> +       }
> +       for (i =3D 0; i <=3D 1; i++) {
> +           if (*s =3D=3D '\'' || *s =3D=3D '"' || *s =3D=3D '`') {
> +               char quote =3D *s++;
> +               string[i] =3D s;
> +               while (*s && *s !=3D quote) s++;
> +               if (!*s) {
> +                   fprintf(stderr, "Unmatched quote on line %d of %s=
:\n%s",
> +                           line, *argv, buf);
> +                   exit(1);
> +               }
> +               end[i] =3D s;
> +           }
> +           else {
> +               if (!*s || *s =3D=3D '\n') {
> +                   fprintf(stderr, "Not enough strings on line %d of=
 %s:\n%s",
> +                           line, *argv, buf);
> +                   exit(1);
> +               }
> +               string[i] =3D s;
> +               while (*++s && *s !=3D ' ' && *s !=3D '\t' && *s !=3D=
 '\n') {}
> +               end[i] =3D s;
> +           }
> +           while (*++s =3D=3D ' ' || *s =3D=3D '\t') {}
> +       }
> +       *end[0] =3D *end[1] =3D '\0';
> +       run_test(line, flag[0],
> +#ifdef COMPARE_WITH_FNMATCH
> +                flag[1],
> +#endif
> +                string[0], string[1]);
> +    }
> +
> +    if (!wildmatch_errors)
> +       fputs("No", stdout);
> +    else
> +       printf("%d", wildmatch_errors);
> +    printf(" wildmatch error%s found.\n", wildmatch_errors =3D=3D 1?=
 "" : "s");
> +
> +#ifdef COMPARE_WITH_FNMATCH
> +    if (!fnmatch_errors)
> +       fputs("No", stdout);
> +    else
> +       printf("%d", fnmatch_errors);
> +    printf(" fnmatch error%s found.\n", fnmatch_errors =3D=3D 1? "" =
: "s");
> +
> +#endif
> +
> +    return 0;
> +}
> diff --git a/wildmatch.c b/wildmatch.c
> new file mode 100644
> index 0000000..f3a1731
> --- /dev/null
> +++ b/wildmatch.c
> @@ -0,0 +1,368 @@
> +/*
> +**  Do shell-style pattern matching for ?, \, [], and * characters.
> +**  It is 8bit clean.
> +**
> +**  Written by Rich $alz, mirror!rs, Wed Nov 26 19:03:17 EST 1986.
> +**  Rich $alz is now <rsalz@bbn.com>.
> +**
> +**  Modified by Wayne Davison to special-case '/' matching, to make =
'**'
> +**  work differently than '*', and to fix the character-class code.
> +*/
> +
> +#include "rsync.h"
> +
> +/* What character marks an inverted character class? */
> +#define NEGATE_CLASS   '!'
> +#define NEGATE_CLASS2  '^'
> +
> +#define FALSE 0
> +#define TRUE 1
> +#define ABORT_ALL -1
> +#define ABORT_TO_STARSTAR -2
> +
> +#define CC_EQ(class, len, litmatch) ((len) =3D=3D sizeof (litmatch)-=
1 \
> +                                   && *(class) =3D=3D *(litmatch) \
> +                                   && strncmp((char*)class, litmatch=
, len) =3D=3D 0)
> +
> +#if defined STDC_HEADERS || !defined isascii
> +# define ISASCII(c) 1
> +#else
> +# define ISASCII(c) isascii(c)
> +#endif
> +
> +#ifdef isblank
> +# define ISBLANK(c) (ISASCII(c) && isblank(c))
> +#else
> +# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
> +#endif
> +
> +#ifdef isgraph
> +# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> +#else
> +# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
> +#endif
> +
> +#define ISPRINT(c) (ISASCII(c) && isprint(c))
> +#define ISDIGIT(c) (ISASCII(c) && isdigit(c))
> +#define ISALNUM(c) (ISASCII(c) && isalnum(c))
> +#define ISALPHA(c) (ISASCII(c) && isalpha(c))
> +#define ISCNTRL(c) (ISASCII(c) && iscntrl(c))
> +#define ISLOWER(c) (ISASCII(c) && islower(c))
> +#define ISPUNCT(c) (ISASCII(c) && ispunct(c))
> +#define ISSPACE(c) (ISASCII(c) && isspace(c))
> +#define ISUPPER(c) (ISASCII(c) && isupper(c))
> +#define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
> +
> +#ifdef WILD_TEST_ITERATIONS
> +int wildmatch_iteration_count;
> +#endif
> +
> +static int force_lower_case =3D 0;
> +
> +/* Match pattern "p" against the a virtually-joined string consistin=
g
> + * of "text" and any strings in array "a". */
> +static int dowild(const uchar *p, const uchar *text, const uchar*con=
st *a)
> +{
> +    uchar p_ch;
> +
> +#ifdef WILD_TEST_ITERATIONS
> +    wildmatch_iteration_count++;
> +#endif
> +
> +    for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
> +       int matched, special;
> +       uchar t_ch, prev_ch;
> +       while ((t_ch =3D *text) =3D=3D '\0') {
> +           if (*a =3D=3D NULL) {
> +               if (p_ch !=3D '*')
> +                   return ABORT_ALL;
> +               break;
> +           }
> +           text =3D *a++;
> +       }
> +       if (force_lower_case && ISUPPER(t_ch))
> +           t_ch =3D tolower(t_ch);
> +       switch (p_ch) {
> +         case '\\':
> +           /* Literal match with following character.  Note that the=
 test
> +            * in "default" handles the p[1] =3D=3D '\0' failure case=
=2E */
> +           p_ch =3D *++p;
> +           /* FALLTHROUGH */
> +         default:
> +           if (t_ch !=3D p_ch)
> +               return FALSE;
> +           continue;
> +         case '?':
> +           /* Match anything but '/'. */
> +           if (t_ch =3D=3D '/')
> +               return FALSE;
> +           continue;
> +         case '*':
> +           if (*++p =3D=3D '*') {
> +               while (*++p =3D=3D '*') {}
> +               special =3D TRUE;
> +           } else
> +               special =3D FALSE;
> +           if (*p =3D=3D '\0') {
> +               /* Trailing "**" matches everything.  Trailing "*" ma=
tches
> +                * only if there are no more slash characters. */
> +               if (!special) {
> +                   do {
> +                       if (strchr((char*)text, '/') !=3D NULL)
> +                           return FALSE;
> +                   } while ((text =3D *a++) !=3D NULL);
> +               }
> +               return TRUE;
> +           }
> +           while (1) {
> +               if (t_ch =3D=3D '\0') {
> +                   if ((text =3D *a++) =3D=3D NULL)
> +                       break;
> +                   t_ch =3D *text;
> +                   continue;
> +               }
> +               if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
> +                   if (!special || matched !=3D ABORT_TO_STARSTAR)
> +                       return matched;
> +               } else if (!special && t_ch =3D=3D '/')
> +                   return ABORT_TO_STARSTAR;
> +               t_ch =3D *++text;
> +           }
> +           return ABORT_ALL;
> +         case '[':
> +           p_ch =3D *++p;
> +#ifdef NEGATE_CLASS2
> +           if (p_ch =3D=3D NEGATE_CLASS2)
> +               p_ch =3D NEGATE_CLASS;
> +#endif
> +           /* Assign literal TRUE/FALSE because of "matched" compari=
son. */
> +           special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
> +           if (special) {
> +               /* Inverted character class. */
> +               p_ch =3D *++p;
> +           }
> +           prev_ch =3D 0;
> +           matched =3D FALSE;
> +           do {
> +               if (!p_ch)
> +                   return ABORT_ALL;
> +               if (p_ch =3D=3D '\\') {
> +                   p_ch =3D *++p;
> +                   if (!p_ch)
> +                       return ABORT_ALL;
> +                   if (t_ch =3D=3D p_ch)
> +                       matched =3D TRUE;
> +               } else if (p_ch =3D=3D '-' && prev_ch && p[1] && p[1]=
 !=3D ']') {
> +                   p_ch =3D *++p;
> +                   if (p_ch =3D=3D '\\') {
> +                       p_ch =3D *++p;
> +                       if (!p_ch)
> +                           return ABORT_ALL;
> +                   }
> +                   if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
> +                       matched =3D TRUE;
> +                   p_ch =3D 0; /* This makes "prev_ch" get set to 0.=
 */
> +               } else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
> +                   const uchar *s;
> +                   int i;
> +                   for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D '=
]'; p++) {} /*SHARED ITERATOR*/
> +                   if (!p_ch)
> +                       return ABORT_ALL;
> +                   i =3D p - s - 1;
> +                   if (i < 0 || p[-1] !=3D ':') {
> +                       /* Didn't find ":]", so treat like a normal s=
et. */
> +                       p =3D s - 2;
> +                       p_ch =3D '[';
> +                       if (t_ch =3D=3D p_ch)
> +                           matched =3D TRUE;
> +                       continue;
> +                   }
> +                   if (CC_EQ(s,i, "alnum")) {
> +                       if (ISALNUM(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "alpha")) {
> +                       if (ISALPHA(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "blank")) {
> +                       if (ISBLANK(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "cntrl")) {
> +                       if (ISCNTRL(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "digit")) {
> +                       if (ISDIGIT(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "graph")) {
> +                       if (ISGRAPH(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "lower")) {
> +                       if (ISLOWER(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "print")) {
> +                       if (ISPRINT(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "punct")) {
> +                       if (ISPUNCT(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "space")) {
> +                       if (ISSPACE(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "upper")) {
> +                       if (ISUPPER(t_ch))
> +                           matched =3D TRUE;
> +                   } else if (CC_EQ(s,i, "xdigit")) {
> +                       if (ISXDIGIT(t_ch))
> +                           matched =3D TRUE;
> +                   } else /* malformed [:class:] string */
> +                       return ABORT_ALL;
> +                   p_ch =3D 0; /* This makes "prev_ch" get set to 0.=
 */
> +               } else if (t_ch =3D=3D p_ch)
> +                   matched =3D TRUE;
> +           } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
> +           if (matched =3D=3D special || t_ch =3D=3D '/')
> +               return FALSE;
> +           continue;
> +       }
> +    }
> +
> +    do {
> +       if (*text)
> +           return FALSE;
> +    } while ((text =3D *a++) !=3D NULL);
> +
> +    return TRUE;
> +}
> +
> +/* Match literal string "s" against the a virtually-joined string co=
nsisting
> + * of "text" and any strings in array "a". */
> +static int doliteral(const uchar *s, const uchar *text, const uchar*=
const *a)
> +{
> +    for ( ; *s !=3D '\0'; text++, s++) {
> +       while (*text =3D=3D '\0') {
> +           if ((text =3D *a++) =3D=3D NULL)
> +               return FALSE;
> +       }
> +       if (*text !=3D *s)
> +           return FALSE;
> +    }
> +
> +    do {
> +       if (*text)
> +           return FALSE;
> +    } while ((text =3D *a++) !=3D NULL);
> +
> +    return TRUE;
> +}
> +
> +/* Return the last "count" path elements from the concatenated strin=
g.
> + * We return a string pointer to the start of the string, and update=
 the
> + * array pointer-pointer to point to any remaining string elements. =
*/
> +static const uchar *trailing_N_elements(const uchar*const **a_ptr, i=
nt count)
> +{
> +    const uchar*const *a =3D *a_ptr;
> +    const uchar*const *first_a =3D a;
> +
> +    while (*a)
> +           a++;
> +
> +    while (a !=3D first_a) {
> +       const uchar *s =3D *--a;
> +       s +=3D strlen((char*)s);
> +       while (--s >=3D *a) {
> +           if (*s =3D=3D '/' && !--count) {
> +               *a_ptr =3D a+1;
> +               return s+1;
> +           }
> +       }
> +    }
> +
> +    if (count =3D=3D 1) {
> +       *a_ptr =3D a+1;
> +       return *a;
> +    }
> +
> +    return NULL;
> +}
> +
> +/* Match the "pattern" against the "text" string. */
> +int wildmatch(const char *pattern, const char *text)
> +{
> +    static const uchar *nomore[1]; /* A NULL pointer. */
> +#ifdef WILD_TEST_ITERATIONS
> +    wildmatch_iteration_count =3D 0;
> +#endif
> +    return dowild((const uchar*)pattern, (const uchar*)text, nomore)=
 =3D=3D TRUE;
> +}
> +
> +/* Match the "pattern" against the forced-to-lower-case "text" strin=
g. */
> +int iwildmatch(const char *pattern, const char *text)
> +{
> +    static const uchar *nomore[1]; /* A NULL pointer. */
> +    int ret;
> +#ifdef WILD_TEST_ITERATIONS
> +    wildmatch_iteration_count =3D 0;
> +#endif
> +    force_lower_case =3D 1;
> +    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore=
) =3D=3D TRUE;
> +    force_lower_case =3D 0;
> +    return ret;
> +}
> +
> +/* Match pattern "p" against the a virtually-joined string consistin=
g
> + * of all the pointers in array "texts" (which has a NULL pointer at=
 the
> + * end).  The int "where" can be 0 (normal matching), > 0 (match onl=
y
> + * the trailing N slash-separated filename components of "texts"), o=
r < 0
> + * (match the "pattern" at the start or after any slash in "texts").=
 */
> +int wildmatch_array(const char *pattern, const char*const *texts, in=
t where)
> +{
> +    const uchar *p =3D (const uchar*)pattern;
> +    const uchar*const *a =3D (const uchar*const*)texts;
> +    const uchar *text;
> +    int matched;
> +
> +#ifdef WILD_TEST_ITERATIONS
> +    wildmatch_iteration_count =3D 0;
> +#endif
> +
> +    if (where > 0)
> +       text =3D trailing_N_elements(&a, where);
> +    else
> +       text =3D *a++;
> +    if (!text)
> +       return FALSE;
> +
> +    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
> +     && matched !=3D ABORT_ALL) {
> +       while (1) {
> +           if (*text =3D=3D '\0') {
> +               if ((text =3D (uchar*)*a++) =3D=3D NULL)
> +                   return FALSE;
> +               continue;
> +           }
> +           if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)=
) !=3D FALSE
> +            && matched !=3D ABORT_TO_STARSTAR)
> +               break;
> +       }
> +    }
> +    return matched =3D=3D TRUE;
> +}
> +
> +/* Match literal string "s" against the a virtually-joined string co=
nsisting
> + * of all the pointers in array "texts" (which has a NULL pointer at=
 the
> + * end).  The int "where" can be 0 (normal matching), or > 0 (match
> + * only the trailing N slash-separated filename components of "texts=
"). */
> +int litmatch_array(const char *string, const char*const *texts, int =
where)
> +{
> +    const uchar *s =3D (const uchar*)string;
> +    const uchar*const *a =3D (const uchar* const*)texts;
> +    const uchar *text;
> +
> +    if (where > 0)
> +       text =3D trailing_N_elements(&a, where);
> +    else
> +       text =3D *a++;
> +    if (!text)
> +       return FALSE;
> +
> +    return doliteral(s, text, a) =3D=3D TRUE;
> +}
> diff --git a/wildmatch.h b/wildmatch.h
> new file mode 100644
> index 0000000..e7f1a35
> --- /dev/null
> +++ b/wildmatch.h
> @@ -0,0 +1,6 @@
> +/* wildmatch.h */
> +
> +int wildmatch(const char *pattern, const char *text);
> +int iwildmatch(const char *pattern, const char *text);
> +int wildmatch_array(const char *pattern, const char*const *texts, in=
t where);
> +int litmatch_array(const char *string, const char*const *texts, int =
where);
> --
> 1.7.12.1.406.g6ab07c4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
