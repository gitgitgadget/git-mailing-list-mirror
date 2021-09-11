Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF9DC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9454060F92
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhIKJRI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Sep 2021 05:17:08 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46844 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhIKJRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:17:08 -0400
Received: by mail-ej1-f52.google.com with SMTP id kt8so9304363ejb.13
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d2BAHIOSJyvHTcFkpXF7u8xjDQe2wUtJMiyKZuVZ4mE=;
        b=o9iEGoYlZG1OF/xwS4Jjupg4yH08dxa9wyyOxN3pF6nYfS3jt03jPNz0Wk5OOzb8w3
         aozZ/SfMRa0gmgdFMKSpSL5fPPal17jgn0ozw9wgpTmhn1vz7xWkmeSUC+iavi8YF4Qt
         9GUtYSmytrOHa76oAv8JxA245FLH99bdRUILwNiTLAYalAg4HRIaKT+CAzVSFbwRw1PT
         wV5Kzg+E8acoP2mD7U7Blk4aARki//W2SV4XS6h7q44EPVuw/mlOr51e5P9yMbPQDnCY
         GGBfr2Ychz4AInUf0iZ4mOlHXfO1LrcKy51/9Kv/dpvdDsS39nSRn7MLIcsZsSIAAX6T
         EWwA==
X-Gm-Message-State: AOAM5300TPOSsIPl5as2iKKmm+7VW7xxBflt+rXniQX5FqeNK0a9owmg
        oU6ZSmm+QOL/XyfyOLEmQ155Fky7WvVqMPF1LZ4=
X-Google-Smtp-Source: ABdhPJwmwfpjfnCl/yjQu9q9SisKBcS9hF3b4BG6JXF4KH5/EmXS4IdQlJtnahbKkobPmy+WgtvSly0lrQG++mUkrtQ=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr1966746ejr.36.1631351754947;
 Sat, 11 Sep 2021 02:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
 <xmqqeeaa4y0v.fsf@gitster.g> <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
 <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
 <xmqqwnnos2jz.fsf@gitster.g> <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
 <878s03c1of.fsf@evledraar.gmail.com>
In-Reply-To: <878s03c1of.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Sep 2021 05:15:43 -0400
Message-ID: <CAPig+cQ+qVNBJqHmQgk6D1fbYHHJpAxhfwyBOgevi9Hvs6JYkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 9:59 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> >> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> > Have we made a decision about whether this patch series -- which
> >> > avoids indenting blank notes lines -- is desirable? Or are we worried
> >> > about backward-compatibility?
>
> This change per-se seems nice, but even having reviewed it to the point
> of rewriting parts of it, I didn't really look into what the whole
> workflow you were trying to address is.
>
> So e.g. just to pick a random commit of your for show:
>     $ git show c990a4c11dd | sed 's/$/Z/'
> Here we end up also adding the whitespace indenting to the empty lines,
> whereas if we were trying to feed this to an editor we'd place those
> later Z's at the start of our line.

I'm not sure what you mean by "feed this to an editor". Do you mean
sending the output of `git show` to an editor? I'm guessing that's not
what you mean, and that you instead are talking about editing the
commit message in an editor (say, via the "reword" option of `git
rebase --interactive`).

> Are notes different? Or are they just similarly indented? For commits we
> don't insert that leading whitespace in the commit object, do notes get
> that part wrong too?

Notes don't store the indented blank lines; it's only at output time,
such as with `git format-patch --notes` that the blank lines get
indented along with the rest of the note text (just as is happening in
your `git show` example in which the entire commit message is being
indented, including the blank lines).

> It might be showing, but I've only used notes a few times, my main use
> of them is Junio's amlog.

I also have only used notes a few times.

> So even for someone experienced in git, I think some show & tell of
> step-by-step showing in the commit message how we end up with X before,
> and have Y with this change would help a lot.

This all came about due to two unrelated circumstances: (1) a few
months ago, I configured Emacs to highlight trailing whitespace, and
(2) I decided to use `notes` to add commentary to a commit since,
although I normally just write the commentary directly in the patch
itself after running `git format-patch`, in this case, it likely will
be weeks or months before I finish the series, and was worried that
I'd forget the intended commentary by that time, thus recorded it as a
note. Since I've almost never used notes, I ran `git format-patch
--notes` as a test and was surprised to see the trailing whitespace on
the "blank" lines when viewing the patch in the editor.

This submission started as a single patch which just "fixed" the bug
and added a test. Only after that was complete (but before I submitted
the patch), did I discover that other tests in the suite were failing
since the "fix" also changed git-log's default output format which
includes notes (indented). Since I so rarely use notes, I had either
forgotten that git-log showed notes or didn't know in the first place.
The submission grew to multiple patches due to fixing those
newly-failing tests.

Anyhow, since then, I've discovered that `git format-patch
--range-diff` also indents blank lines. And you've now shown that `git
show` does, as well, so the behavior which triggered this "fix" turns
out to be somewhat normal in this project, rather than a one-off "bug"
in need of a fix.
