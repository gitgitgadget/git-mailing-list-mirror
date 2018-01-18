Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C9E1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeARVX7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:23:59 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35802 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbeARVXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:23:49 -0500
Received: by mail-wm0-f48.google.com with SMTP id r78so25817859wme.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/9TG0j51PaSZS6hv4OsdZVBW4+LuX1UPC543KXTFPqI=;
        b=ldkyxiisf9ijMMOQLvChNch7vxciW0xthJDBcDgNx5LOt3H3puA1tRVyWPBShs4XuO
         8/jDRCGK4k0Rr23fT+Tna7NB/VvMhZhpji695R85r2W59wv3R41g1VH+8GLuh/ApQ8SL
         IS1ATQwqdEFEfDoRm4IEr2M6ncxBPYicuyL7FbCYMjiJfDKtMal/PhQEcKMTOcfExjHm
         LU+Y0Y/+YnXIYdVKjLOfN4625F5WoKsi9Slcx/5chWikoXAXz3mwIpxuHpmUmnWCy4Mw
         6i75uEi5VC+GEcgbLNq6NulnNDGrU8C0xjOoXqn9bTK7LqHWFToZNc/i+FbNR8ZSgxnB
         OVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/9TG0j51PaSZS6hv4OsdZVBW4+LuX1UPC543KXTFPqI=;
        b=GPfi6IDuCXqN/VdJtg/A4YjBOC/Gkzbe6Yz/BcGbHa1V3MobwYlH9LW/ScRD+0tMtT
         xVN/+oF5YtJUtblk+A1mgWAD95tcxQRDO4HN4Zw4oMcgDNShXl8qwyZXf5TzbqwbsYpV
         8sld0LwsIRLnuPMuJR14fz25JKcL7ImfeK6/HVz+0seZ172zofapEzKXGEj2X5S2H+/J
         Bhm2tkMiA2/VpeM1fLWaO0TFwD9n8iasn5QQ2ZzSMlqvBIqW8ElXe8ogLUa3vF9OzDDO
         1/DUDzc/NKq5vWJnpZzlsYVySYVaoxbz0Gm1dEdEBRYoF1Dy5pQ8OR2/Rw8iNFFpikEp
         7nXA==
X-Gm-Message-State: AKwxytfg6x/jiu7CjYzS+HJRsvjSgbXBjJfOLIjEb+8+HtlmVetcsSYE
        I1cgf2aSJcMzHOW6O60z/7M=
X-Google-Smtp-Source: ACJfBos7MzS5L67CPxJwU37o3REiOgZc9RBC9aqSLzbO6bb34VzmiSJE6GCbIA7GZYEx6coVOrcG0A==
X-Received: by 10.80.155.7 with SMTP id o7mr9726838edi.105.1516310627949;
        Thu, 18 Jan 2018 13:23:47 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id k42sm5537889edb.44.2018.01.18.13.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 13:23:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
References: <20180113132211.13350-1-pclouds@gmail.com> <20180118100546.32251-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180118100546.32251-1-pclouds@gmail.com>
Date:   Thu, 18 Jan 2018 22:23:45 +0100
Message-ID: <87bmhqj1y6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 18 2018, Nguyễn Thái Ngọc Duy jotted:

> This is partly inspired by gerrit web interface which shows diffstat
> like this, e.g. with commit 0433d533f1 (notice the "A" column on the
> third line):
>
>
>      Documentation/merge-config.txt     |  4 +
>      builtin/merge.c                    |  2 +
>    A t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++
>      t/t7612-merge-verify-signatures.sh | 45 ++++++++++
>    4 files changed, 132 insertions(+)

This feature is awesome. This has bothered me about --stat, but I
haven't done anything about it.

> In other words, certain information currently shown with --summary is
> embedded in the diffstat. This helps reading (all information of the
> same file in the same line instead of two) and can reduce the number of
> lines if you add/delete a lot of files.

Wait, isn't there a bug here in the existing --summary code, its
documentation says it'll show information "such as creations, renames
and mode changes".

But even though your --compact-summary shows that the file is being
added and its mode changed:

    $ diff -ru <(./git-show --stat 0433d533f1) <(./git-show --stat --compact-summary 0433d533f1)
    --- /dev/fd/63  2018-01-18 21:11:51.186570555 +0000
    +++ /dev/fd/62  2018-01-18 21:11:51.186570555 +0000
    @@ -14,8 +14,8 @@
           t: add tests for pull --verify-signatures
           merge: add config option for verifySignatures

    - Documentation/merge-config.txt     |  4 ++
    - builtin/merge.c                    |  2 +
    - t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++++++++++++++++
    - t/t7612-merge-verify-signatures.sh | 45 +++++++++++++++++++++
    +     Documentation/merge-config.txt     |  4 ++
    +     builtin/merge.c                    |  2 +
    + A+x t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++++++++++++
    +     t/t7612-merge-verify-signatures.sh | 45 +++++++++++++++++++
      4 files changed, 132 insertions(+)

There is no difference between --stat with and without --summary on the
same commit, shouldn't it show "create mode [...]" ?

E.g. 95450bbbaa will do the trick for both:

    $ diff -ru <(./git-show --stat 95450bbbaa) <(./git-show --stat --summary 95450bbbaa)
    --- /dev/fd/63  2018-01-18 21:14:20.770050599 +0000
    +++ /dev/fd/62  2018-01-18 21:14:20.770050599 +0000
    @@ -14,3 +14,4 @@
      git-svn.perl                    |  1 +
      t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
      2 files changed, 28 insertions(+)
    + create mode 100755 t/t9169-git-svn-dcommit-crlf.sh

    $ diff -ru <(./git-show --stat --summary 95450bbbaa) <(./git-show --stat --compact-summary 95450bbbaa)
    --- /dev/fd/63  2018-01-18 21:14:30.646016210 +0000
    +++ /dev/fd/62  2018-01-18 21:14:30.646016210 +0000
    @@ -11,7 +11,6 @@
         Reported-by: Brian Bennett <Brian.Bennett@Transamerica.com>
         Signed-off-by: Eric Wong <e@80x24.org>

    - git-svn.perl                    |  1 +
    - t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
    +     git-svn.perl                    |  1 +
    + A+x t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
      2 files changed, 28 insertions(+)
    - create mode 100755 t/t9169-git-svn-dcommit-crlf.sh

> +--compact-summary::
> +	Output a condensed summary of extended header information in
> +	front of the file name part of diffstat. This option is
> +	ignored if --stat is not specified.
> ++

If for some reason the lack of information about the commit under
--summary isn't a bug/fixable it makes sense to document the differences
here.

> +File creations or deletions are denoted wigth "A" or "D" respectively,

s/wigth/with/

> +optionally "+l" if it's a symlink, or "+x" if it's executable.
> +Mode changes are shown "M+x" or "M-x" for adding or removing

"Mode changes are shown as" is better worded.
