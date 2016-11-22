Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13C51FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbcKVSgm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:36:42 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36647 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932355AbcKVSgl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:36:41 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so5313364pfz.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcH1/kATEkpZCC+EInS5frAXrI56mNVGSgeP5EGN5mk=;
        b=Mcnktp2HAq8LYM+QLPDdgTXGvglfeTY4SkY0CxkLmAXL45fVN5e7Yf7aWOaCvAbjfz
         9vkjt0S6a/Z1ZMOffRvZN+xR/LokgEInD97AHTWtL/LfmZvyywL6lg1n1JEzrS1am+nP
         SrnD/1QS2F0IvfWwsVZrMwbbvbEse0wilKu6RPZLZPHSVaM7IlAvwKBUURVPNBBMrRjj
         lzYvMDp2/NFX7b8CmcTxcbHhWYYYuV28W5L149BT3EcBlr/94CeJhgS+g3PYu4Q0jPQe
         L3PmKA6/SU4lpBaQ1Tv+ycAoUmDG/e+FZPzuKxgf9npoKMntd8553i+62ec48qnm8Wyi
         h4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcH1/kATEkpZCC+EInS5frAXrI56mNVGSgeP5EGN5mk=;
        b=U6CRhi/a0rCeOAUQoWPMti3oR1cs6zAVAGgwWviPZnYFWLS2ncjaBes7VHpI9X/7QP
         H3vGJ5suehodDi7/ChKBSyVNNniDxZyQV1aea9pgl3bExD1x0MLfi5OTljChsf3MluKz
         eQ2+RakHWQU8O+0TiOXyJt+zmme4PTfJfJvvxFKdNkhdy+iqdD4lUkf1ItaJ6wZYZGQn
         Ra+rYkw3mrdqRJPyLJ5em/Aw3V32CXmRrJyZL2qbvWdUQIQ6mvKR96H0MVOsts49KKkb
         /yr9fNRO3Zb3WwV3ljcPtub1X7pRxhyeC2yrnReO+8JuWFZXk6G4u3pxIli7pn6zgjtj
         lufw==
X-Gm-Message-State: AKaTC030/S6LMZ0DCmP4OJ+Qry9+cy+DYr78mpTag7HbR7uVbFuTHvAlWnFO0dLHwpC7W/ZT
X-Received: by 10.84.148.203 with SMTP id y11mr2373824plg.29.1479839801051;
        Tue, 22 Nov 2016 10:36:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id m5sm28906105pgn.42.2016.11.22.10.36.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:36:40 -0800 (PST)
Date:   Tue, 22 Nov 2016 10:36:39 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jacob.keller@gmail.com
Subject: Re: [PATCHv3 3/3] submodule-config: clarify parsing of null_sha1
 element
Message-ID: <20161122183639.GA65825@google.com>
References: <20161122013550.1800-1-sbeller@google.com>
 <20161122013550.1800-4-sbeller@google.com>
 <xmqqziksfae3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqziksfae3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > +Whenever a submodule configuration is parsed in `parse_submodule_config_option`
> > +via e.g. `gitmodules_config()`, it will be overwrite the null_sha1 entry.
> 
> It will overwrite?  It will be overwritten?  I guess it is the latter?
> 
> > +So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
> > +with the repository configuration, the null_sha1 entry contains the local
> > +configuration of a submodule (e.g. consolidated values from local git
> >  configuration and the .gitmodules file in the worktree).
> >  
> >  For an example usage see test-submodule-config.c.

I brought this up in v2, he must have just missed it for v3.

-- 
Brandon Williams
