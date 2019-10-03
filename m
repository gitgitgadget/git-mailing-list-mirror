Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D9C1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJCG4L (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 02:56:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42853 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJCG4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 02:56:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so1389578ede.9
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNJlLmVqOoOyN4nSvgKg57l7hJyMsHEIFXkeABblEIY=;
        b=sp1RoArlttB/2DiOAYV6C6Inw0glCI8C/TPqSskQdUNFjiOR3Gy1/1pHmfPKhS9yUs
         eDGc90snVIdTfo6P0FKjD3hcwz3HhcWznrB4gRDdqnH4M7JU+GfE45HgrFRUKifORdij
         klRekSUZ3Aal13CkLnURs2th/73X0dJn4yJIOmN7/qJeuNaBY3UJod+WixbY3tRhbaYe
         jb9vIsCUG3oDx1LTNH+UeWpuKYKQtz8v3W7tG83NyhA5NgGqdUS0Cq1VMGDHgR10ZsOP
         jKekKCGJVnjdMO+7Oqec32di+xdZ09LK8Iz3OayPdL1c3MJKysmvujld1hrzd0mH2lf7
         fWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNJlLmVqOoOyN4nSvgKg57l7hJyMsHEIFXkeABblEIY=;
        b=pPZ64E57tecnLQFSHs9dDgemKG2GHo2QdL9Acs16Txx+Ig1VFOPWgH+0qb4pbqxWK7
         bpIvTmi+Zis7PnVI9bsiTQ4TKOVl8T4vCLRD8w3xOMxcoXVdyzfpoz0Z1Tr9DVOuw9eR
         tXLhK2gDavBRZhuj/4JOgKVuEPtojdl7FcGhwtafEm0766EZ8gj+viyNEAV8UpRcjqDv
         3TFoPX7WBkh7C9EbaVx90hjn/ey4xmV46IJFY5FtfhBQcDO6+ZnvVP7n/SR1mgfSV36W
         97gm9CyUtS74al1TE6N19o22WIXU8PIKd1IDIiu+at/6Nf22Un1xoxLwcjxFcgNRo6w3
         A9fw==
X-Gm-Message-State: APjAAAWj9nymg+wl+eObbJPmEv8UEjHSilZAFP3K7TqQW2t7fqbXwo/v
        gebUnwh3KwjlC3gngmZAM/PsHvTcZpxgaes9DqU=
X-Google-Smtp-Source: APXvYqzsSnd3710HLh8VAD4oP4ejTR7Gmha70KAjz5A2QUqIZM6VtVU2VrjchfK3iynx5fGRSuQX4iS1lbCGWSMC7/c=
X-Received: by 2002:a50:9fe5:: with SMTP id c92mr7918855edf.280.1570085768977;
 Wed, 02 Oct 2019 23:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
 <20190913130226.7449-11-chriscool@tuxfamily.org> <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
 <20190914020225.GB28422@sigill.intra.peff.net> <xmqqy2yrbmqu.fsf@gitster-ct.c.googlers.com>
 <20191002155721.GD6116@sigill.intra.peff.net> <xmqq5zl6d1kv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zl6d1kv.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 3 Oct 2019 08:55:57 +0200
Message-ID: <CAP8UFD35BAhAJuxivUy=8+XmGXL4snRnsfHJXxgWO+jXfeMrxg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 3, 2019 at 4:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Hmm, I see the early parts of this graduated to 'next'. I'm not sure
> > everything there is completely correct, though. E.g. I'm not sure of the
> > reasoning in df75281e78 (ewah/bitmap: always allocate 2 more words,
> > 2019-09-13).

Yeah, when I prepared the series I wondered why we allocate 2 more
words instead of just 1 more, but I forgot to ask that when sending
it.

> > I'm sorry for being so slow on giving it a more careful review. I was
> > traveling for work, then playing catch-up, and am now going on vacation.
> > So it might be a little while yet.
>
> Thanks for a status update.  I do not mind moving this topic much
> slower than other topics at all (if somebody is actively working on
> it, I do not even mind reverting the merge and requeuing an updated
> series, but I do not think that is the case here).

I think the series requires at least documenting pack.allowPackReuse
which is introduced in d35b73c5e9 (pack-objects: introduce
pack.allowPackReuse, 2019-09-13). I was planning to send an additional
patch to do that, but if you prefer I can add the documentation to the
same commit that introduce the config variable and resend everything.

> It would give me
> much more confidence in the topic if we can collectively promise
> ourselves that we'll give it a good review before we let it graduate
> to 'master'.

Yeah, a review from Peff could be especially insightful as the code
comes from GitHub.
