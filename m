Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F902021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759751AbcKCSIW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:08:22 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36850 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759760AbcKCSIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:08:21 -0400
Received: by mail-pf0-f177.google.com with SMTP id 189so35580505pfz.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIn6lN+WcOVJkQhMtieUB0UATdX6fyFSxR0OjC83T1E=;
        b=TmkDR1tZYr/zre26QN4TPvo7bnMOv/aNgA848e9muSisf7bTiAO17agAWXPAhMYO4f
         j41zknYmKZwlUz/YCTaRtyuFMhCviK4GAQEK7Qz8BLSmeZ1/8w4fZ5OHrb82YLMt7rtI
         2f/G/Vd+8VxJQhx1r1Q4ufG4PpGW2ihv2EeRZ3p/5uJZAtNQEB6AsmDOdVsLid95AXYv
         gr5tUUrCZehaxcV5BORBbkR4yee0GLg5cxEeybM2V1/0D0hQH8hobTZZ7OJCtQs2Dwi+
         WRdu6FX0d3I0QIhlKnm6K/JyVwns3P2fRqQSODH7GmAH5AuInibQGRn+6ZG2zhwX3NSl
         pqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIn6lN+WcOVJkQhMtieUB0UATdX6fyFSxR0OjC83T1E=;
        b=lCgxAz8Fz0R4DzjXj/EiCIb46QRN78vEWr2hhx6J85Jwj7JIRWsFdDJdUU0wGrGRYC
         gwX7yNYQHpDrsKHQWt3VEMBXhk5eE8Ab0sE6qjPJ/EajJZE0chZnAkIQeSe4h24vDOqr
         YVNjGEPZq+t7VsJjW28tbkETI61fD1m+A9rwjLQvo9+9pWs3YZ5vEOiIRjaSPFuKCVRR
         wIKUXINJIJCsAQG8vhoAC24auFmbY2JLeCUMsmxYdKCgKX8ePpICyjXpm1RvWLPvOU+c
         Tm4zW0bTGUWCSQr2z/e/QRxaWtv8oJ2umULh1RvqsReMr0A/X32NTi/32QWa06xuImsN
         LLVg==
X-Gm-Message-State: ABUngvfIH/G043ttUcQUHDXOJnP9cOmpATHnvBOFKs0pcEgJrpXkTIMSVdlEu1wlo04L/3/B
X-Received: by 10.98.65.156 with SMTP id g28mr18978960pfd.110.1478196500208;
        Thu, 03 Nov 2016 11:08:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id w15sm14321819paj.33.2016.11.03.11.08.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 11:08:19 -0700 (PDT)
Date:   Thu, 3 Nov 2016 11:08:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103180817.GC182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
 <20161103175131.GB182568@google.com>
 <20161103180224.7mhpziotpinmd3tr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103180224.7mhpziotpinmd3tr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Jeff King wrote:
> On Thu, Nov 03, 2016 at 10:51:31AM -0700, Brandon Williams wrote:
> 
> > > > I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> > > > because I view a whitelist or blacklist as well black and white and
> > > > having this user state adds in a gray area.
> > > 
> > > Well the "user" state is to differentiate between the
> > > * "I consciously typed `git clone ...` (and e.g. I know what happens as
> > >   I know the server admin and they are trustworthy.)
> > > * a repository contains a possible hostile .gitmodules file such
> > >   that I am not aware of the network connection.
> > 
> > This is still a gray area to me.  I think that if we have a whitelist of
> > protocols then it should be a true whitelist and not have some means of
> > going around it.  It just seems like something that could be exploited.
> 
> How do you implement:
> 
>   git clone --recursive trusted:foo.git
> 
> and use your ssh keys for the "trusted" server, but not for any servers
> mentioned in .gitmodules?
> 
> You need some way of distinguishing between the two contexts (and
> setting policy for each).
> 
> -Peff

Interesting.  Ok I can see how this would be a useful now.  Thanks for
the example :)

-- 
Brandon Williams
