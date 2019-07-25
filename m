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
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FAA1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 19:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfGYTGi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:06:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35231 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTGi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:06:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so34437083vsu.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpH8s1HwMdHSojFwcY03Y76r+Ai2Q28LGJOBMv0j5go=;
        b=TGZi5mmxYbU98sn61Qyr6qcWN3oeCELG6mAPYLCdx7KNh8dv4YUTw6ZAFXMhsMC7CU
         obUaFUuhWwbnF4wvQIusxIO4HKjXBzg+7UwoCXWD3xxcvUMslQU2/u8ONbnlRqYriVwm
         tfO+AbskbI3H670R/StF77zecK86+r1V0rfziVmXubBMk6/YbNEOmu7LfMMxGn2l3qZS
         8pZrG4suLofYQQkPPfB5EcJ2i0D34DBr8377baPW++A/p1YkQRiZj0kn6+vbPsfVmucW
         JYWP7jqg94Bq7a3YdYOEPeh0xUwTubrz0soYlZMMF1BBTyC+sABE+X0aMbtRsor9wskF
         8wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpH8s1HwMdHSojFwcY03Y76r+Ai2Q28LGJOBMv0j5go=;
        b=Yo9eg7/qSiqwLY9NCvyzbZBJBCiJm81Ord++XClsAd+/RBv/iaBgQT1C0fAT5TGhwQ
         BgAh4P2UrLBM6qsWO0lwwzCZjIZPoEl0jBaxwFZsWP7XYSkwNrNxMPAXKgJ3SYQaXbg/
         tmdyU/RUTyXhq1GzeEZz9UGesQOzh1tgGEDC1WoYlg7YYHiPcZSdXO5DgCUaq5epz0zW
         KOklfYWArKvvuNJwAvkoU8AmCjiwI0SOzNNi94wmt2AbJn819O/DZaszsxr0m9Lue2dI
         ZTLCi3ZWzbqX34KGy2GP/sD6NHY1MCgRAqJ4Cp5CsT2waB7mxBN2O0aNC0EdmhMo/vXH
         Z2Kg==
X-Gm-Message-State: APjAAAXSV7K0WBgMjWlaBT8m7ZREwf8Z0XvyuOtnAAuepeTRxBnLqnQ+
        HESIwYynXuv3ZmVwsV3Xm5UBwIQSGuxkMHONczqgug==
X-Google-Smtp-Source: APXvYqzFguTogQ2k5mS8A9kktHGuXRmks9tQN8XKlrCNcgo0Dv6I7UVY7/w7jssXGtXw8snOCTtMVj+1a5tE9WdpbAI=
X-Received: by 2002:a67:f5d0:: with SMTP id t16mr16482118vso.175.1564081597329;
 Thu, 25 Jul 2019 12:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <xmqqblxioufc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblxioufc.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Jul 2019 12:06:25 -0700
Message-ID: <CABPp-BGkGch-ebOrJTprw3oGgubgZyyVBCCM30VLbC24BU+MUQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] Cleanup merge API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:

> > Stuff I'd most welcome review on:
> >   * Is cache-tree.c the right place for write_tree_from_memory()?
> >     [see patch 7]  Should there be docs on how it differs from
> >     write_index_as_tree(), already found in cache-tree?  What does
> >     the latter even do?
>
> write_index_as_tree() is supposed to write the contents of an index
> state as a tree object, and return the object ID for the resulting
> tree.  It is the primary interface designed to be used by
> write-tree.

Other than the last sentence, that also sounds like the description of
write_index_as_tree() -- at least as best I understood it.  But I
don't understand enough of the cache-tree and locking code to
determine if these are accidental duplicates of the same functionality
(meaning we could delete one, or rewrite one in terms of the other),
or whether there's a useful distinction between the two.  I guess it
doesn't hurt for now to have both, but I was curious if perhaps one
was more robust, and wanted to at least flag it for someone to take a
look.
