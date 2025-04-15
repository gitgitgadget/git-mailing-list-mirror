Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04594256C7A
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749953; cv=none; b=T20wvzIBXmWofYw7gyvCdp9ZpUFDIG7qd+/pYozMbFYgQO4WK5eNjC4Bwc2l1u3rEHEc+7qzDoAUA66KkrFfQO5iMR32+6F1vLjfzNSK3nidUU9CPPbYrM9q9o/ZeSVQFSXF8dJs8Pm1eFxl6mOsrxeWslb8766lbitIvSl6nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749953; c=relaxed/simple;
	bh=bCBSgAP+geZXWJidzZ76ZaAaNhuV4JEPpvU/BvYUbsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHAJ1hm4g2QynQFB3eGXsr1dbO/2FU2R3cNTJNeQSeFo/UFg5E0nM3xhFokz58JQs0JKpvdu5LN14Ht3VsBBpMa/pnJ4mA1Cwe3Hs9VlKtBsIcBuQwSeTdyP6UQasyHd84Qox8aWS1fEHNw4dKTch75f5SYtn5c0JUZ7L2qWzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fgo6pm95; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fgo6pm95"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c59e7039eeso830481085a.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744749949; x=1745354749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFMQ3DOnFQhSyXbNVbfVzwGcPwB84vUitf3B0acekz8=;
        b=Fgo6pm95u8Un6Lxw1mUrRmlMONjtmWZyRC2EFFgk3mQmlwUoT3wY5srPdbWbnKUWbQ
         WAWJtB/gcH36fPzvqJsWDrQRnc9CkPb7al7ajiIvRk4jb3hHbbJYLQi2vvHNCKoMhij3
         D6/IXUsfrMvxMlvnyPmIJK6D466R3nezxxO6Cw/FNHVsxzpsUEy9QhQRDMiLMZ4mpOAN
         OGgoqfsSWur1BN81+febHkNMO4mN787zsU3a/RznFQKqQkBw8TBNAdXY7Aw8AgDtLHQ5
         VUZxQ1Go+UlnMCsPsXUUHa41/Mb8DmZJveGq6955HhcOa2GCQNKCvWGAKAxubruNptie
         X5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744749949; x=1745354749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFMQ3DOnFQhSyXbNVbfVzwGcPwB84vUitf3B0acekz8=;
        b=TUrm3gHbJMMS8zwm+8mwNtrmR+V/tyUgsoFHa9FsYw9jcLblbiWh7ig5ZW+3jP8rOv
         M2keQH463yvveB/twIXMEN9Hx34ZHHIW49ccHdAFWyzOAwjOsSFgn+bt9G00FK+wqqVr
         +5iNvRMvZYooIcZzTiNDeQFJ6jTLcmNxx0fSgMZdStVt10FSl8r1Zm0k1wSgIwOrXFYO
         D6O+afEPfHNaXoNN9wxDIzlLRDdsgSeQskCaY3xAp8VSFmda9scTGWuFwScjAv6V673R
         rlftvoRJ12iLiQKYx6Vgc9jXRVqI21OBpLw/k2AdzobQ0y1jN6eYnjMkLa49v7ENAU1J
         ImEA==
X-Gm-Message-State: AOJu0YxMaAJ3/7ZRtPlfmOf0xNe7w+NMUP2g5jhB2c6ByVRb+1tzfYKr
	8tn9/nK6MmmJ9QYEyQ38UNk9/ycM5Y0zp+ssj/9qTUUhGRFSa2lbG4fMmMrZHqI=
X-Gm-Gg: ASbGncvaNwHZlt7EKCzswPXWD3jBjPG1Gs1Cnqq+Vk9J5f2HyOStFCnz/Eiytv6pSDI
	I+xvWrTQSMUjxiDoyFEzF7HEkb2EHDe6X4UoXOksgCK+cqrVoNO/aTSXf/2CmRmR2jBNUS+AU5W
	BKG4v0rIGvyxHecsqHwZCppnYKYWp+kf85qG21LSxYxLQMWUQTzT/8Sm+odvsED6QP00y2/hl4r
	JUE0s8RywFdrITjoJtWzT+vrDR6xP8WM9kNtgQ3Yu1qJemafm0Z/Ka9f0wRYsbchBK5eOKIKr5W
	1VVRgn6Nze4yQN96ljGlgvZ/pCh+GAV96aiWRvD7/lP1OqU8uaZMSQWICrpMgB1RRprstIRJJ0g
	nRh9nbkFDIxik
X-Google-Smtp-Source: AGHT+IEJHNY5tuB78GmqqeCzFuu9XYb2YknyshPHJbVSUn8s7fsnBfu4Z79LSAcARvcqsn6kISLjpQ==
X-Received: by 2002:a05:620a:4447:b0:7c5:5d13:f186 with SMTP id af79cd13be357-7c91419798bmr113231985a.10.1744749949443;
        Tue, 15 Apr 2025 13:45:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8a18eafsm956191985a.114.2025.04.15.13.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:45:49 -0700 (PDT)
Date: Tue, 15 Apr 2025 16:45:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <Z/7FdgYID9I1qR7K@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <697a337cb147ed638884cf9b8605fef8b572e1c6.1744661167.git.me@ttaylorr.com>
 <CABPp-BFBJP15g=4M90161=KCDei-hEFdnGs7_oY8ERtqgn9s-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFBJP15g=4M90161=KCDei-hEFdnGs7_oY8ERtqgn9s-g@mail.gmail.com>

On Mon, Apr 14, 2025 at 08:11:08PM -0700, Elijah Newren wrote:
> > diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
> > index 7f69ae4855..c894582799 100644
> > --- a/Documentation/git-pack-objects.adoc
> > +++ b/Documentation/git-pack-objects.adoc
> > @@ -87,13 +87,19 @@ base-name::
> >         reference was included in the resulting packfile.  This
> >         can be useful to send new tags to native Git clients.
> >
> > ---stdin-packs::
> > +--stdin-packs[=<mode>]::
> >         Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
> >         from the standard input, instead of object names or revision
> >         arguments. The resulting pack contains all objects listed in the
> >         included packs (those not beginning with `^`), excluding any
> >         objects listed in the excluded packs (beginning with `^`).
> >  +
> > +When `mode` is "follow", pack objects which are reachable from objects
> > +in the included packs, but appear in packs that are not listed.
> > +Reachable objects which appear in excluded packs are not packed. Useful
> > +for resurrecting once-cruft objects to generate packs which are closed
> > +under reachability up to the excluded packs.
>
> Maybe:
>
> When `mode` is "follow", objects from packs not listed on stdin
> receive special treatment.  Objects within unlisted packs will be
> included if those objects (1) are reachable from the included packs,
> and (2) are not also found in any of the excluded packs.  This mode is
> useful for resurrecting once-cruft objects to generate packs which are
> closed under reachability up to the boundary set by the excluded
> packs.

I like it. I went with your version with some minor rewording and tweaks
on top.

> > +               /*
> > +                * Our 'to_pack' list was constructed by iterating all
> > +                * objects packed in included packs, and so doesn't
> > +                * have a non-zero hash field that you would typically
> > +                * pick up during a reachability traversal.
> > +                *
> > +                * Make a best-effort attempt to fill in the ->hash
> > +                * and ->no_try_delta here using a now in order to
> > +                * perhaps improve the delta selection process.
> > +                */
>
> I know you just moved this paragraph from below...but it doesn't parse
> for me.  "using a now in order to perhaps"?  What does that mean?

Yeah, this is just bogus, and was so before this patch. The rewording is
minor enough (just dropping "using a now") that I think we can just
squash it in with the movement in this patch.

> > +               oe->hash = pack_name_hash_fn(name);
> > +               oe->no_try_delta = name && no_try_delta(name);
> > +
> > +               stdin_packs_hints_nr++;
> > +       }
> > +}
> > +
> > +static void show_commit_pack_hint(struct commit *commit, void *data)
> > +{
> > +       enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> > +       if (mode == STDIN_PACKS_MODE_FOLLOW) {
> > +               show_object_pack_hint((struct object *)commit, "", data);
> >                 return;
> > +       }
> > +       /* nothing to do; commits don't have a namehash */
> >
> > -       /*
> > -        * Our 'to_pack' list was constructed by iterating all objects packed in
> > -        * included packs, and so doesn't have a non-zero hash field that you
> > -        * would typically pick up during a reachability traversal.
> > -        *
> > -        * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
> > -        * here using a now in order to perhaps improve the delta selection
> > -        * process.
> > -        */
> > -       oe->hash = pack_name_hash_fn(name);
> > -       oe->no_try_delta = name && no_try_delta(name);
> > -
> > -       stdin_packs_hints_nr++;
> >  }
>
> It might be worth swapping the order of functions as a preparatory
> patch (both here and when you've done it elsewhere in this series),
> just because it'll make the diff so much easier to read when we can
> see the changes to the function without have to also deal with the
> order swapping (since order swapping looks like a large deletion and
> large addition of one of the two functions).

Fair enough.

> > @@ -4467,6 +4484,23 @@ static int is_not_in_promisor_pack(struct commit *commit, void *data) {
> >         return is_not_in_promisor_pack_obj((struct object *) commit, data);
> >  }
> >
> > +static int parse_stdin_packs_mode(const struct option *opt, const char *arg,
> > +                                 int unset)
> > +{
> > +       enum stdin_packs_mode *mode = opt->value;
> > +
> > +       if (unset)
> > +               *mode = STDIN_PACKS_MODE_NONE;
> > +       else if (!arg || !*arg)
> > +               *mode = STDIN_PACKS_MODE_STANDARD;
>
> I don't understand why you have both a None mode and a Standard mode,
> especially since the implementation seems to only care about whether
> or not the Follow mode has been set.  Shouldn't these both be setting
> mode to the same value?

I'm not sure I follow your question... stdin_packs is a tri-state. It
can be off, on in standard/legacy mode, or on in follow mode.

> > +test_expect_success 'setup for --stdin-packs=follow' '
> > +       git init stdin-packs--follow &&
> > +       (
> > +               cd stdin-packs--follow &&
> > +
> > +               for c in A B C D
> > +               do
> > +                       test_commit "$c" || return 1
> > +               done &&
> > +
> > +               A="$(echo A | git pack-objects --revs $packdir/pack)" &&
> > +               B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
> > +               C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
> > +               D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
> > +
> > +               git prune-packed
> > +       )
> > +'

Huh, I have no idea how this snuck in. This "setup" test does nothing
and creates a repository that isn't used later on in the script.
Probably leftover from writing these tests in the first place, but I've
removed it.

> I like the tests -- normal --stdin-packs, then --stdin-packs=follow,
> then --stdin-packs=follow + --unpacked.

I think the normal tests are accidental since we use pack-objects to
write packs A, B, C, and D. But the --stdin-packs vs.
--stdin-packs=follow and --stdin-packs=follow + --unpacked was
definitely intentional.

> However, would it be worthwhile to create commit E immediately after
> creating the packs?

Yeah, I think that is a good suggestion. We already have tests that
exercise --stdin-packs with --unpacked earlier in the same script, but
obviously not with --stdin-packs=follow. Moving the creation of commit E
earlier up makes a lot of sense to me, thanks!

Thanks,
Taylor
