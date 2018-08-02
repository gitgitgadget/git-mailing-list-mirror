Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966D01F597
	for <e@80x24.org>; Thu,  2 Aug 2018 07:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeHBJYM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 05:24:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50909 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeHBJYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 05:24:12 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so132600ite.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jZBH2jvmYv15DhW2w/4Mv5ysafENLnd4hSgXJzb8GqA=;
        b=Z1rxGmYqoAlaeigvlHksrB3pMMTicydN4jzlIKJC4cKHRNCLHWeHz1LyQ4Xb7mvJRR
         2p9sIYm52XzOsxzujFyLLm3hWdtMadcHwBgt0Uc71QrrrWjZnW9djXNiFF9qeG9wTWG8
         ZSr86MlL1gyRRdqNkGMKd62dkxYTlS7+TUMpToxv92+9FqdGalBU3wYDmsLoKI66Q/2J
         jtzaec0+O0cUmkj7RSeKJsPJ7LWBtcWdByg3rAXV2hlgkzj6rRwG2n8kv+FPgMeZG6jg
         8GBKpz5dHCT2Izp8hIeXLDV9xkyubH5XbdsKEWvHZKCXAWdyNwvVXYyD/Tb+ApIBj8lw
         ZRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZBH2jvmYv15DhW2w/4Mv5ysafENLnd4hSgXJzb8GqA=;
        b=LY80VjLGJSrpFsVbZvs64xm6DAwtS4ri9K5vgxQfltiKIvq3xVMtnoAGVqrDAvniN4
         40bbt207K9rBo9OVsfWKxEyUhDQ8OFYiVsMm8RJN4/tYMNt0o2xc+nU+aK3aw9A4r09I
         YwhMvICyPEzqPfLigcy4kRis2XUzP0bdzDUox+IbWnneM0/coHwgxZhV9KTpsRw6VQci
         lVurpwtFQnGT5MDHvElNwrVBknyH5ANkvnfhHWsAstoihgwyMSyEhque0l0GwZIoOAEQ
         l870xbQRhOMZx5X9Sqy1EA2u9eYGvjJaaGaX758NzdHBnOoithKNMYObRGWyYXhSIhi6
         lPGw==
X-Gm-Message-State: AOUpUlFtOmxGxTM3jN5X90lPXPM9TlVKQj1HZtZL7YOODa3PvX73EMUF
        u/wTh+ggqHF46NhzubZn4kgjxrRe1jwVmpDGNQ/d1JpY
X-Google-Smtp-Source: AAOMgpcxWV53wZDEO1gYkGH5Mu23mPSfUoTjlWdHLKZ2NLago+8UOiYEdkA44FUCCabksw+yTJ6CL5n0oH8KinytPqw=
X-Received: by 2002:a24:282:: with SMTP id 124-v6mr1345727itu.151.1533195260322;
 Thu, 02 Aug 2018 00:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
 <xmqqeffi856n.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
 <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Aug 2018 09:34:08 +0200
Message-ID: <CAFQ2z_Mazv3jQF6+juLRu214Ddem3=TOd4tnVcm13ZThYMNH1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 8:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Hmm, do we actually say things like "Error: blah"?  I am not sure if
> >> I like this strncasecmp all that much.
> >
> > this is for the remote end, so what we (git-core) says isn't all that
> > relevant.
>
> It is very relevant, I would think.  Because the coloring is
> controlled at the client end with this implementation, third-party
> remote implementations have strong incentive to follow what our
> remote end says and not to deviate.  Preventing them from being
> different just to be different does help the users, no?

But the ship has already sailed: Gerrit has been saying "ERROR"
instead of "error" for many years. In the case of Gerrit, the upper
case message is a (poor) way to make the error message stand out from
the sea of progress messages that "git push" prints on the terminal,
without requiring a newer version of git-core.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
