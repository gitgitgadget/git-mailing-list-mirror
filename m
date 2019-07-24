Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFE61F462
	for <e@80x24.org>; Wed, 24 Jul 2019 23:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfGXXLf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 19:11:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 19:11:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so22521423plo.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzrmH0wZ3rMTId+gpq70bZbTlAhG3sU036VYmovIzpY=;
        b=L9b6j2YvNEs60r6szN3kE06UaRPzcXE9tb14uvzS/FnQS7mXfrKq61GCRbMy8iDwDn
         oo5hAVSjFl6CVEOLFEcG/yvomW6NFpLYrX/tV0mH1yCxm7yzENhGhh9EFsp+mkQwroLv
         t6q5JtnGPi3a+7SoohFbwuah+UAwbv7dD2AbWNCaN+HUarRqiAGaDLJtSeUCHEsbOlRY
         tkq+QBipPYG5FhzL2x312d6vGJ+Kp74cwJ/HpF0wrd9AUClRaKjZk+ko6CyXbTg4UcR5
         KqDZC7voqirTG3gfibbs3SzwYUFS3vZlVjsX9yzZEV8eBDgjgVpbgNxH7Jbo0Jyto+GG
         DCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gzrmH0wZ3rMTId+gpq70bZbTlAhG3sU036VYmovIzpY=;
        b=CXkyIwFj3T4WvQvF2wT8AbOYfnAHbHmybntXnPPUCwto+CWEoCs6Drt18Cy0QVMiHY
         6q7CHr8yxGRq/XH26UiIE3y6P4bEMobTyexeU3YWDFkcibCHf6L5UY2DMLAqsLu3KZxj
         2y9H4IMkxcmRw1breXXTZcCh/VB3pvtMozlYIqOp1/T7C7HsuQTSeZG46SxrnLlaDOnP
         lSIeX1arzoyEIsSBgngbprw5EKk7C8TdhlqvDpOP8mqfRAsEFY5jt2G8JDglWKZjvnKD
         NiW3xDr3YU1tx9X2jQRinB/GWECpLNjvLCZbUQfXyGEQ5NxqSvBP4wkrF+tqldpoNvxo
         Shpg==
X-Gm-Message-State: APjAAAWylIUbscoOEVmTlZLxx7lef7y7MlQDtopUL03iuzK3U5oWuSYP
        LaS3sfOgetkIClKy+B+dSGRSZg==
X-Google-Smtp-Source: APXvYqzvU4pGmB4v+05us4DVHu9HOnpxIVbGuj2R3QjuiDmEGYo3vWbmNiOr3F9sjBCJrVh+8J+2Dw==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr84276850plp.4.1564009893883;
        Wed, 24 Jul 2019 16:11:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id 64sm49030343pfe.128.2019.07.24.16.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:11:33 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:11:28 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] documentation: add tutorial for revision walking
Message-ID: <20190724231128.GD43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190626234915.171658-1-emilyshaffer@google.com>
 <20190701201934.30321-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701201934.30321-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.01 13:19, Emily Shaffer wrote:
> Existing documentation on revision walks seems to be primarily intended
> as a reference for those already familiar with the procedure. This
> tutorial attempts to give an entry-level guide to a couple of bare-bones
> revision walks so that new Git contributors can learn the concepts
> without having to wade through options parsing or special casing.
> 
> The target audience is a Git contributor who is just getting started
> with the concept of revision walking. The goal is to prepare this
> contributor to be able to understand and modify existing commands which
> perform revision walks more easily, although it will also prepare
> contributors to create new commands which perform walks.
> 
> The tutorial covers a basic overview of the structs involved during
> revision walk, setting up a basic commit walk, setting up a basic
> all-object walk, and adding some configuration changes to both walk
> types. It intentionally does not cover how to create new commands or
> search for options from the command line or gitconfigs.
> 
> There is an associated patchset at
> https://github.com/nasamuffin/git/tree/revwalk that contains a reference
> implementation of the code generated by this tutorial.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>

This looks good to me; as a new Git developer I found it informative and
wish it had been present before I took my first look at the rev-walk
code.
