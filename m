Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B2EC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E576104F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhHLRnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:43:45 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:44031 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236596AbhHLRnp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Aug 2021 13:43:45 -0400
Received: from [100.112.3.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id BD/C8-03042-7BD55116; Thu, 12 Aug 2021 17:43:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRWlGSWpSXmKPExsVyMfT2Md3tsaK
  JBmc38lh0XelmcmD0+LxJLoAxijUzLym/IoE1Y9Obd4wFO3gq7ky5y9TAuJari5GLQ0hgPaPE
  wl83WUAcFoHZzBLLD05lAnEkBH6wSDyfvpMdwrnCKHFjayNbFyMnkFMr0bt4MhOEXSRx6M1WR
  gi7TOJk+3RmEJtXQFDi5MwnLCA2m4CRxMXdk9lBbBYBVYlPDVeA5nAA1QRILNppABIWFvCQ2D
  zvN1iriIC4xNvjM8HKmQU0JVq3/2afwMg3C8nUWUhSCxiZVjGaJRVlpmeU5CZm5ugaGhjoGho
  a6RrrGhkY6yVW6SbplRbrpiYWl+ga6iWWF+sVV+Ym56To5aWWbGIEBl1KAfPpHYxL33zQO8Qo
  ycGkJMq74axIohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3uM7gXKCRanpqRVpmTnACIBJS3DwK
  InwygSJJgrxFhck5hZnpkOkTjEacyzZOG8RM0fHr0WLmIVY8vLzUqXEeX8YApUKgJRmlObBDY
  JF5iVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwhMUBTeDLzSuD2vQI6hQnolHXWYKeUJCK
  kpBqY9EvysjuS31y9vcyELb+24mtC+7bQxedqva85ZD3Sa/PwcHFK8P5oppXwtm3G1gth/ssC
  dl9413LHkeuOqrQ18/yCGeresltYtt46eihkrXLpGrb+6a9N9yy2vLdCdVnuV7/YnFnrvwbOz
  c2epnBaQISlrT7ow83ivzMMv1/P1bvu9tIjR2D5DY9nFvdcBWr6rk2vdJUu9H/j2l94+i7b1R
  Uz3uxbYf1Rnd36/dQDl9XfXv1ntkmw/s69DK9lp3NOvNWPOHi4bgXPtky+F0tiqpI+82UwSZu
  4lrbPztvHcnQNy+Tv8kUeDk3nVgi0TJXkNO54nm7xmuPBwgn1iu2lx4TP9LaIus9p2Bh+7sN8
  JZbijERDLeai4kQApGZbj0cDAAA=
X-Env-Sender: ppokorny@penguincomputing.com
X-Msg-Ref: server-25.tower-392.messagelabs.com!1628790198!87715!1
X-Originating-IP: [209.85.219.198]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18418 invoked from network); 12 Aug 2021 17:43:19 -0000
Received: from mail-yb1-f198.google.com (HELO mail-yb1-f198.google.com) (209.85.219.198)
  by server-25.tower-392.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Aug 2021 17:43:19 -0000
Received: by mail-yb1-f198.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso6712455ybb.14
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguincomputing.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=RmOyX/rye79sfc1iFQ8VnxIfFTkh6h8xLnDALogSKMU=;
        b=jf69kbw3//0BTI/asqLiu6DJ1pZ2F8Q7gnHzOl7K2Nv/m9zS+8k5zPKAd7f3aUDs0T
         Y35+Gmp8zeJsTpXmMvRgVa3lvNfqlRFciMxWFI+DLnvKXYtv+6lO5Pz/hhnjfGoEgFds
         l4wABUOIk9H4uaR8pLA8qv3DTi8SYSVvckCpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RmOyX/rye79sfc1iFQ8VnxIfFTkh6h8xLnDALogSKMU=;
        b=UkgMb5HDGsEjp/2iP0UXMSCbI9ylu/HWPTiVbNpNdPg9p/Gvtj2wqEAmPUIy+j7WNd
         iK6zi/yqrXHmQpansCJho782xgAUHiMXB2x4aoJwUdM/2Dw8av+eK22y58IPNX5FpN0U
         oY2YwN0+kUz7D+B0InDMfft4YF112S3pGESjMMpaAsyZ2xI0N3+AxDH33pe5lUus0AQE
         Y+WpQKIhKqVtKnCMX4Eh/X0AUuCE0qvFEfgmbzGWs8bgeAw+c02PJBtTzsS8jFFd3gQt
         SvIv253lxS/jQgpXNh7wQHqgsOUsIMzZcBFifGDObe4/c51lI+XLcTW/oKUgT+r/JZIh
         ua2w==
X-Gm-Message-State: AOAM530eZwHnN0lCGd+E2DpgD7HyXmc6tKOskD5v09jgEo+GVHNNrrDP
        GtKPuSJqc/obNjgQrDztdBidcNetaHx5/laNz6bROZR6zz7Z27spvqEJiLPe5JqaCtsPSLmPRD9
        EtDQTMZymBYh70+4rAb+C+1qzFyj/UA8TaXoeF1KgXLP09u7hknUpkw==
X-Received: by 2002:a25:7bc6:: with SMTP id w189mr6038417ybc.160.1628790198381;
        Thu, 12 Aug 2021 10:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz22bQPWMXjxKvF4uUda4tC4HeHikZOBMA/o28TLsGZ/VPoaz3f3Xk3z6GgP1HFNMxhx7gjXNV+sO5iCFZGIZ8=
X-Received: by 2002:a25:7bc6:: with SMTP id w189mr6038381ybc.160.1628790198025;
 Thu, 12 Aug 2021 10:43:18 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Pokorny <ppokorny@penguincomputing.com>
Date:   Thu, 12 Aug 2021 10:43:07 -0700
Message-ID: <CAAek22FLBGWAM_MJmUag7YgfGCXLd58pruwLm2AsqMtohdmBLA@mail.gmail.com>
Subject: Problem with git format-patch and --src-prefix and --dst-prefix
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to use git format-patch -> git am to port commits between
two repositories

In the source repository, the files are in the root directory of the
repository (./file) In the destination repository, the files are in a
sub-directory (./dir/file).

The --src-prefix and --dst-prefix seem to be the perfect tool for the
job of getting the patch stream output by format-patch to have the
right format to apply in the destination repository.

Like so:

git format-patch -N -p --src-prefix=a/dir/ --dst-prefix=/b/dir/ -o ../xfer.1

and then in the destination.

git am ../xfer.1

But in the resulting diff's in addition to the requested prefix
changes, there were also
'deleted file mode 100644' lines added.

It's subtle, but I now realize this was because of a typo (vs my
intent) in the above command. The --dst-prefix starts with a slash "/"
not "b/dir/" as I intended.

So I think I stumbled into a problem with the builtin_diff code here:
https://git.kernel.org/pub/scm/git/git.git/tree/diff.c?id=eab9a40b6dd5c1c571b1deb264133db47bb4794d#n1216

It uses the short-hand of testing just the first character of  lbl[0]
and lbl[1] to decide if the source is /dev/null or the destination is
/dev/null to print "new file" or "deleted file" lines.  But with
src-prefix and dst-prefix, those lines could be triggered incorrectly
with a prefix that begins with / which might have a legitimate reason
for others to do.

I'm new to git development, but I'm willing to try and work up a patch
if this is a valid issue and someone can help guide me through the
submission process.

Thanks,
Phil P.
