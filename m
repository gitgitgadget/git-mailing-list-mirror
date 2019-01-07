Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAFB1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 22:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAGW0f (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 17:26:35 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37871 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGW0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 17:26:35 -0500
Received: by mail-pf1-f179.google.com with SMTP id y126so863236pfb.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 14:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hKWtH2t6dtGMKx/8PC0zZ7Q1VBwu9iEniwP7jMVudTE=;
        b=Eo6PpaphHAft2eVqqUvq5FdvzgEZer9ilT4t5NXfBlAoA6NVLxVJwUVKw2iB+w24CF
         +jnxo+RrAsrobp3zpGwMdsFVF5dHF3EL73hOjeama0/hypTxRgyk2UCgZFgY9Xc69ub7
         fKvBgkKc9Q8iBUPJ077R6+zbASDF1uFkajqYm6q5CeMMfmDv/RPaupIQMmynNOMnapIY
         BejKyxW7QwcwsMX8YWjQEWEcQjKiDmnIIK0sdYCYftXztw8HCoL0hk8uD0raukI96xPK
         ReXj2pObkYaZdGBRWaSIcq5qx3Mq4FGx7Coiiqjw58hXrcw9n+aSHV3ofNIhQD26DpPi
         q9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKWtH2t6dtGMKx/8PC0zZ7Q1VBwu9iEniwP7jMVudTE=;
        b=ZIkHpx3iRwo/lSLpndnPhQsjkRoTQ11iJvgMQe3T6uVChz+iGF7FH+Xh9WRO+hQDlQ
         gBMspwSKMZpup7+RvdczXCRDH2rBE8pQt0/FlcRnC8M4tcp5WNbWqgHbtKKtnmG9H6mH
         HijgAwLmHlEWYLg5QagLmNDvCC3dJMG7oI/+Yf8yINTRhaA/TEkh8P9BNIQ3BUQdOlZD
         ulbY5LUyw+CZuSsHZsMblY8gjZCBsHaOOS0zYAOzytk681XFOvE+AKly92oczPI6MeAj
         guP0QvufDGCFHCtv1BFi6qlJJs7tnvqoWku/tn+qDQ5mlPFmULISUU843a3+fk9yOeSD
         S1ZA==
X-Gm-Message-State: AJcUukcMe8Pq74Ti/bOZrEUTj9WjlfdVYoOxPOo9C5w0H+q0J2+cjLoc
        E+Ub9Ume9QujfA7nSIcHBCM=
X-Google-Smtp-Source: ALg8bN4czv/ON1bu4NGIjXgsti9V8Q4OU59/RNxR/dXH40PUdgIAvIssA6purRdh2MPQxWMzqmOZMg==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr12196672pgk.102.1546899993859;
        Mon, 07 Jan 2019 14:26:33 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l22sm116546908pfj.179.2019.01.07.14.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 14:26:33 -0800 (PST)
Date:   Mon, 7 Jan 2019 14:26:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robin Shen <robin@onedev.io>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, jgit-dev@eclipse.org
Subject: Re: Introducing OneDev - an open source git server with interesting
 features
Message-ID: <20190107222631.GB192553@google.com>
References: <SG2PR04MB3205E9C83085CFF2F426FE65B9890@SG2PR04MB3205.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR04MB3205E9C83085CFF2F426FE65B9890@SG2PR04MB3205.apcprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+jgit-dev
Hi Robin,

Robin Shen wrote:

> Dear git users,
>
> OneDev is an open source git server with interesting features such
> as language aware code search/navigation, issue workflow
> customization, free source/diff comment and discussion, etc.
>
> It is using MIT license and hope it can be useful to someone.  Learn
> more at https://onedev.io

Thanks for writing!  Looking at
https://github.com/theonedev/onedev/blob/master/core/pom.xml, it
appears this is a web interface that uses JGit for Git support.

Can you say a little about how it compares to Gitblit
<http://gitblit.com>, Phabricator, Gerrit, and other interfaces?

Also, if you have time for it, mind saying a little about what your
experience using JGit has been like?  Any thoughts about what worked
well and what didn't work as well?  This can help both the Git and
JGit projects:

- Git, since it can help us learn from JGit's successes and mistakes
- JGit, since it's not too late to make the API better :)

Sincerely,
Jonathan
