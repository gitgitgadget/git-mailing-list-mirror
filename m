Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA9820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdASRcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 12:32:31 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36422 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdASRbO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 12:31:14 -0500
Received: by mail-io0-f195.google.com with SMTP id q20so5670972ioi.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RItZnSqDWgkx6eLa5kDqSvazFSyFSelDMCfhLgyWZAc=;
        b=GAq9Sff7LNCFAftX+DvJbAlTyX2D32fewoVGJUYViMGKpNzp+haB38f3MdNGn0+Vis
         IL31cc2XdgzSC29V60EBTINzAS2V5Uu3Dk0hH6JtTvVmiFHPpnto5UIwCaLLjqZ7L+tb
         7I7fk3FWh3DM2LE+1uzm0v+acfJuDXujdqqYlhPbrmHjn9IMgFlhcFbibI3eB+DkNmXY
         yrT9Eb2X7iYJXsapIGwP11IM+KFIMujU5JnmnXahYCwj3sL0sJfVw88CRiB91Soib2Cl
         knVQgOw9I0Qsvs/boglq86HK1z/JcCQdJnHvAa+Yawo8P2QoU0McuYdYK/jve5An//FN
         eaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RItZnSqDWgkx6eLa5kDqSvazFSyFSelDMCfhLgyWZAc=;
        b=soCXcbfoZWuG3SfTWxCfAuUf+vCxdjrJJFemp7oY8Xjc8byW4GRLmW/o0hfwKQNCIu
         mzZ6Sq40xXR14BD1lN3lsvFrEY7OJIdwWylhDAgGnFDCGQJsi2Ewaz5wGOdzW/t/hSKz
         nhHw+OdgmoK/grK6kcga3kTD5Wely0My8JDd4R9pRZYDkr2053qiUfyvvgss0Ywv4A1P
         ckWzCbsLj4XwTkxzpqutnNFdfGk1CrHTZRgs4G46wiFllQHJkJG4cKa+I8Kp1WTIx0uH
         N9o6oqntF4SG+9tt4V+gl445GAcDUOizNPfp+/l7kb9Dye05eZOX4iJsTKp2AW7HMMfM
         GlNA==
X-Gm-Message-State: AIkVDXLh5aefru2zB6n8LP1zGqjbPd3DTUyVF5/n486SXL15oZkJG+oLpHZV3ccJX7sLsx2E7paWPB5rIJubYA==
X-Received: by 10.107.15.167 with SMTP id 39mr7932901iop.204.1484834626712;
 Thu, 19 Jan 2017 06:03:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.132.83 with HTTP; Thu, 19 Jan 2017 06:03:46 -0800 (PST)
In-Reply-To: <20170118215120.6hle2uxgkcvvtlox@sigill.intra.peff.net>
References: <20170112082138.GJ4426@acme.spoerlein.net> <20170118140117.GK4426@acme.spoerlein.net>
 <20170118143814.or34vxxwjwnzg5jz@sigill.intra.peff.net> <20170118200646.6larm2qu32xm73on@sigill.intra.peff.net>
 <CAJ9axoSzZJXD4RKvVx+D60dw4sakMJWgNmOP-cREWA53Ae3C3w@mail.gmail.com>
 <20170118202704.w6pjxfvnge7utk34@sigill.intra.peff.net> <20170118215120.6hle2uxgkcvvtlox@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ulrich_Sp=C3=B6rlein?= <uqs@freebsd.org>
Date:   Thu, 19 Jan 2017 15:03:46 +0100
X-Google-Sender-Auth: lsZ466-Ki6fszt0c2r-BTBMoWgM
Message-ID: <CAJ9axoT1pUQc_jTKxO+RMw7emhA4ss1NCAU+hpnyG5LMwGD89w@mail.gmail.com>
Subject: Re: git fast-import crashing on big imports
To:     Jeff King <peff@peff.net>
Cc:     Ed Maste <emaste@freebsd.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-01-18 22:51 GMT+01:00 Jeff King <peff@peff.net>:
>
> On Wed, Jan 18, 2017 at 03:27:04PM -0500, Jeff King wrote:
>
> > On Wed, Jan 18, 2017 at 09:20:07PM +0100, Ulrich Sp=C3=B6rlein wrote:
> >
> > > I found your commit via bisect in case you were wondering. Thanks for
> > > picking this up.
> >
> > Still downloading. However, just looking at the code, the obvious
> > culprit would be clear_delta_base_cache(), which is called from
> > literally nowhere except fast-import, and then only when checkpointing.

Sorry for the bad URL, pesky last minute changes ...

> Hmm. I haven't reproduced your exact issue, but I was able to produce
> some hijinks in that function.
>
> The problem is that the hashmap_iter interface is unreliable if entries
> are added or removed from the map during the iteration.
>
> I suspect the patch below may fix things for you. It works around it by
> walking over the lru list (either is fine, as they both contain all
> entries, and since we're clearing everything, we don't care about the
> order).

Confirmed. With the patch applied, I can import the whole 55G in one go
without any crashes or aborts. Thanks much!

>
> ---
>  sha1_file.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 1eb47f611..d20714d6b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2342,11 +2342,10 @@ static inline void release_delta_base_cache(struc=
t delta_base_cache_entry *ent)
>
>  void clear_delta_base_cache(void)
>  {
> -       struct hashmap_iter iter;
> -       struct delta_base_cache_entry *entry;
> -       for (entry =3D hashmap_iter_first(&delta_base_cache, &iter);
> -            entry;
> -            entry =3D hashmap_iter_next(&iter)) {
> +       struct list_head *lru, *tmp;
> +       list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
> +               struct delta_base_cache_entry *entry =3D
> +                       list_entry(lru, struct delta_base_cache_entry, lr=
u);
>                 release_delta_base_cache(entry);
>         }
>  }
> --
> 2.11.0.698.gd6b48ab4c
>
>
>
>
> >
> > -Peff
