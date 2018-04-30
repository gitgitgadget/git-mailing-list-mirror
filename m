Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6ED21841
	for <e@80x24.org>; Mon, 30 Apr 2018 08:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeD3IDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 04:03:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38693 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeD3IDp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 04:03:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id i3so12721718wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7UKIctdNJVNwyOiKYK7liNVRxw3mdoUmlL3AP4voxfY=;
        b=tHuX3A9XY9xNO9JhmTD4F7cuxIRwxAdyF/p/0JiEMlol7x5A8s0B+6MSpQXGxy3WTQ
         +kNcUmsfUDrQwha/JQ9NUM1eH1TbLo9oNhfes/TIsyQs0RkM0vPmQI2uRLvC0zEH6lJO
         UsxsuyXIdx/VQHJstJN4M7uDEDH/jg6SlQ8d9VMzSIyH/feC+LhflSNdhlsd4nh/OgQ7
         +flB0OqPy+O1jgTO9i8USiX5Bsil+ELU29LeCoRKv5UhVDqtF3D3k1zD8PqOFZTAP+lB
         Oj6KsRc5Vs/qjrxHbQbsAu8n8GwUolZQTWVBdh1FCC5DJ+F/PK6vdrO58gawWw7jcFif
         Gd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7UKIctdNJVNwyOiKYK7liNVRxw3mdoUmlL3AP4voxfY=;
        b=KZppscl0+jqNuxhX4bQbdmWlfdMcUQip4WLH3+CfwBXhg1X/IpQ3MCfSobUtXnUBYz
         Y7FqoIEZbtil6e2k0YLjL8eAUKGNPq2nXfxynsbX79mDKDBkHsEinK4/uxVKfDk2A4gu
         dGNQ5x9omgGYqopA9OmlNqIj26hLYBc2SwrFOD8P9OYvL3zn1Nyo0LVomg8zqrP8Tc5e
         kSASAjyVvLMTE9m7yVLQV/PQocX2wk4vUv3UNbASrS9/MLkuH2Kx80DH1vPRYJxjM6kS
         8ORp6j2/mxRiFktAiCXkm3+STZon+y7Sl7ePvI/dQBh6nyZQ9F5THMsl/VQJkwIOM69r
         InOA==
X-Gm-Message-State: ALQs6tBAW9bVgQtaYi4NomUx2oc03MbLBUWa6KpmPbNO1ZRkXTVRQVGo
        rEWxMe2GpSqB/PPWB7brquE=
X-Google-Smtp-Source: AB8JxZpoGbDyAq4kTgD47aC5rMGpRbQDYly+Zr9P9xmcPUE2mykV/ZFdBlOBXIuSl9yWNs8JASv4fw==
X-Received: by 10.28.26.73 with SMTP id a70mr7307915wma.77.1525075424235;
        Mon, 30 Apr 2018 01:03:44 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id k28-v6sm2543221wrk.46.2018.04.30.01.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 01:03:43 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 30 Apr 2018 10:03:41 +0200
To:     Elijah Newren <newren@gmail.com>
Cc:     Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
Message-ID: <20180430080341.GA28348@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
 <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
 <20180427183752.GA2799@esm>
 <CABPp-BHwM1jx2+VTxt7hga7v-E6gvHuxVNPqm-MPRXYe5CDVtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHwM1jx2+VTxt7hga7v-E6gvHuxVNPqm-MPRXYe5CDVtA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 01:23:20PM -0700, Elijah Newren wrote:
> I doubt it has ever been discussed before this thread.  But, if you're
> curious, I'll try to dump a few thoughts.

Thank you, I try to dump some of mine, too. Maybe let me first stress
that for me copy detection without --find-copies-harder is much more a
"find content extracted" (like methods being factored out). In a way
this is nearer to a rename than to a real copy.


> [...] Let's say we have branches
> A and B, and:
>    A: modifies file z
>    B: copies z to y
> 
> Should the modifications to z done in A propagate to both z and y?  If
> not, what good is copy detection?  If so, then there are several
> ramifications...

If one just assumes the most likely outcome is that something from z wad
factored out to y, it might just be sufficient to see whether the
modifications of the two branches apply cleanly - if A touched the parts
of B that have been factored out there would be a normal merge conflict
(where one could be nice and give a hint that some content was copied to
y on the B branch), if A did not touched the parts touched (or moved) by
B, then there is no problem. If A exactly deleted the content moved by
B, there will be no conflict - but this is seems to be strange anyway.

I admit that a "real" copy would get unnoticed that way. But the
semantics of such a copy isn't too clear for me either - did I copy the
other part to make it independent of the other or did I just employ a
copy and paste tactic? The former does not want the changes, the later
does. But I am happy catering to the former here.

To sum up:
- fail as before for conflicting merges, but give a hint that one has
  copied to quicken up resolution.


> - If B not only copied z but also first modified it, then do we have
>   potential conflicts with both z and y -- possibly the exact same
>   conflicts, making the user resolve them repeatedly?

With the above suggestion, if there are conflicts, you fail and give a
hint.

> - What if A copied z to x?  Do changes to z propagate to all three of
>   z and x and y?  Do changes to either x or y affect z?  Do they
>   affect each other?

A copy on branch to x and one another to y seems strange even if z
merges cleanly. Did both sides try to factor the same thing out to
different files? Or did they try to make something independent, but
managed to make it to different files? For this I would be inclined to
just suggest fail with a copy/copy(somewhere else). But this is a real
corner case after all. Has anyone seen just thing in practice?

> - If A deleted z, does that give us a copy/delete conflict for y?  Do
>   we also have to worry about copy/add conflicts?  copy/add/delete?
>   rename/copy (multiple variants)?  copy/copy?

We do have the modified/deleted conflict where we could hint that
content also has been copied and then not try to do more.

> - Extra degrees of freedom may mean new conflict types:
> 
>   - The extra degrees of freedom from renames introduced multiple new
>     conflict types (e.g. rename/add, rename/rename(1to2),
>     rename/rename(2to1)).

For renaming one side and coping the other, I would think doing the same
as above is sensible enough: if there are conflicts one can give an
additional hint of the one part having been copied, but not change the
kind of conflicts much.

> The more I think about it, the more I think that attempting to detect
> copies in a merge algorithm just doesn't make sense.  Anything I can
> think of that someone might attempt to use detected copies for would
> just surprise users in a bad way...

Hm, it didn't sound like that. Would you think that users would be
surprised by my suggestions? Or are they all too corner casey to be
worth implementing anyway?

Greetings,
Eckhard
