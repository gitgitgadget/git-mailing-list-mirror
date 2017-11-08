Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299661F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdKHSBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 13:01:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52846 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdKHSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 13:01:31 -0500
Received: by mail-wm0-f42.google.com with SMTP id t139so12651286wmt.1
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJcHFQf+IxjXQa4oQqbwwe2GzWrW5EnEtQD//ELeyEg=;
        b=lzOBVo/mvuwJ+zDtOkPwaKdHwGpf5dZKWoWahWrAxpv2ONUZT4zvcYbudCVsQQfU3Y
         Km8hUt5TnHDAh6jYLAk9bPR2/vs7vGPLSdkjfiuoBhDIOaFfe3Icqg4VQiwFdQlCii96
         sSwY9tZqmoMrwP7jncpflRFtJFuH7SQAaTAz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJcHFQf+IxjXQa4oQqbwwe2GzWrW5EnEtQD//ELeyEg=;
        b=Z1GHZHs1cvvBL39cRgkmnpIQ0qJxmkd0FvQyMNem1aqnmk4nN+BImMRBtTa3PNcdOU
         /Ueb87j8ShE67HKSfbL0oG+qOgjAN/TPTv+KB7xhPueUAkvaRodgH0XwUrn6O5UmyH5x
         SM3so5L9H9WUXgMIyPVI0NJgFTD8eS9M3YcRFfZkSvHBOuiMQTMyMB6v+mx7hV11O77m
         FiczqITxO4qL1lSUnZegLUwjbLmqlfTwgcPhgvwSRI6sniHBNIPvg0zTQiDrAMb08V/S
         CF05bMJ6YRh6vq5ohocAIQnSNqKHaktS58F6pBeimhx6d/5i6u8MQLf9RcaXQUaGjCaP
         ZOwA==
X-Gm-Message-State: AJaThX5uLYUdVN+iAgbpvniZqEaw/SBz+3ICcQkzGFmJPu/YeWe1GOMf
        G21zRfLJWxicI8IOrONi9mYCSA==
X-Google-Smtp-Source: ABhQp+QpyTFPbvgz1h6CypBYxYemksBKS8zO+FN/7TqupbAD7SXrhKc1m/NzmpgLaDiVuIwqCYka6g==
X-Received: by 10.28.111.206 with SMTP id c75mr1079280wmi.123.1510164089930;
        Wed, 08 Nov 2017 10:01:29 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 143sm9470378wmj.35.2017.11.08.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 10:01:29 -0800 (PST)
Date:   Wed, 8 Nov 2017 18:01:27 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 02/14] clone, fetch-pack, index-pack, transport: partial
 clone
Message-ID: <20171108180127.GG20681@dinwoodie.org>
References: <20171102203129.59417-1-git@jeffhostetler.com>
 <20171102203129.59417-3-git@jeffhostetler.com>
 <20171103133229.1612a60560469af53c380a76@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103133229.1612a60560469af53c380a76@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 03 November 2017 at 01:32 pm -0700, Jonathan Tan wrote:
> On Thu,  2 Nov 2017 20:31:17 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index a0a35e6..31cd5ba 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -222,6 +222,16 @@ static unsigned check_object(struct object *obj)
> >  	if (!(obj->flags & FLAG_CHECKED)) {
> >  		unsigned long size;
> >  		int type = sha1_object_info(obj->oid.hash, &size);
> > +
> > +		if (type <= 0) {
> > +			/*
> > +			 * TODO Use the promisor code to conditionally
> > +			 * try to fetch this object -or- assume it is ok.
> > +			 */
> > +			obj->flags |= FLAG_CHECKED;
> > +			return 0;
> > +		}
> > +
> >  		if (type <= 0)
> >  			die(_("did not receive expected object %s"),
> >  			      oid_to_hex(&obj->oid));
> 
> This causes some repo corruption tests to fail.

Confirmed: I see this patch, or at least f7e0dbc38 ("clone, fetch-pack,
index-pack, transport: partial clone", 2017-11-02), causing t5300.26 to
fail on 64-bit Cygwin.

For the sake of anyone trying to reproduce this, I needed to cherry pick
66d4c7a58 ("fixup! upload-pack: add object filtering for partial clone",
2017-11-08) onto that commit before I was able to get it to compile.

Adam
