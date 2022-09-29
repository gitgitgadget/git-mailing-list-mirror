Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBFC07E9D
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 04:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiI2EhA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 29 Sep 2022 00:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2Eg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 00:36:58 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C5127CBA
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 21:36:57 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-324ec5a9e97so3114517b3.7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 21:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uRm6vxYRjRiP618e2g0dP6hjxkPfkxL8WFDIs+CYN78=;
        b=K0RAbZNPUc36W2iKO3D0gQ0laeNRgzREt7nj2altnvlx8NDNfEH5oRMVZHEIqydtOc
         g/VRZbZ8dBvv1vserN3vvH5KHz/r6SCGn0IaHKiR0yT4+tpVMMtPDDEaJ+LV6g9zDB+6
         o5FC4TyK+408+XrBHlTfuo50g5sh0jDiU55nfxqG6n0mnB+fGrEU0FGFwEtCib7ZH2h6
         z5QJz22IMW72dLJY7RLOgz58xd1OFuSWWB2ULRQkN+H95ffFf3NPkXBTYkgrNf3J483s
         71O4t86Ne53X8ioQVRSoLNwLT4RYVUAJUC+q7STJsDY5pue3w9FU90N7FaKSIXDEzh5a
         5Frg==
X-Gm-Message-State: ACrzQf0pYAAzm9JETfggOWSCfopyAYuymyRF6isvLbXFJ8m3JPPgLdNk
        M+M5CgULacyH/aRcotMA89yCC5va2sTH0GO0NGI=
X-Google-Smtp-Source: AMsMyM5fvoi0q/3wIsx8dfgitkDihit8aNRkZZyzEtIGPsCKYVHXrz2c+bEe4bqEKixSkezWgifotxnl/AMOAZvVYro=
X-Received: by 2002:a0d:d2c1:0:b0:33e:e1f4:4bb0 with SMTP id
 u184-20020a0dd2c1000000b0033ee1f44bb0mr1338544ywd.234.1664426216473; Wed, 28
 Sep 2022 21:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <patch-v2-25.35-a4d75ea691c-20220928T082458Z-avarab@gmail.com>
In-Reply-To: <patch-v2-25.35-a4d75ea691c-20220928T082458Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Sep 2022 00:36:45 -0400
Message-ID: <CAPig+cSwokKApLJi6xHVUs1JZGJkjdxd0wkLT1Hqsr9UpPN-JQ@mail.gmail.com>
Subject: Re: [PATCH v2 25/35] doc txt & -h consistency: add missing options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 4:45 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change those built-in commands that were attempting to exhaustively
> the options in the "-h" output to actually do so, and always

s/exhaustively/exhaustively list/

> have *.txt documentation know about the exhaustive list of options.
>
> Let's also fix the documentation and -h output for those built-in
> commands where the *.txt and -h output was a mismatch of missing
> options on both sides.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>  'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
> -'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
> +'git commit-graph write' [--object-dir <dir>] [--append]
> +                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]

Should there be spaces around the vertical bars per [14/35]?

    [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]

> +                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
> +                       <split options>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> -'git interpret-trailers' [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
> -'git interpret-trailers' [<options>] [--parse] [<file>...]
> +'git interpret-trailers' [--in-place] [--trim-empty]
> +                       [(--trailer <token>[(=|:)<value>])...]
> +                       [--parse] [<file>...]

This changes the interpretation from two distinct operating modes to a
single mode. I had to go study the git-interpret-trailers
documentation to convince myself that the revised synopsis is correct
and matches the implementation, and that the old documented dual-mode
behavior was misleading. This probably should have been mentioned in
the commit message, or this change could have been split out to its
own patch (not that I'm advocating making this series even longer).

> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
>  int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  {
>         static const char * const hash_object_usage[] = {
> -               N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
> -               "git hash-object  --stdin-paths",
> +               N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters]\n"
> +                  "                [--stdin [--literally]] [--] <file>..."),
> +               N_("git hash-object [-t <type>] [-w] --stdin-paths [--no-filters]"),

This removes spaces around vertical bars, which seems to contradict
[14/35] (unless I'm misunderstanding [14/35]).
