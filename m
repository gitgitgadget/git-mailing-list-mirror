Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEC21FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 04:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdBNEXe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 23:23:34 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35339 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdBNEXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 23:23:33 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so2782367ith.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 20:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4xGGewTxXLjy0Tc47dGnQnKC5MXWpS4wnCqbn2fGLLM=;
        b=AE1vSBdGTyNbaTSurCzLRvXf6TQp3kqWW5KuvgBZfppTCWmTrTGWoEjW38Zk3DXsoy
         7YxU4p6tdZwpw9YZKjMZkUvqVz2Vje12dLqffgfMiMZ2CxS0nLjZhLUEbsRLVkvLhg1i
         5lxwFrinztSiyAOY/97mSEOyJsuCi5hUC0B/+UjbbMCdb+irEdrc55B7FE6y1gHGziv3
         6DDKxFit4LGxFnht+wTRfC7oDxFWiqXZPX9RURLIbPJd7JN6uPaE2KwDE1X3YVz1nUFx
         znBlz/A4Fyk2FTYnjykAeBk+5LJ8cMlzKJ2D/ceUqwFYhvIY0h5YXY7HuPCpxD6MagGa
         6JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xGGewTxXLjy0Tc47dGnQnKC5MXWpS4wnCqbn2fGLLM=;
        b=NBGdIEk+CROi9tf4p3Z7H2ZkOIF+QP1h/jtKJmNp0kYk1xW54TxIAmNDeTNWNMyIuo
         53WoH0wkWqbJBNj1QfbdAKI+oJqvzR9l7dvk70+hsfTqWGw8s6MLrfbzEScqRxQJbDCY
         TMZd4Fg8JEtzguFEP+v9VXtcbbEDOgZqsK1ho3kfac45Resfb7NEruwUztupi/yq0juI
         rIlc6G0D3AJNGAEFAskWtTot0qDEgy7+GdV9Gr7gyHrKWPpjjABjpSxdObbisr8b4fKg
         OKIeCM4qWfJeHOrgiHj9dl1i3AmRoi/DZSkTKlgNpeWTB0rvPDgQj4CbMI0q4YQ3IFJS
         uYdQ==
X-Gm-Message-State: AMke39n/xQIFrO7a+jgVAnaWFMpCPBcrQh35DFLCaYrJb8CG/KNgzgC6YYcla8zFz/1gOA==
X-Received: by 10.99.153.1 with SMTP id d1mr30723009pge.44.1487046212469;
        Mon, 13 Feb 2017 20:23:32 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id 19sm23553037pft.46.2017.02.13.20.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 20:23:31 -0800 (PST)
Date:   Tue, 14 Feb 2017 04:23:29 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a
 revision
Message-ID: <20170214042329.GA24543@ubuntu-512mb-blr1-01.localdomain>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
 <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
 <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
 <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
 <20170212123630.GA20872@ubuntu-512mb-blr1-01.localdomain>
 <xmqqwpcvfdao.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpcvfdao.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,
> 
> See the 3-patch series I just sent out.  I didn't think it through
> very carefully (especially the error message the other caller
> produces), but the whole thing _smells_ correct to me.

Okay, got it! I will write-up those changes, and make sure nothing bad
happens. (Also, the one other function that calls handle_revision_opt,
parse_revision_opt needs to be fixed for any changes in
handle_revision_opt.)

I will do all of this in the next week (Unfortunately, exams!) and
submit a new version of this patch (Also, I need to update tests, add
documentation, and remove code that does this shorthand stuff for
other commands as per Matthieu's comments)

--
Best Regards,

Siddharth Kannan.
