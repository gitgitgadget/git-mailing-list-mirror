Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFC41F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 19:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeKOF4Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 00:56:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeKOF4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 00:56:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so8434811pff.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9aG3c5KwtxLEQm4KoyeKjCplvoakkmHEJuvs3fyRROk=;
        b=r/F/5yjSuaJeF7NsPEpjOnIgeSiEMGxzpBm5l0FuD3XI6WGyWcMmOeXVdPy632GM4M
         hdIR36sxVCpJvtyDo9KHR6uS7itoI+v+40BGxvvizfO7a0xa1cdLZ5ZgIYoz8O2fOBqh
         JnHkZKtNm8NmkdDVCacRl2uaw1m+ZHVBS1SngUBsH8nqWMRmKiktxTG8lX2Rusuu909M
         t+E+P3B1zpe3/MjljGyquxOXLhzO4ldnC+x/wLv2GfiK8XSohw772ciwjWyZRALdNrni
         9bZwJrGMZyir80XtGDN63ls6Q7qdl1CtFmSdfoimm35y3yChEsbbn/nVIsIHQ6nMWlRR
         V77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9aG3c5KwtxLEQm4KoyeKjCplvoakkmHEJuvs3fyRROk=;
        b=IlyPhmKYe8YJOBTDHZFBwTOgqu8IZwlrArQA6jor3UTu1LSYx8T2uPLlUdVPcfD50p
         MqKh10YJ+Kc+xsLsWE5qjcltZWH6571GHkViIsJWq8esp+LJuja2k6M6+fn42FGcbywH
         YypOUVXbJhWdOYUW3N//iiMztlC8LoL2vmSdaJLoaDz/1IqWuAvlXWulR+UVe7igi5GT
         5hY5EJ8iE283GlZBqk57/bbFlCIf8LqZ7KKVB9E+RNFxUJLL1glbfd3mUacDEUS7BFky
         Jan10vXdRH1Zrn9mepzbbCVG9TkryFOp1hMQUa2jopoSioWjra+wCR+N2cdQhyZhpHG1
         YtPA==
X-Gm-Message-State: AGRZ1gJhmCmKUZ5FoTH7y547cFybkqf2m9RqJMGHQNtj7o+Y6evhCIUU
        uoaq9TjnN6Xmy+3r8XnUqTlat1FX/guehg==
X-Google-Smtp-Source: AJdET5d+wK9zydslK7B7ejrvscCiLM+a3gLkYPZzDJHiymutvO5os80rJ0q/3Bn+aWnhj2Zwhsxcbw==
X-Received: by 2002:a63:a612:: with SMTP id t18-v6mr2978178pge.338.1542225109343;
        Wed, 14 Nov 2018 11:51:49 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 134sm24104696pgb.78.2018.11.14.11.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:51:48 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:51:42 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/1] Advertise multiple supported proto versions
Message-ID: <20181114195142.GI126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com, szeder.dev@gmail.com
References: <cover.1542059029.git.steadmon@google.com>
 <cover.1542162201.git.steadmon@google.com>
 <xmqqin10m01g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin10m01g.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.14 19:22, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Fix several bugs identified in v3, clarify commit message, and clean up
> > extern keyword in protocol.h.
> 
> It is good to descirbe the change relative to v3 here, which would
> help those who are interested and reviewed v3.
> 
> To help those who missed the boat and v4 is their first encounter
> with this series, having the description relative to v3 alone and
> nothing else is not very friendly, though.

Ack. Will keep this in mind for future patches.

> >     + diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> >     + --- a/builtin/upload-archive.c
> >     + +++ b/builtin/upload-archive.c
> >     +@@
> >     + #include "builtin.h"
> >     + #include "archive.h"
> >     + #include "pkt-line.h"
> >     ++#include "protocol.h"
> >     + #include "sideband.h"
> >     + #include "run-command.h"
> >     + #include "argv-array.h"
> >     +@@
> >     + 	if (argc == 2 && !strcmp(argv[1], "-h"))
> >     + 		usage(upload_archive_usage);
> >     + 
> >     ++	register_allowed_protocol_version(protocol_v0);
> >     ++
> >     + 	/*
> >     + 	 * Set up sideband subprocess.
> >     + 	 *
> 
> This one unfortunately seems to interact rather badly with your
> js/remote-archive-v2 topic which is already in 'next', when this
> topic is merged to 'pu', and my attempt to mechanically resolve
> conflicts breaks t5000.

Hmm, should we drop js/remote-archive-v2 then? Any solution that
unblocks js/remote-archive-v2 will almost certainly depend on this
patch.
