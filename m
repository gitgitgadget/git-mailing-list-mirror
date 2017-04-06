Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2081FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 17:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755587AbdDFRjt (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 13:39:49 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33337 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbdDFRjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 13:39:39 -0400
Received: by mail-io0-f182.google.com with SMTP id t68so728828iof.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I35GBQ1rmHw9d+iNDLb67f12cRptF+4wQTwr3YGolQg=;
        b=e70nEZPvIQ+aKdfwgA0aMjKbY3f+JpvX2/Y6MYiqiepHtiyTIM9ndwU7HwjxmcefMq
         a6qkWY4HbAQ+G7oZ4awpJ1dYKW/ud45Ckl31n9mPbuMri0ovazrvxbo/hMnxPx+tEEJ+
         EvQwKEFK4VXP4/apE96Qh6N8p1dv+ur6+DU7R0Gu2jEfrWrWFBzP6i+3TnhfIPQp5Pkb
         +WXi73m1Vs/f1XuGdKNAiK1cGhLbPTXH7gG0tknPQSdekGo4rsZIdpqbXz9exzw9A1bP
         Ccr2xQOJkAt33+XqDQel+ftzZV/iHcb2L5fBigNncO6mb8SKyF5VQEqrlBq7dAF/VChG
         pABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I35GBQ1rmHw9d+iNDLb67f12cRptF+4wQTwr3YGolQg=;
        b=RAIig3At0VtgSHviG60ochwXbp9bLRT+0wts8vT3mFuWDzTLZFYBqNPKczGvb2o6Df
         wYkF5d5RlVc4kTHmO1vfxBUmsQmedIwbLh7yn1EOnlclwaDBVEszKnbcOLlE4B0y6HgA
         8MqBa0F4ZdPpBqbkxtdca1F5dU/Lxsvl6wCdxzpdNLzsNx8OV0zegdo5k4NeMjhsZEb1
         GaEVOKXq3qVHie6kBg3ZazJMwvWMCNxAHfmZlL2j6AbmR6vYyKdzWXfo1f+K/Gwj28hU
         9OF2+VoWfDK+5i8BZA1w+k4XLfMmnUyX+6zVtXR5O+8P5wBiYqPiqrzlndLOqLC6weAk
         qWMA==
X-Gm-Message-State: AFeK/H34/gw1Egh37mJweAXu8FBXoVOdfefR8tA/eb0SwJNXZeYVYVHDgytMXx13eKjgTNZf
X-Received: by 10.107.156.200 with SMTP id f191mr35396766ioe.9.1491500378681;
        Thu, 06 Apr 2017 10:39:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:94b7:58e1:86f9:6a3f])
        by smtp.gmail.com with ESMTPSA id z20sm1171830ioz.23.2017.04.06.10.39.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 10:39:37 -0700 (PDT)
Date:   Thu, 6 Apr 2017 10:39:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] push: propagate push-options with
 --recurse-submodules
Message-ID: <20170406173936.GA142670@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
 <20170331235623.166408-3-bmwill@google.com>
 <20170401001924.GC8741@aiede.mtv.corp.google.com>
 <CA+P7+xq58Bc2KVb2ewBPWPj8Zyf82tJWgQeq=oFvbs0ACysvLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xq58Bc2KVb2ewBPWPj8Zyf82tJWgQeq=oFvbs0ACysvLQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/05, Jacob Keller wrote:
> On Fri, Mar 31, 2017 at 5:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Brandon Williams wrote:
> >
> >> Teach push --recurse-submodules to propagate push-options recursively to
> >> the pushes performed in the submodules.
> >
> > Some time in the future we may want "push --recurse-submodules" to do a
> > dry run pass before doing the final push, so that if it is known that
> > some of the pushes wouldn't succeed (e.g. due to not being
> > fast-forward, or the server not being reachable, or the server not
> > supporting push options) then git could stop early instead of some
> > succeeding and some failing.
> >
> > But that's a larger and separate change from this one.  Users of push
> > --recurse-submodules today know they are effectively asking for
> > multiple pushes that are not guaranteed to succeed or fail together.
> >
> 
> If you want it to be truly atomic it will require more effort than the
> above. Suppose that you do a dry-run first, and then find out
> everything will succeed. After this, you do the real pushes. But in
> between these two commands something could have changed, and you could
> still end up with a non-atomic set of pushes.
> 
> I think that's ok and better than before, but it should be noted that
> you stll don't guarantee that all the pushes succeed or fail together.
> 
> I'm really not sure if you even can make these pushes work atomically
> considering they are going to different hosts.

Yeah, really it becomes impossible to have submodules pushed to multiple
hosts in an atomic way.  I think what Jonathan is mentioning is a way to
ensure that the options and everything are supported by the server you
are communicating with (for each submodule), though you could just run
an explicit dry-run yourself.

If you truly wanted the superproject and all submodules updated in an
atomic way you would need some other server side service (e.g. gerrit)
to ensure that it was done properly.

-- 
Brandon Williams
