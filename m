Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02ACE1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfJIBkr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:40:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39590 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbfJIBkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:40:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so444155wml.4
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRquUH9KoKn7xaNK+QV+fIssDhbFOKKwj0M5cUPXIec=;
        b=ZFZLy5xYYdV5E2tJaPFEjy1fBlEagXBfYlCSxTJJk+FcXW/ooR3e07qdFfdo+Itibd
         +6mmIVBTGXm6SnoNTF5ffYiyHOXM6DZIYySpp2sc+gay5FM8evIwZv6+sfVaCsp7UL2I
         XSoAn2bREy4RNZ16kvRZbBDW76hdrQRCVTqvb/gESy7hzM8bUkteYfU+L37RFP9kpslR
         ++KWFvoTSBBrSNivfYPkcX5ydOgFkQpbI6uY0zME0sBTDCpcJrOejwLkrB0f0+e93XuC
         QTno7XX9dxx/kb/1tmYaPo41PWqcfAhyJLnY5Tzj6Rl71RW71usebhXNE6d0R5HJvY+q
         sWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRquUH9KoKn7xaNK+QV+fIssDhbFOKKwj0M5cUPXIec=;
        b=GGDni+NTs5F9wA+QsE63BwEU9GQTbB5pv2HhzvAHNcg7eduli1aQPO8QxKuS27fgxC
         KMHNfGB08Q9eMGtldoAGkDRl/A78f1Qlk2WcroiMDUx8iB7fZCdyIYDG/VcxIXoSPGm7
         BcypIRlMSsnhFI8mZcFK/ifTuKSDu8Dy+jn42qr0GFPGI3omxZNkK75YlODMw5cqpNYl
         RkufPbDpGcf/2OrSYZxjJUOxAHm0DUNRqGMa0qzmDXvt9Lbz4ihuI/cXGok7dhY4UPej
         uCHJGr14XYvnJR0wcoRY+/LWUEmvRCrY8kgC2mz4uVR7cm3iWr21Cri2KZJzOPkTdSqc
         Gbqw==
X-Gm-Message-State: APjAAAXprrK4JqTLQeqQpVc/aS3r0mGs/5oFKlF4Kd0rCCAzWktMY3YH
        bDkzq1RoSBkC+AGW8A0gW4EhRqcC
X-Google-Smtp-Source: APXvYqxKxALEfJlKHCfY1oMAHhnSQCESp+Yb4Wd5EG3usg/CDftaVwsj3+meJgaDAPOJAiz4HT9Jfg==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr489397wmj.91.1570585244877;
        Tue, 08 Oct 2019 18:40:44 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id 207sm823988wme.17.2019.10.08.18.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 18:40:44 -0700 (PDT)
Date:   Wed, 9 Oct 2019 03:40:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191009014039.GA10802@szeder.dev>
References: <20191008074935.10972-1-toon@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008074935.10972-1-toon@iotcl.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 09:49:35AM +0200, Toon Claes wrote:
> Add support to provide the Co-author when committing. For each
> co-author provided with --coauthor=<coauthor>, a line is added at the
> bottom of the commit message, like this:
> 
>     Co-authored-by: <coauthor>
> 
> It's a common practice use when pairing up with other people and both
> authors want to in the commit message.

I wonder how we are supposed to use this trailer in the Git project,
in particular in combination with Signed-off-by.  Should all
(co)authors sign off as well?  Or will Co-authored-by imply
Signed-off-by?

