Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4001FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbcLHACK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:02:10 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36232 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbcLHACJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:02:09 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so33074432ywb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 16:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FPmto62ne0t1gxSzErcNYZY+bRfR9pXSGArbg0z1vVM=;
        b=LaukMiWImPYtaNEQk08acxpcgd+1lpIZVLClZ7NchiYGEfObFaT2WiwvnpiuWHjg/V
         6lgmZJB547oA2J+kuBhLms3ro4AdsWkRkswM8TnM7p/ROxWwp90C01TR00H+J0m2k3hq
         A+X8v81b8yUIPke7g5I2qhD8GCOAMqsHzF0tuZE4W4DHpvTI96h1Du/6wnuQIaY5PHov
         ZcQ8h7TablEosPE11ymlb9FFPfglhrMJNvKPoMNZCeSVCdmneCxbIslxRv/COLbeq9wA
         +HMEgP1uLTdfh4rf26xydvEtgFW2gLEhfJCozitmMm00d4avmJoetYWrkWF+b9nOJUYt
         ZDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FPmto62ne0t1gxSzErcNYZY+bRfR9pXSGArbg0z1vVM=;
        b=En7TkN4+fAghgRbhwC+C81axZtXmIcjvdQXaWxdEAQ092IlXt0Ao93hzTqtbyZ/5HR
         U8Z9WGjzVfS63WubTHjiYlA9bBCT/zVVLDff8JBrUZ0K0zPUAYWUByow94Zr+PMN9sCD
         GyGysPpy42T+JkPaCwLtmqURlhnN9ytUErid/i7en7FoCziTVsmw+N/k82W/KVvg5YvZ
         rrOiFOOrFUlaFIHeiUBcckd55dZxPtBPNYoYkSSbZOAKQIBTy+kivZAGO9WUK68Nkb2A
         26DP1xo7yM92cDtBqNXSDjt+qo3437QmAxAB5ua8VLLNB63AnUdZXo/2DYMwOGPMZSpE
         t3yg==
X-Gm-Message-State: AKaTC03mA2G6guaP0vuVUnX82M+NflNenYH6WJuAlcCnXZAx+f76773NP8je/vLHKr9zf4KG4uI02qFgW3LHoA==
X-Received: by 10.37.177.6 with SMTP id g6mr18325380ybj.132.1481155328937;
 Wed, 07 Dec 2016 16:02:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Wed, 7 Dec 2016 16:01:48 -0800 (PST)
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Dec 2016 16:01:48 -0800
Message-ID: <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 7:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>
> Initially posted here: $(gmane/279226). It was decided that this series
> would follow up after refactoring ref-filter parsing mechanism, which
> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>
> v1 can be found here: $(gmane/288342)
> v2 can be found here: $(gmane/288863)
> v3 can be found here: $(gmane/290299)
> v4 can be found here: $(gmane/291106)
> v5b can be found here: $(gmane/292467)
> v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
> v7 can be found here: http://marc.info/?l=git&m=147863593317362&w=2
>
> Changes in this version:
>
> 1. use an enum for holding the comparision type in
> %(if:[equals/notequals=...]) options.
> 2. rename the 'strip' option to 'lstrip' and introduce an 'rstrip'
> option. Also modify them to take negative values. This drops the
> ':dri' and ':base' options.
> 3. Drop unecessary code.
> 4. Cleanup code and fix spacing.
> 5. Add more comments wherever required.
> 6. Add quote_literal_for_format(const char *s) for safer string
> insertions in branch.c:build_format().
>
> Thanks to Jacob, Jackub, Junio and Matthieu for their inputs on the
> previous version.
>
> Interdiff below.
>
> Karthik Nayak (19):
>   ref-filter: implement %(if), %(then), and %(else) atoms
>   ref-filter: include reference to 'used_atom' within 'atom_value'
>   ref-filter: implement %(if:equals=<string>) and
>     %(if:notequals=<string>)
>   ref-filter: modify "%(objectname:short)" to take length
>   ref-filter: move get_head_description() from branch.c
>   ref-filter: introduce format_ref_array_item()
>   ref-filter: make %(upstream:track) prints "[gone]" for invalid
>     upstreams
>   ref-filter: add support for %(upstream:track,nobracket)
>   ref-filter: make "%(symref)" atom work with the ':short' modifier
>   ref-filter: introduce refname_atom_parser_internal()
>   ref-filter: introduce refname_atom_parser()
>   ref-filter: make remote_ref_atom_parser() use
>     refname_atom_parser_internal()
>   ref-filter: rename the 'strip' option to 'lstrip'
>   ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
>   ref-filter: add an 'rstrip=<N>' option to atoms which deal with
>     refnames
>   ref-filter: allow porcelain to translate messages in the output
>   branch, tag: use porcelain output
>   branch: use ref-filter printing APIs
>   branch: implement '--format' option
>
>  Documentation/git-branch.txt       |   7 +-
>  Documentation/git-for-each-ref.txt |  86 +++++--
>  builtin/branch.c                   | 290 +++++++---------------
>  builtin/tag.c                      |   6 +-
>  ref-filter.c                       | 488 +++++++++++++++++++++++++++++++------
>  ref-filter.h                       |   7 +
>  t/t3203-branch-output.sh           |  16 +-
>  t/t6040-tracking-info.sh           |   2 +-
>  t/t6300-for-each-ref.sh            |  88 ++++++-
>  t/t6302-for-each-ref-filter.sh     |  94 +++++++
>  10 files changed, 784 insertions(+), 300 deletions(-)
>
> Interdiff:
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f4ad297..c72baeb 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -92,13 +92,14 @@ refname::
>         The name of the ref (the part after $GIT_DIR/).
>         For a non-ambiguous short name of the ref append `:short`.
>         The option core.warnAmbiguousRefs is used to select the strict
> -       abbreviation mode. If `strip=<N>` is appended, strips `<N>`
> -       slash-separated path components from the front of the refname
> -       (e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
> -       `<N>` must be a positive integer.  If a displayed ref has fewer
> -       components than `<N>`, the command aborts with an error. For the base
> -       directory of the ref (i.e. foo in refs/foo/bar/boz) append
> -       `:base`. For the entire directory path append `:dir`.
> +       abbreviation mode. If `lstrip=<N>` or `rstrip=<N>` option can

Grammar here, drop the If before `lstrip since you're referring to
multiples and you say "x can be appended to y" rather than "if x is
added, do y"

> +       be appended to strip `<N>` slash-separated path components
> +       from or end of the refname respectively (e.g.,
> +       `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
> +       `%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
> +       `<N>` is a negative number, then only `<N>` path components
> +       are left behind.  If a displayed ref has fewer components than
> +       `<N>`, the command aborts with an error.
>

Would it make more sense to not die and instead just return the empty
string? On the one hand, if we die() it's obvious that you tried to
strip too many components. But on the other hand, it's also somewhat
annoying to have the whole command fail because we happen upon a
single ref that has fewer components?

So, for positive numbers, we simply strip what we can, which may
result in the empty string, and for negative numbers, we keep up to
what we said, while potentially keeping the entire string. I feel
that's a better alternative than a die() in the middle of a ref
filter..

What are other people's thoughts on this?

Thanks,
Jake
