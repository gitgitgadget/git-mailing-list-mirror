Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E4A1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756094AbcH1VZD (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 17:25:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755862AbcH1VZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 17:25:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so7102603wmf.3
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyR7peLB/B9LOdp2YvZaab6MM9Aho+NvazZNvdjA01k=;
        b=B/0MBEv8LxbzqWuDnn+U0UEfbzXvYPJUHcbKvKdNxMrs7DxEgUFW5xIjci3PVCjrFG
         fOmBw8gDu6rokYdUp8IiS1M6gFw3uGOUZ6QA3m2FA0BiO5eDoRi/BTMUhoAG1WitKqW9
         tUyLJoS/SXqUWTTKnTdF0YLbqixQnWY7jbfirXLCqMbNHp8I4bp9oNydo4zZwH1g2QBo
         +Fby+8OEJGOkJ1SipVnYf6xZAjPuYJmG9SRqmmih6aZc4bmungtFU8uNNnAlztcsuzAl
         mVgUBYgHzXW36NyMEAnrw5PGEssvmRQvWEDXVXf99P6/V2dvngJqiwBvDHEjvidiNIz2
         HPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyR7peLB/B9LOdp2YvZaab6MM9Aho+NvazZNvdjA01k=;
        b=cc4ZB8IVqm6d2hufs533OWYUHb1SkVv5HegUzGIPENRy9XRjIszmy8uCPeeKvMyARJ
         5ZIYlJzB7ix9OHY7542vzFJKXIZxQzu+HCFQk2wMeXpj7cKshGBMQYCEIrGlINxwDQML
         NDiybT2wMeFlCD0EF89mLNRFySGQVQ6Y+aiQBIPhq38Av4dsc6dXwAW0sP5dHCAB44j1
         rFZ6o3OSIUZIi4ldxZ8pmWEEWYiVi85iOZ0ZtJYC8LxcbCID2MUBCzuXqn6o5+hvytsP
         mWHHOWuEauf7xy4wJ45BrZ0PmjyXpYi2LcmCJ+vUJI7/+xUWAMoTl43UmK9UamyClTW/
         popg==
X-Gm-Message-State: AE9vXwOAAbXTNiRdryePDIfQlZAtSGlBksvEFhZEVxNLtXkI9+3i+JA/khbrnLnO8uaQaQ==
X-Received: by 10.194.77.97 with SMTP id r1mr12614293wjw.83.1472419501131;
        Sun, 28 Aug 2016 14:25:01 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id a3sm11489457wjw.15.2016.08.28.14.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 14:25:00 -0700 (PDT)
Message-ID: <1472419498.4265.16.camel@kaarsemaker.net>
Subject: Re: [Ksummit-discuss] checkkpatch (in)sanity ?
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        git <git@vger.kernel.org>
Cc:     "Levin, Alexander" <alexander.levin@verizon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <levinsasha928@gmail.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Aug 2016 23:24:58 +0200
In-Reply-To: <1472413969.26978.108.camel@perches.com>
References: <1472330452.26978.23.camel@perches.com>
         <20160828005636.GB19088@sasha-lappy>
         <20160828075632.GA1852@p183.telecom.by>
         <alpine.DEB.2.10.1608281152080.3321@hadrien>
         <1472413969.26978.108.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On zo, 2016-08-28 at 12:52 -0700, Joe Perches wrote:
> On Sun, 2016-08-28 at 11:59 +0200, Julia Lawall wrote:
> > 
> > On Sun, 28 Aug 2016, Alexey Dobriyan wrote:
> []
> > 
> > > 
> > > The problem is that c-h.pl generates noise in the commit history
> > > and
> > > makes git-blame less useful than it can be.
> > Could it be that this is a problem with git blame, rather than with
> > checkpatch?  Last year there was a discussion on this list about
> > how there
> > is an option to git blame that will cause it to step through the
> > history,
> > and not show only the most recent patch that has modified a given
> > line.
> It is more or less an ease-of-use limitation of git blame.
> 
> There are some that want an ncurses only version of git blame
> that could
> use arrow-key style navigation for historical commit
> line-ranges.
> 
> git gui blame kind of works, but it's not ncurses/text based.
> git-cola kind of works too, but it's not text based either.
> 
> Are there other existing tools for blame history viewing?

tig has a neat way of doing blame history digging: do a `tig blame
filename`, select a line and hit the comma key to re-blame from the
parent of the commit that was blamed for that line.

(hat tip to Jeff King who pointed out this trick recently)

D.
