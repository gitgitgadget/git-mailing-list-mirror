Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244DD1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbcIBXwD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:52:03 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35422 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbcIBXwD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:52:03 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so6078758pad.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SwMzLi+FIFv7Hk3rzxLyPWQCX4LhozFW5gItfOjQFgE=;
        b=XqGNx/sUnAOFrIMMrPaNfUyyAhDMSPxDegz/hsOTqiJZsdjoLf5UYBsNHlsbzSK7Kw
         v0Mm0CGZV+tZtH96KMkNYipZS+zTNPFb9356B4Jx2N7wbc2A+o5TTjD0n0h9biBphjLh
         uPd3i5wAnWbAdzbWl+VUrc1DXDQGYyKctEx7PaDeA29760OagWqj63j2H5m8xEkhXPJa
         cG/3O23hFpoopY333tAin1ekdNPtTqj8ujjx/mA/iher3TZ+0lciNMhUq+nK5mRCA4gB
         e2JgeDyLClaI+pSNjDVmtOreNcAZshqFaGoPYI2TLfyz+rkc57K+42T/po3PIQITx2v4
         8vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SwMzLi+FIFv7Hk3rzxLyPWQCX4LhozFW5gItfOjQFgE=;
        b=KsiLdGDOcG+PqNPqJUdOUckB6ZcwD35FLyOcm5RsdpQ0SuAnJWdUYk1JXyYXal9Lhb
         h+fCudCE+qt6gJW8sBXdnUySpwC9Id+uUO4N1nJSCYYAeIAcct7SzQSnP16ebUqJ+n9Q
         PlrVN/oOuZQZJIcck7p/sm28fHQueE2fuJzuwUoaePDNvUDnM20wX2HQzt6oEQpW8tVU
         Kd6qPJrALrTLOETvTcVFIW/bGmxLmEelDnfURuDbSdAEbM7xW9fdg3xpQUxRqoSxMdI8
         kJNpg1855+oSoQBS2XzZH2TBV2SqcOQ0dm0E8l5VCSXnLyra5I8sV0kI4IolIHstIqyU
         qrUQ==
X-Gm-Message-State: AE9vXwPcN8rhTZ3uk6mqHoVtJrLlU6h3sBI11uGd9xjNI8rkEUTi5eGfH3z0bp+aUcCLeQ==
X-Received: by 10.66.76.9 with SMTP id g9mr40305832paw.51.1472860308924;
        Fri, 02 Sep 2016 16:51:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:34:ec2f:e9e8:7f87])
        by smtp.gmail.com with ESMTPSA id d72sm17261904pfj.15.2016.09.02.16.51.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 16:51:47 -0700 (PDT)
Date:   Fri, 2 Sep 2016 16:51:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160902235145.GI14758@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
 <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Sep 02, 2016 at 03:06:12PM -0700, Jonathan Tan wrote:

>                                  But combining hideRefs with
> allowTipSHA1InWant could trigger this case.

Yes.

[...]
> I'd be more interested in the pain of this transition if there was a
> concrete use case for "hide literally all refs, but still allow
> fetches". Is that a thing that people do?

Sure, it is a thing that people do.  For example I've seen replication
systems that learn what SHA-1s to fetch out-of-band and then use this
approach to avoid the overhead of a long ref advertisement.

However, that is not my motivation.  My motivation is being able to
extend the protocol in the future.  The capabilities line has been
important for that historically.

Do you have any objection to the server gaining support for this
guarded by a configuration option?  Then when the time comes to
consider flipping the default we can use real-world statistics about
what git client versions people use to make an informed decision.

Thanks,
Jonathan
