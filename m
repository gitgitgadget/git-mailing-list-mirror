Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF4C1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeHQXUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:20:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36081 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHQXUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:20:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id b22-v6so6742039lfa.3
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWVYF3+TRiY8MP2R/0v0dBgEeKF+c/xsLmNbwhosx8k=;
        b=dh/eI8kSePGbSnnTfN0/YFSZV5S4tHRwn9rxvd+Yf8RRowoMQkEBrXguWCltwfwyxX
         VCd690u7fQDi55CjK0rjMz9l8rVSZ1BlR7DlgJBVwdabPfQXBawnRS1k1r9/7k6sMjyq
         uJSJKJVHSXFt4HkMGpHrxSRu3Yf81i4XGF36cExL0TggDu1ApUxMB1ePRQNJK2Noio3H
         eddEQU2bkaOr6vM16a9Mdmiutd1uCRDxWHHVNQ8vHZ7BnECKeY2BrANmB6QIkaV012aM
         /8k3DjcdxKvDD8CS2M199LTCA0Q1CRMwMog6cbrIVc+06VJt2kbpU4VU0NuxIfXQS01V
         E0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWVYF3+TRiY8MP2R/0v0dBgEeKF+c/xsLmNbwhosx8k=;
        b=ZbqmciB1OJE3Hdmk1sMTxtQqNSbSi1Vz2IHkpqXM0xaqHxmfK61fVdnUIzjAqGxPcl
         bEk4Yfj9AcFVtC7jRJcvPFbLhUjtb1fMMwZFz0+wPm0i2xwbKLQg4QW0Y7/URd6j1+Wa
         NBZppTUcjTJp6II/5uFIR2AC0VnL2/sP434x56BdUUpJoNYszNvy5KAXDgka8fVbPiGc
         /ldA47m7riTB6BPfnnu1kfj5GPzcdMHPln2mphlyzLgRqGig+csU2gGXdY9l79zHs00F
         1r5tNEOLEgGMVle7Ian6kLZIsbYYVm1MEpRh0HnVEX6w0kf51IFklch1xXGNJJMLAVMw
         6NYw==
X-Gm-Message-State: AOUpUlHVNkxoJOxwVuNyl8S3hm2HcodyIqf58d1f+x37BDYaPEg88Whs
        ziJA/xe4znFEv0lUpdzHPNWJhdvEnk/YJ8yriQw=
X-Google-Smtp-Source: AA+uWPxKWGY+wQgfqmRaDKLIB2Y95teshdG2JftVQYLzrDMMDHgcczXuAmw65mzVB9qK6ywKE31JUSybflTG4RmeVmk=
X-Received: by 2002:a19:5154:: with SMTP id f81-v6mr5766248lfb.55.1534536930895;
 Fri, 17 Aug 2018 13:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180814114721.25577-1-szeder.dev@gmail.com> <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com> <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
 <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
In-Reply-To: <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 17 Aug 2018 22:15:19 +0200
Message-ID: <CAM0VKj=rw14MbLbXvuJiiwf05Txo1tu6A8xzy+_3RHOytX8mXA@mail.gmail.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     rybak.a.v@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 9:27 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 17/08/18 19:39, SZEDER G=C3=A1bor wrote:
> >
> > See, we have quite a few tests that extract repetitive common tasks
> > into helper functions, which sometimes includes preparing the expected
> > results and running 'test_cmp', e.g. something like this
> > (oversimplified) example:
> >
> >   check_cmd () {
> >         git cmd $1 >actual &&
> >         echo "$2" >expect &&
> >         test_cmp expect actual
> >   }
> >
> >   check_cmd --foo    FOO
> >   check_cmd --no-foo ""
>
> I've only had time to look into this from t0001 up to t0008-ignores.sh, w=
here
> test_check_ignore does this. If these helper functions need to allow comp=
aring
> empty files -- how about adding special variation of cmp functions for ca=
ses
> like this: test_cmp_allow_empty and test_i18ncmp_allow_empty?
>
> I think it would be a good trade-off to allow these helper functions to s=
kip
> checking emptiness of arguments for test_cmp. Such patch will require onl=
y
> s/test_cmp/&_allow_empty/ for these helper functions and it will help cat=
ch
> cases as bogus test in t5310.
>
> I'll try something like the following on the weekend:
>
>         test_cmp() {
>                 if test "$1" !=3D - && ! test -s "$1"
>                 then
>                         echo >&4 "error: trying to compare empty file '$1=
'"
>                         return 1
>                 fi
>                 if test "$2" !=3D - && ! test -s "$2"
>                 then
>                         echo >&4 "error: trying to compare empty file '$2=
'"
>                         return 1
>                 fi

Yeah, these conditions are what I instrumented 'test_cmp' with (except
I used 'error "bug in test script ..."') to find callsites that could
be converted to 'test_must_be_empty', that's how I found the bug fixed
in this patch.  However, it resulted in a lot of errors from the cases
mentioned in my previous email.  Then I reached out to Bash and tried
this:

  test_cmp() {
         if test -n "$BASH_VERSION" &&
            test "${FUNCNAME[1]}" =3D "test_eval_inner_" &&
            test "$1" !=3D "-" &&
            test ! -s "$1"
         then
                 error "bug in test script: using test_cmp to check
empty file; use test_must_be_empty instead"
         fi
         $GIT_TEST_CMP "$@"
  }

i.e. to limit the check callsites where 'test_cmp' is called directly
from within a test_expect_{success,failure} block.  This is better,
almost all errors could be converted to 'test_must_be_empty' stright
away; I have the patches almost ready.  There are, however, a few
parametric cases that choke on this: where we run 'test_cmp' in a
loop, e.g. 'cvs update (-p)' in t9400, and I think there was a case
where the 'test_expect_success' block is within a function.


>                 test_cmp_allow_empty "$@"
>         }
>
>         test_cmp_allow_empty() {
>                 $GIT_TEST_CMP "$@"
>         }
>
> (I'm not sure about redirections in test lib functions. The two if's woul=
d
> probably be in a separate function to be re-used by test_i18ncmp.)
