Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9B820373
	for <e@80x24.org>; Tue, 14 Mar 2017 17:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdCNRDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:03:38 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34245 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdCNRDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:03:37 -0400
Received: by mail-pf0-f178.google.com with SMTP id v190so72972631pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrp1WyupWKB42C4JkoFyiVu9VZrV43ct7xCTtIBSkb4=;
        b=FXSeUbghYenAASE3pDhR//O0OfUIgUn/F1/VoQ+YdJUsXPsSAkd/Km1YzykIRNflY7
         B54s1sXjcXUvHjzrIU9AGH1BIPn8K9ZcnKbf39MFd7sF+f7hWsugNFohti0yD315Gc0Z
         LLvQgNCiVOBgNKwMabfnfKjkzcqBLf9l+qLp6khEJvpptaPvIwFLNAXo+7sU5an0impC
         vlTDN3M62ErjOLcqwIDHQtogYLq5877ad5QhOFHsXVo29kWznoF3m1bhABzfOGsHnwpJ
         iHFmHMXWLRHSOv4Q+TxjU4bygQhFHIcMEJsOi8E4117xTX2emvSjw1qzkh4sb8ivOcRU
         OMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrp1WyupWKB42C4JkoFyiVu9VZrV43ct7xCTtIBSkb4=;
        b=eu67uDzU0v5Jqw633I3ZHEtFyyNuDehBZpyZUgIo6DeoJj/xwF2JgcLg056ED80wBS
         9kLiEre8Fm5kopVwy5iEitXln6JDKHv1G2KXpZV5O+X3MCHpP7FvnN65tufxi3vCxlyP
         VP85toC3M/DxnBJvdRWHu9a8DlVam5g2noD5j4Vir2vKUexI6PrKcZ9cZ7E0BC3PgcC1
         YF/R3K4sIx6tbRU20xCvUshJmVDOREg53m3xiNPHNI2GOQFIqYF22rPkNblSu88wWOTw
         fDoQRC0fJDWjeHABxD5oJbhn1Yt1SGYk6RmyYddBFs8vQ7BOButSgwuqR4nBflLjU484
         0EWQ==
X-Gm-Message-State: AMke39mZQt9TDId/+Z62LzdVU4yCHwDlpHTt9UHTqCf9OqVphDNZ899TB1kuwQXFGT9PGPJn
X-Received: by 10.99.125.68 with SMTP id m4mr45253648pgn.13.1489511015860;
        Tue, 14 Mar 2017 10:03:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id y5sm39716068pfd.33.2017.03.14.10.03.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 10:03:34 -0700 (PDT)
Date:   Tue, 14 Mar 2017 10:03:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket
 if a socket
Message-ID: <20170314170333.GD66601@google.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
 <20170314003246.71586-4-lehmacdj@gmail.com>
 <2ACF39EA-B76A-462E-993C-ACBB143A1581@gmail.com>
 <20170314004420.GC66601@google.com>
 <D11DDB6C-7B6A-43BF-86A3-6DA48109C07C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D11DDB6C-7B6A-43BF-86A3-6DA48109C07C@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Devin Lehmacher wrote:
> > Best practice for submitting patches would be to ensure that each patch
> > compiles without errors (with the DEVELOPER=1 flag set) and that the
> > entire test suite passes with no errors; this is to maintain
> > bisect-ability.  Only after you've done this should you send your
> > patches to the mailing list.
> 
> Thanks for the advice. I will be more careful in the future.

Of course! And no worries, I just wanted you to be aware of the
conventions so that you have an easier time contributing :)

-- 
Brandon Williams
