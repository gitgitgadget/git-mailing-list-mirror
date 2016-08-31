Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915011F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbcHaWnn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:43:43 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34065 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbcHaWnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:43:42 -0400
Received: by mail-yw0-f176.google.com with SMTP id z8so40132025ywa.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GG+BBwwaGFvcnUx9tanXE6oLJuZz35XtWfn7VbMFPFo=;
        b=x+uxzL5MRkrAzvRBEJraXsUNIb/w/F/DyeSwlw2lajAa+xz1rS5KzXJlq+PQ5gmejz
         gH9tHF5mtW6NZRfhwYXLKB+NxFFiI5PNmggcQk7mLgs9Dg4OEksQElLCJSA1F2de0ANY
         mtD9vjyr8A4CQOIdW5x0CMFmJeE3rYBS+Mziehsnk87pXqwGcQb9Gqq5PxC+u6XahZ37
         TCJGHSQEE4JLLkl6vHFhHP4zsbCLeaov2NKUZVy88ysllKB7+dTDOg4KUg5y6e2gqqPQ
         iS+GZuL8a0HvBPSbJ7k80BRo4WcoszJsqNv627BKa7NoCMY244IaisfVLLDFntqFP2W2
         0+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GG+BBwwaGFvcnUx9tanXE6oLJuZz35XtWfn7VbMFPFo=;
        b=OVAXVnXyd7+DPPQlcu25Y83vA4Y0iv1+TybtzhDsj7iG2T6dacyH2TiBAy05urlXg/
         6gLm+KVNPP9DtP4tD6jRWiJJCKGQLnDbRNEsReJk9JBBFIak15oPAWxFpsAztSYQt7ZO
         2OM+aRM3GDY2uy8QPt/3pG+YNB1ELsqXbwSr8LSOzizKBCuUohpBD9jLomyKFszH5zSr
         Eb1HIHCaiZfPX5CDXSXxE9oBssZVnTG3WImgFCdZ8/yixeA4VdefWQmFI9vIk2yPpPkU
         xO05GDm0VWYjaBzG+biL2E8BtBbbKfki2VVK2rQc84zblnLNkYDz/VqVzgUnnnY52aaq
         E+Qg==
X-Gm-Message-State: AE9vXwMwm+YOTTefD+wuqAnl0iH7NsxsQRNA3CFycWgP2rXkz833G2fHC7nEMNUb5CJIDssMKvMIaWXW4KAuBQ==
X-Received: by 10.13.228.196 with SMTP id n187mr11274613ywe.83.1472683421448;
 Wed, 31 Aug 2016 15:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 31 Aug 2016 15:43:21 -0700 (PDT)
In-Reply-To: <xmqq37lk3n17.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpvtdoeK3uiSGAeNzQaYQhS7p0WT+nCcfKAS7FauFNftQ@mail.gmail.com>
 <20160826231320.7038-1-jacob.e.keller@intel.com> <xmqq37lk3n17.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 31 Aug 2016 15:43:21 -0700
Message-ID: <CA+P7+xppw7NFX5d7EM+dXKq4v-hMzJgg0mhGmv8wmUJ52i8Nzw@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] submodule inline diff format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 9:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>>> We probably should release for the error case. I'll do that. I don't
>>> believe do_submodule_path ensures that the passed in argument is
>>> guaranteed to not be initialized or used.
>>>
>>> Thanks,
>>> Jake
>>
>> Here's the squash for this fix.
>
> It seems that the topic has been quiet since the message I am
> responding to.  Have all the issues been resolved, or are there
> still some loose ends to be hashed out?
>
> Hoping that the answer is "the former", I'll mark this topic as
> "Waiting for a reroll."
>
> Thanks.

As far as I know they have. You mentioned a few nits in one comment,
but then said you had a re-worded message that you queued so I assumed
those nits were all squashed in. If that's correct, and you already
applied my squash for the strbuf leak I think we're good and I had
nothing coming in a future re-roll based on looking at what you have
queued in your jk/diff-submodule-inline-diff branch.

Regards,
Jake
