Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF41F20193
	for <e@80x24.org>; Sat, 13 Aug 2016 08:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbcHMIlg convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Sat, 13 Aug 2016 04:41:36 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36261 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbcHMIlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 04:41:31 -0400
Received: by mail-it0-f43.google.com with SMTP id i186so2027666itf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2016 01:41:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HebR5Jzy0NaaKm1atnfpV8iHkH5lrRb1TOjmJir7LwQ=;
        b=Bn5qN5o+DsQca0r43GDJW6Hg5SC3dzP+Q1+XS9B+2jSxcnSZG0uq8YFKavFGSwnuk1
         ptldX2JW4cRuN4h3CfebZQj+3lgMx/cG0z0JE0EgNFuG8B67KJxJ1ghmqHOEbDPOFwCL
         mCdlBF2LKvLPFYibJwXHYOB7mdRdZolXgBr84XSl3SOC4Q1FqDFjcz/WxPkG10M0Zf4C
         qpAi52AlfLlOVPa+noQllu7l3n2eyK6h2WDPbC4LFNxy4E819YW5R2kwDhCvthwDnMzx
         WWzKCc8ueDFX57hUVami+urSPqV7jSAb+k7Qx8i0uKiPFUN4t0P8c5RHXnx/HtUoF/8c
         MnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HebR5Jzy0NaaKm1atnfpV8iHkH5lrRb1TOjmJir7LwQ=;
        b=JWNHvCPr28vIxFSLlZuzUYlo+sDOYDrGrxzY27bhLpIPqlsoZsjFkJG79LGQTuizea
         +zItHSt1NiwooR/GTowsRmKDG6z+s4Sk2xIBUclTZwoU5LNqO+oIfLJ/yX3Cu6PgdF/C
         EgaO1fa3M1cudxJRYKMEAEDG1NQGmXTkdad8vSrY3NV+jD92JdLAwzsMsEFL39q3eFVx
         /cALxynVyNyqS0HG1oFD1p+cLlR1dK2iPSK0B0JxbcSzG2IZ3dWQDAxf8G595tv8L4EF
         s3wg1m7pID4qS5hfUznRp4sbDzcORo7lvrWWpPdK7zp4RyYDOuOfFR9xDlH64082A7N3
         ztNw==
X-Gm-Message-State: AEkoout8cynDBV+TWLLMnntweyfswIf8eYGbTDPMaHiiJF86N+kt8nzxte/zhL87uCdDnlowrpxCrHwAMJvitA==
X-Received: by 10.36.33.197 with SMTP id e188mr3324191ita.42.1471077689935;
 Sat, 13 Aug 2016 01:41:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Sat, 13 Aug 2016 01:40:59 -0700 (PDT)
In-Reply-To: <20160714153311.2166-1-pclouds@gmail.com>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 13 Aug 2016 15:40:59 +0700
Message-ID: <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ping..

On Thu, Jul 14, 2016 at 10:33 PM, Nguyễn Thái Ngọc Duy
<pclouds@gmail.com> wrote:
> Helped-by: Jeff King <peff@peff.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  The diff from v3 is mostly clarification in code and document.
>
>     diff --git a/Documentation/config.txt b/Documentation/config.txt
>     index 18623ee..d971334 100644
>     --- a/Documentation/config.txt
>     +++ b/Documentation/config.txt
>     @@ -99,10 +99,9 @@ Supported keywords are:
>
>      `gitdir`::
>         The environment variable `GIT_DIR` must match the following
>     -   pattern for files to be included. The pattern can contain
>     -   standard globbing wildcards and two additional ones, `**/` and
>     -   `/**`, that can match multiple path components. Please refer
>     -   to linkgit:gitignore[5] for details. For convenience:
>     +   pattern for files to be included. The pattern shares the same
>     +   syntax as patterns in link:gitignore[5] with a few exceptions
>     +   below:
>
>       * If the pattern starts with `~/`, `~` will be substituted with the
>         content of the environment variable `HOME`.
>     diff --git a/config.c b/config.c
>     index ff44e00..690f3d5 100644
>     --- a/config.c
>     +++ b/config.c
>     @@ -183,6 +183,11 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
>
>                 strbuf_add_absolute_path(&path, home);
>                 strbuf_splice(pat, 0, 1, path.buf, path.len);
>     +           /*
>     +            * This part, path.buf[0..len], should be considered
>     +            * a literal string even if it has wildcards in it,
>     +            * because those wildcards are not wanted by the user.
>     +            */
>                 prefix = path.len + 1 /*slash*/;
>                 strbuf_release(&path);
>         } else if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
>     @@ -198,6 +203,11 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
>                 if (!slash)
>                         die("BUG: how is this possible?");
>                 strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
>     +           /*
>     +            * This part, path.buf[0..slash], should be consider
>     +            * a literal string even if it has wildcards in it,
>     +            * because those wildcards are not wanted by the user.
>     +            */
>                 prefix = slash - path.buf + 1 /* slash */;
>                 strbuf_release(&path);
>         } else if (!is_absolute_path(pat->buf))
>     @@ -224,8 +234,9 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
>
>         if (prefix > 0) {
>                 /*
>     -            * perform literal matching on the prefix part so that
>     -            * any wildcard character in it can't create side effects.
>     +            * perform literal matching on the expanded prefix
>     +            * part so that any wildcard character in it (e.g in
>     +            * the expansion of ~) can't create side effects.
>                  */
>                 if (text.len < prefix)
>                         goto done;
>  Documentation/config.txt  |  47 +++++++++++++++++++
>  config.c                  | 113 +++++++++++++++++++++++++++++++++++++++++++++-
>  t/t1305-config-include.sh |  56 +++++++++++++++++++++++
>  3 files changed, 214 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index db05dec..d971334 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -91,6 +91,42 @@ found at the location of the include directive. If the value of the
>  relative to the configuration file in which the include directive was
>  found.  See below for examples.
>
> +Included files can be grouped into subsections where the subsection
> +name is the condition that must be met for the files to be included.
> +The condition starts with a keyword, followed by a colon and a
> +pattern. The interpretation of the pattern depends on the keyword.
> +Supported keywords are:
> +
> +`gitdir`::
> +       The environment variable `GIT_DIR` must match the following
> +       pattern for files to be included. The pattern shares the same
> +       syntax as patterns in link:gitignore[5] with a few exceptions
> +       below:
> +
> + * If the pattern starts with `~/`, `~` will be substituted with the
> +   content of the environment variable `HOME`.
> +
> + * If the pattern starts with `./`, it is replaced with the directory
> +   containing the current config file.
> +
> + * If the pattern does not start with either `~/`, `./` or `/`, `**/`
> +   will be automatically prepended. For example, the pattern `foo/bar`
> +   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
> +
> + * If the pattern ends with `/`, `**` will be automatically added. For
> +   example, the pattern `foo/` becomes `foo/**`. In other words, it
> +   matches "foo" and everything inside, recursively.
> +
> +`gitdir/i`::
> +       This is the same as `gitdir` except that matching is done
> +       case-insensitively (e.g. on case-insensitive file sytems)
> +
> +A few more notes on matching:
> +
> + * Symlinks in `$GIT_DIR` are not resolved before matching.
> +
> + * Note that "../" is not special and will match literally, which is
> +   unlikely what you want.
>
>  Example
>  ~~~~~~~
> @@ -119,6 +155,17 @@ Example
>                 path = foo ; expand "foo" relative to the current file
>                 path = ~/foo ; expand "foo" in your `$HOME` directory
>
> +       ; include if $GIT_DIR is /path/to/foo/.git
> +       [include "gitdir:/path/to/foo/.git"]
> +               path = /path/to/foo.inc
> +
> +       ; include for all repositories inside /path/to/group
> +       [include "gitdir:/path/to/group/"]
> +               path = /path/to/foo.inc
> +
> +       ; include for all repositories inside $HOME/to/group
> +       [include "gitdir:~/to/group/"]
> +               path = /path/to/foo.inc
>
>  Values
>  ~~~~~~
> diff --git a/config.c b/config.c
> index bea937e..690f3d5 100644
> --- a/config.c
> +++ b/config.c
> @@ -13,6 +13,7 @@
>  #include "hashmap.h"
>  #include "string-list.h"
>  #include "utf8.h"
> +#include "dir.h"
>
>  struct config_source {
>         struct config_source *prev;
> @@ -168,9 +169,113 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>         return ret;
>  }
>
> +static int prepare_include_condition_pattern(struct strbuf *pat)
> +{
> +       int prefix = 0;
> +
> +       /* TODO: maybe support ~user/ too */
> +       if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
> +               struct strbuf path = STRBUF_INIT;
> +               const char *home = getenv("HOME");
> +
> +               if (!home)
> +                       return error(_("$HOME is not defined"));
> +
> +               strbuf_add_absolute_path(&path, home);
> +               strbuf_splice(pat, 0, 1, path.buf, path.len);
> +               /*
> +                * This part, path.buf[0..len], should be considered
> +                * a literal string even if it has wildcards in it,
> +                * because those wildcards are not wanted by the user.
> +                */
> +               prefix = path.len + 1 /*slash*/;
> +               strbuf_release(&path);
> +       } else if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
> +               struct strbuf path = STRBUF_INIT;
> +               const char *slash;
> +
> +               if (!cf || !cf->path)
> +                       return error(_("relative config include "
> +                                      "conditionals must come from files"));
> +
> +               strbuf_add_absolute_path(&path, cf->path);
> +               slash = find_last_dir_sep(path.buf);
> +               if (!slash)
> +                       die("BUG: how is this possible?");
> +               strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
> +               /*
> +                * This part, path.buf[0..slash], should be consider
> +                * a literal string even if it has wildcards in it,
> +                * because those wildcards are not wanted by the user.
> +                */
> +               prefix = slash - path.buf + 1 /* slash */;
> +               strbuf_release(&path);
> +       } else if (!is_absolute_path(pat->buf))
> +               strbuf_insert(pat, 0, "**/", 3);
> +
> +       if (pat->len && is_dir_sep(pat->buf[pat->len - 1]))
> +               strbuf_addstr(pat, "**");
> +
> +       return prefix;
> +}
> +
> +static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
> +{
> +       struct strbuf text = STRBUF_INIT;
> +       struct strbuf pattern = STRBUF_INIT;
> +       int ret = 0, prefix;
> +
> +       strbuf_add_absolute_path(&text, get_git_dir());
> +       strbuf_add(&pattern, cond, cond_len);
> +       prefix = prepare_include_condition_pattern(&pattern);
> +
> +       if (prefix < 0)
> +               goto done;
> +
> +       if (prefix > 0) {
> +               /*
> +                * perform literal matching on the expanded prefix
> +                * part so that any wildcard character in it (e.g in
> +                * the expansion of ~) can't create side effects.
> +                */
> +               if (text.len < prefix)
> +                       goto done;
> +               if (!icase && strncmp(pattern.buf, text.buf, prefix))
> +                       goto done;
> +               if (icase && strncasecmp(pattern.buf, text.buf, prefix))
> +                       goto done;
> +       }
> +
> +       ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
> +                        icase ? WM_CASEFOLD : 0, NULL);
> +
> +done:
> +       strbuf_release(&pattern);
> +       strbuf_release(&text);
> +       return ret;
> +}
> +
> +static int include_condition_is_true(const char *cond, size_t cond_len)
> +{
> +       /* no condition (i.e., "include.path") is always true */
> +       if (!cond)
> +               return 1;
> +
> +       if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> +               return include_by_gitdir(cond, cond_len, 0);
> +       else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> +               return include_by_gitdir(cond, cond_len, 1);
> +
> +       error(_("unrecognized include condition: %.*s"), (int)cond_len, cond);
> +       /* unknown conditionals are always false */
> +       return 0;
> +}
> +
>  int git_config_include(const char *var, const char *value, void *data)
>  {
>         struct config_include_data *inc = data;
> +       const char *cond, *key;
> +       int cond_len;
>         int ret;
>
>         /*
> @@ -181,8 +286,12 @@ int git_config_include(const char *var, const char *value, void *data)
>         if (ret < 0)
>                 return ret;
>
> -       if (!strcmp(var, "include.path"))
> -               ret = handle_path_include(value, inc);
> +       if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
> +           include_condition_is_true(cond, cond_len)) {
> +               if (!strcmp(key, "path"))
> +                       ret = handle_path_include(value, inc);
> +               /* else we do not know about this type of include; ignore */
> +       }
>         return ret;
>  }
>
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 9ba2ba1..83501ec 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -152,6 +152,62 @@ test_expect_success 'relative includes from stdin line fail' '
>         test_must_fail git config --file - test.one
>  '
>
> +test_expect_success 'conditional include, both unanchored' '
> +       git init foo &&
> +       (
> +               cd foo &&
> +               echo "[include \"gitdir:foo/\"]path=bar" >>.git/config &&
> +               echo "[test]one=1" >.git/bar &&
> +               echo 1 >expect &&
> +               git config test.one >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'conditional include, $HOME expansion' '
> +       (
> +               cd foo &&
> +               echo "[include \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
> +               echo "[test]two=2" >.git/bar2 &&
> +               echo 2 >expect &&
> +               git config test.two >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'conditional include, full pattern' '
> +       (
> +               cd foo &&
> +               echo "[include \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
> +               echo "[test]three=3" >.git/bar3 &&
> +               echo 3 >expect &&
> +               git config test.three >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'conditional include, relative path' '
> +       echo "[include \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
> +       echo "[test]four=4" >bar4 &&
> +       (
> +               cd foo &&
> +               echo 4 >expect &&
> +               git config test.four >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'conditional include, both unanchored, icase' '
> +       (
> +               cd foo &&
> +               echo "[include \"gitdir/i:FOO/\"]path=bar5" >>.git/config &&
> +               echo "[test]five=5" >.git/bar5 &&
> +               echo 5 >expect &&
> +               git config test.five >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_expect_success 'include cycles are detected' '
>         cat >.gitconfig <<-\EOF &&
>         [test]value = gitconfig
> --
> 2.9.1.566.gbd532d4
>



-- 
Duy
