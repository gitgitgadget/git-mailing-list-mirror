Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD701F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHOWSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:18:45 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45775 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:18:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so1648630ywg.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhJ266H7N4nBLjq0H1twAyXE+l3T/PhRhOSYhx+lfPc=;
        b=d0TkzVs+nIzwTpeA3JUjQa7SizmCJyVLAjQ8VaghKTgP0tuHuUVNpZa6J2MwhAfBHZ
         v0F10bGWM25aOuAbefTAblMbXMlLgqwBqKr1/X1HG+Ra2LATR5nGkNGvnP/nRWwn/AIL
         CfyYmnZ0N51F9OBsvBVCOEYP99wmcF54GvIo54wdIFV5swpqVmOlS+kk1AC/rEfFc+0J
         KA1f/03Xy5a/qUFDbJtzrVgvtKPjSxuka8C+3r4zaE9n/drj6Eqg4g4b5MXH33G5Ovfq
         GL/dgtl74wpycrP02lQVY+1UeOfN4OmnQENw70ycWr2rKzSP56BX8JqHPpQZqZK6tYDs
         zMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhJ266H7N4nBLjq0H1twAyXE+l3T/PhRhOSYhx+lfPc=;
        b=oyHq8npAR3z/WpAbs6yInezy8bnVPT7fLZrfjwhVDPxxbL9l9hkKyqomffow3R3+ne
         Ic9pkoyMfmKOiY3OWc5BnQPH9iKBL58LbqmzdYKNvMVhZsdq06WSCnkzdU/ekhlpO5ve
         JMPge3YH5wwBhQ3B+vDJN42ngH5uO1pPiUYHZWGQ9cCKKm3zgWgtIGA5eY7K7t3rp5r0
         8FNW3mCjXHdAN36Tvfm0T5EWTGD9rZlgorxL1H9vOUa23qUIxBFqrtlaIpRYiDfS34CX
         wOf3JkMqY6lbObaVq5Dd1aQFot2PpTYeHfxBduEc7gB7uukD3s4jsnN/SwuY/0blbN8O
         b/mA==
X-Gm-Message-State: AOUpUlHpRlJ5P/FwfBn4gGBMcbtFOMeUZbL+2V+mgPmMx4O7YIaJd6My
        g0mR4Ju+ukUtFVby2dzO+QVgkMqfPh/Rynsu5ky+dw==
X-Google-Smtp-Source: AA+uWPwvMvDjsXMdHMvZvb04BEV+ip5NS6326B+/C0NqRwpUVHMfrm/fjgrTRGO5C/Q+GuaNm90O9eG09VesBPZdB9Q=
X-Received: by 2002:a25:874d:: with SMTP id e13-v6mr11730974ybn.515.1534361116877;
 Wed, 15 Aug 2018 12:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813161441.16824-9-pclouds@gmail.com>
 <CAGZ79kbs+4_D95+F5km0ODPb1_7tPXMivet35Pq+4vut1ZS9dw@mail.gmail.com> <CACsJy8AJh16X5HPf6GqfBn-6JwiDn=3505d0+e38bNOxOTg76Q@mail.gmail.com>
In-Reply-To: <CACsJy8AJh16X5HPf6GqfBn-6JwiDn=3505d0+e38bNOxOTg76Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 12:25:05 -0700
Message-ID: <CAGZ79ka=G6918mECGWUm5vYs-r-SAKLGuBirahKCTv9waQ2xgw@mail.gmail.com>
Subject: Re: [PATCH 08/24] unpack-trees: remove 'extern' on function declaration
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 12:21 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Aug 15, 2018 at 9:10 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Mon, Aug 13, 2018 at 9:15 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> > >
> > > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> >
> > This removes the only existing extern keyword, which was added by
> > Linus in  933bf40a5c6 (Start moving unpack-trees to "struct tree_desc",
> > 2007-08-09). All other callers do not have this noise word as it was
> > simply never
> > present there despite the old age of unpack-trees.h. Interesting histor=
y.
>
> Linus did not add 'extern' though. It was Johannes a year ago in
> 16da134b1f (read-trees: refactor the unpack_trees() part -
> 2006-07-30). Man this function is _old_.

Ah, yes. I stopped at the first blame here but dug down on other functions
as I expected some of the recent "remove externs here" and magically
overlook this function.
