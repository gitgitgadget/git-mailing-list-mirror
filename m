Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB351F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeKFFrs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 6 Nov 2018 00:47:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37550 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFrs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:47:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id p35so128852qtc.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mzTquz2bLXuyBOI7fwjc3b0ajJVRJ3pWHMy4aJ3pdcg=;
        b=DiJcp5AdmWVd9SA0K+j86yzkLaN0BuJD6SBwIpBa85fF/Ef0npzczjYwHNZdUHpWLE
         7V3KlQsL45Acck0F6UiRVCZsDXYIT8x0qjZQcPDZ8nOiB6nnW/LTDLpd1YJQHFNzYQiq
         WC+SCx3233gv6s61aWKnrt9fnOzWxoBF/MxISr2Y0LJ/a5Zxd93i1muBLl8BzpaT7ymy
         4e44C1Kv+AGuJ9u7WRGfwtWmf8o2+PPfna4TByYsuAZBi062oMWPhCtQvj7mSyh/K/EF
         uGAEk8Qg5ZSMj/YpdY2UWSGzwbxC7wwYrZT+1N6GFYSKZsX9WhnxgZWet9OAX2916Kue
         WwLA==
X-Gm-Message-State: AGRZ1gJy6/WMPZduLkG+pcbOXXidC1hS+pr+s4t7JE3yNBIh/T4g/P7q
        Mrm9p0P8l2sp1bgLhBHQV3Palkn9AWI3hRKRkXw=
X-Google-Smtp-Source: AJdET5df9+LpfsmPZYVyhV4AQDJNxxpxB4PlRLtGxj0gdGGM9XQN0D3tHP2/TYi7UoboUtj8+pR6pfWfW7cV/Ox+NL4=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr23029857qve.203.1541449583137;
 Mon, 05 Nov 2018 12:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20181105200650.31177-1-avarab@gmail.com>
In-Reply-To: <20181105200650.31177-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Nov 2018 15:26:12 -0500
Message-ID: <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        lucas.demarchi@intel.com, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a --no-patch option which shows which changes got removed, added
> or moved etc., without showing the diff associated with them.

This option existed in the very first version[1] of range-diff (then
called branch-diff) implemented by Dscho, although it was called
--no-patches (with an "es"), which it inherited from tbdiff. I think
someone (possibly me) pointed out that --no-patch (sans "es") would be
more consistent with existing Git options. I don't recall why Dscho
removed the option during the re-rolls, but the explanation may be in
that thread.

I was also wondering if --summarize or --summary-only might be a
better name, describing the behavior at a higher level, but since
there is precedent for --no-patch (or --no-patches in tbdiff), perhaps
the name is fine as is.

The patch itself looks okay.

[1]: https://public-inbox.org/git/8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de/
