Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087411F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRRuV (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:50:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42320 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGRRuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:50:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so550260plo.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o/+2zEsiFDS7RH412UniAlvJHIUgNgx8vUReTDUBAgA=;
        b=jd9OCEukikl+7AV6nbeeB+9F9O02lrnGLT8UfS9L4e6c9jB3Nw2VCMceejLePMFpb5
         IY9iRseFRBHWR2QrAboCXzV2auTpm6g19oxmw14CrQQiSCYMYyRSM2r0qXztDXQ0+r/3
         gaF25KmQbbrPnkJSsyR9SBMcXrX1K1nHSAA4U8luF+chgzxxwS5JFR+FYtjvMav6YXCa
         S0iZVlFLJwpU7k4tDwp6RyqRnGX+5OQBfkAvF92v9xd1iQL7yvmbsoUbbdxcDrYPnB1X
         tEKIwUdZflKNhIG+D+MBPrTQiuIRjhAuiLmbQ4BpAvHlD8YfcEUJH0SWqQlkZZ1lxbYk
         1a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/+2zEsiFDS7RH412UniAlvJHIUgNgx8vUReTDUBAgA=;
        b=q/BdVRK4tre48jCH1nLq59TjGAicE+KIkKvHMdsFjctgiTl26oagkBDVhMgfq6Ae++
         rC9F3MNBeCV5B4hH/47WTFh4Ue26TphMxywEtdhSOM86Hx8IpVi6u2oQf3nC/Z9nhmim
         uOK5goHvAMXxfrcz+Rholf7MVpnB0jUPuasdpmL7SG79PqqCuPXjw53rVKNlB8t5MKRW
         zvP/zayfj5sxwKVIJtD3wYGImCXks9WsvtehM5vKG6E0IFpJgOoVHYb8oxdBiv7Sw47M
         Kn5I73UNB5K2B4zZaaiRWOctk+s2RGgmgCcQsY/UZ2wK5YuPRV8LH40gTbB/i5FkRdIw
         TC5g==
X-Gm-Message-State: AOUpUlGq7qGOPmmD5rx+h1/xjTVpxVK7ONsYPcolaHZExI7VmP7Hqx/u
        AEeZSjxQKtHE8tC3S61I2rJSXA==
X-Google-Smtp-Source: AAOMgpctYIxzaop2JeeADRXjGDcScAq2t1SI8fsStvxH6w6Qv1aiM2ovP+DWUD6okYBZk6aqnFMjdw==
X-Received: by 2002:a17:902:112b:: with SMTP id d40-v6mr6757116pla.123.1531933889505;
        Wed, 18 Jul 2018 10:11:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 65-v6sm6699986pfq.81.2018.07.18.10.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:11:28 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:11:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180718171127.GB17137@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Derrick Stolee wrote:
> On 7/17/2018 7:25 PM, Stefan Beller wrote:
> > On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > ---
> > > 
> > > Since introducing protocol v2 and enabling fetch I've been thinking
> > > about what its inverse 'push' would look like.  After talking with a
> > > number of people I have a longish list of things that could be done to
> > > improve push and I think I've been able to distill the core features we
> > > want in push v2.
> > It would be nice to know which things you want to improve.
> 
> Hopefully we can also get others to chime in with things they don't like
> about the existing protocol. What pain points exist, and what can we do to
> improve at the transport layer before considering new functionality?
> 
> > >   Thankfully (due to the capability system) most of the
> > > other features/improvements can be added later with ease.
> > > 
> > > What I've got now is a rough design for a more flexible push, more
> > > flexible because it allows for the server to do what it wants with the
> > > refs that are pushed and has the ability to communicate back what was
> > > done to the client.  The main motivation for this is to work around
> > > issues when working with Gerrit and other code-review systems where you
> > > need to have Change-Ids in the commit messages (now the server can just
> > > insert them for you and send back new commits) and you need to push to
> > > magic refs to get around various limitations (now a Gerrit server should
> > > be able to communicate that pushing to 'master' doesn't update master
> > > but instead creates a refs/changes/<id> ref).
> > Well Gerrit is our main motivation, but this allows for other workflows as well.
> > For example Facebook uses hg internally and they have a
> > "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> > brings up quite some contention. The protocol outlined below would allow
> > for such a workflow as well? (This might be an easier sell to the Git
> > community as most are not quite familiar with Gerrit)
> 
> I'm also curious how this "change commits on push" would be helpful to other
> scenarios.
> 
> Since I'm not familiar with Gerrit: what is preventing you from having a
> commit hook that inserts (or requests) a Change-Id when not present? How can
> the server identify the Change-Id automatically when it isn't present?

Right now all Gerrit users have a commit hook installed which inserts
the Change-Id.  The issue is that if you push to gerrit and you don't
have Change-ids, the push fails and you're prompted to blindly run a
command to install the commit-hook.  So if we could just have the server
handle this completely then the users of gerrit wouldn't ever need to
have a hook installed in the first place.


-- 
Brandon Williams
