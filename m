Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36141F404
	for <e@80x24.org>; Mon, 27 Aug 2018 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeH0WZ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 18:25:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39919 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0WZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 18:25:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so11183455edi.6
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wf9FRObg7c05dplSc7aSpQHfoX4syb8uoA/b/hLnt1w=;
        b=FEs+xwwXl1cpzNgpshzH+s4Rt5OkAk2GAGC0Ba6E1ZHDM8vKiNtGzpIxsgoZuMjpuN
         AbvcjS0rJqjjKMKPZnmMIu91smuRcOmy/ZHqg85v3JD3dkwAmqq7OGaScckz6WxcZ8HY
         7UXtFP/Ci3DFdUVZetk4HWvV7L0FtagHP20vmXDSqPxt9WB5Gcnln0/bL8ukxJDRgmaO
         Hf1YZ8E5hAiG8tyd3cK50uykDq2X09w1BReTSm1lu1fMR2RiWvM0GnqDCi1teRBOOxs+
         WrJRzisUusA7LT+KMcgcp64KfOQ1LC1pqPBG2eKaQzNDcQ0qB8YT2eufuR7v9qky08vf
         ZNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wf9FRObg7c05dplSc7aSpQHfoX4syb8uoA/b/hLnt1w=;
        b=a3UrXW2lzSN8Szj0GPsCk31Xlk6B9MmMXNJHu87M9W2Pgh+BAnKnMcV7Fd8fAx6VD/
         X+8tQoeF7/ZN/zBfWNVjidAL7XvGOUchDJ/ps9Na2Ep4HBaa7x2md7TtBDHjXyaHAaEE
         iQdmmf9G8J3LcB9IRCPY+i01ehuzC58F05Qk19eaVvWHJ7RD/EMhrhfIhT2Vvc7wRUDq
         pYfanM0cM8ZoD2Hqy9TK7fuSgcBFYDjFoANCpjUSinUWRsnD0k5IJj3H23TTZoEI8TBG
         oncVgenDiTp3dVUM61W6638EqEdz9roViLA2AOmOXSvNeQrq9zcXPGbG+HHoAqGQCyNQ
         ollg==
X-Gm-Message-State: APzg51AEj94Izfayd5hCplfotGeCkW9JIn0V0yFpoQbM6fOR81CgztK4
        ZIMmCuD6ZMnEWAYJ4suUX1U9irSMXvK5gVvCAWDPwQ==
X-Google-Smtp-Source: ANB0Vdb8xKadbTf9y25K6WT1MM0Cs9TIimcugCusXrTo8In/VG4rbPZa//4wZ98Zy3tI3vaGmOIWvOnb1yyG+Ei1r+0=
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr17927321edi.81.1535395062263;
 Mon, 27 Aug 2018 11:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-3-pclouds@gmail.com>
In-Reply-To: <20180826100314.5137-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Aug 2018 11:37:31 -0700
Message-ID: <CAGZ79kbZRuzaoK=922b2JyfY9u8kOqm44KzKmbpWdWAkJ=SVDg@mail.gmail.com>
Subject: Re: [PATCH 02/21] read-cache.c: remove 'const' from index_has_changes()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 3:03 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This function calls do_diff_cache() which eventually needs to set this
> "istate" to unpack_options->src_index (*). This is an unfornate fact

unfortunate

> diff --git a/diff.c b/diff.c

Unlike I thought in the cover letter, this is just adding the repository al=
l
over the place and not adding new code, despite the size.

A cursory read seems to make sense, though I'd nitpick on the
choice of the variable name as I used to use 'r' for the repository
struct. I am not saying that is better, but we could think if we want to
strive for some consistency eventually. (for example most strbufs are
named 'sb', as they are temporary helpers with no explicit naming
required. So maybe we could strive to name all "repository pass throughs"
to be "repo" or "r").

It's sad to see the diff code invaded by the need of the_repository, but
the dependency is there, so it is better to have it explicit than implicit.

Thanks,
Stefan
