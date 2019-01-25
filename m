Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2055C1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAYRxw (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 12:53:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35542 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYRxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 12:53:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so5084906pfi.2
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d6rZJ+T8EsPl4ViW/lWARrn8fbQlZXmMvwEX5Mpttw8=;
        b=BmSolqvMSE04OD4/4XJNBWEMWblVmAVUHia+xjVHHq8c95G0xb4qiy3rbaB+hVV6QM
         9WYNOSKYZkdXiSl47DqQFCMXJ1lpK6+4llM8263POjpPf74qPXepDUBUDY/cAog2X5+i
         zrxDxsl8KUQHssNRs7FNmctqa+h7mNxWzt7NktoVkuC/E/sX8h4nc7j4yDAwLl4jDD0b
         6dBSLMYOtY+7gZw/m6WdDIAURWn/4l3/TicliiWy1PJaxb6x25fd678xoeCY4TYtRvIB
         1AODPyhNbNK/u4TpGExGNiIOxG7KsfY2vCIwWAxfgiI9srdDh4a4o3l0Wma6QGZgYtqz
         Awpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=d6rZJ+T8EsPl4ViW/lWARrn8fbQlZXmMvwEX5Mpttw8=;
        b=O5+7LYTsLWTUALdAHmR6/yssTIydPR4RqzmM4t3mEmVohv9ELVB3N34jQ1L+g4ZzRn
         wevq8lRIxhgsB8WBBfFFyAXzrmSHNRLSK98JT33lDIvF72xsrQV0juZVNR0PJ65pzL9J
         S7V2mYIDpSXpDD252b8+z25iLSH6EB4yimH850RfRs9QvA9f5V9kXw/b3IxHyDC8kgQJ
         rDFuLtclwF9oRmn+O1vJzUZJ74M8ZEx2UaorQCoWP7B8RdqkZoBLsb7SpbzZ+mz6gDR3
         VsrKb8xMcYrRdO0XZWwDuwK4RP0vyrll9pHrlS9mAloizqMXRoHErYgLVm05tg696fIG
         Upog==
X-Gm-Message-State: AJcUukc1sCZH/hbREmZdoWDeeeFz1/kq16F942Mfu/jdqYCQQIXD6Col
        BA8dhZoz75ZecY80GUcdVEC+3w==
X-Google-Smtp-Source: ALg8bN7LcoA+MTIT9o2Xtxc17blD1tpb6xyCeeaRD4qA8+w9q9ZfbIzT1MDtn7K0xEVZPNnFiEwcNQ==
X-Received: by 2002:a63:f615:: with SMTP id m21mr11001097pgh.428.1548438830632;
        Fri, 25 Jan 2019 09:53:50 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id l64sm34132560pge.73.2019.01.25.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 09:53:49 -0800 (PST)
Date:   Fri, 25 Jan 2019 09:53:42 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] trace2: Documentation/technical/api-trace2.txt
Message-ID: <20190125175342.GA72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.git.gitgitgadget@gmail.com>
 <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
 <20190125131929.GC6702@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125131929.GC6702@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.25 14:19, SZEDER Gábor wrote:
> On Tue, Jan 22, 2019 at 01:22:12PM -0800, Jeff Hostetler via GitGitGadget wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> > 
> > Created design document for Trace2 feature.
> > 
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > ---
> >  Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
> >  1 file changed, 1158 insertions(+)
> >  create mode 100644 Documentation/technical/api-trace2.txt
> > 
> > diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> > new file mode 100644
> > index 0000000000..501fd770f2
> > --- /dev/null
> > +++ b/Documentation/technical/api-trace2.txt
> > @@ -0,0 +1,1158 @@
> > +Trace2 API
> > +==========
> > +
> > +The Trace2 API can be used to print debug, performance, and telemetry
> > +information to stderr or a file.  The Trace2 feature is inactive unless
> > +explicitly enabled by setting one or more of the `GIT_TR2`, `GIT_TR2_PERF`,
> > +or `GIT_TR2_EVENT` environment variables.
> > +
> > +The Trace2 API is intended to replace the existing (Trace1)
> > +printf-style tracing provided by the existing `GIT_TRACE` and
> > +`GIT_TRACE_PERFORMANCE` facilities.  During initial implementation,
> > +Trace2 and Trace1 may operate in parallel.
> 
> Speaking of replacing Trace1, I couldn't find (or managed to overlook)
> the Trace2 equivalent of the good old "plain"
> 
>   trace_printf("Uh-oh!");
> 
> which is my go-to tool when chasing elusive heisenbugs and attempting
> to understand racy situations and flaky tests.

trace2_printf() is declared in trace2.h (line 387) and defined in
trace2.c (line 801).
