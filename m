Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01F020133
	for <e@80x24.org>; Mon,  6 Mar 2017 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbdCFSbV (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 13:31:21 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34720 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbdCFSbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 13:31:18 -0500
Received: by mail-pf0-f178.google.com with SMTP id v190so26848902pfb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujj6m0qx8jYAuAleQzkGljj6Z8vHP2Sg0j+qAqWgoQU=;
        b=LaZ8g4khsvgIsWXQhDo2JXC1nVZhjBARvZXzfRsRzSKTfFYec9mPygJBvardcxb0vf
         99mtNQbpZVEI3qB+w6UX+Tauklt5MTWzoZFDkrsXhnXUzBfkqokIS5+SEoc/GvQaFOPw
         gUEqbZsSMjrbtJmgm7JkIt59PqHML+Rt4Sp6iY4b0NECpF90aJKc+I6+WNbFKsNU0Pd8
         wVCb8+aGJEqNxBXlMGs/DUY/utgwCCrUXCLThHL0PgHqUKavA3rFNYsHHqLlz2Tqlhtk
         0qYj89/KxsyuWApBr5SVP4n+WPqNsewbdY8j/P6qfpgRSSRa9Rt63EjJCDyCa2kX9oMC
         f28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujj6m0qx8jYAuAleQzkGljj6Z8vHP2Sg0j+qAqWgoQU=;
        b=DCE4DF87P96zRvRADygWt0ic512nQtxXmel05IQ5sLGV6JIVnihPYPN9okxgvL365S
         SU0Aw6CdW6icTvxK43JP2ru0qVZ20fy+AssuMQIF0hSPlQiUC1q+WfFugme+EDihnXho
         uyGN4ZTIYT0zLMXvuarRMKUWJ/zgJ06Vcj/2pYcAqTNO9O3CPt/LTYPLWFx7qTvmK8s9
         4qjzolWIAWulUItAwc+nYmYwMIh6H+yl8YK3WoObLbUgUkZnNm+rcZdH/L7eFZ+/jh8S
         v+T/xoRUmO0xD8Y1uaWVSxz03H7S9lMfmsXdm+6XI1NQXjUwO4X6cbuUfpgzOKSnpAob
         Jgiw==
X-Gm-Message-State: AMke39kRCwkDbeWpQqNdtuk26j3tCcQ5sUx1tdJ5o+gnXUz1RjPzrbboh38hqK4EKf6akrY4
X-Received: by 10.99.213.81 with SMTP id v17mr21839419pgi.130.1488824665535;
        Mon, 06 Mar 2017 10:24:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:10a1:c255:c5bd:a65f])
        by smtp.gmail.com with ESMTPSA id a90sm20478701pfg.78.2017.03.06.10.24.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 10:24:24 -0800 (PST)
Date:   Mon, 6 Mar 2017 10:24:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306182423.GB183239@google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06, brian m. carlson wrote:
> On Sat, Mar 04, 2017 at 06:35:38PM -0800, Linus Torvalds wrote:
> > On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > >
> > > This document is still in flux but I thought it best to send it out
> > > early to start getting feedback.
> > 
> > This actually looks very reasonable if you can implement it cleanly
> > enough. In many ways the "convert entirely to a new 256-bit hash" is
> > the cleanest model, and interoperability was at least my personal
> > concern. Maybe your model solves it (devil in the details), in which
> > case I really like it.
> 
> If you think you can do it, I'm all for it.
> 
> > Btw, I do think the particular choice of hash should still be on the
> > table. sha-256 may be the obvious first choice, but there are
> > definitely a few reasons to consider alternatives, especially if it's
> > a complete switch-over like this.
> > 
> > One is large-file behavior - a parallel (or tree) mode could improve
> > on that noticeably. BLAKE2 does have special support for that, for
> > example. And SHA-256 does have known attacks compared to SHA-3-256 or
> > BLAKE2 - whether that is due to age or due to more effort, I can't
> > really judge. But if we're switching away from SHA1 due to known
> > attacks, it does feel like we should be careful.
> 
> I agree with Linus on this.  SHA-256 is the slowest option, and it's the
> one with the most advanced cryptanalysis.  SHA-3-256 is faster on 64-bit
> machines (which, as we've seen on the list, is the overwhelming majority
> of machines using Git), and even BLAKE2b-256 is stronger.
> 
> Doing this all over again in another couple years should also be a
> non-goal.

I agree that when we decide to move to a new algorithm that we should
select one which we plan on using for as long as possible (much longer
than a couple years).  While writing the document we simply used
"sha256" because it was more tangible and easier to reference.

> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204



-- 
Brandon Williams
