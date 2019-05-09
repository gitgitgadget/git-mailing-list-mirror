Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3E11F45F
	for <e@80x24.org>; Thu,  9 May 2019 19:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfEITAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 15:00:20 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42687 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfEISvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:51:43 -0400
Received: by mail-pg1-f182.google.com with SMTP id 145so1654721pgg.9
        for <git@vger.kernel.org>; Thu, 09 May 2019 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y3SOUsmOb5d58lM4AwxJDyPV6FttcEVXL5Ct4i7rrOU=;
        b=Gkf5tAKimfIoMd4y6Y4WlAU2XayiwdvEj643LSgH/uWpMSquSkE77t6Q9yoN3KsSqH
         OdHy5a1J9RLeWtl8QxGZWIQd7E5vzM4vdyoLrAxiJrr+/xHrTAQyO/tcvI6GJJu4EM1U
         uuUdsjUaY4mgMeWa/ap9mAxJJdWtyQEvkl5IMDNiYXS9QipPothjfl2uK2JzyM4lkjgn
         ev37ruufWYRvEiA+ObijDXCIShKzFsRW9udZaBLnzsTTqC0J/mXMsndWoyYo6vThdL0Z
         knEiVEWX18YSnQ/tlK10Ix6MHLYAvX4ftz7upw+fOJGj0T90z5Z1pd/LK0EOFSXpoJVK
         RrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y3SOUsmOb5d58lM4AwxJDyPV6FttcEVXL5Ct4i7rrOU=;
        b=IrLFd7F58h5x0a2Y9S7jNoL/p0E/qs3VYLJWEsPdsnNmIwcN0ce5IbvuRewCGzp/ku
         qRwUJWdFtkZtIYe8XY6bLwcTJspUV4CqvrKARTaSTFJqTEM+XmADXOk3ZyUBYWNQM+UP
         d+GHAC4ky8ZamRDLmkq62kOc86dlPFk1ybyG2/d10xON5gPJ2YlmtI1Kb4/3p5gnsSEZ
         ceEvjY18vqKr1rslJTEqJzYb14IiO1qlKsWU8vTsMBIUlFqR/tadHCmCgWKM7Lq0hYyu
         gtWfchw4HkBpjZICj5aAcEM0O5lRQ5m7/iS9mmuggFGKGM6elbAhln5UdM+z6DoZbGFg
         Q5Yw==
X-Gm-Message-State: APjAAAWeIossSucB/Bkv6r9tfxxX+ykekIaXPjE4jQHA+Zdx3CH0MNJg
        uHoYhPs9gpyiVtrKbs/XcX7edCfdovacxw==
X-Google-Smtp-Source: APXvYqwxwRu4ONzxpxx+pk09+YRgR9Sh/FTHy0HdgF5XGdFqmsEUpDEBs/sapG0IutvaVV2JDLVDWw==
X-Received: by 2002:a62:479b:: with SMTP id p27mr7800195pfi.111.1557427901560;
        Thu, 09 May 2019 11:51:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id b20sm6198028pff.118.2019.05.09.11.51.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 11:51:40 -0700 (PDT)
Date:   Thu, 9 May 2019 11:51:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190509185136.GC14000@google.com>
References: <20190508231013.GA25216@homura.localdomain>
 <20190509001959.GB14000@google.com>
 <20190509165025.GA18342@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509165025.GA18342@homura.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 09, 2019 at 12:50:25PM -0400, Drew DeVault wrote:
> On 2019-05-08  5:19 PM, Emily Shaffer wrote:
> > What I think might be useful (and what I was hoping you were going to
> > talk about when I saw the subject line) would be if the Message-Id is
> > conveniently stored during `git send-email` on v1 and somehow saved in a
> > useful place in order to apply to the In-Reply-To field on v2
> > automatically upon `git format-patch -v2`. I'll admit I didn't know
> > about --in-reply-to=ask and that helps with the pain point I've
> > experienced sending out v2 before.
> 
> --in-reply-to=ask doesn't exist, that's what I'm looking to add. This
> convenient storage mechanism is exactly what I'm talking about. Sorry
> for the confusion.

Looking at the documentation, I suppose I hadn't realized before that
--thread will generate a Message-Id for your cover letter. It does seem
like we could teach --thread to check for the previous patch's cover
letter in the directory provided by -o. Of course, this wouldn't work
if the author was generating v2 and didn't have the v1 files available
(i.e. different workstation or different author picking up the set).

I'm still not sure I see the value of the extra header proposed here.
I'd appreciate an explanation of how you think it would be used, Drew.

I don't know much about emailed workflows outside of Git; is this
something likely to be useful to other communities?

 - Emily
