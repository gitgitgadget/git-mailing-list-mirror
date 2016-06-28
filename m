Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3262018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbcF1Nx4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:53:56 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35695 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbcF1Nxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 09:53:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id v199so140938625wmv.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 06:53:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C6fQITvdK6E0aw0eIPU+BR8QE+lQK4wdW9TeWhuQHkE=;
        b=XTL3QM1DbLNNYmMQxO6CSP+ovccKVIRTVqJURWNsF2vmoe9ak71S8uU5BLu3PuWD4i
         5CNOS5gWrhHAVBHdxv94YCizBHW0Tjf7f62Rc+mpXVVwVCtEHeWnkhzhSWH2F9uEuI5/
         qcKRJWeFOg1NoroI3NoXpbCYah0jK4zK5XA5RQC/pEGVgw3f0fa4CktPsK+Z3JSbSqMz
         kUuhdrZN2xZ3M6dAF5EQUrAe8VJ8ZDGATOzxxFh3OLe/7XulvvvRDRL1+Ysja0T//xtt
         lVeu5MoMfN65ULRTRgoCgc7LQ3HVRtKkbn1mjeMOQuDBx82tpF3h2BnQ9L1JJM/aPLbN
         97Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C6fQITvdK6E0aw0eIPU+BR8QE+lQK4wdW9TeWhuQHkE=;
        b=LS1Jym4+765FHQycJnsk4aGWfxkqAWputWGLS51bt6iAdWUj0jHtA9AdkwSJBUH7Mi
         5qDd0y3jPQWDrdnI+Rjpn+Rs/cazSuPMTQ6HS/q/esjo9aqhnOkdSkOoELHjpUaE1brG
         5mVe3sLgX05Upy2So4DuwMnE75VY0jC0hEuh0q4ja2MvMto2pdDN/Je3NmnrMTRo6AIa
         l0S8IYkYMraythpA1kh+lMt4eoqzUA6+w9HcqaZ22SIb5nVzE5hDbbcfW7YjAhHPIX9z
         6wi3UbudgCsamvQgi4hUIj+ixkzlK7XQ14ylQGwsyoauHsLp3AJCdThZ7UH04YNTYohR
         tVKw==
X-Gm-Message-State: ALyK8tKuAlPL3I57BBkbW7jQhv+27axa9aLhuur5P9m+vhfb04WM+1YD7aJLSvvKPb7uHf9oqjSi4Ydf9X4arA==
X-Received: by 10.28.129.208 with SMTP id c199mr15434525wmd.79.1467122028286;
 Tue, 28 Jun 2016 06:53:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Tue, 28 Jun 2016 06:53:47 -0700 (PDT)
In-Reply-To: <9603B6F9-3BEF-4779-84C3-6DC61D7FBC46@gmail.com>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
 <xmqqmvm6bom5.fsf@gitster.mtv.corp.google.com> <9603B6F9-3BEF-4779-84C3-6DC61D7FBC46@gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 28 Jun 2016 15:53:47 +0200
Message-ID: <CAP8UFD1Zr+Fu3j=kzkbHzHm2TH0fY93r2GmAE-rzqQfg4Aa4Xw@mail.gmail.com>
Subject: Re: [RFC] Native access to Git LFS cache
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 3:22 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> @Christian/Peff:
> Is there a place to look for more info about your remote-object-store idea?

You may want to take a look at:

https://github.com/chriscool/git/commits/external-odb

I just updated it and I may send an updated RFC series from this
branch to the list soon.
