Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564341F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfHOWyU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:54:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39470 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbfHOWyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:54:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so1628298pln.6
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGJITiRZZ8WmPV5f+VDY7stsxBRC2PE1Jtd4FTVuy2g=;
        b=U2Tq87Upe34i8Wlzfc8imGMUEkQ2udyz2kOCi3Dt6anOwSmWxWeSFnnJ0Vwgkvyljb
         1IvLd7DouNAxJ5BSPPEdRzCQJNeJzTutpTlBsy2hpApVRg2+COLfLM20hWq5qNt11VwE
         Or+vGi/5J/vaOhVlSiUMlwAconj9ptCR37MLW2sE+Vg52BhVpZZOqwBJwG4ZY47jD7CL
         P2hV3OW2RqYGlqHB6wolPfuKCEQrgwASocMoq/fXYLYlbLzfac9oih7Nkbf+4+yLgm7r
         mv6QUgFI1XuECXSxFZ2/GKS3y/YfaFeyp5iWDea7OPHMAAK1GkluvYB+WwHipmMie5hH
         /xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGJITiRZZ8WmPV5f+VDY7stsxBRC2PE1Jtd4FTVuy2g=;
        b=dei/zrXEkixhvtBDsFiyeShgbjHggb+I3VoNTNWVIR5j8hwoYAX8c41SDRqR05goWs
         9z3R141/gmWT161efHoecZ6X2Qx/D6YkjwFe4N82dcVx7Qr+4+HXq1TQaatDYFX6RaHv
         BM85cEYobBbJ7+enTCR8n4lDYt8ft6EZl2oNTTufO2jYd0Dn9vmmLLMfFYu+4yPfeTVL
         HOVl5AwAc3OfUC6xZV3e6gXZCSOfvgo1kvE7DBAr4GG69BO2O3MZ2D6GyuhYDgaeoxXq
         JgNesIE1t9NF3e/RheM7dnVVwqwBKx3ovF61U5l4TDPdb+Mf+qSIdw64NYhcqr4Ocr+J
         a3Wg==
X-Gm-Message-State: APjAAAXZFW1ZQnXW3xUSvONaLcxJBtYHM39CNiZJDpGehqB1tPXHqPub
        M1kkQBnsLQ9YsrDzsN/Cuu+g9g==
X-Google-Smtp-Source: APXvYqzB9mY0EgCGURZTKMbV4qCR7eMU1kQajmv9Qygd1JSa/4t+mmute2SHhHewD2T2taDFDzpsqQ==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr5921447plf.98.1565909659055;
        Thu, 15 Aug 2019 15:54:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m125sm3211165pfm.139.2019.08.15.15.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 15:54:18 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:54:13 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190815225413.GE208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com>
 <20190815215225.GB208753@google.com>
 <xmqq7e7e2hbv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e7e2hbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 03:29:24PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> > +NOTE
> >> > +----
> >> > +Bug reports can be sent to git@vger.kernel.org.
> >> 
> >> I am not sure if this belongs here.
> >
> > Sure, I wasn't certain either. Would you rather I remove the "what to do
> > with this bugreport" NOTE section entirely?
> 
> Not really.  You are invoking an editor to let the user edit the
> pre-populated report, and I would imagine that a comment in that
> file would be the best place to give instructions, not a manpage
> for "git bugreport" command.

Oh, I see! In that case, do you still want the Git mailing list address
shown in the report text?

> 
> > So, what's your suggestion? Not to check the output at all? (This may
> > actually be fine; it occurred to me while reading your review that if a
> > user is filing a bug report about something, one of the diagnostic
> > commands in bugreport might be what's broken for them. So perhaps it
> > should be tolerant to missing information...)
> 
> Right.

Ok, will do.
