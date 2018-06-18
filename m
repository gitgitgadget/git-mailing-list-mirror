Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35C41F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbeFRXQq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:16:46 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:44825 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeFRXQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:16:46 -0400
Received: by mail-qk0-f201.google.com with SMTP id m65-v6so15737528qkh.11
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=z2k1i5Ub7zrwLMGX1GcgmwHpffJGMHaGzgnbnW0W3lg=;
        b=pp3TE+U81XWbff6V+alBYX+5mnywEQGBvk7v6X9RwRsMWZx0NKZ3d93Y0F5jQ3S/so
         9ygMRThGzRJsZWyxrRUSMivcMabZXpp+HexwxxVvNDcilukYrNeCNTd1Ug+T3SRJZek7
         XWH0sTdDQUS3/bfFrRo50ABF2HxvjnC49NJFOxcT+4Xt6VaT2xozPupjZ9SrpQPxFN2E
         OFBanuw4CotnKgciNcJA617WxCwn27oJnglgU813f4WRNZmh7x7dOHP38KXnGlXXTNKm
         B1I/eoGi6iHTpSAjwtgyCZ3yYTX1mIKryfxNMTpCV9iiJS6vgraX9nLdozGkLvYFrVrg
         mTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=z2k1i5Ub7zrwLMGX1GcgmwHpffJGMHaGzgnbnW0W3lg=;
        b=YhUc1vLLKQN8Yo9OJSaEi32qm68pRuQOZeUEXtxCALsQMQk8SdmlVR7JtjM3P8Pg/H
         rLYX8OP0TCatsEF33o7MI9ua/VtFwDnl5NwNbq95rIo5oXyDMJzfgwagNqjcV1fNpKqd
         +rDVuJOIRZPumJFMLdJ222QrVgFPcxbtrFd/bJh6TwGL0Mk+r6KFm+ogehq9GGm/64YM
         vZuB4Co+nNz/yCn29yQ4YLGJFTYAFWU/4d/hW5X1LQdrYc7LpPip0Vsbq5PVrBzZOCCG
         TVn5xEALehZsDMT1qqrf+2SMlgk8agbsURjUecWb3FdXUHRgKx8m/Fuulg38Dhwy6JxT
         P21Q==
X-Gm-Message-State: APt69E3COfSlWLpajKYALABCsDOkmjg3QiyWt4uB2FHLaECytjTU0Gw2
        tnfEnl/KctZEPxKrLhzSOUmMcSRXmjClcPgPPw7d
X-Google-Smtp-Source: ADUXVKIOZayCu10SfLP4//3kNJAUmGdQbmbCMjHZfbRNhhcxHvcgxNV6o2JtRJUiQnVgR9vi2TvnBnnVKeA9/DMgtWh2
MIME-Version: 1.0
X-Received: by 2002:a0c:d687:: with SMTP id k7-v6mr7709440qvi.22.1529363805167;
 Mon, 18 Jun 2018 16:16:45 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:16:42 -0700
In-Reply-To: <xmqqwouvwzsz.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180618231642.174650-1-jonathantanmy@google.com>
References: <xmqqwouvwzsz.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> Wouldn't that allow us not having to advertise the whole tags
> >> namespace only to implement the tag following?
> >
> > Yes, it would, but as far as I can tell, it would add an extra burden on
> > the server to walk all refs requested in the ls-refs call (in order to
> > determine which tags to send back in the response). Also, this walk must
> > be done before any negotiation (since this is a ls-refs call),...
> 
> My comment was that I doubt the "must be done" part of the above.
> How would refs-in-want be responded where client-supplied "I want
> 'master' branch---I am not asking for the exact object the first
> server I contacted said where the 'master' is at" gets turned into
> "So the final value of 'master' among these servers that are not
> quite in sync is this" by the one that gives you the pack, not
> necessarily the one that responds to ls-refs upon initial contact?
> Can't we do something similar, i.e. let the client say "I want tags
> that refer to new objects you are going to send me, I do not know
> what they are offhand" and the server that actually gives you the
> pack to say "here are the tags I ended up including"?  The
> "include-tag" process to generate pack with extra objects (i.e. the
> tags that point at packed objects) has to involve walking for
> reachabliity anyway, so as long as the feature is supported,
> somebody has to do the work, and if you want to cut down the
> transfer cost of the refs/tags/* enumeration, it needs to happen on
> the server end, no?

Ah, I think I see. There are these possible worlds:
 (1) the current world
 (2) no ref-in-want, and upload-pack sends tag information as part of
     its response to ls-refs
 (3) no ref-in-want, but upload-pack can send ref information right
     before the packfile
 (4) ref-in-want, and upload-pack will send ref information right before
     the packfile

I was only thinking about (2) and (4), but I think you are talking about
(3). Yes, that would work, although I don't think it's worth the
protocol churn to do (3) then (4), especially since we already have
ref-in-want patches sent to the mailing list - but I should have
discussed this option in my previous e-mails too.

> Or perhaps v2 fetch should implement the automated tag following
> without using include-tag and instead as an extended feature of
> ref-in-want.  I think that is merely giving a different name to the
> same idea outlined above, though ;-)

Instead of not using include-tag, I would define include-tag in
the presence of want-refs to also include the refs, but I agree with
this solution.
