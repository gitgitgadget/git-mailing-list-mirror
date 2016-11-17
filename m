Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C67B1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750714AbcKQW3c (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:29:32 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35359 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbcKQW3a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:29:30 -0500
Received: by mail-pf0-f170.google.com with SMTP id i88so50811216pfk.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 14:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5pX+mvZ09S1QUvJTzdOBh8fMm9N9XfNFxcrrMVz51aY=;
        b=py7yiUaSCMY497CuV0XMMLtxP3dCRUtfUrwIBErV+f5xOwwAzhSzJQt2/qU/QiZtV8
         6IffDBc5o0zqmpTec9xIhbBk/N0Z5sR4cIKJoE7tWx5Qw4/3ybA1HBpq+a887e6jS6uW
         58/soPlLaifaAbZ4yGUcrC13rh8ezHKBh9kq8X1ah+7a0OMlO+g09sEjXBPV55wSxo5L
         rwA/kBDVRWdq/rH/coh4arPyIIn3NgDI61rabvSzMoOs5vKfBcWn4RfxhGa/ufUL8r57
         NBMYlBJSmJGvY/R/iey0tPw0KEhk0TSuJRr8FWiIlXeAhQVT/ntx+0UyKbt6zOj9HOEH
         R8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5pX+mvZ09S1QUvJTzdOBh8fMm9N9XfNFxcrrMVz51aY=;
        b=GVIJQTN0LAoqa5sYSS3o2fYqyHp9pX9Nmu4ydyQ887HboIPSZ+7fTRdXVdWC1HkRbC
         MWLs5jGd7bYi6i7R1J1tdxbkKO8IvZUk4G8PlqIoePo3HOlKxHkSznCmSvlksJ+M0ygQ
         Uk7xJAzIIknoZspwtHWUCvQxA6dIKDw350qhYXOMj1bGO2Iw+oGlZAY6t9JKSo/feXAf
         K6B2bb3D7FjySlm7yChDEY5j0/rzNgaetXWcrYuBzg578TpL7JyPsOEasZd9ZeJgDVHs
         AC22ZTP2LPWcjIwDE/77j1/8eKgaiA47kvIxCw1nQcbXd6Mjt1xtNbXwBen775fAaS2W
         ZYWg==
X-Gm-Message-State: ABUngvcxA8xjqRQ+axlEcLms6GKJJiAh+pW5s/+B/+gtK/p4ZuKxrJLLhg7UNCvzrORDlAbD
X-Received: by 10.98.88.4 with SMTP id m4mr7389722pfb.81.1479421769487;
        Thu, 17 Nov 2016 14:29:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:718b:9d6c:8235:ef51])
        by smtp.gmail.com with ESMTPSA id d197sm7496038pfd.38.2016.11.17.14.29.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 14:29:28 -0800 (PST)
Date:   Thu, 17 Nov 2016 14:29:26 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
Message-ID: <20161117222926.GN66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com>
 <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17, Stefan Beller wrote:
> Well first you get the warning:
> 
>     "cannot remove submodule '%s' because it (or one of "
>     "its nested submodules) uses a .git directory"),
> 
> and in case a d/f/ conflict arises in a later stage (e.g. when the submodule
> is replaced by a file or symlink), you get another related error with
> less helpful description how to debug it.

Maybe a warning isn't the right thing?  Shouldn't the checkout fail if
there are any issues?  This would force the user to stash/commit their
changes and then retry.

> >  All other submodules will actually be removed? Couldn't
> > you end up in an undesirable state with a checkout effecting one
> > submodule but not another?
> 
> Yes you could. Maybe it's time to add
> "git submodule intern-git-dir", which can be given as a helpful hint
> or even run here first.

That would be a good idea, does that functionality already exist in one
form or another?  I'm assuming it must since git update does just that
when cloning a submodule.

-- 
Brandon Williams
