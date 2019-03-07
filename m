Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39C620248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCGAQK (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:16:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35702 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCGAQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:16:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so9756512pgd.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q+RnuloFZ2zLbWBXGsbJPx1I4EkWEwOVdP6dVj3hPoo=;
        b=U6C2xTk68h9qpQ7ZNpljlYbvmk8GIfCmy4MFS3wG4GCTv0/gdMDgIkvVoHcOzVSQ5o
         wQa7QI9/+dRyJdAWk3UF1ngv6i7w7pll3IDJ7ycrcz6fIvKDegHsHtBWYrcyM4uyQf4I
         dFOVVOSh12/dHaDEBN1fwdDiuzeVAVmMmI3Yrr4LZIc6UnblyIzaRuAWhu4bdxFNT7Pb
         jT9wQ1hiB0lJdQvVJQ1wUyXGy4S+6TyDdhPCWNJwtagb4K5ceCdFj4hJDOweyYFqdf40
         SFt0RDvszaYPtZZawuHbgasKvsz5ayeXta6b5Widq4jQzz55Nw9HDbet/gwj4wc0Nq5m
         uFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+RnuloFZ2zLbWBXGsbJPx1I4EkWEwOVdP6dVj3hPoo=;
        b=XSsx7JbtePkN2Og8ikumQtSIiJ0BGkfIezuHdrvZBDyyMMhP6IxEs+1kmjvFOQigN5
         x3pafLZhmIDdJqtLUhPJbVtDaqEjVqxeNjOzpFlAL9xk5wvWB++S8RNhoNBIQEULMHln
         MbNObbmZN5/1RtHYjdtaaDF5o2IcC4Hsktc6ao568gKoDIxcHDavHRD73hyyRiImGfjN
         J6ovHwIzS3KA61CS9JO55DnfFeiczIlK+oqeEsB3kkRJoWLcCGa6X14UaCblQJgtuI7E
         k7NTHU9XDUwuZan/wKzGbdaa4DytqV52NRYHV8JrAyW6J2fXVKWyNAWA1SPCCPkhGfMA
         Gzcg==
X-Gm-Message-State: APjAAAWXVkkYWGr/MkzSB1oFJFDkoOqze9UHYX2HV9RmayDclL7CPSNR
        GlWmQeH2hZ+TAUwy45gRP4I=
X-Google-Smtp-Source: APXvYqxeZdurceFQspEOTYmns8FnOAxVN7ep6+vlguJEpPUPibPxZQr2ylh51Pj6w3iBJ2kdqq5Ztg==
X-Received: by 2002:a63:1021:: with SMTP id f33mr8766166pgl.392.1551917769618;
        Wed, 06 Mar 2019 16:16:09 -0800 (PST)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k27sm3894871pgb.70.2019.03.06.16.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:16:08 -0800 (PST)
Date:   Wed, 6 Mar 2019 16:16:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] cherry-pick/revert: add scissors line on merge
 conflict
Message-ID: <20190307001607.GA25324@dev-l>
References: <cover.1551867827.git.liu.denton@gmail.com>
 <70a508ca0b2d837b311afefcc2b0ffb6cfbd34fb.1551867827.git.liu.denton@gmail.com>
 <1fa469d7-76ef-36b5-9688-43853fa2b2ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fa469d7-76ef-36b5-9688-43853fa2b2ee@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip, sorry I forgot to address one of your replies.

On Wed, Mar 06, 2019 at 04:29:20PM +0000, Phillip Wood wrote:
> Hi Denton
> 
> On 06/03/2019 10:30, Denton Liu wrote:
> >Fix a bug where the scissors line is placed after the Conflicts:
> >section, in the case where a merge conflict occurs and
> >commit.cleanup = scissors.
> 
> Was that the case with cherry-pick and revert as well as merge, or were they
> missing the scissors line entirely as the subject line suggests?

The bug is that git-{cherry-pick,revert,merge} all place the conflicts
hint into MERGE_MSG, which then gets read by git-commit which will place
a scissors line under all that stuff.

The fix is to make git-{cherry-pick,revert,merge} put the scissors line
before the conflicts hint, so the scissors are actually placed in that
command instead of in git-commit. Is the commit message still unclear or
does it make sense now?

Thanks,

Denton
