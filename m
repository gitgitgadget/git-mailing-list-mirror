Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF9A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 02:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBLCpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 21:45:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45978 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBLCpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 21:45:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so936789wrn.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 18:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GAcDGZtepajbTY2AZncXzGulvaZDyq4fd4Gwjyd8BYE=;
        b=cpfv1LOFfTgUUZq4kUlcBNCJ1cOrDjVwz1LDmPoWiDpUg7oEuzqXbnVmWTsTbI/Bqd
         Qb2tAgixMDa8pTy+XkC/oqDRbnXqw14qnh8p6/g/7CVe/3OgCj6kvKD59VkJhBKNIo02
         LIPs7wjXQazdP8Dv3GaXRDcEP0FfbH4K3q0/eCKl0PxBJ1XaPAV+UZvHIj2TNf6Dcr9M
         dvi3ad0K1jnZyCqdB5dr7mUwtYjifyO16zoNClbTXZsRO/LoeI87nnNb9j6fJgGdzaGY
         ny3fVeMT2IkWjB+2wX3Onr7MznU7MHIsfD0AqC4IVpp0/qEOYjbIwYwPCW9HDkFbCm2n
         f5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GAcDGZtepajbTY2AZncXzGulvaZDyq4fd4Gwjyd8BYE=;
        b=qyUviBmVlaASaqUfbNsVCqF56m+/mIcpo7Aac6lJ2cDJhIGOw+l+mfWsaZOY3TMJ4x
         yVDDCbrfssS+MNGFPHIu3xyrdnzhz+xQCiaKBu1ybrZYD7r+oPoQdgCW0KpyGdAirZZg
         B6E1CU2N7f/Ym6rl6qrnFMXWjgi8ppofpVz5+BMWOMCbErcCDeSERt/MQP13F2zRx6s3
         FJ+GpbsTKQLeNDx18pchDK8rEKAC6pc6hjBj5m8XFO11g4aCb73IdOQfjhAnO6IuOos5
         NP9JGKmFpliP9gRp4ftk9dV9AoQo/3MytmyTGIg+/HI31nGlUK+jJH+C1UmBSm/XsDeJ
         xMVw==
X-Gm-Message-State: AHQUAuYZ2eP7EqmY452Xen0LnHZRzkqK0izhQC4jBEsFV7MlvZyzC/nz
        d9FpDIwWuZca0yia7Vb7nc4=
X-Google-Smtp-Source: AHgI3IbfdBid14ITNJktaWpoVmf/nNr5OCF9bnqNIso5w5x3g3fASCKrtfWAT932ud7TkDgETJX+LA==
X-Received: by 2002:adf:b648:: with SMTP id i8mr867976wre.319.1549939503901;
        Mon, 11 Feb 2019 18:45:03 -0800 (PST)
Received: from szeder.dev (x4dbe9d5f.dyn.telefonica.de. [77.190.157.95])
        by smtp.gmail.com with ESMTPSA id m21sm1039050wmi.43.2019.02.11.18.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:45:02 -0800 (PST)
Date:   Tue, 12 Feb 2019 03:45:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190212024501.GB1622@szeder.dev>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190209140605.GE10587@szeder.dev>
 <20190212004433.GJ13301@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212004433.GJ13301@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 07:44:33PM -0500, Jeff King wrote:
> On Sat, Feb 09, 2019 at 03:06:05PM +0100, SZEDER Gábor wrote:
> 
> > On Thu, Feb 07, 2019 at 10:17:44PM -0500, Todd Zullinger wrote:
> > > Looking through the build logs for the fedora git packages, I noticed it
> > > was missing the GPGSM prereq.
> > 
> > Just curious: how did you noticed the missing GPGSM prereq?
> > 
> > I'm asking because I use a patch for a good couple of months now that
> > collects the prereqs missed by test cases and prints them at the end
> > of 'make test'.  Its output looks like this:
> > 
> >   https://travis-ci.org/szeder/git/jobs/490944032#L2358

> But it looks from the output like it just mentions every prereq that
> wasn't satisfied. I don't think that's particularly useful to show for
> all users, since most of them are platform things that cannot be changed
> (and you'd never get the list to zero, since some of them are mutually
> exclusive).

The idea was that people might notice when a new unmet prereq pops up
all of a sudden, because they modified something on their setup, or
because a new prereq was recently introduced, e.g. PERLJSON.  Or they
might notice that a prereq necessary to test a fundamental feature is
missing on their setup that they haven't been aware of before, e.g.
TTY.

