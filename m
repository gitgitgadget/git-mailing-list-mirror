Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168C31F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLSr2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:47:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34248 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:47:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so4407534plr.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rlmpusxKOKVJTQ1X8vZAr4yYDDOJT5pEZWSMW6DfG58=;
        b=M3t26WeCWW+U+MoVMGgfKkCrsTZ4fYuMETjnZgw6WXuS6sat+WrEGr9sUi0kbmRteE
         c3utOEUL1LUtv9XgP9rALX0tTYCaihlPP+wqekaFVwKkWZEGqCNQ7CTZaMKUkxtxdbem
         xVg/aUIXxY2CmoZ/4iuYxEnibnXTDohvrWotMVDdzIywGejFlJoLkww5BJmSAXQE5LoE
         R4itH3bIinOvqaAS+d7Vj3VN5WwOZ0QPEtzbo62zCguGnaq+d2tVdpMxlxOvWk5/YeP1
         yNHjvaEcpSmGUbvGEHdnVBOmFwWSLSmBrPL+RSD84yipPtRrVGYpaqcXp0+TKB9EBBdM
         vaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rlmpusxKOKVJTQ1X8vZAr4yYDDOJT5pEZWSMW6DfG58=;
        b=mj+hoZcn0yddYGW3PKW7ShYkqYJtuidF0lZxFSXuu6NFmD7YFZQCBP/X13WS6jw+cL
         h+jhAgiBR3yj4ASFpztQa0OLpc9QEEKmrbQu+JRl8ccYN8vAqUWwwv9g3CuY6e9H/QiX
         H844YiNHAK9kyUuGyw8MulEnZVAm24DiuazVfuHIF2k+XwnFON3VwyoA2ptAZzvHARCz
         O1HJS36Y8FvFoF79GhJmrVoAuIzjKVPWQC1JEM0ijLAHZbWW2Gq1Y+XFOn78NHpZkgkW
         4ZZ5UpRu10Utjaf+OqEo2rOEhrOr1cK3m6bCa+cG4YBkm1JtVDvYpLlesoU5hQtK8eQa
         vQuQ==
X-Gm-Message-State: APjAAAVCoISe+zqfa3pLstrLkpsewYDIWbex7UMfJbOH+jl1aYNyRDsi
        TbxTp4NOk2/r2GQYRkGNm3GMRg==
X-Google-Smtp-Source: APXvYqxs+L19oeKeKSjAr7RDS3/5xQBoLWNBTY+YcN0qwfx0eqjjeunxsjniUrZZVC9sKzCD290psw==
X-Received: by 2002:a17:902:349:: with SMTP id 67mr34228911pld.80.1573584446601;
        Tue, 12 Nov 2019 10:47:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r33sm3338149pjb.5.2019.11.12.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:47:25 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:47:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
Message-ID: <20191112184720.GB38770@google.com>
References: <20191108225035.GA60198@google.com>
 <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 09, 2019 at 01:27:16PM +0900, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Should 'git add -p <newly-added-file>' do the same thing as 'git add -N
> > <newly-added-file && git add -p <newly-added-file>'?
> 
> Probably.  
> 
> I originally wrote "git add -i" with the intention that the
> interactive mode is _the_ primary interface to the machinery, so the
> expected way to work with a new file was "git add -i", tell the
> command to add that <newly-added-file>, and do the "patch" thing
> using the interactive subcommand to do so within the "git add -i"
> session.
> 
> Later people liked (only) the patch part, and "git add -p" (and
> various "--patch" options that invoke "add -p" internally from other
> commands like "checkout", "reset" were added) was born.  I think
> nobody thought things through when they did so.
> 
> If I were designing "git add -p" from scratch and explicitly asked
> not to do the other parts of the "--interactive" feature, I would
> imagine "add -N && add -p" combination is what I would make it
> mimic.
> 
> Patches welcome, but you may want to check with Dscho as there is an
> effort going on to reimplement the entire "add -i" machinery in C.

Ah, this is a compelling point. I imagine the landscape will be fairly
different when that effort is finished.


From the replies, it sounds like it's a favorable change, but it makes
sense to wait on it considering the refactor to use C. Thanks, all.

 - Emily
