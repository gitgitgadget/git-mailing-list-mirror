Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6A51F859
	for <e@80x24.org>; Fri, 19 Aug 2016 19:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbcHSTat (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 15:30:49 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34098 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbcHSTas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 15:30:48 -0400
Received: by mail-pa0-f50.google.com with SMTP id fi15so18732319pac.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MHIQnslngtQEjdbeWZ3avn94VTBT36+HfooX8hc66s=;
        b=FgmMyDq9lmDwp8EW5RM4zOzrVTVdcmP2rU6bHoKlFo9iSIAdzt3PN1N5jjfDHM+LAx
         gu9P0q4x/xlx//2b4FWQJRXYlbNl7GTS9XZ3WbLKNjTIiQBjmWB1NdbENqKNA4OvUnMV
         lBTq2OWyOxoLBbmj81toMzUxMSOAPD61flbnAxQdKl5WJvPxE0oSkIKv0w9OhwlLKIgg
         745mkSo9aR2C4Tx6GFbkflDJogNm99VFceBkZwTyITcimnq46C6b1oWX4epyo05EWFLS
         L6pdA404OXRHs2IR+J17VbW/TUVmkVwyynLUniIW78SJTiI8ENaS1/0bBetoXgNKOtXU
         IUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MHIQnslngtQEjdbeWZ3avn94VTBT36+HfooX8hc66s=;
        b=Z6giLBfA2lxW+acxgXkAOzQkNyHG619D/ytoTl0m98vv2meQgUsiKZKPJ4ndGhrvdc
         TV+rGEPpMVHomuA8C0hU8jHk+b2C0iwsiahKrUkdT6gGvaS//PJ2C9R8AecncYvTiY9K
         9IcSI9d0yCci6mQN9WdVvOhomOMGhuu+mMkaheB8XheJfu/W6G2jUyzNTi+f+JR9IAwq
         cCKoEaAvFbSsL2SwXqFZ9ojg51HIGZ175BKQwJqq6S92Sxq1oAfd1r1UuHVNz4B2ChTA
         oAwjfHccxqr7En2cy7kXeQt9/AaoiDlM+Zi+CSEa/QJe1XgEI3Sd2gQjlKBwJ+9THPuw
         pDiA==
X-Gm-Message-State: AEkoout3ZkFcNCT6Pz9twmu+gnUWWXvRQW2gW/GhoRnH5NjXDDEbXwRFaiRcofvisCFNtA==
X-Received: by 10.66.233.38 with SMTP id tt6mr16470147pac.99.1471635047655;
        Fri, 19 Aug 2016 12:30:47 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id g21sm8387006pfj.88.2016.08.19.12.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 12:30:47 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
X-Google-Original-From: Brian Henderson <bhenderson@yp.com>
Date:   Fri, 19 Aug 2016 12:30:45 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
        peff@peff.net, e@80x24.org
Subject: Re: [PATCH v3 1/3] diff-highlight: add some tests.
Message-ID: <20160819193045.GA9262@tci.corp.yp.com>
References: <20160819170812.1676-1-henderson.bj@gmail.com>
 <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
 <20160819170812.1676-2-henderson.bj@gmail.com>
 <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 11:10:55AM -0700, Junio C Hamano wrote:
> 
> > +# vim: set noet
> 
> We tend to avoid cluttering the source with editor specific insns
> like this.

oops.

Anyone have any suggestions for project level vim settings?
