Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F84D201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbdKLMOm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 07:14:42 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:44868 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdKLMOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 07:14:41 -0500
Received: by mail-pg0-f42.google.com with SMTP id 4so1817601pge.1
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 04:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=5HnPE2ZbTVqsjCVkct3Lc7h8tSJvMsKjgCE9ztyu57A=;
        b=P/p0POy0bBcM76KdynRMSLG7XE8LfyDkNRfinFb9GmNFZFMa4oLoXYT1sf+bdF3U82
         SG8iCUjwNbUUWI3+5FH7YlBmmVCcnYdYBRACQNmAgTBJ/xgRc7C+Ls0lPgWUc/ImAzCX
         Ws106gkEewKQiQ4L2vkd4U6aZIwqzT5ZHHc+4OpSEEcRrl0ZMN6G7/wI4Vy7Cyd9sVTz
         wQOXVUJ+4p63tCJ9zteLUrx7f5qLKkMBCm4/qxhAQCfqr5HmNQ6WDb9dHcCwAygm66k9
         j0hEzPMxK2+o9gveMtmkJCCR6a4fz+91XtYkgjEN5s5nR3EhWTsEAzyJVbhnI/juATAL
         EhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=5HnPE2ZbTVqsjCVkct3Lc7h8tSJvMsKjgCE9ztyu57A=;
        b=d+Zkcmd6zEnvAFl9eQDJLbJ1YIVYHUf1pPK84Y/YJLjpISMCQL/PrdoMF3i8Ub5pAY
         8iRbsW3odXyxq5B1BI0hKRU57oaQkk0jPb8tqb2Hcr0aoNpmE3ntoDcKntqYSk/SUw4g
         CYaCwDNJaCiTDRB3dt/eUmYaH+fMkFTLumanqtN6CWFZCwTnPn2QekdBOAUQeZ0RmcO5
         vsjM7CKTUY9q+ATMfBmStHLQKfaygbCOPbOJ0TsmNrfRSZIebCIdXTmHMHKduFTg1pbT
         3PFXpRAtnU8yQGAuKkpRpjSYFd9jQYG7RAj+PdmZl8hZqMUC2tNHIyHI3f8HVuDROpp6
         pxQw==
X-Gm-Message-State: AJaThX6i0U4JVzwuIu7XDVfXRLISNNx+nt9mrIZpptqWW6/NpXXTXj5V
        DgixAspfNefJz4R308/gZLY=
X-Google-Smtp-Source: AGs4zMY+FqgVfkb3hiS/vIq4l6Dmr16guAm3vyHd23zpY1RtulHxnS9GjdYp+pGxYcVia6dML3CzlA==
X-Received: by 10.99.126.6 with SMTP id z6mr4183625pgc.126.1510488881246;
        Sun, 12 Nov 2017 04:14:41 -0800 (PST)
Received: from unique-pc ([117.249.159.102])
        by smtp.gmail.com with ESMTPSA id f7sm642000pfa.133.2017.11.12.04.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 04:14:40 -0800 (PST)
Message-ID: <1510488875.2683.3.camel@gmail.com>
Subject: Re: "git bisect" takes exactly one bad commit and one or more good?
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.21.1711111024470.10756@localhost.localdomain>
References: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
         <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com>
         <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
         <alpine.LFD.2.21.1711111024470.10756@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 12 Nov 2017 17:44:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-11-11 at 10:27 -0500, Robert P. J. Day wrote:
> 
>   i realize that one of each commit is the simplest use case, but the
> scenario that occurred to me is a bunch of branches being merged and,
> suddenly, you have a bug, and you're not sure where it came from so
> you identify a number of good commits, one per merged branch, and go
> from there.
> 
> 

Just thinking out loud, couldn't you give the one commit that was the
tip of the branch, to which you merged the branches, before you merged
in the branches as the good commit ?


-- 
Kaartic
