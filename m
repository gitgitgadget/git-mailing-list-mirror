Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BB720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLKWXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:23:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so3902294wmf.5
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06LWV7/hefCm//JXISG+B0Eva7xSqenjgz6vK/qMgUM=;
        b=Xpu2qyloEK4wrQKoNbmG8Cf124P5FCDaIh4XNbV17muc92lwbNyD6kzG+e6bkRHAK/
         8c6nOWAAlnF46NtnCvsgcnaoY8f5PPPwNE+BaZzTD49kuVBkArhMcxZabVKNY0pSBRAe
         wFXU/TUF6C7SRI7QImivMAIFlwjhM0NVUKiwyPnVq8eciwZAMYTp59V+gxCo6rm4gDEW
         +65fQ/sxjmknyvVJEbzAgBny4x01QuB/66ftqBYpJHsLCVqQY3oAY5gUUZ/KreMSgrBr
         Vs7evF9t9/p7mi0KPfnVaAz9DaSE2GUUQO1CDKd8kW3KH9I36Cj2UoGnkT94+GcECEBv
         ZEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06LWV7/hefCm//JXISG+B0Eva7xSqenjgz6vK/qMgUM=;
        b=YHj8UETWVqWAQDyZqFiSlY1jdWbPEzKFyIwmbl+eC85QAEaAgvNVBk6rF9BD4/3GDZ
         XTCNlVbzGgC1PpOEy6So4vIF4owTK89DU9XLmYI+0RX2RsgtbNo8wCYkKf/wN7MwP9LS
         kslUQYqgkSAo/v6SI2vEra+lDGsc91e2L0ROlXmugfl3AV298wlhbGBZkOajGT0Sduf8
         F8X5Rh+hA3j7V5xRJ2AM6JbhC8By0PEZpMgbjzIOyNxmpwXV5m0ugYSAV9cxC1rq+ZU5
         CPdxBtHPhEg5JZ7BL7BN7j6ArIGX1KoD9dd5TAfQySTMIqUcP6Py8HYkQvFpBoKHMl3s
         tThA==
X-Gm-Message-State: AA+aEWZ8K8B/lTij/ZyqFeq1eRB21Fq4courdJqNGt2W7U/Yu+s35nXK
        y7ZFndMA8yveAGMmxzXUqk0=
X-Google-Smtp-Source: AFSGD/UmnPTU/j//u1L6enpe6vbK2LV2R6XIiCmtv86n1FoOtSpzZC2tbDW9b3WbSp82cXtWfNDEbA==
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr3943675wme.108.1544566994392;
        Tue, 11 Dec 2018 14:23:14 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id p5sm1057565wmh.16.2018.12.11.14.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:23:13 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:23:12 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/8] checkout: allow ignoring unmatched pathspec
Message-ID: <20181211222312.GT4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-8-t.gummerer@gmail.com>
 <CACsJy8CjQHGANKf2Z=vJL=_ktoeXxOzQGL+VFJC4W63fzok78g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CjQHGANKf2Z=vJL=_ktoeXxOzQGL+VFJC4W63fzok78g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Duy Nguyen wrote:
> On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Currently when 'git checkout -- <pathspec>...' is invoked with
> > multiple pathspecs, where one or more of the pathspecs don't match
> > anything, checkout errors out.
> >
> > This can be inconvenient in some cases, such as when using git
> > checkout from a script.
> 
> Wait, should scripts go with read-tree, checkout-index or other
> plumbing commands instead?

Possibly.  As mentioned in an other email, we do seem to have some
scripts in git.git that are using 'git checkout' already, but they are
using it in the checkout branch mode, rather than the checkout paths
mode that I would like to use it in git-stash.

But with the rewrite of 'git stash' in C, maybe this step is moot
anyway, and we can just call the checkout_paths function internally
without using the run_command API at all.  We could then have an
internal mode for ignoring unmatched pathspecs that we wouldn't need
to expose to users.

> -- 
> Duy
