Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179531F597
	for <e@80x24.org>; Thu, 26 Jul 2018 20:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbeGZWP6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 18:15:58 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33162 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeGZWP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 18:15:58 -0400
Received: by mail-yb0-f195.google.com with SMTP id e84-v6so1200518ybb.0
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 13:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=su+SQ7RY6cWZlUHUoGUukQ/qhDJM5o154mXFLaTRa2Q=;
        b=F8Fc32qFg2MPNtpjPVMVzMiohIPHyiB1DvTJlJBMeXoOk7+Ba6bMDAH91DUzRXxYoJ
         S86jDjT9Q2LqpZs5RvgjPrv0HNFVKevJmxHDB74lkYMnpHQrQ4Qy0Ifu+J9+X4jHsctP
         vZp5rfAFYHXkMvib/lhBrkO1fvb6DfraM8TpIqWf5I/aYFHmjybaPOrgsTtB8agD0puV
         oCUQuOKbBLHE3xmeccLUt0hAQmR3X499b8HHkahSLFtwsfIE13LDzrSfigxpDNQO4saT
         8yL5jYG6SNNcSRY/ZFdM5UYyDr74lkXBFYHwBG47QUEk2raQE+cTImhNwXzQTkIu2LAs
         NCgA==
X-Gm-Message-State: AOUpUlGNZ8fY1zkzQRfsACIlDy9e+BvUm95VBjTODKocJOaQ1F0tMprq
        uZ0nYDpfnGbqJawPkVmLwuwsfU2lGxQIRKgWqV8=
X-Google-Smtp-Source: AAOMgpfJqay0ogUR/UDjAtepKzIap38DKow/Hm7JJ+BJHBLG+3Lx//Q3epCVi77V/qHdLlivkT1IlyPk2qar5VD12Do=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr1899701ybf.287.1532638643589;
 Thu, 26 Jul 2018 13:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-3-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet>
 <CAPig+cTKGd8N78XvW-rmBEZC7ykcJsE+na1V_vCVXTUhGrFe4Q@mail.gmail.com> <nycvar.QRO.7.76.6.1807261249490.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807261249490.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 16:57:12 -0400
Message-ID: <CAPig+cSYXYrEdJMpkC_emi3u5PY2GFmZw0nsn5EbEBtU28ZXtw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] format-patch: add --range-diff option to embed
 diff in cover letter
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 6:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 17 Jul 2018, Eric Sunshine wrote:
> > On Tue, Jul 17, 2018 at 6:31 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > BTW I like to have an extra space in front of all the range-diff lines, to
> > > make it easier to discern them from the rest.
> >
> > I'm not sure what you mean. Perhaps I'm misreading your comment.
>
> Sorry, I was really unclear.
>
> In the cover letters sent out by GitGitGadget (or earlier, my
> mail-patch-series.sh command), I took pains to indent the entire
> range-diff (or interdiff) with a single space. That is, the footer
> "Range-diff vs v<n>:" is not indented at all, but all subsequent lines of
> the range-diff have a leading space.
>
> The original reason was to stop confusing `git apply` when sending an
> interdiff as part of a single patch without a cover letter (in which case
> mail-patch-series.sh inserted the interdiff below the `---` marker, and
> the interdiff would have looked like the start of the real diff
> otherwise).

The new version[1] likewise indents the interdiff to avoid confusing
git-am / git-apply.

[1]: https://public-inbox.org/git/20180722095717.17912-1-sunshine@sunshineco.com/

> In the meantime, I got used to this indentation so much that I do not want
> to miss it, it is a relatively easy and intuitive visual marker.
>
> This, however, will be harder to achieve now that you are using the
> libified range-diff.

I toyed with indenting the range-diff in both the cover letter and
below the "---" line in a patch. With the libified range-diff, doing
so involves modifying the range-diff implementation (rather than
having the consumer of the range-diff manage the indentation locally),
so it adds a bit of complexity to show_range_diff(), though perhaps
not too much.

However, I opted against it for a few reasons. First, "header" lines
apart, all lines of the range-diff are already indented, and the
existing indentation was sufficient (for me, at least) as a visual
marker. Second, range-diffs tend to be _wide_, especially the header
lines, and I was loath to make it wider by indenting more. Third, due
to the existing indentation of the diff proper, a range-diff won't
confuse git-am / git-apply, nor will the unindented header lines, so
extra indentation seemed superfluous.

> > > > @@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > > > +     const char *range_diff = NULL;
> > >
> > > Maybe `range_diff_opt`? It's not exactly the range diff that is contained
> > > in this variable.
> >
> > I could, though I was trying to keep it shorter rather than longer.
> > This is still the same in the re-roll, but I can rename it if you
> > insist.
>
> I think it will confuse me in the future if I read `range_diff` and even
> the data type suggests that it could hold the output of a `git range-diff
> <options>` run.
>
> So I would like to insist.

In the new version[1], this variable is named 'rdiff_prev' (the
"previous" version against which the range-diff is to be generated).

> > > > +format_patch () {
> > > > +     title=$1 &&
> > > > +     range=$2 &&
> > > > +     test_expect_success "format-patch --range-diff ($title)" '
> > > > +             git format-patch --stdout --cover-letter --range-diff=$range \
> > > > +                     master..unmodified >actual &&
> > > > +             grep "= 1: .* s/5/A" actual &&
> > > > +             grep "= 2: .* s/4/A" actual &&
> > > > +             grep "= 3: .* s/11/B" actual &&
> > > > +             grep "= 4: .* s/12/B" actual
> > >
> > > I guess this might make sense if `format_patch` was not a function, but it
> > > is specifically marked as a function... so... shouldn't these `grep`s also
> > > be using function parameters?
> >
> > A later patch adds a second test which specifies the same ranges but
> > in a different way, so the result will be the same, hence the
> > hard-coded grep'ing. The function avoids repetition across the two
> > tests. I suppose I could do this a bit differently, though, to avoid
> > pretending it's a general-purpose function.
>
> If you can think of a way that would make this easier to read for, say,
> myself if I ever find myself debugging a regression caught by this test, I
> would appreciate that.

In the new version, the function is gone; it looks like this:

--- >8 ---
for prev in topic master..topic
do
    test_expect_success "format-patch --range-diff=$prev" '
        git format-patch --stdout --cover-letter --range-diff=$prev \
            master..unmodified >actual &&
        grep "= 1: .* s/5/A" actual &&
        grep "= 2: .* s/4/A" actual &&
        grep "= 3: .* s/11/B" actual &&
        grep "= 4: .* s/12/B" actual
    '
done
--- >8 ---
