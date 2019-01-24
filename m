Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8BC1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfAXWCl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 17:02:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfAXWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 17:02:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so4737523wml.3
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 14:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N5DHK0UkbwynjBJiPdvoGus+IDtySxHpR+tv+d/rOvU=;
        b=OYb3hjD00esGhAZ694adyIuekV8xWCy0dvIkFkcvfIGxTxYdx+TtRZEP2eFj2dMGot
         zw/E81jmtMmiW6SiNHHMh/PM19ZROgvqFL7lT+tMoz1/tXXV+fgh51MilbXY/1SOh5uy
         JfpY7Ze23fJFy2/EIhqcGpvHQsnHKXCIV63etFaS2QEjXLYS+/ROGV04NAAS9xXYJOiT
         iXVcmTdfl9ncKXpMlvdYI68Fk68VPxrEWNx+c471zJnXe10rCpKdETPnnd125stevRDJ
         vRfiXDn/VjEIkv/lWGTHHCLEJ81XU2IZoy7G9kjSIxyOF9VXcf01dL6XfbPp+WN0Jw4L
         LOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N5DHK0UkbwynjBJiPdvoGus+IDtySxHpR+tv+d/rOvU=;
        b=NMXpwNkxPxDsI94wrsLS/0p+VvytxWw7q15WlFj/Az/s5dDZdllUBPKYxv1nw3vIZ7
         A17egia+sbkYfgoqBLHKdEezOJyByCzuAXZochCRvsYgF747Qgun6FME+JxXG9c9CaRr
         cT7hJnNIAbSAtWOezw4DlYOpVfH6cVRKeaaA3HvlccsFCXeMJKslwbBN8NlsXxb32/6m
         8ACXwyrOpyoK4MKl9nhZUD3KyDOXm9S1aS+RH9rNSSpSx3BEHEpHQWieDHANT9U8P4lX
         Af66Y8ZA4+pPtPhWSQtqLb9d4RIiJRK/QqNjViS7OwIXZZnj4PrKjrkRPudVABwNRUSO
         31Zw==
X-Gm-Message-State: AJcUukdgUQPn0Ob3RTb/AU3IysCWLnX9c/guLNkKhMyWgaB2RrWfzZGt
        eHwMObjXQDZdZ+dl+LG/INXjVLDC
X-Google-Smtp-Source: ALg8bN7yA3rTBI/TuvCZ9N5J+oQYhaI52ojYPc0OIU6aSGf1cCGsl1zw6kf/TgyZi67lN6YjZdvG6w==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr4352589wmf.3.1548367358619;
        Thu, 24 Jan 2019 14:02:38 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id o16sm147123903wrn.11.2019.01.24.14.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 14:02:37 -0800 (PST)
Date:   Thu, 24 Jan 2019 22:02:36 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190124220236.GB11293@hank.intra.tgummerer.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
 <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
 <20190124011244.GE34357@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124011244.GE34357@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Jonathan Nieder wrote:
> Hi,
> 
> Junio C Hamano wrote:
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >> Jonathan Nieder wrote:
> 
> >>> Is this analogous to "git add --ignore-removal"?  If so, can we just
> >>> call it --ignore-removal?
> >>
> >> Yes, it seems like they are very similar.
> >
> > Hmm, I am not sure if the word "removal" makes sense in the context
> > of "checkout", as "removal" is an _action_ just like "checking out"
> > itself is, and not a _state_.  You'd check out a state out of a tree
> > to the index and the working tree, so "checking out absence of a
> > path" may make sense, though, as "absence of a path" is a state
> > recorded in that source tree object.
> 
> I find --ignore-removal fairly easy to understand, and I had no idea
> what --overlay would mean.

What do you think about --[no-]ignore-removed?  That would not be the same
as we are using in 'git add' though, and the slight difference may be
worse than a different option?  Though I suspect not too many people
are using --ignore-removal in 'git add' in the first place.

> I realize this is just one user's experience.  I'd be happy to do a
> little informal survey (e.g. taking the description from the manpage
> and asking people to name the option) if that's useful.

Sure, that sounds like an option if we can't come to an agreement
here.  What would such a survey look like?

> See also https://dl.acm.org/citation.cfm?id=32212 on this subject.

Sorry I don't have access to this, and unfortunately not the time to
read this either at the moment.
