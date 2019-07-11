Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1AE61F461
	for <e@80x24.org>; Thu, 11 Jul 2019 20:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfGKUFB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 16:05:01 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:43055 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGKUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:00 -0400
Received: by mail-vs1-f52.google.com with SMTP id j26so5121340vsn.10
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBJD9w1AgPHC6dd4gOvFE4DWboNGOKHvm8Ar14eZKws=;
        b=sMJVgK6ielIxCigXKD52eMa0Ynp3HgpXWCv44We/uY70LmAo42cRw7eaO04RS8xYvq
         F8REuyg0wEWo/b3+KuwmfxHzDM0HbomTQOGT4v4ch7RmX+91sCojK8+uL43jbUCSMz0G
         NV8qvbTpiiPXg28Rnr24Spn9nn8lBvW34la9k7RiE/siwqrImTF6PhBvaLuqXPENcXpy
         g64alEKrOOVlm9zY0+jY/Q9gDXbmBCVAg4h6gb1E1FB/7ySQ9jaJPCpMpRYPk60Ojnm4
         +BdgqJMj9HVdQ/Qa4mCR1QW4IL9THvTjibkvmp8LWItP7OdR1KnLVC1OOHr1hAWFFYgg
         iIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBJD9w1AgPHC6dd4gOvFE4DWboNGOKHvm8Ar14eZKws=;
        b=mzRqXxjAS9ydqHumq0scP0JSuWPNpFKQtciE/JidXiUXQ0e7AxkjVJMAus6VW+aAGZ
         cHk3WwWFzoehPzADEXLUBiJj3BDrq0/XqqZjPKaqrutWVMGAd4TZ/J4/3+gwf23ZliZE
         4oHII5293HbTAlBsc+9MQayWuO1kOX5oQV42tV47GEonfuGFKRgNblKf3T5guLrqwT+z
         qDIWAC5U36+Lc6EwArFvQr3+pb8HWKbY04choxBWbEkR9LZSUVQfswFvDQn8UPW+QjUO
         cBxCgA1cEIGCt6jD4jqE/43utU5ZPYCl0RHNoj5CrGdSLnpeg2F51LrCmIYZGSCTVRuY
         tMTA==
X-Gm-Message-State: APjAAAXYFEtvrcH3BNKTtNlqGVfWl02DTureB319XnLZJhzpRADEAzUx
        4FHksWMFZ3/+1dd4cLwOBpPATye9muxKc6IRHFI=
X-Google-Smtp-Source: APXvYqzno0zbU6m81IbtBrs5uwo8uLgzyFGcwlUewP6KwPEw2EdcbqdHecyoo3uIWmAHrBtj3QyT3+jWYGFZkUfWdCE=
X-Received: by 2002:a67:c419:: with SMTP id c25mr6332874vsk.136.1562875499498;
 Thu, 11 Jul 2019 13:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
 <CABPp-BFr5TLNnjFxj_YRmt=z17U=ehxz1WjhqxDCA0aNf6v6JQ@mail.gmail.com> <CY4PR2201MB1559CC4E242F3689124D99AF9AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
In-Reply-To: <CY4PR2201MB1559CC4E242F3689124D99AF9AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Jul 2019 13:04:48 -0700
Message-ID: <CABPp-BFYYP4RjgxPqvJjfctCZq347dWi=Vy6S2W3R2mQ2Ks7_g@mail.gmail.com>
Subject: Re: EXTERNAL: Re: List of Known Issues for a particular release
To:     "Mark T. Ortell" <mtortell@ra.rockwell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Thu, Jul 11, 2019 at 12:02 PM Mark T. Ortell
<mtortell@ra.rockwell.com> wrote:
>
> Elijah,
>
> Thanks for the response. I am not clear whether the test_expect_failure m=
eans that the test is trying to do something that should fail and so it is =
a valid test case or if it is a test case that is failing, but should succe=
ed and has only been temporarily disabled until it is fixed. I'm guessing t=
he former. In this case, if it successfully did whatever it were testing, t=
hat would be an issue. A simple example of this would be a test to try to l=
ogin with an invalid username and password. That is expected to fail and if=
 it passed, it would be an issue. If this is the case, then it doesn't look=
 like it provides a list of issues. Please clarify what the test_expect_fai=
lure indicates.

Please don't top-post on this list.

test_expect_failure (as well as other helper functions in the test
harness library, such as test_expect_success, test_must_fail,
test_might_fail, etc.) are explained in t/README.  By its definition,
it technically satisfies "list of known issues" as you asked for.
However, most software products that publish a list of known issues
has probably curated problems that users are likely to see or be
curious about, and which they want to inform users of both to reduce
support load and help users avoid problems.

This list is not curated in any such way.  It's just a list of issues
developers thought to document for themselves and/or other developers.
It is thus way different than what you might want:

(1) There is evidence that some have used it for "In an ideal world,
this thing should support this feature too in which case I'd expect it
to behave a certain way that it doesn't yet."  The line between
feature (what works is fine but we could make it better) and bug (it's
not really correct if it doesn't do it this way) gets really blurry at
times, and you'd pick a much different tradeoff in communication
between developers than you would in communication from developers to
users; with other developers you spend a lot more time talking about
internals and goals and direction we'd like to move the software in.

(2) Also, some of these "known breakages" could be in corner cases
that are very unlikely to be hit be users, and perhaps not only likely
to be hit by individual users, but unlikely that anyone anywhere will
ever hit that error (some of the merge recursive tests I added might
fall into that category).

(3) There may also be cases where someone once thought that optimal
behavior would be a little different and that they were planning to
implement more features, and then later changed their mind but forgot
to clean up the testcases.

(4) ...and that's just a few off the top of my head.  I'm sure the
list has several other things that make it not quite match what you
want.

As such, Brian's answer to your question elsewhere in this thread is
probably better than mine, but if by chance you are just being forced
to go through a box checking exercise and there's no reason for
needing these results other than that someone asked that they be
provided (I sometimes had to go through such exercises when I worked
at Sandia National Labs years ago), then technically the command I
gave you could be used to satisfy it.

> Below is the output from the provided command:
<snip>

Not sure why you included this.

> Regards,
> Mark


Best Wishes,
Elijah
