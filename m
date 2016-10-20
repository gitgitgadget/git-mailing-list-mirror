Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38831F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbcJTSEf (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:04:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36261 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcJTSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:04:34 -0400
Received: by mail-lf0-f68.google.com with SMTP id b75so1586928lfg.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=us9JHpsrBeUSNE6bZNSpgFfyEDlW2duCGrYncMuSAMU=;
        b=Tqwbm1HUG8r76nEXc8pLLWtF4VJEgPetD8eQy+Q/Oy4+ItGjUX8rc08/HxEd6OZUWj
         B2XhQfKKmD6BAr5mzuhpSKmHKQTa1rtFbEU4exVqCFHc3R591HOR/Rx5bi9P2cvhU3gf
         J9g18tmy5ISrfOYDiKhjHztOP77aXgqGEvUJ78T+XnY3CmwH4DeTb8A8nTPwgs16o1iA
         lYJsc2G9JjuQC4LsWLmz/ZyHZzE0v8I2CqcLo/o2DPoGRSHemkspAO7zfW9unnFyNB8W
         3cdnEAsP4Ey2chEFvsmX4HVttSN4VcG6NFroOMBU7u/2IrS6qJkvXP9p5l0ukopy3FEJ
         0XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=us9JHpsrBeUSNE6bZNSpgFfyEDlW2duCGrYncMuSAMU=;
        b=M4AaxS0GB1JmCoiYN2mu9OWEMfwEwEKst1htcRF5RdFtelnOCPiCm892E695mulArw
         GjvktWgaT0lMFzqQZea1KbB6b9v3X+gruKneBbZYixdAR4nW54VyVevKPnqELwVlavL/
         /RY2AVBS3ZIWhdbgT6jo69Th7UhnkBdCXZC5CoJ9D81H9hmipA0g3yF55nYQW0EchFpu
         zqP4O6aGkwiYOU9MYYnmJ4G4SNP91syP044A9xqGBbqDRPFWLWa/kjGB0lgvbN2PtYow
         81Qk5U3M0TI6oBSuCldgXV93H80GNG5RJWVBOQEZGK4B5paYGylU+t0OLIHRoWSS94o7
         FLHA==
X-Gm-Message-State: ABUngvdvycmurwlwf3EZNCroaNQiD+RRwRj4RVzfua1f/dIm0qF7T9Jw8+iS59dLqBeNMw==
X-Received: by 10.194.23.4 with SMTP id i4mr1056513wjf.185.1476986673033;
        Thu, 20 Oct 2016 11:04:33 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id pe5sm80801833wjb.15.2016.10.20.11.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 11:04:32 -0700 (PDT)
Message-ID: <1476986671.28685.5.camel@kaarsemaker.net>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header
 mode
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jacob.e.keller@intel.com,
        stefanbeller@gmail.com, peff@peff.net, j6t@kdbg.org,
        jacob.keller@gmail.com
Date:   Thu, 20 Oct 2016 20:04:31 +0200
In-Reply-To: <xmqq4m48j70o.fsf@gitster.mtv.corp.google.com>
References: <1476908699.26043.9.camel@kaarsemaker.net>
         <20161019210448.aupphybw5qar6mqe@hurricane>
         <xmqq4m48j70o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-10-19 at 15:41 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > +	touch expect &&
> > +	printf "\0" > expect &&
> 
> 
> What's the point of that "touch", especially if you are going to
> overwrite it immediately after?

Leftover debugging crud. I tried various ways of generating an
actual/expect to compare.

> > +	git rev-list --header --max-count=1 HEAD | tail -n1 >actual &&
> 
> 
> As "tail" is a tool for text files, it is likely unportable to use
> "tail -n1" to grab the "last incomplete line that happens to contain
> a single NUL".
> 
> > +	test_cmp_bin expect actual
> > +'

Yeah, I was fearing that. I didn't find anything in the testsuite that
helps answering the question "does this file end with a NUL" and would
appreciate a hint :)

D.
