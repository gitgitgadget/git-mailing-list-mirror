From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t6302: simplify non-gpg cases
Date: Mon, 9 May 2016 13:47:35 -0400
Message-ID: <CAPig+cQPbwM0+6yruK0VKKq2ujFLoCLogS7eQNN7WWgRjG5V0w@mail.gmail.com>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
	<20160509160725.GA11861@sigill.intra.peff.net>
	<CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
	<20160509164859.GA8231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 19:48:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpHR-0007fB-1t
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcEIRrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:47:36 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34248 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcEIRrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:47:36 -0400
Received: by mail-ig0-f196.google.com with SMTP id kj7so11896308igb.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=3HG7rifq6f+ELFKeuSgSOPs7bZBGtBMq1QXq9Z+0ggU=;
        b=XrZx/EldTSNYMY3qTKkmmiT1n7Mm9p8XcG4yCyeoiOOPjPDHMxDgKcnNCmRgOi5fub
         MXgMlPG+V9iRA2YdZWKPSF80GXLP6y+AkpFlEi6GAW45NgO1jsAAunlLeG+wKD28Vonf
         tHOzPFt2oAqOYwEf9TJY+uBY4r1ruHl+/hdIXko/NN3VGGtzwlw3bCmpVaWCsa8V2yGV
         AyDNPUlYs2c1apRxINJp9W68cRsmQf/cXpKt5EdQG1DTmFxewAmP+jYySOdilb1ccw5+
         q0xe6bIW8G7Pi7IyDMExqdk6p8NS+fe5rxUO56+kJCQy2Tx0lyGeGuKrVxym7LA25cs/
         +cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3HG7rifq6f+ELFKeuSgSOPs7bZBGtBMq1QXq9Z+0ggU=;
        b=NGYlZU5udO97Vy2hz2xFOHZzvH6OHA98FI02c/K2zk4Ai+5v+4WaoRbphdcbNbUal4
         ElyQGKfujBWV9YyY6EfDu+2Xte28Id5P+SaYOMP8b9dmKt/r6XBP+Ras0Qc74LNyiBIy
         pTvwLZ0fr1QXpuJghzwVxY8CeORuA89GcfP7HeBJGvnSlnI6Q61O/iXbDNMXRVdadNpr
         0QFKMhLrFbbUU5aWQ5xlC9WU3IawmVOzgECPcY3NcIHHNJVVPaQDNqiF3MA2v8FbbCL5
         aJZxUEqKtLoKXH2HEkvwrGPPvMLh2KBwmhldw/wjOU9aUcckMgE0ZzJhBpmtuKGL0bV3
         jU/A==
X-Gm-Message-State: AOPr4FXRuUZ1j7Vz/aY95VZboAsiNTngFsu0ZG2T8uxgB5zpL0PJ3MWxOCVS7R8wRHaX7spw7ZkHYQGs3QEiLg==
X-Received: by 10.50.205.42 with SMTP id ld10mr12517096igc.17.1462816055075;
 Mon, 09 May 2016 10:47:35 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 10:47:35 -0700 (PDT)
In-Reply-To: <20160509164859.GA8231@sigill.intra.peff.net>
X-Google-Sender-Auth: 3ki0YE2nftY5xBu2-I2KkwZ73t0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294028>

On Mon, May 9, 2016 at 12:49 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2016 at 12:30:43PM -0400, Eric Sunshine wrote:
> Since you as the author of 618310a seem to agree with this direction,
> here it is as a real patch.

Thanks for working on this.

> Subject: [PATCH] t6302: simplify non-gpg cases
>
> When commit 618310a taught t6302 to run without the GPG

618310a (t6302: skip only signed tags rather than all tests when GPG
is missing, 2016-03-06)

> prerequisite, it did so by conditionally creating the signed
> tags only when gpg is available. As a result, further tests
> need to take this into account, which they can do with the
> test_prepare_expect helper. This is a minor hassle, though,
> as the helper cannot easily cover all cases (it just matches
> "signed" in the output, so all output must include the
> actual refname).

Should we cite bc9acea (ref-filter: implement %(if), %(then), and
%(else) atoms, 2016-04-25) here as an example of a commit for which
this was problematic (and which indeed broke the tests when GPG is
unavailable)?

> Instead, let's take a different approach. We'll always
> create the tags, and only conditionally sign them. This does
> mean our tag-names are a minor lie, but it lets the tests
> which do not care about signing easily behave the same in
> all settings. We'll include a comment to document our lie
> and avoid confusing further test-writers.
>
> Signed-off-by: Jeff King <peff@peff.net>

Looks good. With or without the minor change below, this patch is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>  test_expect_success 'check signed tags with --points-at' '
> -       test_prepare_expect <<-\EOF | sed -e "s/Z$//" >expect &&
> +       cat <<-\EOF | sed -e "s/Z$//" >expect &&

To make this as close to a reversion as possible, this could be
restored to the original (sans 'cat'):

    sed -e "s/Z$//" >expect <<-\EOF &&

>         refs/heads/side Z
>         refs/tags/annotated-tag four
>         refs/tags/four Z
