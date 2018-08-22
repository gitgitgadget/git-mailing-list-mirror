Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06071F97E
	for <e@80x24.org>; Wed, 22 Aug 2018 18:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHVV0f (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:26:35 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40785 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHVV0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:26:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so971464ywa.7
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XErwDNE4ExINkMH4sJkZJT2apTNpmggpQm2xkIvLSoc=;
        b=BL7PSlgMoqvKqXbRiUd71RdM7T3RSn/x8CAGeGn1r/Idm1fUbVJFLxa3JazcRhg11S
         Ylvw2yCaeQFsGrQ30CEnqL4OE1XOj8SO0vpEWK2WnKDKzZZaXYW95wJ/fZ8+o7y0vi3J
         XE+9JWgHKE60YPf57c8dk2H+Sqkibi90npS8RJTVk4LOfH8NjM+D+SPMVB4NxWuwv9/9
         ljSvcV1tf6fL0Tcks3G1ucByofUvq/WDspw843oEEdxfxMWujjysMTLqFVXc+UTHeDBA
         JqUy/P5Pfyuo6y+hL5u5766PLzDmfMdX5Ip7klP/Ey5fHuYPA3bpngQUik7JEcnRQt+h
         y8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XErwDNE4ExINkMH4sJkZJT2apTNpmggpQm2xkIvLSoc=;
        b=NYb5Aug5ZzwIOGAJMnT+xc9BH2Z04348CWfZA7BN8N+DmTV2k3PUXW+fq0/loMxHom
         sM4hz/ObiuzpQT3V5nYq1cjvHJ/WfJphAwKBThCrd3Q/vCzB0mg1OfrAE2IpawsW+jW8
         UcCl/ZKtR/vy9MwTIZNzVLnDXx6gvtWpEOKmXD1cFCTgNvplXn2ODKWH31/kVvqNH4V8
         zLQJ/PgPII76L7s6EekDznYf+srriyFECBK0t6OM9gcN0/cpgcYJ5KBEtSWLTKegJpX9
         pwVhI1Fqk5kWox8gBikEVHwWSqSIw4VlkY80X0msC6b+4YBNpUYUbWdETe2dcU1U+2o+
         6afw==
X-Gm-Message-State: APzg51ATMOorrfDWbmPeoTxRG5fQvbxKIKOLbGg76TudEfkZ5jdO/e98
        1kONEG/IDd7HECBBWxS2MM3LrTYL9FctRbgqrIFcPw==
X-Google-Smtp-Source: ANB0VdbAPgWEE8uQyE5URAnihiHlDTRET4NTYAfIskcon4RGv36WJdIrQIXdt6BKcomNvvxSd5drpJrdkXVSThy0CFU=
X-Received: by 2002:a81:3056:: with SMTP id w83-v6mr675137yww.238.1534960840494;
 Wed, 22 Aug 2018 11:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
 <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
 <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com>
 <CAMfpvhKPJijO_E2FRh-UtrOthEc2YTaG0=1ToYy3akjzWUZWiw@mail.gmail.com>
 <CAGZ79kZfZ2FWfgrvb82YxXP7zHjYDp0J_581ZHgG3un1phHxGg@mail.gmail.com> <xmqqlg8z75qo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg8z75qo.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Aug 2018 11:00:29 -0700
Message-ID: <CAGZ79kaxbgbroqQcih4yCWg=SQvUjuxwMMCTLSGv66rm7pes1w@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >> ...
> >> OTOH, if it were up to me I would have just gotten rid of
> >> test_must_be_empty and used an existing function with the right
> >> argument, like `test_cmp /dev/null` - but using some form consistently
> >> is the most important, whatever it is.
> >
> > /dev/null, eh? It shows you don't use Windows on a day to day basis. ;-)
> > But yeah consistency is really good to have. :)
>
> Just to make sure we don't give wrong impression to bystanders, do
> you mean that we should discourage using /dev/null in our tests or
> scripts due to portability concerns?

I would discourage reading /dev/null (as in `test_cmp /dev/null actual`)
over a more specific `test_must_be_empty` as that is easier to read.
(But I do neither en- or discourage the use of /dev/null in the implementation
of that function).

> I thought they had good enough emulation that writing /dev/null on
> the command line in scripts do what we expect the shell to do; the
> same thing can be said for calling open(2) on "/dev/null".

Oh, opening and reading is new to me, thanks!

> Back to the topic from the tangent, but there was a discussion on
> choosing between "test_must_be_empty actual" vs "test_cmp empty
> actual", and was even a proposal to trigger an error when an empty
> file is given to test_cmp.

Oh, that is an interesting way to ensure consistency.

>  You two might want to join the party
> there, perhaps?

I'll read into that.

Stefan
