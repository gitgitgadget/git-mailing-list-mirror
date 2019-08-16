Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBE91F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHPTIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 15:08:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33385 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPTIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 15:08:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id go14so2509108plb.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPxwOhRVpKyqv+aLk5Rfsr7IFMONRUDxPhyVnvDPhRM=;
        b=dXgT7hh+Loo1eKpJsV+JxFJw3Ifqj0dJiU8HIrUn0if4wkoMQFonbIvlv3oMiC52gy
         Ywqo30smGFyBYfyzcqWOHuPtqKyCg2kjLWkxVFCi48W61HEFsO+cy4rr9b5RSeSe0BwM
         oRupFdx0bYLMgzcS2uml52iHM4rQv8ML4Y0xNu46ZwaoMdl2l6SdN8NemaL7UXnSjXmL
         +SLLo+/ZhWkSNumkVXouZPP0MdbGJYy9t6VtoGdN4z0Ui7OTFZGSWQMrFrhUVPtrWAa7
         Rz17xr+DDh/Q+etWBEQVK26mNi0uxrjo96dfIT0Os4g3nLoFhr2kQBnnsjOF7kqMj66y
         Q5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPxwOhRVpKyqv+aLk5Rfsr7IFMONRUDxPhyVnvDPhRM=;
        b=EsawC2sTyFx9qj1D8Qnz3Yb+Q/XGLxIfhMo+BItLIl941wzmmqS1m8PDuACy8B5jp5
         fsWVBninxpvfHIuv74hv2dd8eKDFhHcRaBhifBKn8PKckQWFxRXEgnGwBG4WJRk4UEwk
         B0SDVSnmAdjwEtAxC3qD9xEO1/pa4LLSRRGzmoenxDkdXIzs17vTut2oRuqzOcshLrwW
         VYD6djyJSigPf4aNFKj1lbLbIEit+JvZM1f5I53flcBoRTrRX3FptvAv1FS5YXcn4Msc
         IR8zpNXdqvt7Ix+/PD5o4NEajq43Nljpg2/kfaSP/kqPrrrJMwJ0d4L7YCBWjVL2D4Zz
         ABDw==
X-Gm-Message-State: APjAAAWOR9FFWNMSg1VTpZ7k/jF3pjAlbrM7/rJcLUO9MDZFAp6lev69
        Gsmgxfy3QgC5D5POdylYp9/JIQ==
X-Google-Smtp-Source: APXvYqwSjB2lSJUmrwYWKxkF+RIJBSW+ihEeJf6PgoRdQKJJx4AIl5TYawapjIRB9SwQPE31glM0jQ==
X-Received: by 2002:a17:902:82c4:: with SMTP id u4mr10848049plz.196.1565982495558;
        Fri, 16 Aug 2019 12:08:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e189sm5742514pgc.15.2019.08.16.12.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 12:08:14 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:08:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190816190810.GG208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
 <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
 <20190815225231.GD208753@google.com>
 <xmqqwofe0zgd.fsf@gitster-ct.c.googlers.com>
 <20190816012519.GF208753@google.com>
 <xmqqpnl512re.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnl512re.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 09:41:41AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > I think comparing this habit to the .gitignore isn't quite fair -
> > .gitignore tells me I forgot to add my new command binary to it, when I
> > run `git status` to see what I need to add to my commit with new
> > command.
> 
> That is why I said that we need to actively work on, if we care
> about getting quality reports.
> 
> I do not think it is unreasonable to expect the build procedure for
> "git bugreport" to involve scanning in Documentation/config/ to pick
> up variable names, annotated in such a way that is invisible to
> AsciiDoc to allow us tell which ones are sensitive and which ones
> are not.  A test in t/ could even check if a documented
> configuration variable has such an annotation.  A commit that adds
> configuration variables without documentiong them does exist, but
> variables without documentation are (1) bugs, and (2) are not worth
> serious engineering effort on until they get documented.

Interesting. I think I have an idea for a way to do this, but it ends up
fairly large; I'll send proof of concept as a follow-on patch to this
one. Thanks for the suggestions.

 - Emily
