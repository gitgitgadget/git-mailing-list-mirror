Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FA61F453
	for <e@80x24.org>; Mon, 15 Oct 2018 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJPFxF (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 01:53:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50423 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeJPFxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 01:53:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so20298874wmg.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NOgsvEDRdra34v4f99UpXrw7hsnuFKB8ugg0BsPRoLc=;
        b=CYVPBQSfljQPLPgoO081ha/r2zXaOU/OLlNQTZh+dXYwBOcvp+0UWOGwl17XSJjPSI
         Slr0+cAs1SAcRPWOpSNnoOI4re2Y6ZsWRdUxn6pBv0YpEuNLvt3XsDL2diif11p9leOC
         RoBihHLTgD0afd889qH8YN6QI3iRAUAZC+1XYVGdvzyBDTVJkUgrZxAyJQf1ZVEx+Kbs
         dJNqflBRVXBm5G5GadC/cwiDJppMXxbEfFPSEraZPlXvRlCsYk6xlZrOQgt98g+lQGOp
         dAnUlNDKKCyWQzuQIqsk1SQKMFhESQiNJ1TZOHs0jrdZi2LiNxRrpaAQ9rnfJaubICyI
         Ui7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NOgsvEDRdra34v4f99UpXrw7hsnuFKB8ugg0BsPRoLc=;
        b=sVwL5YZk2lWKOTKMs9v3yM5+uMJVsT6sG+OMPsW0hLJUs8HMEo7Zy91sNtl/4mZFSY
         /nEjbGDHK7rBc2+lFfzDGX+mAOUwdU0xrHo9eEvqKMIMvtLgFZ8MwufMZcu2f6Q/cOzf
         lNVQTQ2UXgI70gEVcFjomt7T9fFUf0CIRvHXtfcRHgh+HrzNZe4EVNsQiaNcC0mAMP+e
         B7RyC7/OJL69NCIWIfHJL9Nlw39KHXfZcEB3gZJc7lrW1TagNtaaJLJqj2Z89Cr+BlDA
         uT0d6MErAIZNQfX0Bkw+hd2jqhdyJWFj+W+5Tqpmj0SmVzqnyGmi80SdrCdvuAESXPrB
         IeBg==
X-Gm-Message-State: ABuFfog4UGngL0F9bZMZ2yDnt6nupQHV3gIHRIaIAslCqy/GaUvwFC6I
        UCHxWLX0K8PuiLsH75VWMCbgvDgz
X-Google-Smtp-Source: ACcGV63oJu2kdl5WMbZG2n4riGZNWsfgh06sES8Pai/vZJSyc7NUVy1d/OQjDaRNLos2+d/evLbPDw==
X-Received: by 2002:a1c:3584:: with SMTP id c126-v6mr15213914wma.120.1539641155669;
        Mon, 15 Oct 2018 15:05:55 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id p1-v6sm8049214wrw.12.2018.10.15.15.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:05:54 -0700 (PDT)
Date:   Mon, 15 Oct 2018 23:05:53 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 18/21] stash: convert save to builtin
Message-ID: <20181015220553.GC4883@hank.intra.tgummerer.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
 <fbb4d34f26f6bd8946e3506e9e30a56d509dc1f8.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb4d34f26f6bd8946e3506e9e30a56d509dc1f8.1539553398.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15, Paul-Sebastian Ungureanu wrote:
> The `-m` option is no longer supported as it might not make
> sense to have two ways of passing a message. Even if this is
> a change in behaviour, the documentation remains the same
> because the `-m` parameter was omitted before.

[...]

> +		OPT_STRING('m', "message", &stash_msg, "message",
> +			   N_("stash message")),
> +		OPT_END()

We do seem to support a '-m' option here though.  I'm happy not
supporting it, but the commit message seems to say otherwise.  I can't
remember the discussion her, but either the commit message, or the
option parsing should be updated here.
