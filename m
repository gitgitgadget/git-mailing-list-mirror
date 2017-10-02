Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227E120281
	for <e@80x24.org>; Mon,  2 Oct 2017 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdJBQNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 12:13:01 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:46290 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdJBQNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 12:13:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id r68so3118420pfj.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qmm4W9pyuFS1cSyFdTYNNfyNdEhak+hGZ1AyXZCSqbs=;
        b=EXke3uD69QZc8sIU2T89/g/SZbzo2E7vZTHtTdu+otQseTWLvVcl+XpIdfIXUWNpVy
         ejufE5AZ1DbLeYpeop7b2Egd3+NNWG92Wqiyqlfb6luj/WmOp7UIvI2FWHUZ8Bh1I9Ou
         waGgHodPZLQp0nsudbSs3C25zLWHxfP/LOJiH4WsFb9l4dpLa3zJoXESS0DSUaJ0jB2Q
         EWPmfEQJgGpJgusXHTkGVJWRXzIVjAaLneiKkrqFgof6QKL9HQZb5RLTjbQwnRf4o6Sd
         G9Hj71uDzffjBUkzWHyTI6eDk4D/Dn7ZPbN4cYljeVDeOqbpqY1z/BsuS+2BEZu/f6gW
         RSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qmm4W9pyuFS1cSyFdTYNNfyNdEhak+hGZ1AyXZCSqbs=;
        b=ruyDLWHauJgOS0WSlSnl6JyFslIOkZf+9ft2We+R8s41828SRUuiZcBN2Vg8gMXgcB
         K/apZFrh/X5vFw525Y9704JAhqHsnrjX7ooS65xNhdJvM+9hjlZbblHJDtDOUbh7n27R
         d/Rx1m31Y5Wzx5va2onjw2ls5XKby0T/Dh9y4mW/UcPxGmb49bWmME0U9BgGop6LhJs2
         l5kgR+Z0CLcwlREVOJ65kr2gRuuhnz9w5RmsMUtw+stsY2I4nPIwuxh8ObIH3kEBNAwH
         gYxbvPFG9ruAe4ISsBz+hC3CkMADhGhSlHwWRZN+E+f5f3nIoy4oahiR4LXgmJokOwNC
         wDPA==
X-Gm-Message-State: AMCzsaXxfIxIQCmdw9aVBf/jnfwYYcG/oDgh5IC0HYomU+qJ9qd9iYl8
        MySUHuuPcavIIcpO0hTRQruGJ+145D0=
X-Google-Smtp-Source: AOwi7QCuRPU1a9w6AitO1PYUU+TTpip5+H9/enEGe4UHo8J2xG1XTG82FTs2N6ZxP2dvk+d9R0Ffdw==
X-Received: by 10.98.200.138 with SMTP id i10mr2803139pfk.222.1506960780341;
        Mon, 02 Oct 2017 09:13:00 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id n2sm17573999pgs.89.2017.10.02.09.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 09:12:58 -0700 (PDT)
Date:   Mon, 2 Oct 2017 09:12:58 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers
Message-ID: <20171002161258.GC39723@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002055311.29681-1-me@ttaylorr.com>
 <20171002064335.vzm3j2dgax4q5bxd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002064335.vzm3j2dgax4q5bxd@sigill.intra.peff.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 02:43:35AM -0400, Jeff King wrote:
> On Sun, Oct 01, 2017 at 10:53:11PM -0700, Taylor Blau wrote:
>
> > Peff points out that different atom parsers handle the empty
> > "sub-argument" list differently. An example of this is the format
> > "%(refname:)".
> >
> > Since callers often use `string_list_split` (which splits the empty
> > string with any delimiter as a 1-ary string_list containing the empty
> > string), this makes handling empty sub-argument strings non-ergonomic.
> >
> > Let's fix this by assuming that atom parser implementations don't care
> > about distinguishing between the empty string "%(refname:)" and no
> > sub-arguments "%(refname)".
>
> This looks good to me (both the explanation and the function of the
> code).

Thanks :-).

> But let me assume for a moment that your "please let me know" from the
> earlier series is still in effect, and you wish to be showered with
> pedantry and subjective advice. ;)
>
> I see a lot of newer contributors sending single patches as a 1-patch
> series with a cover letter. As a reviewer, I think this is mostly just a
> hassle. The cover letter ends up mostly repeating the same content from
> the single commit, so readers end up having to go over it twice (and you
> ended up having to write it twice).
>
> Sometimes there _is_ useful information to be conveyed that doesn't
> belong in the commit message, but that can easily go after the "---" (or
> before a "-- >8 --" if you really feel it should be read before the
> commit message.
>
> In general, if you find yourself writing a really long cover letter, and
> especially one that isn't mostly "meta" information (like where this
> should be applied, or what's changed since the last version), you should
> consider whether that information ought to go into the commit message
> instead. The one exception is if you _do_ have a long series and you
> need to sketch out the approach to help the reader see the big picture
> (in which case your cover letter should be summarizing what's already in
> the commit messages).

Thank you for this advice. I was worried when writing my cover letter
last night that it would be considered repetitive, but I wasn't sure how
much brevity/detail would be desired in a patch series of this length.

I'll keep this in mind for the future.

> And before anybody digs in the list to find my novel-length cover
> letters to throw back in my face, I know that I'm very guilty of this.
> I'm trying to get better at it, and passing it on so you can learn from
> my mistakes. :)

I appreciate your humility ;-).

> > -	if (arg)
> > +	if (arg) {
> >  		arg = used_atom[at].name + (arg - atom) + 1;
> > +		if (!*arg) {
> > +			/*
> > +			 * string_list_split is often use by atom parsers to
> > +			 * split multiple sub-arguments for inspection.
> > +			 *
> > +			 * Given a string that does not contain a delimiter
> > +			 * (example: ""), string_list_split returns a 1-ary
> > +			 * string_list that requires adding special cases to
> > +			 * atom parsers.
> > +			 *
> > +			 * Thus, treat the empty argument string as NULL.
> > +			 */
> > +			arg = NULL;
> > +		}
> > +	}
>
> I know this is getting _really_ subjective, but IMHO this is a lot more
> reasoning than the comment needs. The commit message goes into the
> details of the "why", but here I'd have just written something like:
>
>   /* treat "%(foo:)" the same as "%(foo)"; i.e., no arguments */

I sent an updated v2 of this "series" (without a cover-letter) that
shortens this comment to more or less what you suggested. I've kept the
commit message longer, since I think that that information is useful
within "git blame".


--
- Taylor
