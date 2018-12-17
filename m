Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E8F1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbeLQU7f (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 15:59:35 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:34549 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbeLQU7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 15:59:35 -0500
Received: by mail-io1-f51.google.com with SMTP id w21so11138761ioc.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=68wG74NLu0Jcv9yZpKgrGcIuwDIT4mHtO7lj2tnv+SI=;
        b=DOq6qxaWMlHcFszYpVtYCnYY2SSqRa00c5jFn65DVhgG3CZ569onQ6y71/3TsielkQ
         38ZC2gYSHDcMLpmr7eXTRWVmcrNyQv0+2AvC7KE3RN24LF/H2oLO5YtLiOqQgnINF1pu
         asd5WCCEqblFn/fpGngw14UInG8PhwCsag2C/fOiqFlAn152mcA0mvQGjekSXu1sFQE1
         jJa45Mku+3Gqrx/ttAQzgmuyAcB1n4C760dwpmxP20+8jKCcxMhFGsJZhWHu6gQAiVH/
         KaH/C3hps4zR79Zz0KlbHdf7bZI2Dvr/Zs0L7sAKmJRWyoLNmrKs+EVlPZsbgqH5ZTw1
         Igaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=68wG74NLu0Jcv9yZpKgrGcIuwDIT4mHtO7lj2tnv+SI=;
        b=R172D8neH6XroABKUIgBQaoMeE8cDtVUohufJyuU9iVJlRKjJ5rHADxNpqLmUZsr39
         KVtS3dsKgEqaYHpJJ0x+60/fXfgz/Du6PoYEbuCU3n3W5YkjZ/Oa2lZM1rlnp/9ZnQ9o
         wOL9J38GV5NIMp48GnsCDGbjdO6CSPGgbRWnlKEnn9IvwP038yGmelP6HgWIabhI4XWv
         MkPslPcmRPCbyq/EUkYTAUVfLZFJT6FK1OUVDNvkKuKZ9vPbct039PNQoNfO+lWFcKZt
         QAdfyzE+h20h1dp0LPaptH7tKEXpUiivv5BCT4WulqBDKQH1QQZdjQsIor7OWfV0jRWZ
         TVBw==
X-Gm-Message-State: AA+aEWbSxlCBSEduMreQR2Afnn2glZj3acqmJIBWojc2bZB9Z5gXBQXF
        UdcmCo/6YXMhDtQoEcUSxbgtqKkZMicDLxcmng0=
X-Google-Smtp-Source: AFSGD/ULQrBWNI0EabAYEZOB9NH1/BCWGwGBL4c01e0/paSWMY/uf0Ie5NtlNKdm7WXOu+wMnaUHiysYpKjejy+JiVk=
X-Received: by 2002:a6b:bc83:: with SMTP id m125mr11905717iof.83.1545080374112;
 Mon, 17 Dec 2018 12:59:34 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
 <3f3e7b11-19ef-cc2f-3bd4-e03d9ba8dc91@gmail.com>
In-Reply-To: <3f3e7b11-19ef-cc2f-3bd4-e03d9ba8dc91@gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Mon, 17 Dec 2018 12:59:33 -0800
Message-ID: <CABXAcUxNAr0H+EOmzv_TsW026Y-yDET01PeU3PtgcOmuFE5rjQ@mail.gmail.com>
Subject: Re: Git blame performance on files with a lot of history
To:     stolee@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 1:31 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Please double-check that you have the 'core.commitGraph' config setting
> enabled, or you will not read the commit-graph at run-time:
>
>      git config core.commitGraph true
>

Yeah, this is what happens when trying too many things at once :( I
had removed it to get
with/without scores, and forgot to re-enable it before trying my last
set of experiments.
Here are the results with it enabled:
> time GIT_TRACE_BLOOM_FILTER=3D2 GIT_USE_POC_BLOOM_FILTER=3Dy /path/to/git=
 rev-list --count --full-history HEAD -- important/file.C
10:32:06.665057 revision.c:483          bloom filter total queries:
286363 definitely not: 234605 maybe: 51758 false positives: 48212 fp
ratio: 0.168360
GIT_TRACE_BLOOM_FILTER=3D2 GIT_USE_POC_BLOOM_FILTER=3Dy  rev-list --count
HEAD -  2.62s user 0.14s system 97% cpu 2.830 total
> time /path/to/git rev-list --count --full-history HEAD -- ic/lv/src/iclv/=
drc_compiler.C
3576
/path/to/git rev-list      8.86s user 0.15s system 99% cpu 9.031 total

So I'm getting a 3x benefit, not bad! This is on the re-repacked repo,
which is why I ran again
with and without the Bloom filter.

Let's see what this does for blame:
> time GIT_TRACE_BLOOM_FILTER=3D2 GIT_USE_POC_BLOOM_FILTER=3Dy /path/to/git=
 blame master -- important/file.C > /tmp/foo
Blaming lines: 100% (33179/33179), done.
12:50:42.703522 revision.c:483          bloom filter total queries: 0
definitely not: 0 maybe: 0 false positives: 0 fp ratio: -nan
GIT_TRACE_BLOOM_FILTER=3D2 GIT_USE_POC_BLOOM_FILTER=3Dy  blame master --
>   132.59s user 2.15s system 99% cpu 2:14.95 total

Seems like it's not implemented for blame operations. I'll be happy to
test any implementation.

Take care,

Cl=C3=A9ment
