Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD8320248
	for <e@80x24.org>; Fri, 15 Mar 2019 01:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCOB4p (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 21:56:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43676 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCOB4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 21:56:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id d22so6038215otk.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 18:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3eCWAYm2i2TCakzVvzAedvibu+iVP78T2zd71oQeG0=;
        b=VsdBpfCBk2ryEfyxniclY8UttSF/rgUkvKeVJe8SMVpGLKWnbBCy3J2FnztxRAhiXc
         yWgvCe3UwL4HDfUTgBqn6wzN8VbVxFj7vfnim1ct03BZAS8QhE7eRzeRTdJbPBzWOjbV
         geAGNdQm9PcTXQlpSxq0u43eA6zxAvKHw3H7igVlg/l2/oP3z5LTdFkCLfMRG0fShSA7
         SzU/LjrRWVZwlwUl0a6Kr6dxQGbaStH5uqzeEzd0uvX6+q6Bi0b5beOI9jI9WzNcPM3H
         IKx7gnHJ+wyXLsXnABIXhvKIPR/e4asqSc5GHd32XfB87UgL9TADRXGXNYZ3cpP53oIT
         V7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3eCWAYm2i2TCakzVvzAedvibu+iVP78T2zd71oQeG0=;
        b=ERZfcNWCqqR/bveJDY4jXKvtEjRQ0+h3xLuBAqF9p56Tjx4zCqU8x3rEz1dxihhMY2
         JqNFOTmLtI9LRhLSnqSLekgB4HL0aseWWAQk4TLMrLTZw1zj3ZtWNCDDz2SiG/wrP4vA
         m1aogsQFyeUTTjRPOKLPDsTRSOU30SjkFZ4s/UiJwivGnejvXzAYIXx8QCxaXvXso0gs
         p592ADA+goMMVklRw3cLK/D9BM16VCb/Z+ju5uYxp3Tev5INT4j84k9qAszFu4mpCv/f
         7xXKTOLV6XqB5tNEpnPw/+N6kBXwAQcDQmHny1ywDsF6scsyOb5LuC4FlKFVT/4pfJ6J
         RXhg==
X-Gm-Message-State: APjAAAXmoIW65/LHUxerMypT4Rb6NyZI05YFjoEHxK48KvAvJkh4nzBy
        tFuiy0WU4xV5DxUiRoWH1RDqbXTQLmF/wTDRQ80=
X-Google-Smtp-Source: APXvYqxqmpm/OoW7XqIAFbTACVRjWmoRKOZs7larqOg1MoS9kX3GY4am8IfTPAc57l+KbXG01ozPKPZF9u3Yzt0lzGI=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr653388otl.366.1552615003688;
 Thu, 14 Mar 2019 18:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190310080841.64082-1-ttjtftx@gmail.com> <20190310080931.64134-1-ttjtftx@gmail.com>
 <CAPig+cQP74MC6fJC4fNCz9Rz3tDux1K4TGB7N+cOC8zScxOoAA@mail.gmail.com>
In-Reply-To: <CAPig+cQP74MC6fJC4fNCz9Rz3tDux1K4TGB7N+cOC8zScxOoAA@mail.gmail.com>
From:   jonathan chang <ttjtftx@gmail.com>
Date:   Fri, 15 Mar 2019 09:56:33 +0800
Message-ID: <CAOAu_YLGDAije4ugkPYh-11QMKVUEbGZNC335F4VtnszJO8Q9A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 3/5] t0003-attributes: avoid using pipes
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 6:13 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Mar 10, 2019 at 4:09 AM Jonathan Chang <ttjtftx@gmail.com> wrote:
> > The exit code of the upstream in a pipe is ignored thus we should avoid
> > using it. By writing out the output of the git command to a file, we can
> > test the exit codes of both the commands.
> >
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> >
> > diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> > @@ -203,15 +203,18 @@ test_expect_success 'attribute test: read paths from stdin' '
> >  test_expect_success 'attribute test: --all option' '
> >         grep -v unspecified <expect-all | sort >specified-all &&
> >         sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
> > -       git check-attr --stdin --all <stdin-all | sort >actual &&
> > +       git check-attr --stdin --all <stdin-all >actual &&
> > +       sort -o actual actual &&
> >         test_cmp specified-all actual
> >  '
>
> There is no existing use of "sort -o" anywhere in the Git test suite
> (or, for that matter, anywhere else in Git), which should give one
> pause before using it here. Although -o is allowed by POSIX, and POSIX
> even says it's safe for the output file to have the same name as one
> of the input files, there is no guarantee that "sort -o" will be
> supported on all platforms, or that all platforms promise that the
> output filename can match an input filename (in fact, neither the
> MacOS nor FreeBSD man pages for 'sort' make this promise).
> Consequently, it would be better to err on the side of safety and
> avoid "sort -o", which is easily enough done by using another
> temporary file:
>
>     git check-attr --stdin --all <stdin-all >output &&
>     sort output >actual &&
>
> The same comment applies to the remaining changes.

Noted. I did check POSIX, I should have also checked the use in Git.

Thanks for the review.
