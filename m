Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154ECC7D626
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5321B247E5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfLMR54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:57:56 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37886 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfLMR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:57:55 -0500
Received: by mail-il1-f196.google.com with SMTP id h15so140959ile.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1VkL4itQht0ZGaHRRFS7UR3Dv0SMQ2QxCIN+r4yVCo=;
        b=SPZQ3STTYPPyQ21Jf4Kj9T5d62MB/I9rmsRAwsVSiZMhsQhl8poiNZ0N1J+NaxckUi
         I7yvXZe8HavGT3MWlyi609Kt6rbnSUVaNb8DZ9DErAAtQt0zsaSXXPoDWVm27sZbIItw
         O1EeJR7UkapgoA83JRjvESJNjCzTr2Uqa2ld/sIkX6X8+TO4q/QXkA1RXhi+tMYOHnQY
         bdv4yVED+8470nIOroFQBDHRRUHC/9S4RNj7TNsoACvj5MVnTcRWOwGyo9a87NOxWH2b
         wgKMzwuDAaIVIrs2lOR3d5mH9h1KB3YLEm7uEKub4YLJz3gXENLFXbdw+LAUMStx0+xw
         HEPw==
X-Gm-Message-State: APjAAAVrlv/YUHntnu5bfX0rmjJE4H7WlacVGlcVbZ1Jytm4Xl9DszJx
        dZUUxIZKUwvnP9wXMpHoN8QNnNGBfYWDDTZuPmE=
X-Google-Smtp-Source: APXvYqyVALvDPQRH0JE9u0KoTWKd2HYJH2GzjUB3imsK3JO9y2/BY0+GK0ZKI0URQsJ3ylSoAr3WTbaSEKGn49GwIGs=
X-Received: by 2002:a92:cbd2:: with SMTP id s18mr536355ilq.98.1576259875154;
 Fri, 13 Dec 2019 09:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20191213173902.71541-1-emaste@FreeBSD.org> <20191213174542.GB117158@coredump.intra.peff.net>
In-Reply-To: <20191213174542.GB117158@coredump.intra.peff.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 13 Dec 2019 09:11:30 -0500
Message-ID: <CAPyFy2DfhVwEFen2G4oOdQS2uo_L=V5gyrpPWUB0uRxNSnWcuQ@mail.gmail.com>
Subject: Re: [PATCH] userdiff: remove empty subexpression from elixir regex
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, lukasz@niemier.pl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Dec 2019 at 12:45, Jeff King <peff@peff.net> wrote:
>
> And that is the right thing, since these strings are the funcname and
> word_regex patterns, respectively.
>
> So I think this is the correct fix. Many of the other regexes in this
> list use "/* -- */" to seperate the two for readability. Maybe worth
> doing here, too?

Yeah, this elixir set seems to be the only one with comments on the
individual subexpressions in the second set but the extra /* -- */
does make it a bit more clear. Patch v2 sent.
