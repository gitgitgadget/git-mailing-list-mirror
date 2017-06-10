Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106BC1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdFJIow (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 04:44:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34954 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdFJIoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 04:44:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so9753480pgc.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=O42qknDZ9YEcnU1g+MjEZHu+Oe/Zf3BQd/4K0P+e3jA=;
        b=nkl4rklaS6jSZpqyffUylpC4psFW/H+kcbYy6FKUFWhMFMDbY6Kw6oArIY8bNEBy6G
         c0EhzlKtnEG2OMSztG041pLZnSv9nlefSFA/Uc6/rXQVSVzoY58z1PrA+qRzzp6TmTnT
         Jg4DI8qq5YiZEYyEOCUZ97REa4MDksAh28f3XpWuMT2LnK0e29nAU6pm1Tv4jDY8vS1V
         /3KvMPksDjUZQ5jUgmSDkJATepifYM46e3E7fQ43m3WaZUqK0MvTCeAYu1eUIyN1oA7H
         AjmnD4ia5KzGxhbOulstKVHKkmfLvaJH+HYa7Ilk224k8dTaroCoQUK0L1MfeXSvuTBO
         Re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=O42qknDZ9YEcnU1g+MjEZHu+Oe/Zf3BQd/4K0P+e3jA=;
        b=kmo9APThZXWDMi45T9DNy3RqS+Q3o5FiNjO3kxi6z0/3QtY89AWqqcCkGCCuTrt6YE
         yGrG83jKPYR7syHQtYy9A/eET0vrATse3e/oL2nd1YfSZ1cUTBXU3Miv6mN1pYT4Lqsc
         gQnFZDRcLRd/tcIF360rUG8F6YcSa3ve2kvd4Nrcryox5RLO/CZ0tdnqIsfUeKRGuXUI
         Nsa/cm3g3LQ6HCg5q+HfaI4LfNlOAdxys1ctSf9UdGoPjDgi5mWzZ+gigOx3bLSKGMk7
         Nn/4eY7rTJoqVraCtk8tM0sWlvzFN4W8makMAmoa7kRhjSc1v9fuqaX3lQKZcPJ3PvSk
         7rdQ==
X-Gm-Message-State: AODbwcDXFVv1fx+nzCNdhRn0icch5SyRNE6N5Jmq64Uvnpm4HlnDaEoC
        6tztj2KX+rLdAA==
X-Received: by 10.99.160.82 with SMTP id u18mr27834696pgn.176.1497084271668;
        Sat, 10 Jun 2017 01:44:31 -0700 (PDT)
Received: from unique-pc ([2405:205:800f:e175:94b2:5f2f:a42d:438b])
        by smtp.googlemail.com with ESMTPSA id u45sm11333879pgn.28.2017.06.10.01.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Jun 2017 01:44:31 -0700 (PDT)
Message-ID: <1497084241.8531.2.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Date:   Sat, 10 Jun 2017 14:14:01 +0530
In-Reply-To: <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
         <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-06-10 at 11:23 +0900, Junio C Hamano wrote:
> $ git shortlog -20 --no-merges
> 
> may help learning the preferred style of writing the title.  We do
> not say "[I] did this".  Instead we phrase things in imperative
> mood, giving an order to the codebase to "become like so".  E.g.
This style is a little new to me thus my commit message turned out to
be a repercussion of my own style (which, I guess, targets other
developers who read the log). Will be careful the next time :). Made
the requested changes except for a few doubts they raised (see comments
below).

> And it wasn't just "a little" confusing.
> 
> 	"git status" indicated "Initial commit" when HEAD points at
> 	an unborn branch.  This message is shared with the commit
> 	log template "git commit" prepares for the user when
> 	creating a commit (i.e. "You are about to create the initial
> 	commit"),
I didn't get that, where should I be seeing the line, "You are about to
create the initial commit" in the commit template ? I just saw "Initial
commit" in it.

> Does this break "git commit", or is the update limited to "git
> status"?
This does seem to be breaking 'git commit' as it seems to be using the
output of 'git status'. This change results in the following commit
template for the initial commit,

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
#
# Waiting for initial commit
#
# Changes to be committed:
#       new file:   test-file
#

Looks odd. Not sure how to fix this. Maybe on of the alternatives have
to be considered. "Your current branch does not have any commits" seems
a good one.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
