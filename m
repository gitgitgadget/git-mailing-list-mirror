Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE41D20958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbdCTSu4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:50:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34413 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbdCTSuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:50:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so21521967pgg.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WW91EryVJ/q4CNAY8N8CYErxCiF8vOU52lgxKNtrf1A=;
        b=kvEIqDO4/Uz2fVW4GYrKUMF+8UTB9MXPlW3QOQWC7WoDHqh2T89b8y65iO6IEGZWLL
         y3Otsaeb95idemb8xZmJtffqvOZCTGyn9n/ll8tvRTEO2yZ2FuCXzVQTWLhVzgwnKMFg
         NUH5xPNR+TRussebeMks9hFJ2MSAoVoKjj8fbyIsZjHW3PpYND6aQ7wkdcctoB/xcQtQ
         4gTibhAX5xr7MQOzOP2macil1LzQhKQVtF/a5aZpmm5faAmTX/f8gslGof2Cx+hfug99
         Gmg86LaSaVZ+y97TeuGPvAwyu/WVQ7OTlLVgpZhR3LQk/2O2zuY2ESqrfoO2Wxt6ENTk
         4I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WW91EryVJ/q4CNAY8N8CYErxCiF8vOU52lgxKNtrf1A=;
        b=G4W8Oq5clR71j8sHpz5WYF+kUqaf29KLvDlUOIhtfKSXzspcEcaOiCzwFjCIR440DR
         ShdzMvQ13HktCZ+GetqzkZ6Ng1d4ySS+/twOOqjwmf9Z5vFHwIrrEizfJkI+QcvrCrjA
         +LBm34AzRQEiuoBgQDgL0nUcDOo+VlqY2g12xo7QolLsP7prxXeVeeulbX+65NrasM6G
         mF/Rjr6eWfx/VvuqwzovRlIVr82451xjnevOyQSlbAqNxXJfURhzmFJ9PZvXerjlpeiu
         AyY/XbrfdMLlzpeEikS4YGuEyFz2U0GykOlrtSmJu7v39Y2FkXXltk2g42U9e2jSa65R
         KuVA==
X-Gm-Message-State: AFeK/H3wfOFKddo2qrhUtpnOdb32zcAjZvcaMGZRZQqLTqA0+2gXO+FvREsGQoy2qDbRrw==
X-Received: by 10.84.140.107 with SMTP id 98mr10324275pls.87.1490035841269;
        Mon, 20 Mar 2017 11:50:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1478:9e4b:5dd1:a569])
        by smtp.gmail.com with ESMTPSA id r12sm34958617pgn.26.2017.03.20.11.50.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 11:50:40 -0700 (PDT)
Date:   Mon, 20 Mar 2017 11:50:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees
 on the file system
Message-ID: <20170320185038.GU26789@aiede.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com>
 <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:

>> While it may be true that you can have bare worktrees; I would question
>> why anyone wants to do this, as the only thing it provides is an
>> additional HEAD (plus its reflog).
>
> A more plausible situation is you start with a bare one as the
> primary and used to make local clones to do your work in the world
> before "git worktree".  It would be a natural extension to your
> workflow to instead create worktrees of of that bare one as the
> primary worktree with secondaries with working trees.

For what it's worth, this conversation makes me think it was a mistake
to call this construct a worktree.

It's fine for the command to have one name and the documentation to
use a longer, clearer name to explain it.  What should that longer,
clearer name be?

Thanks,
Jonathan
