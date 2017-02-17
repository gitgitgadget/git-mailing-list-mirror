Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98503201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964852AbdBQXMK (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:12:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34750 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964806AbdBQXMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:12:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so4883874wmi.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsgJ7VGyvDUEyOAa+DRXhRxbTLdQ4m6CQb++uMO5/P0=;
        b=TnDbe4+FE3+h6PHhVS1fTnHyOAZTpqVuIquuQRwy8yE3UaD8erloHHvGvm6ei2ad1B
         Bgs4giDmUSKbQrzfGICA25NQR+6jK/wik+7LQoTALEPuffbLD0BCX4U6oZ5hvAY/vG6p
         n3TeR56qe1W/kqTOsO0KyKku76IhJncCHcg4teSFFSE7j2F2PyZ7tfblbziQr+QiRhty
         h7qCv9bewJ7hjqS/RDSjHyDXXM5kgYTf9VqfGGjBR3m0UwM2uZoab4y24Xq44XtLwLka
         fS/QXgAgwT92Z2eTMLoid08/ojDbBacU+1stOJ51DzboyTTL/XWlC22Tlh4FxUuR5uQL
         km9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsgJ7VGyvDUEyOAa+DRXhRxbTLdQ4m6CQb++uMO5/P0=;
        b=cRfc9OGOKZ5QbL6R1ITBnYUgkRDI2llYx6UhE75eRqtYBHTrEZj2vVc0PDgN3RRzml
         xYVH40k/BZqR6HlqriVQrAxeSEQLKafS3QWdNUT6HJzd5eSR/48K1/ILUCjkQaU8mOaA
         XxFRRJUPLCkYd3zvprAsuGqmYF8pPO8XAgv//f+B1b+SoFWb9XvZqvYFXugHL/Q6jqDU
         FRYNHMGJCJKca7zM9fvF8xkN0VqyqfKpGDmpyv2NSD6YNX+wK+j40T7fSB86pvz0Nbka
         zpNDj25KPs8kkuelneboybP5nw8+qGPxT5Wbxjww7l2I8twwKrdA2BoQtRQXUQH+Pe8p
         g/5w==
X-Gm-Message-State: AMke39mTaEruvjmzB45AXpv+46RjExUaLxo3TWc9ZBfE7ckGjCmRpBDMvxQyeoUtUxB2TQ==
X-Received: by 10.28.139.74 with SMTP id n71mr3736570wmd.139.1487373128217;
        Fri, 17 Feb 2017 15:12:08 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g71sm3385123wmc.9.2017.02.17.15.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 15:12:07 -0800 (PST)
Date:   Fri, 17 Feb 2017 23:12:46 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/6] stash: support pathspec argument
Message-ID: <20170217231246.GI652@hank>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <xmqqfujcpgky.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfujcpgky.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/17, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> [some people may see this message twice, as I forgot to check if the
> copy I received had "Some A . Body" not enclosed in dq; blindly
> doing "Reply-All" ended up listing an invalid address on my Cc: line
> and dropped by vger. apologies]
> 
> > diff --git a/git-stash.sh b/git-stash.sh
> > index a184b1e274..1446fbe2e8 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -67,51 +67,20 @@ create_stash () {
> >  		case "$1" in
> >  		-m|--message)
> >  			shift
> > -			test -z ${1+x} && usage
> > -			stash_msg="$1"
> > -			new_style=t
> > +			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
> >  			;;
> 
> Did you mean ${1?"BUG: ..."} here and also "-u" below?

Yeah, shell scripts are still confusing me sometimes.  Thanks for
catching.  Would you mind fixing this up while queuing or do you want
me to resend?

> >  		-u|--include-untracked)
> >  			shift
> > -			test -z ${1+x} && usage
> > -			untracked="$1"
> > -			new_style=t
> > +			untracked=${1-"BUG: create_stash () -u requires an argument"}
> >  			;;
> 
> Other than that the whole series looked sensible to me.
> 
> Thanks, will replace but that may not happen today.

Thanks!
