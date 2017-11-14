Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235251F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 21:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756845AbdKNVLs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 16:11:48 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:44357 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756839AbdKNVLq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 16:11:46 -0500
Received: by mail-ua0-f178.google.com with SMTP id g12so111225uaa.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r2a2tR/ARw97VNQC4m+HKDo27C37N75HSDqx3YGBPto=;
        b=BtS5/XlQ6uDA7z0rfYR/Er4XiOXFNaB8a8+bSIeI+4825ee8FXmxedn+QraZ3n7MR7
         BxsDVmHssxBKKTPT4ikIGvcLz6kgK5lvqBQkzsI6Y9KOKJx/0jPH0UkVGd8jewhtD+/c
         XLU7qwZaBQJ4Mf3Fi6ZLPHUSIZW+BiH2oGi/JLxF33r1hWGyL6w6dlVEJ5NglRYaTmoL
         bI9FM+yyHkQ7O8+e4ByfcNBS7YzheTfP8ttVQLkzUzik3FvoVf1nvJDucN58EabJOCW0
         lzD+GHddyVOspHt4CQI0PSB+uPf4U3UIfNVUvoF3mjZDydSV3K0um5zaYzGwdLurZs5D
         ozBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r2a2tR/ARw97VNQC4m+HKDo27C37N75HSDqx3YGBPto=;
        b=F2K9yMikJh5qaG4FWVuUH/xOgk0eJERcWP6pXKwwp87k28zW7GrTzr4TzTi8o+s6Z5
         Eo/sxDeptjAGolCCTkAspKGWpKMgPzuvajAbVOJD+psk7dB032ZehmrczJPR1X5EQncJ
         g49xni+nnLQbZgWWDM/qx62WG8cTtd8PBJ2BhIEHQuHpgjRVsyFnTm9wYb8ALHuQ8UE4
         g2h3yPEpHtKGK7wfq38B7ukbDSRpyBOVB2K2qd5UR81BKddQZmiZmP8wvLEA2ZAJq9lQ
         v7pSCk6hz2DIPLN6+9l6HE8aVaF+fUfoJdY1FCm2gnC08u9kB5Ll5IDZjgzahLZ8MEpF
         563g==
X-Gm-Message-State: AJaThX756GfZ5FQzU09dPbbVrHW6+BS8NjYftL5teS1UTbM8W347xyFC
        zqTB+n8IhByCmV5jcG/7vomLT+Zec3jFgolH/70=
X-Google-Smtp-Source: AGs4zMZKyAFmJun2whzlshN4zHu0A3CPJAyoPCQENtEbOVx9oRRH2cECdGVHo5cmq3aI2M+d3aw7opDlej12hbNds0w=
X-Received: by 10.176.95.138 with SMTP id b10mr12361493uaj.55.1510693905547;
 Tue, 14 Nov 2017 13:11:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 13:11:44 -0800 (PST)
In-Reply-To: <CAGZ79kaDWxx2g2OMY-VKJZD0-0t7V33644aqPLHq5Hppo_Be+w@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-11-newren@gmail.com>
 <CAGZ79kaDWxx2g2OMY-VKJZD0-0t7V33644aqPLHq5Hppo_Be+w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 13:11:44 -0800
Message-ID: <CABPp-BE7qKiYBNxMquXRv+Gr=sA3jGs8JyKuqNSzAwKbOWOQ=Q@mail.gmail.com>
Subject: Re: [PATCH 10/30] directory rename detection: more involved
 edge/corner testcases
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:

> "In my opinion" ... sounds like commit message?

Sure, I can move it there.


>> +# Testcase 7a, rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file
>> +#   Commit A: z/{b,c}
>> +#   Commit B: y/{b,c}
>> +#   Commit C: w/b, x/c, z/d
>> +#   Expected: y/d, CONFLICT(rename/rename for both z/b and z/c)
>> +#   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.
>
> But the creator of C intended to have z/d, not {w,x}/d, and as {w,x} == y,
> I am not sure I like this result. (I have no concrete counter example, just
> messy logic)

I'm open to alternative interpretations here.  The biggest issue for
me -- going back our discussion at the end of
https://public-inbox.org/git/CABPp-BFKiam6AK-Gg_RzaLuLur-jz0kvv3TqsHNHg5+HTv_uzA@mail.gmail.com/
-- is "simple, predictable rule", which is consistent with the other
rules and limits the number of nasty corner cases as much as possible.
Perhaps you think this is one of those nasty corner cases, and that's
fair, but I think it'd be hard to do much better.

After spending quite a while trying to think of any other alternative
rules or ways of looking at this, I could only come up with two
points:

  1) One could view this as a case where commit C didn't in fact do
any directory rename -- note that directory z/ still exists in that
commit.  Thus, only B did a rename, it renamed z/ -> y/, thus C's z/d
should be moved to y/d.  So, this choice is consistent with the other
rules we've got.

  2) An alternate (or maybe additional?) rule: We could decide that if
a source path is renamed on both sides of history, then we'll just
ignore both renames for consideration of directory rename detection.

The new rule idea would "fix" this testcase to your liking, although
now we'd be somewhat inconsistent with the "directory still exists
implies no directory rename occurred rule".  But what other weirdness
could entail?  Here's a few I've thought of:

Commit O: z/{b,c,d}
Commit A: y/{b,c}
Commit B: z/{newb, newc, e}

Here, A renamed z/ -> y/.  Except B renamed z/b and z/c differently,
so all paths used to detect the z/ -> y/ rename are ignored, so there
isn't a rename after all.  I'm not so sure I like that decision.
Let's keep looking though, and change it up a bit more:

Commit O: z/{b,c,d}
Commit A: y/{b,c}, x/d
Commit B: z/{newb, newc, d, e}

Here, A has a split rename.  Since B renames z/b and z/c differently,
we have to ignore the z/ -> y/ rename, and thus the only rename left
implies z/ -> x/.  Thus we'd end up with z/e getting moved into x/e.
Seems weird to me, and less likely that a user would understand this
rule than the "majority wins" one.


>> +# Testcase 7c, rename/rename(1to...2or3); transitive rename may add complexity
>> +#   (Related to testcases 3b and 5c)
>> +#   Commit A: z/{b,c}, x/d
>> +#   Commit B: y/{b,c}, w/d
>> +#   Commit C: z/{b,c,d}
>> +#   Expected: y/{b,c}, CONFLICT(x/d -> w/d vs. y/d)
>
> CONFLICT(x/d -> y/d vs w/d) ?

I'm afraid I'm not following the question.

>
>> +#   NOTE: z/ was renamed to y/ so we do not want to report
>> +#         either CONFLICT(x/d -> w/d vs. z/d)
>> +#         or CONFLiCT x/d -> w/d vs. y/d vs. z/d)
>
> "neither ... nor" instead of "not either or"?

Yes, thanks.

>> +# Testcase 7e, transitive rename in rename/delete AND dirs in the way
>> +#   (Very similar to 'both rename source and destination involved in D/F conflict' from t6022-merge-rename.sh)
>> +#   (Also related to testcases 9c and 9d)
>> +#   Commit A: z/{b,c},     x/d_1
>> +#   Commit B: y/{b,c,d/g}, x/d/f
>> +#   Commit C: z/{b,c,d_1}
>> +#   Expected: rename/delete(x/d_1->y/d_1 vs. None) + D/F conflict on y/d
>> +#             y/{b,c,d/g}, y/d_1~C^0, x/d/f
>> +#   NOTE: x/d/f may be slightly confusing here.  x/d_1 -> z/d_1 implies
>> +#         there is a directory rename from x/ -> z/, performed by commit C.
>> +#         However, on the side of commit B, it renamed z/ -> y/, thus
>> +#         making a rename from x/ -> z/ when it was getting rid of z/ seems
>> +#         non-sensical.  Further, putting x/d/f into y/d/f also doesn't
>> +#         make a lot of sense because commit B did the renaming of z to y
>> +#         and it created x/d/f, and it clearly made these things separate,
>> +#         so it doesn't make much sense to push these together.
>
> This is confusing.

Indeed it is.  When I first wrote this testcase, I didn't realize that
I actually had two potentially directory renames involved and a
doubly-transitive rename from it, on top of the D/F conflict.  I can
see two ways to resolve this.

1) Leave the testcase alone, just try to make the NOTE more clear:

NOTE: The main path of interest here is d_1 and where it ends up, but
this is actually a case that has two potential directory renames
involved and D/F conflict(s), so it makes sense to walk through each
step.  Commit B renames z/ -> y/.  Thus everything that C adds to z/
should be instead moved to y/.  This gives us the D/F conflict on y/d
because x/d_1 -> z/d_1 -> y/d_1 conflicts with y/d/g.  Further, commit
C renames x/ -> z/, thus everything B adds to x/ should instead be
moved to z/...BUT we removed z/ and renamed it to y/, so maybe
everything should move not from x/ to z/, but from x/ to z/ to y/.
Doing so might make sense from the logic so far, but note that commit
B had both an x/ and a y/; it did the renaming of z/ to y/ and created
x/d/f and it clearly made these things separate, so it doesn't make
much sense to push these together.  Doing so is what I'd call a doubly
transitive rename; see testcases 9c and 9d for further discussion of
this issue and how it's resolved.

2) Modify the testcase so it doesn't have two potential directory
renames involved.  Just add another unrelated file under x/ that
doesn't change on either side, thus removing the x/ -> z/ rename from
the mix.  That wouldn't actually change the expected result (other
than the new file should remain around), but it would change the
reasoning and simplify it:

NOTE: Commit B renames z/ -> y/.  Thus everything that C adds to z/
should be instead moved to y/.  This gives us the D/F conflict on y/d
because x/d_1 -> z/d_1 -> y/d_1 conflicts with y/d/g.  As a side note,
one could imagine an alternative implementation trying to resolve D/F
conflicts caused by renames by just undoing the rename, but in this
case that would end up with us needing to write an x/d_1, which would
still be a D/F conflict with x/d/f.
