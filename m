Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DAFC433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 19:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC05A61B30
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhJBTme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJBTmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 15:42:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2E3C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 12:40:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l7so24105132edq.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljIrCNtmgKLO2xbrUNOaEUsb/jbBAeK30c2mZLV7hjE=;
        b=Eag+cHWcO312uTAkUskVYsGdzQEoi+3hUrycK3fnNHl88mZHM/IUt2cu0oGGqU8Cca
         1slSbfVxuMrSq4880XZFiUg2e6IWkvVbPFIUK4RtljoTFghHEcPrsWyHPzf8iIfNQJ/c
         6Moao+j94Xttsmm5VjT+w2ZGI8uaGS8t6IeC8B1WslFtdjb6VLPUscwOVRcPydkAJ/Dl
         Ret1nuA+4nswa//ZFS5MRjj/byHqrWVbRl9y96wXHnp6zH6KLQXH8K3KpUSbubMUjFkK
         M2IscfS3jvu5m3+U2QXusw/a7RWcmDGydv9x2lxbmdEOQnGgrU9Dp8FTRv6vy+riAWGS
         hfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljIrCNtmgKLO2xbrUNOaEUsb/jbBAeK30c2mZLV7hjE=;
        b=do/9UPcWKahop4laDQxB5W2F1olAucWgNv/6NQYn6AzQLnbned0ePSGWTkGDWs6s21
         roewMqMc5Iu2WMsRwR9+j4z6UDiK/9zJ2K/JApGCgZSfU30WPBsj792EjsqKffkVCiMX
         vkjvoo6Va/CtrbqSYW3xN1jAKmwkNvjBWrN/Ehh2YgF6TAhUv2R7egrSWJDdIketpDb4
         sSijCfgIluHtvHDdLRG1s6Jv2x0Us6DHbmQ14Aomu05wj57HNFDnbEtfQFpNKFPkGl3i
         MQNynKYYO4Fp+5qYlJXD3y+DGjwqTYQ0irpwJMrrk9kSKV+Yid9XNrn8ODfMW8AhvnMJ
         tnxw==
X-Gm-Message-State: AOAM531oSUKlntR4R+xhprkce9Et7hNSmJkVDzFJxNBW7Zcy/ubg6zLB
        XENfmxVtofgeWrYNO8Lb9xsEW1CWmjhYZD69d6QYVvpUNv9eNw==
X-Google-Smtp-Source: ABdhPJxX/qmq2deG0YfL7qaLTvBnJgpvgNSez0qs/l+VJw3zXUGGs6e28MUagtftz7qKMdZSfXkCcxOSQXE0S4kdNok=
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr6192339ejb.253.1633203644976;
 Sat, 02 Oct 2021 12:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211002184407.117282-1-rybak.a.v@gmail.com> <20211002184407.117282-2-rybak.a.v@gmail.com>
In-Reply-To: <20211002184407.117282-2-rybak.a.v@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Oct 2021 12:40:32 -0700
Message-ID: <CABPp-BFm1aEoJyEf3STwq_ePKN-sxLdJ=9qYUtmEGRM1=0FTsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] *: spell Latin abbreviations correctly
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 11:49 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> Abbreviation "i.e." stands for Latin phrase "id est".  Abbreviation
> "e.g." stands for Latin phrase "exempli gratia".  Abbreviation "cf."
> stands for Latin "confer".  Fix a couple of places where these were
> spelled incorrectly.  All were found using:

I learned something new; I didn't know about "cf."

>
>     git grep -E ' ([Ee]g[.]|[Ii]e[.]|[Cc][.]f[.])'
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>
> Originally the changes in this patch /3 were in three separate commits (one for
> "e.g", "i.e." and "cf." respectively), I'm not too sure about it, but leaning
> towards having it in a single commit.

I'm glad this is separate from the other spelling fixes.  I'm also not
sure if this is best as one patch or three; it's small enough to be
one, but if there's concern that folks might like one spelling fix but
not the others (I was surprised "c.f." wasn't correct since that's
what I've run across more but never knew what it actually stood for),
then splitting would be better.  So, *shrug*.

>  Documentation/config/commitgraph.txt             | 2 +-
>  Documentation/git-tag.txt                        | 2 +-
>  compat/regex/regcomp.c                           | 2 +-
>  contrib/coccinelle/README                        | 2 +-
>  contrib/diff-highlight/t/t9400-diff-highlight.sh | 2 +-
>  contrib/subtree/todo                             | 4 ++--
>  convert.c                                        | 2 +-
>  git-p4.py                                        | 2 +-
>  midx.c                                           | 2 +-
>  run-command.h                                    | 2 +-
>  t/t0021-conversion.sh                            | 4 ++--
>  transport.c                                      | 6 +++---
>  12 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
> index 30604e4a4c..c37a1b7ddb 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -6,7 +6,7 @@ commitGraph.generationVersion::
>
>  commitGraph.maxNewFilters::
>         Specifies the default value for the `--max-new-filters` option of `git
> -       commit-graph write` (c.f., linkgit:git-commit-graph[1]).
> +       commit-graph write` (cf., linkgit:git-commit-graph[1]).
>
>  commitGraph.readChangedPaths::
>         If true, then git will use the changed-path Bloom filters in the
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 31a97a1b6c..84491ff08e 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -297,7 +297,7 @@ On Automatic following
>  ~~~~~~~~~~~~~~~~~~~~~~
>
>  If you are following somebody else's tree, you are most likely
> -using remote-tracking branches (eg. `refs/remotes/origin/master`).
> +using remote-tracking branches (e.g. `refs/remotes/origin/master`).
>  You usually want the tags from the other end.
>
>  On the other hand, if you are fetching because you would want a
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index d1bc09e49b..fcf7b2daf6 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -2370,7 +2370,7 @@ parse_expression (re_string_t *regexp, regex_t *preg, re_token_t *token,
>         }
>        /* We must return here, since ANCHORs can't be followed
>          by repetition operators.
> -        eg. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
> +        e.g. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
>              it must not be "<ANCHOR(^)><REPEAT(*)>".  */
>        fetch_token (token, regexp, syntax);
>        return tree;
> diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
> index f0e80bd7f0..c7723a5542 100644
> --- a/contrib/coccinelle/README
> +++ b/contrib/coccinelle/README
> @@ -18,7 +18,7 @@ There are two types of semantic patches:
>                 a strbuf, 2018-03-25)
>     f919ffebed (Use MOVE_ARRAY, 2018-01-22)
>
> -   These types of semantic patches are usually part of testing, c.f.
> +   These types of semantic patches are usually part of testing, cf.
>     0860a7641b (travis-ci: fail if Coccinelle static analysis found something
>                 to transform, 2018-07-23)
>
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index f6f5195d00..12140b9734 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -21,7 +21,7 @@ fi
>  # dh_test is a test helper function which takes 3 file names as parameters. The
>  # first 2 files are used to generate diff and commit output, which is then
>  # piped through diff-highlight. The 3rd file should contain the expected output
> -# of diff-highlight (minus the diff/commit header, ie. everything after and
> +# of diff-highlight (minus the diff/commit header, i.e. everything after and
>  # including the first @@ line).
>  dh_test () {
>         a="$1" b="$2" &&
> diff --git a/contrib/subtree/todo b/contrib/subtree/todo
> index 32d2ce3a40..c9cef579b7 100644
> --- a/contrib/subtree/todo
> +++ b/contrib/subtree/todo
> @@ -1,7 +1,7 @@
>
>         delete tempdir
>
> -       'git subtree rejoin' option to do the same as --rejoin, eg. after a
> +       'git subtree rejoin' option to do the same as --rejoin, e.g. after a
>           rebase
>
>         --prefix doesn't force the subtree correctly in merge/pull:
> @@ -39,7 +39,7 @@
>
>         make a 'force-update' that does what 'add' does even if the subtree
>                 already exists.  That way we can help people who imported
> -               subtrees "incorrectly" (eg. by just copying in the files) in
> +               subtrees "incorrectly" (e.g. by just copying in the files) in
>                 the past.
>
>         guess --prefix automatically if possible based on pwd
> diff --git a/convert.c b/convert.c
> index 0d6fb3410a..83ad1c4183 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -335,7 +335,7 @@ static int check_roundtrip(const char *enc_name)
>  {
>         /*
>          * check_roundtrip_encoding contains a string of comma and/or
> -        * space separated encodings (eg. "UTF-16, ASCII, CP1125").
> +        * space separated encodings (e.g. "UTF-16, ASCII, CP1125").
>          * Search for the given encoding in that string.
>          */
>         const char *found = strcasestr(check_roundtrip_encoding, enc_name);
> diff --git a/git-p4.py b/git-p4.py
> index 2b4500226a..eae4e5ff8f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1388,7 +1388,7 @@ def generatePointer(self, contentFile):
>          # Git LFS removed the preamble in the output of the 'pointer' command
>          # starting from version 1.2.0. Check for the preamble here to support
>          # earlier versions.
> -        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
> +        # cf. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
>          if pointerFile.startswith('Git LFS pointer for'):
>              pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
>
> diff --git a/midx.c b/midx.c
> index f96fb2efee..11a9a4219b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1002,7 +1002,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
>
>         /*
>          * Build the MIDX-order index based on pdata.objects (which is already
> -        * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
> +        * in MIDX order; cf., 'midx_pack_order_cmp()' for the definition of
>          * this order).
>          */
>         ALLOC_ARRAY(index, pdata.nr_objects);
> diff --git a/run-command.h b/run-command.h
> index b9aff74914..5d4c9dc7f4 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -170,7 +170,7 @@ struct child_process {
>   *   non-zero.
>   *
>   * - If the program terminated due to a signal, then the return value is the
> - *   signal number + 128, ie. the same value that a POSIX shell's $? would
> + *   signal number + 128, i.e. the same value that a POSIX shell's $? would
>   *   report.  A diagnostic is printed.
>   *
>   */
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 33dfc9cd56..d9f1a04133 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -35,7 +35,7 @@ filter_git () {
>  # Compare two files and ensure that `clean` and `smudge` respectively are
>  # called at least once if specified in the `expect` file. The actual
>  # invocation count is not relevant because their number can vary.
> -# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> +# cf. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
>  test_cmp_count () {
>         expect=$1
>         actual=$2
> @@ -50,7 +50,7 @@ test_cmp_count () {
>
>  # Compare two files but exclude all `clean` invocations because Git can
>  # call `clean` zero or more times.
> -# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> +# cf. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
>  test_cmp_exclude_clean () {
>         expect=$1
>         actual=$2
> diff --git a/transport.c b/transport.c
> index b37664ba87..999bf0f2ca 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1167,9 +1167,9 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
>          * Rules used to determine whether to report progress (processing aborts
>          * when a rule is satisfied):
>          *
> -        *   . Report progress, if force_progress is 1 (ie. --progress).
> -        *   . Don't report progress, if force_progress is 0 (ie. --no-progress).
> -        *   . Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
> +        *   . Report progress, if force_progress is 1 (i.e. --progress).
> +        *   . Don't report progress, if force_progress is 0 (i.e. --no-progress).
> +        *   . Don't report progress, if verbosity < 0 (i.e. -q/--quiet ).
>          *   . Report progress if isatty(2) is 1.
>          **/
>         if (force_progress >= 0)
> --
> 2.33.0

This patch looks good to me; thanks.
