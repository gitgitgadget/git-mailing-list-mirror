Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B60A20133
	for <e@80x24.org>; Sat,  4 Mar 2017 04:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdCDEof (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 23:44:35 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36533 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdCDEoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 23:44:34 -0500
Received: by mail-qk0-f170.google.com with SMTP id 1so88135532qkl.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 20:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=O0AX7et7VA/udu0E7L/heCwnH5L38P+ADbcl+wowY0c=;
        b=FA6c6tQenl+4ITosO9oQGeEcRJRkxSCp5vVhFAhNOusETaY2BjmEdMLfqMrOjdFJUL
         XcC/5q/92sOW4Y6mW0+uaadtTvr1wJ17Vdw8rMG03XHOdXyW0272bXc6BIpGv5TdNrUb
         4v+IJV9O420Yvsc5XH8FZUt06gkgy/HX7kufz5NxPUU/LXwonXFEqT+eRzMPX57YUIIR
         5UPW9yT3fKtwNXcwtYUbdi3GSm+6uCiA0gGzZulBlTypzlG9j3oC1TZ6uZi7A8wGVKCM
         OXlWJUC3B5VdJcGkYLsueDH9ynm0JhbchTXu2tJe3e4DWj8/qtYNxYVdojikRjcvTx9u
         NIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=O0AX7et7VA/udu0E7L/heCwnH5L38P+ADbcl+wowY0c=;
        b=OTxpDkTwsBOtPZz2Uksran/Tn5ETC7wzJda5su86DhHkAGzeRxCTFnaYVr4E7FR+hF
         cup60+S4rznm8GhziJnJf0mlcC9tQfw+lgL7Bm0d1xscJUh6O3l92OpuDcEZYsYhTQ1T
         Xn8AIOFElkTVv0bfFTnbMtWWbAmku+6qCc0baEYneG1E7kX0/gVDPwrzCz4ruSI6cmcA
         MeCHWBMJWlUWZRbjVZv4aW3LvhzIlREZkVE7ET53EIQmjY50ORQDrz7kEHCLBBR7CiVw
         zZr5Y9cAgAoXQPhRUQ5gq4U6FENVIh6YRxZMpE4StqutcyprUskav/sAaV7VDmRbgGG/
         kXVA==
X-Gm-Message-State: AMke39lc5fbjnCf2eSNhXNeAyXqwRgFTLH/8+iaeoGKg+/HGaaMq/mVupy6eCWIw6iIWYOzCJ+x7YDpFkPDuZA==
X-Received: by 10.233.232.21 with SMTP id a21mr6347245qkg.180.1488600692861;
 Fri, 03 Mar 2017 20:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Fri, 3 Mar 2017 20:11:12 -0800 (PST)
In-Reply-To: <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox>
 <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com> <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox> <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 3 Mar 2017 20:11:12 -0800
X-Google-Sender-Auth: OUW0naAe0KZrULkmBihxk8TyytE
Message-ID: <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 4:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I only recently started looking at Travis logs, so I cannot tell if
> it is just a usual flake (e.g. some builds a few days ago seems to
> have failed due to not being able to check out the tree being
> tested, which I do not think is our fault) that we shouldn't worry
> about, or if it is a sign of a real problem.

Tonight's pushout also seems to stall the same way. Dscho's
unversioned one didn't exhibit the problem?
https://travis-ci.org/git/git/jobs/206811396

> Unrelated to linux-32, the same build has hard failure with Apple
> clang in t0021 with the rot13-filter.pl thing, by the way.

This one may be a Heisenbug which may indicate some raciness in the
clean/smudge filter protocol.
The latest build of 'pu' https://travis-ci.org/git/git/jobs/207550171 seems to
have passed OK.
