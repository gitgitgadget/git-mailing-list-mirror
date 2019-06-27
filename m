Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082061F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF0WUj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:20:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44980 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:20:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so2021156plr.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6WjhU3N6Vk+zV0XCxQP1DOJyK5vnOUNP2ku5ZbTurZY=;
        b=T18cscox2q71ekB+/ejqwoQw7bflNVLtX98xb5djQBfWc9Ppc3f/0HuaACClZK67zb
         9Xt4GV+0mLhx3oNmIfbw49/mhbzsHzvlCBZCTv/h9nVspBVzDn7rRVknfS5Qeli0alNk
         +1wGsGY3r8oHJUT5/6bVNJH0FiLaW4N9Rzub7YaE7ihPsAxCttjCRKTpZu1UW6SUmsqV
         OeNXfayAU1DW39PsoJ+QdOGnm56FIKo0KlAL2BnEqISNw1xnVE8Y88vYEyJSzO7OIFyw
         QLf3dk7Uow3ll91XCydJ4w6gC1sGu87ypLrRx03886fnuxucUM4wUav728/QyUycGvM4
         ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6WjhU3N6Vk+zV0XCxQP1DOJyK5vnOUNP2ku5ZbTurZY=;
        b=b7oULgfRSVIm+XnsIH/rMMt0uQQ8wGIgV5MN56Vt8cIxVBqVMkKinSKCkGIFyws+qM
         lOHsqzficDIJhWnq6n9GPIjxiNyYHN6uF2ABkGN73HsjpTfpFRBMuwp6uRHwbW2h29vZ
         z9LYsSdT3ZOA/wr1pLuwSm/FPpiqgDEtY/u4tevJDWBfOWhTFodl2/cVhLobi8g2Teo8
         HPX0DiKMPxT/Ft7xlfRimD7hvk/86YCEjjmeQnWyDEMtqKuXNIcQNkX6PS7/uRcqjCmI
         9i0YChk+2V4fUVgIqhnzkIlR32nl41tZCeynw6JYZZ+r3McK8214OfInOKZcNEzuTcJk
         yfQQ==
X-Gm-Message-State: APjAAAW3b9NDZNNW3nDGgr7/mCpkh+iXtR5nNOQRrz9QuYRzWcvxv82W
        zkqJavAClH/qXtzP8eq+cvfgRQaeTTw=
X-Google-Smtp-Source: APXvYqw444cWybYrVFj4FBe20W/t9z6k9wvCjeR9vkg2tFPWmuUw5Ob5Wfv31relNaeN321ZTOYGyw==
X-Received: by 2002:a17:902:b20d:: with SMTP id t13mr7030013plr.229.1561674037792;
        Thu, 27 Jun 2019 15:20:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id f186sm105832pfb.5.2019.06.27.15.20.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:20:36 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:20:32 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/13] walken: demonstrate reversing a revision
 walk list
Message-ID: <20190627222032.GG245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-10-emilyshaffer@google.com>
 <CAPig+cQh2rEW271KziUyYGZyPXrFV8z_OV6UzY=-e4pOrF_zsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQh2rEW271KziUyYGZyPXrFV8z_OV6UzY=-e4pOrF_zsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:26:19AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > The final installment in the tutorial about sorting revision walk
> > outputs. This commit reverses the commit list, so that we see newer
> > commits last (handy since we aren't using a pager).
> >
> > It's important to note that rev->reverse needs to be set after
> > add_head_to_pending() or before setup_revisions(). (This is mentioned in
> > the accompanying tutorial.)
> 
> This leaves the reader wondering "why that requirement?". Is it
> because those functions may change the value or otherwise depend upon
> the value?
> 
> Also, something this important probably deserves an in-code comment
> (and need not be mentioned in the commit message if the in-code
> comment explains it well.)

This I will remove. I removed from the tutorial as it turned out I was
incorrect. Thanks.

> 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -69,6 +69,9 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
> >         /* add the HEAD to pending so we can start */
> >         add_head_to_pending(rev);
> > +
> > +       /* Reverse the order */
> > +       rev->reverse = 1;
