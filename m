Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA311F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHJWUO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:20:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37690 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeHJWUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:20:14 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so4252818itf.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIWT7xQaoKg1obiTPIqwv3hU/J67kYYsMNJycDUZ+kg=;
        b=K2c1UBX0Df0hlIOLRtUWCFxoqisE0M53exD1suCqBCiXG5z/ofjhMVQ4+xtN5U/gMR
         jpaMqH4z/mGgCAp9fbbzd24VObQVJnELlBpU5x2TAINJa9O+Z28nED6bdxkPHoTB+sv7
         Ay8NCM+B25eeWhBhSIEXEdErfpOvBVNkagS/+g2Ytu1gRClffIPLljmt3lzltdrtF8I1
         b6ckM26jcP+8WlaC0bhfOIxj+ZJDcThQDKpsZhYcHDNDB4zfg6kOzcibZ2//FzS6ZcS3
         JBKRTdd6EwJfTiUuZQHWrsbTnkz/bNC0vePXiqVX/9PdFXYlX12bnkNpwTXCUakxHbnO
         GgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIWT7xQaoKg1obiTPIqwv3hU/J67kYYsMNJycDUZ+kg=;
        b=M4lmsYkEfqJcpyQyhWSUDh/dw/mC4NA53e6rTXhBrailiHq2Teebyq4pi7FCKgCHn3
         vfUTITY/MWMjn6CmAlsYCa2uCZj8Gciv3pYIFKxeQvDi6dKtb4MFqlWpYY5lk6nb0iPa
         1QCoybrXMBjpxfmTZFeg2wOamx20Z7gjPo+9C8igcBRMM+rjGaaFtXrvRO14c81KFnbD
         OQwOgW0M+c6rDRL/JMqlqbGzp3367afeMRpDsKwmff8JImNn4+EgoniOH9nyaQSaRdYS
         u44SorADVTzFqjm4HKbhDgh9dTxs43xjJWzMGb6LSVOKD2YNEJsLRtpgVz7qUsyTjE91
         h4DQ==
X-Gm-Message-State: AOUpUlEhN0MSZT5BOE+EjJVbUp9Yi7bMARtE2Qsewq1OxHvPZ2kVAoIB
        RrYjS5H9e3aBuQrkTFDcopIC+oALkDVGPM6UAKI=
X-Google-Smtp-Source: AA+uWPwoUcThOCRtM1xc0/TttwXrF+YuHLB+IfnhA56YBxEYfm/kBrWj2QoCa1pTGCTCNN7C2fAAKJ9z4zcnQcUrj8k=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr3458217itc.68.1533930537078;
 Fri, 10 Aug 2018 12:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com> <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
 <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com>
 <CABPp-BGU6QnUwQgkhwx6vLBc3ozoEScQ4DaZd-9ZZfQhXfxPww@mail.gmail.com>
 <CACsJy8AeptcqwRC+DOrdhvk69kEQT6+S6M=0OGWBFOE5gihGzA@mail.gmail.com> <CABPp-BHMC8k3t2_9KzdJvg80e-nqwsbLUceTLNjQ=ST=9XthEA@mail.gmail.com>
In-Reply-To: <CABPp-BHMC8k3t2_9KzdJvg80e-nqwsbLUceTLNjQ=ST=9XthEA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 21:48:30 +0200
Message-ID: <CACsJy8D+UcmokEVn-=PRp7cZMK9fY0H+epKJpR8ytLSJdjWHcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 9:40 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Aug 10, 2018 at 12:30 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, Aug 10, 2018 at 8:39 PM Elijah Newren <newren@gmail.com> wrote:
> ...
> > > Why do we still need to go through add_index_entry()?  I thought that
> > > the whole point was that you already checked that at the current path,
> > > the trees being unpacked were all equal and matched both the index and
> > > the cache_tree.  If so, why is there any need for an update at all?
> > > (Did I read your all_trees_same_as_cache_tree() function wrong, and
> > > you don't actually know these all match in some important way?)
> >
> > Unless fn is oneway_diff, we have to create a new index (in o->result)
> > based on o->src_index and some other trees. So we have to add entries
>
> Oh, right, o->src_index may not equal o->dst_index (because of people
> like me who call it that way from merge-recursive.c) and even if it
> does, we still have the temporary o->result in the mean time.  I
> should have remembered that; just didn't.

Your forgetting about this actually helps. I think the idea of
avoiding add_index_entry() may be worth considering.

We know that 90% of cases of unpack_trees() is from the_index to
the_index. So if instead of creating a full temporary index, where 90%
of it might be the same as source index, if we just mark in the source
index (e.g. in ce_flags) the entries that should be copied to
o->result and _not_ create them in o->result. When it's time to create
o->dst_index (which is the_index) from o->result, we could just do
little manipulation to delete stuff that the_index has but o->result
does not and add a bit more things. It is something that at least
sounds nice in my head, but I'm not sure if it works out...
-- 
Duy
