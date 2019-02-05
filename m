Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4705D1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 15:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBEPyw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 10:54:52 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37735 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBEPyv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 10:54:51 -0500
Received: by mail-vs1-f66.google.com with SMTP id s16so391991vsk.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82ldfuO6xtw9uWR0HKZg4Q0Kzpacn3A/n9NgDvf5o6Q=;
        b=FPtobwXTueIl1Qqb0TwEMyio0SLdsCbG96hKKbRvW+K2QHY5+AryE8YNXeShLJaazr
         pGJ04VYMOMWGkNLMlM0T3I1X6/7g0cQLbGx20BrRy/AbkT+ucLHeNGKYHZhOrOLhEKWv
         me0SCQNZCw6MMZkI+npXiWPQBkEL2issiiIxNqasxOYsjBNDcNxzq+knbD2iVuyjf8nh
         6zSxxRPilZOTcZS3QbIaWcLB5kJO18fzHVp/zGZiD5vkpS6L3hZ0mbI/OK1Hv/T+0Gi9
         uHDa6b+q57ldBmcrVEoHY8PJzYt7zHGxVnOkLzRHay2M//+TeXMUt2pl5Ntc8M76YPNG
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82ldfuO6xtw9uWR0HKZg4Q0Kzpacn3A/n9NgDvf5o6Q=;
        b=NhGOBahtTFZRUK16RQZANePuBp+/VBA/+EbLGqalkwcHsPclGx4I/HZ1TZykQMfz1n
         vHLcp3b0n8hDYUY7sz0ICQsLXnpTBrXvh+mj/6NQD9R34QYVSRVAqA19dUC7LsD3tAfG
         peG3f3xnhWQfHz3cr2rFRbh+ElNRcsntd2tkMWIDI1nwxr+d1PXfD1gYKd+XR/x76F0Y
         9rZoxV/3zGD4wm/YsGbqi9e7KRUudC2gWzZQPBdp+K/GLQLQf06oiPblduWd2HUAoChA
         0LX17+skdPeAjy4Gt+ncmNQ8D6BEn4GCoN+7vhKUrdGJJjCtNJsOsS1imuLWcxGKAK9A
         DsKA==
X-Gm-Message-State: AHQUAuahRWoNjl/9y1eO8hUFdF4aPkI9yPNMFjR6LBTjN9zNXBwAoLwy
        Kp1f+EUb6uCQMi6kgq8Reom5jRE05ROMvyFsSNA=
X-Google-Smtp-Source: AHgI3IY9uEuJ+1II3O4gFbzzwxnPhfP5jI7OhL1fBQIkJqspwdP0okfOJS5h5nbKKGmQhbH8Ge2mGortF0fL+QJenFQ=
X-Received: by 2002:a67:44c4:: with SMTP id y65mr190628vsf.53.1549382090410;
 Tue, 05 Feb 2019 07:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <nycvar.QRO.7.76.6.1902051045460.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902051045460.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Feb 2019 07:54:38 -0800
Message-ID: <CABPp-BGQ62Mj1jym8-xu5XKN6mJ65yq-QUqXjR-xx=AWFZgNbw@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Feb 5, 2019 at 1:48 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 4 Feb 2019, Elijah Newren wrote:
>
> > The combined diff format for merges will only list one filename, even i=
f
> > rename or copy detection is active.  For example, with raw format one
> > might see:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   describe.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   bar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   phooey.c
> >
> > This doesn't let us know what the original name of bar.sh was in the
> > first parent, and doesn't let us know what either of the original names
> > of phooey.c were in either of the parents.  In contrast, for non-merge
> > commits, raw format does provide original filenames (and a rename score
> > to boot).  In order to also provide original filenames for merge
> > commits, add a --combined-all-names option (which must be used with
> > either -c or --cc, and is likely only useful with rename or copy
> > detection active) so that we can print tab-separated filenames when
> > renames are involved.  This transforms the above output to:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   desc.c  desc.c  d=
esc.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   foo.sh  bar.sh  b=
ar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   fooey.c fuey.c  p=
hooey.c
> >
> > Further, in patch format, this changes the from/to headers so that
> > instead of just having one "from" header, we get one for each parent.
> > For example, instead of having
> >
> >   --- a/phooey.c
> >   +++ b/phooey.c
> >
> > we would see
> >
> >   --- a/fooey.c
> >   --- a/fuey.c
> >   +++ b/phooey.c
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> I do not really see where this needs to have tests with filenames
> containing tabs, but your test does create such files. Which makes it
> break on filesystems that do not allow tabs in file names, such as
> NTFS. I need this to make the test pass again:
>
> -- snip --
> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 5bccc323f648..596705985baa 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -435,7 +435,7 @@ test_expect_success 'combine diff gets tree sorting r=
ight' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'setup for --combined-with-paths' '
> +test_expect_success FUNNYNAMES 'setup for --combined-with-paths' '
>         git branch side1c &&
>         git branch side2c &&
>         git checkout side1c &&
> @@ -456,7 +456,7 @@ test_expect_success 'setup for --combined-with-paths'=
 '
>         git commit
>  '
>
> -test_expect_success '--combined-all-names and --raw' '
> +test_expect_success FUNNYNAMES '--combined-all-names and --raw' '
>         cat <<-\EOF >expect &&
>         ::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 0=
88bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d4=
0ee1b RR    "file\twith\ttabs"      "i\tam\ttabbed" "fickle\tnaming"
>         EOF
> @@ -465,13 +465,13 @@ test_expect_success '--combined-all-names and --raw=
' '
>         test_cmp expect actual
>  '
>
> -test_expect_success '--combined-all-names and --raw -and -z' '
> +test_expect_success FUNNYNAMES '--combined-all-names and --raw -and -z' =
'
>         printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644=
 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c=
2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttab=
s\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
>         git diff-tree -c -M --raw --combined-all-names -z HEAD >actual &&
>         test_cmp -a expect actual
>  '
>
> -test_expect_success '--combined-all-names and --cc' '
> +test_expect_success FUNNYNAMES '--combined-all-names and --cc' '
>         cat <<-\EOF >expect &&
>         --- "a/file\twith\ttabs"
>         --- "a/i\tam\ttabbed"
> -- snap --
>
> But maybe you want to get rid of the funny file names? Or test for them i=
n
> a separate, dedicated test case so that we do not have to guard *all* of
> your added tests behind FUNNYNAMES?

I don't want to get rid of them; the initial reviews of my original
patch thought the format was ambiguous and would mishandle files with
tabs in them.  But yeah, I can definitely add a few testcases without
FUNNYNAMES.  Sorry for the headache; I'll fix this up.

Elijah
