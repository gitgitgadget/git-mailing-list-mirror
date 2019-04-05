Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78F120248
	for <e@80x24.org>; Fri,  5 Apr 2019 16:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfDEQcU (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 12:32:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40183 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDEQcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 12:32:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so6052387edw.7
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+tKXi2NvzG+K/bsQasP9dSrQO5HNFzXy4C6HqcbwA8=;
        b=kbxTWylID4aaGQaIx1qZos5fJhQXXvmNwL7VxnebASTGP+a32y12Vrxblvrgo4uLal
         xWQ9iFAGOkIkgLf0gSD03T6qL/hsz/yIYYlF63S+wMwgDOq0CT+gunoFLmJ2aKrBymX/
         MdITerGTs+gu/zEWgykNiei6oHkEG5wnK/Xf0khdK3SHRo+8lEMA/yPWaJC9ohjfDG4q
         LgMulM57XqUzQIEdpqlPiOS+F7Ok1TSWzeR7/NIDS/iWI3cozw27fRXTue+/H30iKwok
         WzRpApXp2vIWdY9QpR6fwNpw9nbGkCvu9Ng4kCuHWJqt+JnQHMh/+z8i92+78jjbIfAU
         bBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+tKXi2NvzG+K/bsQasP9dSrQO5HNFzXy4C6HqcbwA8=;
        b=lxZ7upc392PMsuApS9ZUlXbm2qRcRKAqN0zscfeKtcHi/ZEGDIv0s2s+oS07+1K80Y
         8X+kVF83CwwH6DRETr2qpb1qabvJ9fFABR7K8jtl2L1cPBmFwpRpD/EkLWwLsxSM9v2h
         +fFrMuVCHW75TLMbJWghIlJ9lePiqhFKlNU4L9ymI0Ms0aZpvKoOJGS8uH/P6eoWTjhK
         6DgmP42cRc2VwwJOe/Heneb2MDXkeVMAp/H1oRa/gwlqJDngV8Pqw+rnVcFfKzImSnOw
         ybsxtulPhn8HBE/a+A8jLwjsL5CVkzTEG15A0nVBXKEITsD/GSnY437VvktI0XjoeQ85
         SKvw==
X-Gm-Message-State: APjAAAU2VKMBzSkGDqYw5fISHvXQmFJq/Ez2D0wt6bCHltNsWgsBPv5n
        A3kpOdtsGTSl7FR5BIoIfZo3JNiTKgqY1qTNvpA=
X-Google-Smtp-Source: APXvYqzMCjfvKvilgw2fvivaCYQlavlQG2Qzgt6r2yhEf9Wf8DWSX0w4nUzt/VrwoiU8coU1eMl1DzHA4hb14YHT4vk=
X-Received: by 2002:aa7:dcca:: with SMTP id w10mr8663241edu.73.1554481937972;
 Fri, 05 Apr 2019 09:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190330003336.21940-1-newren@gmail.com> <20190405150026.5260-1-newren@gmail.com>
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 5 Apr 2019 09:32:06 -0700
Message-ID: <CA+P7+xrbd3c7J5tW+LOXKq7g62HL_0GdDOBZhT-oNgRPHOeS+A@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Switch directory rename detection default
To:     Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 8:03 AM Elijah Newren <newren@gmail.com> wrote:
>
> This series adds a new configuration option, merge.directoryRenames,
> for setting how to make use of directory rename detection heuristics.
> The default becomes "conflict", meaning that conflicts are reported
> instead of silently moving paths according to the heuristics.  Also,
> even when merge.directoryRenames config setting is "true", this series
> changes behavior in that it now prints informational messages about
> paths that are adjusted by the directory rename detection heuristics.
>

I read through the v2 series, and the range diff on v3. I thought it
looked good.

> Changes since v2 (range-diff below):
>   * Made use of git_parse_maybe_bool() as suggested by =C3=86var, and mad=
e
>     the parsing of the merge.directoryRenames setting look more like
>     that for merge.ff.
>
> I didn't get much review of round 2, which maybe means everyone is
> happy with what they see.  If anyone would like to take a look at just
> part of the series, the pieces I'd most like folks to look at are:
>   * Patch 15, particularly looking over the new testcases (13a-13d) in
>     t6043 and the documentation.

The documentation made sense to me. I can't speak much towards the
implementation, but I definitely agree that conflicting is a suitable
default, and better than silently renaming.

>   * Should I have switched the type of "mode" from 'unsigned short' to
>     'unsigned' instead of vice-versa in patch 1?

I think switching to unsigned short is better. Unless we need the full
integer width for some reason? but since it's already short I don't
see why we would..

>   * Similarly, does anyone have a reason to prefer oid,mode pair over
>     using a diff_filespec (in patch 11 I convert half the sites to the
>     latter)?
>


>
> Elijah Newren (15):
>   Use 'unsigned short' for mode, like diff_filespec does
>   merge-recursive: rename merge_options argument from 'o' to 'opt'
>   merge-recursive: rename diff_filespec 'one' to 'o'
>   merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
>   merge-recursive: use 'ci' for rename_conflict_info variable name
>   merge-recursive: move some struct declarations together
>   merge-recursive: shrink rename_conflict_info
>   merge-recursive: remove ren[12]_other fields from rename_conflict_info
>   merge-recursive: track branch where rename occurred in rename struct
>   merge-recursive: cleanup handle_rename_* function signatures
>   merge-recursive: switch from (oid,mode) pairs to a diff_filespec
>   t6043: fix copied test description to match its purpose
>   merge-recursive: track information associated with directory renames
>   merge-recursive: give callers of handle_content_merge() access to
>     contents
>   merge-recursive: switch directory rename detection default
>
>  Documentation/config/merge.txt         |   19 +-
>  archive.c                              |    2 +-
>  blame.c                                |    2 +-
>  blame.h                                |    2 +-
>  builtin/rm.c                           |    2 +-
>  builtin/update-index.c                 |    2 +-
>  cache.h                                |    2 +-
>  fsck.c                                 |    2 +-
>  line-log.c                             |    2 +-
>  match-trees.c                          |    8 +-
>  merge-recursive.c                      | 1853 ++++++++++++------------
>  notes.c                                |    2 +-
>  sha1-name.c                            |    2 +-
>  t/t3401-rebase-and-am-rename.sh        |    8 +-
>  t/t6043-merge-rename-directories.sh    |  462 +++++-
>  t/t6046-merge-skip-unneeded-updates.sh |    8 +-
>  tree-diff.c                            |    2 +-
>  tree-walk.c                            |    6 +-
>  tree-walk.h                            |    6 +-
>  19 files changed, 1367 insertions(+), 1025 deletions(-)
>
> Range-diff:
>  1:  bb5b410a61 =3D  1:  bb5b410a61 Use 'unsigned short' for mode, like d=
iff_filespec does
>  2:  f91c28257e =3D  2:  f91c28257e merge-recursive: rename merge_options=
 argument from 'o' to 'opt'
>  3:  e3fe8baa15 =3D  3:  e3fe8baa15 merge-recursive: rename diff_filespec=
 'one' to 'o'
>  4:  c6bd963ffb =3D  4:  c6bd963ffb merge-recursive: rename locals 'o' an=
d 'a' to 'obuf' and 'abuf'
>  5:  eca30e7571 =3D  5:  eca30e7571 merge-recursive: use 'ci' for rename_=
conflict_info variable name
>  6:  07f0d5fa8e =3D  6:  07f0d5fa8e merge-recursive: move some struct dec=
larations together
>  7:  4cdd1ecbcb =3D  7:  4cdd1ecbcb merge-recursive: shrink rename_confli=
ct_info
>  8:  3490324bdd =3D  8:  3490324bdd merge-recursive: remove ren[12]_other=
 fields from rename_conflict_info
>  9:  fb73a2c55d =3D  9:  fb73a2c55d merge-recursive: track branch where r=
ename occurred in rename struct
> 10:  124ee08ed8 =3D 10:  124ee08ed8 merge-recursive: cleanup handle_renam=
e_* function signatures
> 11:  78a5916efe =3D 11:  78a5916efe merge-recursive: switch from (oid,mod=
e) pairs to a diff_filespec
> 12:  a8309326c1 =3D 12:  a8309326c1 t6043: fix copied test description to=
 match its purpose
> 13:  b362f4db1e =3D 13:  b362f4db1e merge-recursive: track information as=
sociated with directory renames
> 14:  2e0258a358 =3D 14:  2e0258a358 merge-recursive: give callers of hand=
le_content_merge() access to contents
> 15:  719c25afaf ! 15:  428cdf62b3 merge-recursive: switch directory renam=
e detection default
>     @@ -262,17 +262,12 @@
>                 free(value);
>         }
>      +  if (!git_config_get_string("merge.directoryrenames", &value)) {
>     -+          if (!strcasecmp(value, "true"))
>     -+                  opt->detect_directory_renames =3D 2;
>     -+          else if (!strcasecmp(value, "false"))
>     -+                  opt->detect_directory_renames =3D 0;
>     -+          else if (!strcasecmp(value, "conflict"))
>     ++          int boolval =3D git_parse_maybe_bool(value);
>     ++          if (0 <=3D boolval) {
>     ++                  opt->detect_directory_renames =3D boolval ? 2 : 0=
;
>     ++          } else if (!strcasecmp(value, "conflict")) {
>      +                  opt->detect_directory_renames =3D 1;
>     -+          else {
>     -+                  error(_("Invalid value for merge.directoryRenames=
: %s"),
>     -+                        value);
>     -+                  opt->detect_directory_renames =3D 1;
>     -+          }
>     ++          } /* avoid erroring on values from future versions of git=
 */
>      +          free(value);
>      +  }
>         git_config(git_xmerge_config, NULL);
> --
> 2.21.0.211.g719c25afaf.dirty
>
