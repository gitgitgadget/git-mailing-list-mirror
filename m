Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D70202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdIVUmQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:42:16 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:51570 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbdIVUmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:42:15 -0400
Received: by mail-pg0-f48.google.com with SMTP id k193so1166902pgc.8
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOD0ZEW9EPerKN+IDiWLREeYJZr2I0Y5RJ0fo/2+Ins=;
        b=B77zIVQoEygUzaFzDpTF7kPnRhpRSb7cdZqKxOtQk3X51sRf3jFH2Nz65ECP+V243H
         B7vWNffxWLzswM3QwUJldFeJwKheCtx7Y9u+dweS+jGMgSbMWKNbJ1RonpHZS8O8mSQn
         YTr66sRGFCRH9wV/RkC2wwUhNPI4CyopXaogj5BMoskm4+Wu10Bxab3wHu19lLo7eSpu
         vQXuVCqDA+iAdoVzWW0miAf4/C4HEUaxZWpTdIPbLivFw8rHPQ29ZRMx0UDVB4r+emhJ
         YX3bAZFtP1Tu+GuH8UWfWpBKO/oHKXAoBPghsxjYK3UGVr1iEQbI5I97DFnQbv4Uer+7
         WAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOD0ZEW9EPerKN+IDiWLREeYJZr2I0Y5RJ0fo/2+Ins=;
        b=igCpnXaYnmOZWPvVLZipuk250iifqj1OgsWf556wKInh0X7+5FDBvb9nQClg5B/Jh2
         wMIGvFtwwCm0YdHNTZtGZ5pXrDTCm2ahsAGd6GqzxOKgsLPpy+jSy2t4dQ63ivoNoxrQ
         hb6tzDFzlNYbjEJ9I3HF87VHNtStPwmSF3cXC7jI8zwdEqeK3gaBqqxLWZknTM5R7F4L
         RK2blVuCJYgB05vBxEfOJ8sVNBXmMas9dF+AElu+7PKiEq+ImeQrBBzfBktj7VWcb1dt
         5KTqwYF6ZrhxSqHoiP9FrggtaeBA4nzXrbqfDukhFd0bdO8RxcgMPjZQpFAnOfNmtfgf
         PpNQ==
X-Gm-Message-State: AHPjjUg9VNZgJ3EB7HxqBrgWfnpFVmrENdEpSBrje+1jjM2ehRFaZFIf
        BgAGqJzpyi0atRgKqmuThLMfmg==
X-Google-Smtp-Source: AOwi7QDkrR3/oppw2+I5mA9Oahzt1Ed1SBkUQ8joHexqcXbE/nORf2T0tqQrXw9orG8PC3wMp8QsXA==
X-Received: by 10.84.248.144 with SMTP id q16mr291941pll.345.1506112934745;
        Fri, 22 Sep 2017 13:42:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id u186sm716871pgb.35.2017.09.22.13.42.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 13:42:13 -0700 (PDT)
Date:   Fri, 22 Sep 2017 13:42:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, jeffhost@microsoft.com
Subject: Re: [PATCH 02/13] oidset2: create oidset subclass with object length
 and pathname
Message-ID: <20170922204211.GA24036@google.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
 <20170922202632.53714-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922202632.53714-3-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/22, Jeff Hostetler wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create subclass of oidset where each entry has a
> field to store the length of the object's content
> and an optional pathname.
> 
> This will be used in a future commit to build a
> manifest of omitted objects in a partial/narrow
> clone/fetch.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

I think it may be better to create an 'oidmap' instead of an
'oidset+some specific other bits' that way, in the future, we have a
generalized data structure which we can use to provide a mapping
between oids and some arbitrary data.

-- 
Brandon Williams
