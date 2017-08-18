Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE82208D0
	for <e@80x24.org>; Fri, 18 Aug 2017 11:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdHRLa4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 07:30:56 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38056 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdHRLaz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 07:30:55 -0400
Received: by mail-wr0-f174.google.com with SMTP id 5so44055695wrz.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+TpsZDMVS+k8KsEPOR0kjiEr3JLpWdz1TAbCkIOrpkA=;
        b=JK2j4eyQ2QwumnasblTt3Wn8kI6TETiMVqP/tjIa4ZX/BPK1yqUTYYD0JUM7Fgccpc
         1Jpsw0tITF++pJs47n8pZC5pGkskVFU9alW/OuWkLR0zU59INz8RDvM4Q6v32MGS1qYu
         WthckFOL6JpWZqfs5qJMuK4xOHkkpD3qiPKFyjtLLgnKNo3ZzmJjg59h8vevtKj3oaEJ
         qG6LGeOHRChLTX/ZQo0lBRisYpqnBTfKVLlQXZShFKidNSVZwxrnhNoL+FkFF/mgXb/q
         dqoRCbhfkTkSzVlMZG/vX8gBcOOKmeYh0fKg5JUP5tomtRc4yMuMclXxBiehqd0J2koW
         0rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+TpsZDMVS+k8KsEPOR0kjiEr3JLpWdz1TAbCkIOrpkA=;
        b=klksCXJo4sGGfp/uu704+fpRMfK9AUQmNYSHEaD6vtnGiUDtir6F3fqF8S81nvJX/f
         MeG2riml8CszS8sgXJ2Gji1o2FBsEgoItgQtu9mmrZQZKHk6kLPnt0XFazXN6yFucaoq
         AM/258CRdc0LkcKOTX1jcUWAiqKBJf8gN45fVqD3w4YQwv5vBf1u/MbOer/DAUs1RZB3
         qreX5AETaSsCklj9jZFzT/zWXW3O8s8lOKyynHK+UlYXUQmpIrJWvJIcwNG+OdNu908y
         +ebnibGul/w4ZS6khsgJTLomF5rJ0f0I/XrNFyP0klWlS0GfCTOIivmHCR1UZd1HJteN
         VLAg==
X-Gm-Message-State: AHYfb5hkw46BtFW7zkkgNWtGRg2HFgv+aHThyzREWpOiFn7ls0fuQMk3
        QdwiLQIFiP/LIUcJLKKcXZ0p9SoXbVrkD0g=
X-Received: by 10.28.46.197 with SMTP id u188mr1222715wmu.26.1503055853787;
 Fri, 18 Aug 2017 04:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Fri, 18 Aug 2017 04:30:23 -0700 (PDT)
In-Reply-To: <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
References: <cover.1503020338.git.patryk.obara@gmail.com> <cb98970b3f6c175321f52efb65deb48f9cfeabae.1503020338.git.patryk.obara@gmail.com>
 <20170818064335.h5sr5iz7mh64axji@sigill.intra.peff.net> <xmqqziaxcobp.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Fri, 18 Aug 2017 13:30:23 +0200
X-Google-Sender-Auth: 5jOPGS5w8OVIqbekmdlI1IqmLpY
Message-ID: <CAJfL8+SHSAhgrMY6ONVHLMWEHcT0mhm4oKMmq6D=89SErDKiMA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] commit: rewrite read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
>
> So we're probably fine. The two parsing passes are right next to each
> other and are sufficiently simple and strict that we don't have to
> worry about them diverging.

That was my conclusion as well. I added comment before the first pass and
avoided any "cleverness" to make it perfectly clear to a reader.

> We'd reject such an input totally (though as an interesting side effect,
> you can convince the parser to allocate 20x as much RAM as you send it;
> one oid for each space).

Grafts are not populated during clone operation, so it really would be user
making his life miserable. I could allocate FLEXI_ARRAY of size
min(n, line->len / (GIT_*MIN*_HEXSZ+1)) instead=E2=80=A6 but I think it's n=
ot even
worth the cost of making the code more complicated (and I don't want
to reintroduce these size macros in here.

We _could_ put an artificial limit on graft parents, though (e.g. 10) and
display an error message urging the user to stop using grafts?

> The single-pass alternative would probably be to read into a dynamic
> structure like an oid_array, and then copy the result into the flex
> structure.

Before sending v3 I tried two other alternative implementations (perhaps I
should've listed them in the v3 cover letter):

  1. Using string_list_split_in_place. I resigned from this approach as soo=
n
     as I noticed, that line->buf needs to be preserved for possible
     error message. string_list_split would have no benefits over using
     oid_array.

  2. Parsing into temporary oid_array and then copying memory to FLEXI_ARRA=
Y.
     Throw-away oid_array still needs to be cleaned, which means we have
     new/different return path (one before xmalloc and one after xmalloc),
     which means "bad_graft_data" label needs to be changed into "cleanup"
     label (or removed), which means error description needs be conditional=
ly
     put in earlier code=E2=80=A6 and at this point, I decided these change=
s are not
     making code cleaner nor more readable at all :)

Junio C Hamano <gitster@pobox.com> wrote:
>
> If I were doing the two-pass thing, I'd probably write a for loop
> that runs exactly twice, where the first iteration parses into a
> single throw-away oid struct only to count, and the second iteration
> parses the same input into the allocated array of oid struct.  That
> way, you do not have to worry about two phrases going out of sync.

Two passes would still differ in error handling due to xmalloc between them=
=E2=80=A6

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
