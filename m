Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875E41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeI1CB2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:01:28 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52053 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeI1CB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 22:01:28 -0400
Received: by mail-qt1-f202.google.com with SMTP id h26-v6so3282288qtp.18
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HmCpt/Bjl+4R5pSk1G1+emClfcJhHxW9qmeQs2AWmv4=;
        b=F+v2z/l24Ykzjsl4OxdHnX+OEz3dizYtEj6YzkEVtGSC4U5Clilb5EGeL5SpH7jEge
         fH51hmaMrLeTvOtKmvQLCD/Kt5RHyVHSS4Hnr5IH1bx3jiORKn+OksSLnsAz0pfg7WOZ
         VNk9RZW/3yUvrQvtbtS8YiUNxxOm5Qgkzih21dy2lludYWmeHjO4B3M7hdo7CWY0nG7C
         rEuVTPAWaFDMgAYFNVSyt0BTg4vyQYmSJi1od76hJpWCUPSRgis1OGq216yDNjffN48t
         J45ma0lw5DMaycb7jSXGw49nk/cSELLZ8lFXjTdJ3fgFFTWTsze8hVP46fcrFmTvr+lN
         9pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HmCpt/Bjl+4R5pSk1G1+emClfcJhHxW9qmeQs2AWmv4=;
        b=tpTr5TvzMNEsVeKBZL7Izo9/tZv6vFB33qJ9GZNky68eX0Ujo7F8pbvr9vMonWbM9V
         uGNolsCWZv17Y/hFYCLbJmFimLclNYwe6NXyE0gEk54T/EzGOz4ckZgFLalgpDoG9bg6
         Z5yn9yNZz3I2qx7uAgysLADdBntI85sL/gJg8YuGB4/LGkDbhtG4wp5xvxB74ADLABxM
         ADZ1H1ZsmUsxpyM71lGaJFZwE+8VqqHTOsQQHXZBcysXKaiUhXHFR7pdsGuAxF3jEU9y
         T7XesSL6dyK9Ms7uOWp06dHrBRnBnnDucGmGvQBcCFUkkqLO1jb3vdh4UDPFqTOD0NPz
         TKkA==
X-Gm-Message-State: ABuFfoiegiaF0saIbCab/et27ygrDELWdvPiBAhWA8vzhQlEbBnWIqA8
        37au5bzGdBd7lkMaAMd4f/Txy5LLaukzMHCvT5Td
X-Google-Smtp-Source: ACcGV63rYUsjm1GLda8/7iOuFAtgmb/qqOXvp6QdNFQiEuWfoKFi6ftC50hDQg4rDuAvIYhLKoyVfM6h0KVwgNR6DStB
X-Received: by 2002:ad4:5141:: with SMTP id g1-v6mr5833693qvq.51.1538077295955;
 Thu, 27 Sep 2018 12:41:35 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:41:25 -0700
In-Reply-To: <87in4tu6wb.fsf@evledraar.gmail.com>
Message-Id: <20180927194125.8380-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87in4tu6wb.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [PATCH 0/2] negotiator: improve recent behavior + docs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > If you wanted to do this, it seems better to me to just declare a "null"
> > negotiation algorithm that does not perform any negotiation at all.
> 
> I think such an algorithm is a good idea in general, especially for
> testing, and yeah, maybe that's the best way out of this, i.e. to do:
> 
>     if git rev-parse {}/HEAD 2>/dev/null
>     then
>         git fetch --negotiation-tip={}/HEAD {}
>     else
>         git -c fetch.negotiationAlgorithm=null fetch {}
>     fi
> 
> Would such an algorithm be added by overriding default.c's add_tip
> function to never add anything by calling default_negotiator_init()
> followed by null_negotiator_init(), which would only override add_tip?
> (yay C OO)
> 
> If so from fetch-pack.c it looks like there may be the limitation on the
> interface that the negotiator can't exit early (in
> fetch-pack.c:mark_tips). But I've just skimmed this, so maybe I've
> missed something.

(I was reminded to reply to this offlist - sorry for the late reply.)

I think too many things need to be replaced (known_common, add_tip, and
ack all need to do nothing), so it's best to start from scratch. That
way, we also don't need to deal with the subtleties of C OO :-)

> Also, looks like because of the current interface =null and
> --negotiation-tip=* would (somewhat confusingly) do a "real" negotiation
> if done that way, since it'll bypass the API and insert tips for it to
> negotiate, but it looks like overriding next() will get around that.

If you do it as I suggest (in particular, add_tip doing nothing) then
there is the opposite problem that it won't be easy to inform the user
that --negotiation-tip does nothing in this case. Maybe there needs to
be an "accepts_tips" field in struct fetch_negotiator that, if false,
means that custom tips (or any tips) are not accepted, allowing the
caller of the negotiator to print a warning message in this case.
