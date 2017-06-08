Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390871FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdFHW3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 18:29:54 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35220 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdFHW3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 18:29:53 -0400
Received: by mail-pg0-f51.google.com with SMTP id k71so20279189pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Af6JrCz+EXWVfSGVZhd2PcLO5XNfolNhSWPH+YvSi7Y=;
        b=jPLmmgKBs4rjtJUURkhPNrB5jdYaCBnnlGd9mNElB2g7VxwZFLThiOF5wyqeaFRUa7
         1D3uVJkAyGaob2FUT0Gub7SjvJ5juxw2z4aaFMdASqSZ/7yb19q+/gsmXWt5Gf2SW7is
         mUyHNgYC9HWAmA0TkYaF8zJjrqbVM30RJSJ8tzLwScH6Yd61WOc5LUOVhwE7aXb37RzV
         MXeQv7PdfWXs5Ob8omGaxhQQ3xXTZNFDR5fzH/HNGHWsUVh4FNZdNHFf45ZPHhTObJfO
         BKnPSH9vFFQt1zEL8iHVtGeCck24Q+q7/mDNPrykjVlWDy4+rPST2d7Zb0+p9kRd4QY8
         sZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Af6JrCz+EXWVfSGVZhd2PcLO5XNfolNhSWPH+YvSi7Y=;
        b=Vbjj/for/PE0nzuAIm5I0F1h1i3C3mRBPCB/QDMCRLa7iADIUUczjL1TdRHT1CQvLG
         6iWUu4frjtRmQRuKOikKtFFkFUhUQ2r1BSNZoi0mxDZ1ATgADAVp2PmddhhuZCNA+7Tw
         POGF7FSPHh6mbnrnC5rFv8OViQrlYmSPBYhEspj/wt0zleYBQ9rzPtAd9A+dvvmi+6JI
         O2+jkJsPxT34N1zOAzkEUDprfQk0pJLEyGtWOKU7G7SA3Xhztan+c3XRHZLmeqm+x2Wk
         Y+gy0SHeaO+acELtU7G1UxSASYIUhB3r/U3813gWw6rkUN65eeGTF+rRGb6IMLyWDo26
         Eq4w==
X-Gm-Message-State: AODbwcA9HUwYmQy3daUvWQ/MTf0OMju1w8OvqqnN1PRpjH3o+pSHl8wS
        uoJ4XqagRKzyULuV
X-Received: by 10.98.103.12 with SMTP id b12mr32050365pfc.171.1496960992217;
        Thu, 08 Jun 2017 15:29:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id s10sm12623298pfi.16.2017.06.08.15.29.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 15:29:51 -0700 (PDT)
Date:   Thu, 8 Jun 2017 15:29:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: git stash --include-untracked possible destructive behavior
Message-ID: <20170608222949.GA121539@google.com>
References: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
 <197975d0-7ec3-0ff4-9201-48226fd3b60c@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197975d0-7ec3-0ff4-9201-48226fd3b60c@teichroeb.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Joel Teichroeb wrote:
> It looks like it's an issue with git clean, as that's what stash
> uses internally. You can try your same test, but replace git stash
> with "git clean -df" and it will delete Data. Maybe clean should
> check if there are any ignored files in an untracked directory and
> only remove it if -x is specified?
> 
> Joel

There was someone working on fixing clean, you can look at the patch
series at
https://public-inbox.org/git/20170523100937.8752-1-sxlijin@gmail.com/
though I'm unsure of the series' status.

-- 
Brandon Williams
