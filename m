Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABE01F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIZBf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:35:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37024 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeIZBf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:35:58 -0400
Received: by mail-yb1-f193.google.com with SMTP id b3-v6so9224070yba.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/c1rs/ssSdeSzdG5xD0/WUrTZDCp+rJzfag9Czu4o10=;
        b=gQgMJpjdc0P+LSF/dXUO5LuFL+ElkO79VcXtSueTSRk6HWAFVGu/ltADiF/ULwSsP7
         6TOPp+QX5ru1BMZCNuIIu2HOVqdbFVSmyMx9tTO1uXb69OMsg/sgHn+vNHMbvfvNic4M
         FwCH5ccAPhAMqGLOzzHazI7rM5HjbInQjaGmqO/9oh9AIPFQcVuS+h7ymHV5fsl5yGLV
         KEB7N1EenX4jSB3/iJ5c91H2HBHFvOP3Lt0aEfaLphqkTE64n6F8V+UZ1iA4QmNuLqLc
         H6HpuUx3JOv0q/4Btq7u5h+FtwzIYzLjkxqgfPzXwhLv8xkjejrDSRtwMcGqX45fqHrO
         TgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/c1rs/ssSdeSzdG5xD0/WUrTZDCp+rJzfag9Czu4o10=;
        b=pvpKtGLqJg8TIXG3mNEUsG7L4rSfd8w7UAyTIEwrnSj+LF/WR9YFvPhwyLU3lq5V8Y
         jXSQvFkCdBzW6q7zRZ5d3xC/OyVO/1usshhJilYojkIJkRGjCOIrgD2hFBjxUe+fj962
         xTD5HjDQkmDi0SLdN0zIS4BDR9c01zkH9fajtJqlgg0V79xxb0JAjMBiOaSKbly4DORr
         vF1ZsDoS+DSvezHaPG19F2u2Hh1gmco/3uZIsWcehNTBwwVGZdjlK6VsCxUQ6c0qYSyo
         72mk7khpnwmFCipfyJtjLfvXCUlzJQrgCnn/Z9P3Dqul84Iom/RvD7PjirlG6m+aO9d8
         k7kw==
X-Gm-Message-State: ABuFfojZ3AtzF07NK1tsmoXPhwiDe8RgpT/w983mOYNAG7DHhvfVTXJM
        yVGSgezv09t4V+CANRD5wFkWsQMCS8G9OOjuC9QRfZZ6s+w=
X-Google-Smtp-Source: ACcGV62KC/wnqCLgedBEIFoduKQu7H6hT3nmHbBo2+3GlZpKBjhe3x+gwTVAQbvoBcGi3Q99Nph6HGWl+S8X4Zoz5nk=
X-Received: by 2002:a5b:1ce:: with SMTP id f14-v6mr1447923ybp.363.1537903615368;
 Tue, 25 Sep 2018 12:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
In-Reply-To: <87h8ihk7sl.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Sep 2018 12:26:44 -0700
Message-ID: <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 5:58 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Sep 21 2018, Stefan Beller wrote:
>
> > +/*
> > + * Apply want to each entry in array, retaining only the entries for
> > + * which the function returns true.  Preserve the order of the entries
> > + * that are retained.
> > + */
> > +void oid_array_filter(struct oid_array *array,
> > +                   for_each_oid_fn want,
> > +                   void *cbdata);
> > +
> >  #endif /* SHA1_ARRAY_H */
>
> The code LGTM, but this comment should instead be an update to the API
> docs, see my recent 5cc044e025 ("get_short_oid: sort ambiguous objects
> by type, then SHA-1", 2018-05-10) for an addition of a new function to
> this API where I added some new docs.

ok will fix for consistency (this whole API is there).

Longer term (I thought) we were trying to migrate API docs
to headers instead?

Stefan
