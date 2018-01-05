Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D06D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeAEUd1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:33:27 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:43830 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeAEUd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:33:26 -0500
Received: by mail-ua0-f179.google.com with SMTP id l12so3270383uaa.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WiFnoglHpWc/QxRrhX7JRClHxn8jfvmd29ZS4oqQqAg=;
        b=aDgzTnt4tn9SR66gJ94wbB12c/E1ydc4R3+JFHJzXgMTZ/d1LVqyO/0cpotFi+EDfz
         /v6pd9u3yfxA4zIupH6Ggf7i3ztUMzsS5gwUAM0mlZIgfXmliorpReC/FGEgEoI+HTOD
         YEc8KF+3hyMiULemlnCgcjNlO7Gj3DRLa2GvXimkYD4HoaOeWnuKp/MbuM7mmNGlaYQc
         KIsNpL06LNi9rkDFTGh14B0gU44C256BVs2jbZU+/fu4NNYL5j4FQL3sF5fNPqXnpk8f
         juVLbrDl2lRempB4V5niTvzJdH0qawXbXla6ihnyZU7rKBoHQM08BrNJrvCDaLBlX8T6
         OwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WiFnoglHpWc/QxRrhX7JRClHxn8jfvmd29ZS4oqQqAg=;
        b=aT58sI5QGSX1wVxHrHg8bslOf7EeUbj4gEPgdhG5p3xgImD18BjnQxtw9F8TzxfGBW
         iQYkmQnFppyW88tRziJ5sT7diLORo2x60s8DcI9nS79p9a5rY/oBO9qDl4zoRCUBwwy3
         cqByjnY7+lDYN2842u7vnKT82Wkp+12tpA6xnwJJI5g8WF23wYeqs+1I7kvmkLGd1QOa
         3USrd5iX47dqq6U36O/xiAxIK2bGWinhAjpj2cRpWyqLyzWPae+B7Jbu14O4arN7koni
         g7jZkgzkRm19Di/ffkkSA9hh8sQ1lLBdcQWaMAE+BJ6e2x2V6HXmjahvZSSVg4E7Q/xq
         obSA==
X-Gm-Message-State: AKGB3mK4bnvqGscGOhp/zMrw29Ov3LwPKSdUjo1xBwBklmPlhYXzsSWQ
        RPfgLhgDldEsa8l+SlL2dUx6cHkWTJKpb+lRBQo=
X-Google-Smtp-Source: ACJfBotrGy+wT8sN1NNn8lTxW93Mhb8zmGl0d1qpKmCjlYtK++bPh5oJDmHC8CTWWwVSVuPDZw/K+NAgIB3OLoULGDI=
X-Received: by 10.176.64.67 with SMTP id h61mr4199683uad.40.1515184405313;
 Fri, 05 Jan 2018 12:33:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Fri, 5 Jan 2018 12:33:24 -0800 (PST)
In-Reply-To: <20180105203151.GA24806@hank>
References: <20171228041352.27880-14-newren@gmail.com> <20180104005223.13566-1-szeder.dev@gmail.com>
 <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com> <20180105203151.GA24806@hank>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 5 Jan 2018 12:33:24 -0800
Message-ID: <CABPp-BEA-t_=WjXF6yH2_M4nvoeweJJsvR+AOMye9vvvpKaYXA@mail.gmail.com>
Subject: Re: [PATCH v5 13/34] directory rename detection: tests for handling
 overwriting untracked files
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 12:31 PM, Thomas Gummerer <t.gummerer@gmail.com> wro=
te:
> On 01/04, Elijah Newren wrote:
>> On Wed, Jan 3, 2018 at 5:52 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
>>
>> >> +             test $(git rev-parse :0:y/b) =3D $(git rev-parse O:z/b)=
 &&
>> >
>> > There is a test helper for that :)
>> >
>> >   test_cmp_rev :0:y/b O:z/b
>> >
>> > Note, that this is not only a matter of useful output on failure, but
>> > also that of correctness and robustness.
>>
>>
>> Cool, good to know.  Is there any reason test_cmp_rev is not
>> documented in t/README?
>
> It is documented since a few weeks, I added the docs in 5a0526264b
> ("t/README: document test_cmp_rev", 2017-11-26).  Though as people
> mention they just look in 't/test-lib-functions.sh' anyway, maybe the
> docs should live there instead of in the README in the first place?
>

Nice!  If we don't end up moving them, it might be nice to add a note
to point people towards t/test-lib-functions.sh from t/README,
mentioning that it might have other functions available as well.
