Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF98C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 10:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157D24686
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHR/nSWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1KCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:02:53 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:46159 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgA1KCw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 05:02:52 -0500
Received: by mail-qk1-f181.google.com with SMTP id g195so12697083qke.13
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LH3ok7Qh/69jOoZYQxfd6jsk0VcbBEETF7rGfcDpswE=;
        b=pHR/nSWMtbL8nBW5rLKoq01RwfKxXe5o5Fsa9t/lc48XRIm1j6yh4b7laBnGtc3WW3
         nEZgLSRHsVXo8ftefkbHGzXlSovGtS31Zc1eKYjYohJ1h4bXVtmctpBBGAL1OV+ohVOO
         snyxJOdf3uK3/Fex7hWugEW0bjRM+Cw5X/rrfxC87ZaNXLicNmu45p70u20f5PYyH0sa
         XTrHGP+Dx1P4O8VYWwj3v3KsdN8j0npBB2gDt1RujFT+8fH7t8GCts4nE+2btyGjNRiq
         /Bqv2uYaVQhum1z7stlxqQ5UXLJ3AWxjl8f8YoL5dPdhIJF7uf1rd4Hqn+GosyG9a3LT
         YVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LH3ok7Qh/69jOoZYQxfd6jsk0VcbBEETF7rGfcDpswE=;
        b=CNhdCiaOWy6nyThgaAPliLTpaMbJ4QhfO5jkF3JvcCo86MPxfKjRh+SeWxjpayNl+c
         0ZEcjGutcfkGfUc58anX2qXwV9vbdzjW9jjgQtbxo4E1ejJV1hffMp7Pogqs/Prn6X2H
         U0WYFfuoh3d9dvoPKpSJ5sy6nWG0Ie4r3Ma4Twb3WjiCP0Pz+bXUJLRTTM8kwwAGeu9L
         TbEa324hmdoh3gpNlKe0fi33bILNglMsDiDfZ2VUhnJGX+duOMx1lEKr9Qrjk4PUTgKW
         USD4521XZWL/aIHdEd6rVbZeK0pT3zJ5MWdcoUbmEAVsAEHqNTLzhxDkuStc9YhHop71
         pGPg==
X-Gm-Message-State: APjAAAW8JkjOykffyp09r3Pp8JvVFkja2fus3tW3GetAT3z9vs8RG4Pf
        6G0FHm+tpnjJRegImdZL7hax6JEAi0RFpFD/s5M=
X-Google-Smtp-Source: APXvYqxv7Y2X3AXrJ+7dV4c3U9wsL31u3pPvqAC4JuSm4bxZkn+RzlBT/CR+bQYqaxGubq3Ebnr4GzdZ7qvT2/mgFBU=
X-Received: by 2002:a37:9245:: with SMTP id u66mr21976370qkd.102.1580205771758;
 Tue, 28 Jan 2020 02:02:51 -0800 (PST)
MIME-Version: 1.0
From:   abhishek kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 28 Jan 2020 15:32:06 +0530
Message-ID: <CAHk66fs+FX_W+MwOCOF1_zw_vPz73D+0HbTrb7sXTHzgnWhzQQ@mail.gmail.com>
Subject: Re: [GSoC] Doubts in an issue
To:     shouryashukla.oo@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Shourya

I am not exactly Johannes (just another GSoC applicant) but here's
what I understood from the issue and your thread:

> And what exactly do we mean by "built-ins" here(does it refer to the "dashed" commands)?

"Built-in" refers to commands implemented in C [1][2]. The more common
use of "built-in" which is a command that the shell (bash, sh, ksh)
carries out itself [3]. The name draws out the similarity between
shell builtins and git builtins, both written in C and executable
through the shell.

Therefore, "hardlink built-in to the corresponding dashed forms" is to
create a hard link with the dashed form name to the C program.

> where is the <<libexec/git-core/>> directory?

As the makefile suggests, the programs and scripts are installed at
`gitexecdir`. I couldn't find it but instead found `GIT_EXEC_PATH`
which point to pretty much the same thing. You can find it by `git
--exec_path` [4].

> Now, whenever we call scripts whose "dashed" version exists, it will sort of link the "dashed" version as well for I guess historical reasons? ;)

No. Creating hard links is done during the build process. But calling
`git-<script-name>` through `git <script-name>` makes `git` prepend
`libexec/gitcore` which is necessary to find the hard link. So, you
are half-right :).

Regards
Abhishek

[1]: https://github.com/msysgit/msysgit/wiki/Why-Is--libexec--so-huge%3F
[2]: https://github.com/git/git/blob/master/builtin.h
[3]: https://unix.stackexchange.com/a/11465
[4]: https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
