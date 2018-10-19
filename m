Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800CB1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 00:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeJSIhE (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 04:37:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42507 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSIhE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 04:37:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so14956078pgq.9
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cmmSb9bwA2DooqTXUBi6RKMGVSQWnNHxCjltyuET3M=;
        b=sJqdNPFuT7fJBBSg13oN3oOSuA3/t9StCOaxXlkaIiP8EoxO2uFPIJeo/LDagz3IhQ
         SGJNLKLSoUfAtyMSg3UBT2wqWqWs6eJB86/FrHtoOivLXGHtr6vrF3EGFZ8ycbys9wy6
         EC0k6r65RevqtqO5MWwIU+Oe5yY5sFPPIdX0Zj1mORPQbn+Rh21b6hNKTkSvgk6drKte
         7kmlXESfqkSoNSDzY7JXgVP2vJvufn1JOo8k7NqIP3pQgLunU/DO5BofP2P1mmVIq2D4
         mVDe+uyYbGyr0p8wGkhDj3HjB1D5hzlqzAsAnNe22l/ZkfZeQ5T/Q0DA5oJ/U/q++BiL
         OmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cmmSb9bwA2DooqTXUBi6RKMGVSQWnNHxCjltyuET3M=;
        b=a1THCwqWnteFfshwbBZtKQ77Tnpfu2sDjxcmy+nqiiOBuC3nRWG9Mlz7L0bT1COvOG
         LOMVvu2lKYrE0+atIwfI6WvmYamr/RDGFimKmBxyqVut+6iMUDvRNVktaVYThLR57JmX
         1Ul8SzdtKIss8fdbAGX3zD8OJc4wztc5YOmloEIcI+k4uWq2p2oKPbgvOvzS4FJYoHTb
         UvvJkRiza9TcB5LzzxWEPtWC1aME3jn4cwOCWqyGaTnPcsk6TNacux6F1FYc91/5haBL
         3tlT8zdOvCmwq2ZWLJ4so+46KBDfY6cFn0EP1pcNLrBUz34LvoNSDVWCE28WicVkiTYW
         fGhA==
X-Gm-Message-State: ABuFfojcULuuF/7sVhdZLVVjKTHY71151HJ06WXe8OOKKTzJ8r5Odozt
        0JwOacbo1uKPgWclpqOABv8=
X-Google-Smtp-Source: ACcGV60WuSplczbJ6828Agg25S5QGvp4oe/d13uldCEknoXLpnF1do8CbxlnJarYm7fK0ysj4zh21w==
X-Received: by 2002:a62:c68e:: with SMTP id x14-v6mr24681465pfk.151.1539909208252;
        Thu, 18 Oct 2018 17:33:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z22-v6sm22802588pgv.24.2018.10.18.17.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:33:27 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:33:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, sbeller@google.com,
        git@vger.kernel.org, peff@peff.net, Ben.Peart@microsoft.com,
        pclouds@gmail.com, mh@glandium.org, larsxschneider@gmail.com,
        e@80x24.org, chriscool@tuxfamily.org, jeffhost@microsoft.com,
        sunshine@sunshineco.com, dev+git@drbeat.li
Subject: Re: [PATCH v4 9/9] Documentation/config: add
 odb.<name>.promisorRemote
Message-ID: <20181019003325.GA30421@aiede.svl.corp.google.com>
References: <20181016174304.GA221682@aiede.svl.corp.google.com>
 <20181016222243.58620-1-jonathantanmy@google.com>
 <xmqqwoqe4xev.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwoqe4xev.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>> Jonathan Nieder wrote:

>>> 	[object]
>>> 		missingObjectRemote = local-cache-remote
>>> 		missingObjectRemote = origin
>>
>> In the presence of missingObjectRemote, old versions of Git, when lazily
>> fetching, would only know to try the extensions.partialClone remote. But
>> this is safe because existing data wouldn't be clobbered (since we're
>> not using ideas like adding meaning to the contents of the .promisor
>> file). Also, other things like fsck and gc still work.
>
> It is a good idea to implicitly include the promisor-remote to the
> set of secondary places to consult to help existing versions of Git,
> but once the repository starts fetching incomplete subgraphs and
> adding new object.missingobjectremote [*1*], these versions of Git
> will stop working correctly, so I am not sure if it is all that
> useful approach for compatibility in practice.

Can you spell this out for me more?  Do you mean that a remote from
this list might make a promise that the original partialClone remote
can't keep?

If we're careful to only page in objects that were promised by the
original partialClone remote, then a promise "I promise to supply you
on demand with any object directly or indirectly reachable from any
object you have fetched from me" from the partialClone remote should
be enough.

> [Footnote]
>
> *1* That name with two "object" in it sounds horrible.

Sorry about that.  Another name used while discussing this was
objectAccess.promisorRemote.  As long as the idea is clear (that this
means "remotes to use when attempting to obtain an object that is not
already available locally"), I am not attached to any particular name.

Thanks,
Jonathan
