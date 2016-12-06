Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3A81FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbcLFSjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:39:37 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33754 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbcLFSjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:39:37 -0500
Received: by mail-io0-f196.google.com with SMTP id j92so8624607ioi.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XtitExXM8Y2n01wElbVJIvsithEQwxjMZIX3X61sC4g=;
        b=oa/xMC0KN7y2cghsMGJwO21h28nw97EaQtpG+UMMWiRH9NALutpEHra8sT6BcsPt+f
         3gTEzmucUtbIYobB3h9bN8BF+HHdWueD26Gq1tBR7agRdcQQ3wtXZj4QoBI8qtUDV/h1
         4xouOOv8XwcwdZdPVyjUBxVznZDA2SkQ4xDBRzzZhJnjLqnfvQ7zGbN6eRki3ScXzNnT
         Odm3GKnBTGsOiQmQr8f7STfIU5mAKpvlkdc6Jaylwm+RZmCjfbyJHkx6RGNeLHkryrBd
         MBaY5pNTwCJY1t56sWpL2nN0WnmHK7E8aof38A4hV7ltocQZz0fiPwcyiy2umcGiz7Oh
         ODxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XtitExXM8Y2n01wElbVJIvsithEQwxjMZIX3X61sC4g=;
        b=ceABOa6Mcpxy6i84cwsLmauo1JVDK7nFKBTWLQNMU1K7T0IGb4vBWD4T6FxULe5VAz
         ytOn8QsN986udQMSZGBqas14WcSYyvGmxpkq1pPM1gmW2UEKFVkfJJHioZdklX8GSwx0
         OnQ1cizA4hHqt18st71oK9Igw0zruWW//8G43+sleTJvdLXPC+BjqazDjtb0UWWBd/99
         UmNJpLxtpWkKvnH6nk+mEy5PogVHIHn5MfAp9SN7nwjg8Z6Ds+NQmqL6XWK0iI/AdrO9
         3+Y1wKyzXncP8e5t98L2zHTBBxm3iWwbS6PmIJ0OYL5TzSqlsTqXPKB46GT0QJl+G6nJ
         Zdzg==
X-Gm-Message-State: AKaTC02ABE+Ie5R4ysxYItqoPafGNdePddLC0gouKLOoM85IG0btuPkHCl9SstnluSX/9IPJdu0h5mlS3LRGoQ==
X-Received: by 10.36.70.21 with SMTP id j21mr7162itb.60.1481049576162; Tue, 06
 Dec 2016 10:39:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 10:39:35 -0800 (PST)
In-Reply-To: <b78a4cbf-86ed-938e-1d41-6c48e0df981e@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1adb-ab4c90ed-d084-40b5-a037-f62c76e52ec4-000000@eu-west-1.amazonses.com>
 <b78a4cbf-86ed-938e-1d41-6c48e0df981e@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 00:09:35 +0530
Message-ID: <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
Subject: Re: [PATCH v15 11/27] bisect--helper: `bisect_next_check` &
 bisect_voc shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

Sorry for the late replies. My end semester exams just got over.

On Fri, Nov 18, 2016 at 2:29 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> Hi Pranit,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> > Also reimplement `bisect_voc` shell function in C and call it from
> > `bisect_next_check` implementation in C.
>
> Please don't! ;D
>
> > +static char *bisect_voc(char *revision_type)
> > +{
> > +     if (!strcmp(revision_type, "bad"))
> > +             return "bad|new";
> > +     if (!strcmp(revision_type, "good"))
> > +             return "good|old";
> > +
> > +     return NULL;
> > +}
>
> Why not simply use something like this:
>
> static const char *voc[] = {
>         "bad|new",
>         "good|old",
> };
>
> Then...

This probably seems a good idea.

> > +static int bisect_next_check(const struct bisect_terms *terms,
> > +                          const char *current_term)
> > +{
> > +     int missing_good = 1, missing_bad = 1, retval = 0;
> > +     char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
> > +     char *good_glob = xstrfmt("%s-*", terms->term_good);
> > +     char *bad_syn, *good_syn;
>
> ...you don't need bad_syn and good_syn...
>
> > +     bad_syn = xstrdup(bisect_voc("bad"));
> > +     good_syn = xstrdup(bisect_voc("good"));
>
> ...and hence not these two lines...
>
> > +     if (!is_empty_or_missing_file(git_path_bisect_start())) {
> > +             error(_("You need to give me at least one %s and "
> > +                     "%s revision. You can use \"git bisect %s\" "
> > +                     "and \"git bisect %s\" for that. \n"),
> > +                     bad_syn, good_syn, bad_syn, good_syn);
>
> ...and write
>                         voc[0], voc[1], voc[0], voc[1]);
> instead...
>
> > +             retval = -1;
> > +             goto finish;
> > +     }
> > +     else {
> > +             error(_("You need to start by \"git bisect start\". You "
> > +                     "then need to give me at least one %s and %s "
> > +                     "revision. You can use \"git bisect %s\" and "
> > +                     "\"git bisect %s\" for that.\n"),
> > +                     good_syn, bad_syn, bad_syn, good_syn);
>
> ...and here
>                         voc[1], voc[0], voc[0], voc[1]);
> ...
>
> > +             retval = -1;
> > +             goto finish;
> > +     }
> > +     goto finish;
> > +finish:
> > +     if (!bad_ref)
> > +             free(bad_ref);
> > +     if (!good_glob)
> > +             free(good_glob);
> > +     if (!bad_syn)
> > +             free(bad_syn);
> > +     if (!good_syn)
> > +             free(good_syn);
>
> ...and you can remove the 4 lines above.
>
> > +     return retval;
> > +}
>
> Besides that, there are again some things that I've already mentioned
> and that can be applied here, too, for example, not capitalizing
> TERM_GOOD and TERM_BAD, the goto fail simplification, the terms memory leak.

Your suggestion simplifies things, I will use that.

Regards,
Pranit Bauva
