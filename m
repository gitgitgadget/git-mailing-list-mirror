Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E94C1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfHGU0M (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 16:26:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41699 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfHGU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 16:26:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so86693378ljg.8
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkL8V9YivciBjs+rV/150mGYlHxI5DSWKjjGRXK1g5E=;
        b=qdKhghocXJCLoTLzBxMSVJprlyu/D6gx4i27CwtRRM3jG7HaLMYQ3n8EgrOuuhkiap
         QIbPot97S7VumXeCk0XGxAb8Uv8xt1rVRIRxpB9NoWlpcXJe/CJUKBq7GEFdS3Tfht9Q
         GGrGDZnWaleMQuNOq5ZMdfWB2OzrgfRsi0FEV9J0bhAdIsTeiw9z8hkTQMbY34nlrabY
         zoxr+SJKeFJbRu2imhxiEKGCG7Td6yBAh2g3u80xorLSSpZWRPBQeMkVfI4jDL68Qsex
         qg5GoUAwvNfdQsqPY6N5OZu3mADYgWFFnnbtAVtUgjh5AiZF28gC+f/WOuM7a5GBW8XF
         2jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkL8V9YivciBjs+rV/150mGYlHxI5DSWKjjGRXK1g5E=;
        b=AnCpo0xd9ePmcEYviiJ5Asfw8GZPcQnBG4W2NiuJ7zOLMVHH+PiHyJQ08dS5uzRO03
         Kll7WbfdIsvVFxUeYmaUrj4edBALX3DrYdVncZxe0qSJmyBnClqYOSSZR8fTI2u6EcRl
         tiwtOTqdeL6z3tHMdEx/qmxG9y0nqshJlZm1ti43215zvFBFVp/9RCytCm8T8r6KO7Xb
         aNwarCc9p+UlChDAiWlRHsO/WZIhk2d9yyGGt8luDpBONcv95fHolhL1A+U9LKKgl7VC
         ZbWsrg5fIoiO1JGgHkrOUK2GbMIbTxYURp+09gV6n3JbLqCJbCo7aWwwNKlRZ4yRHYx5
         MGSg==
X-Gm-Message-State: APjAAAXfOXcmSenzMj//vp6vZMLWIfLElDXLx2gcZ4vRxXkdGh420/mL
        esHrviSnyY2spU6CzH5Jy9gO8PfJxira+tpg6D1mhCfXdd4=
X-Google-Smtp-Source: APXvYqwY8/sWmoZmjQ8Dx9rwtC11zjPbkvHdzyN/Gr8CooSRH1IJHl/Ot1TgkKhuI82HqhU5q015qm5pr21Sdjkzg/k=
X-Received: by 2002:a2e:968f:: with SMTP id q15mr5908270lji.30.1565209570034;
 Wed, 07 Aug 2019 13:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-2-rohit.ashiwal265@gmail.com> <xmqqimr9ilha.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimr9ilha.fsf@gitster-ct.c.googlers.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Thu, 8 Aug 2019 01:55:30 +0530
Message-ID: <CAL7ArXp04YM9chfrzGBzy1szxuqNuSeRmPYc35s3ZiJjoZaCQA@mail.gmail.com>
Subject: Re: [GSoC][PATCHl 1/6] rebase -i: add --ignore-whitespace flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Wed, Aug 7, 2019 at 11:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
>
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index db6ca9bd7d..3c195ddc73 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > ...
> > @@ -511,6 +523,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> >       argc = parse_options(argc, argv, NULL, options,
> >                       builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>
> Curious.  Did you rebase onto an older codebase?  I think the round
> currently queued in my tree already has c0e78f7e46 which merged the
> jk/unused-params-final-batch topic that updated this call to
> parse_options() to pass prefix.  Perhaps you want to fetch from me
> what has been on 'pu' (it should be "log master..10827432") and
> compare what you had?  Unless there is no compelling reason not to,
> it would be a good idea to base the reroll on the same commit as
> the commit on which the previous version has been queued, which in
> this case is 9c9b961d ("The sixth batch", 2019-07-19).

Oh~ I didn't notice it. I'll rebase and re send the patch. Thanks for
pointing out.

> > diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> > new file mode 100755
> > index 0000000000..e617d3150e
> > --- /dev/null
> > +++ b/t/t3433-rebase-options-compatibility.sh
> > @@ -0,0 +1,65 @@
> > ...
> > +
> > +     git checkout --orphan master &&
> > +     cat >file <<-EOF &&
> > +     line 1
> > +             line 2
> > +     line 3
> > +     EOF
>
> The second line triggers "indent with spaces" whitespace error; you
> can protect these spaces in the leading indent like so:
>
>         sed -e "s/^|//" <<-\EOF &&
>         |line 1
>         |        line 2
>         |line 3
>         EOF
>
> Also make it a habit to always quote the EOF token that begins the
> here document (i.e. <<-\EOF) when the here document does not need
> variable interpolation.  I suspect (but I did not read all of the
> tests) that there may be many other instances of here document in
> this patch that can use the same improvement.

Will keep this in mind.

Thanks
Rohit
