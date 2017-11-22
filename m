Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16C520A40
	for <e@80x24.org>; Wed, 22 Nov 2017 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdKVSAR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:00:17 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:37588 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdKVSAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:00:17 -0500
Received: by mail-it0-f47.google.com with SMTP id m191so7354255itg.2
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohvhamPWioIQdHCtUdy8wsrWkdpMdu2+JJbbYlHRK18=;
        b=VS8KNMCvfUBqBDU66r16oiR3Jvt5GgyVQhuqNZvUKvUEf0us+GcU/5Szq1TvTufKwf
         MMngoaXFvOoLs8iiyjpHJOVf/KRkrF828XaWy4tFcDcIEJmvOySurpZtQV31kBFGbSZM
         pkAINACKLsFD2hyjUly4r/2AqVuubANJRXoidm/a/UWG/i16vZDwk1Wu9+gAQEfmdUh8
         oLJG1MoDRR45RLzFbi6QyiqZt7RO6zqsBrlX6izsk3s59lTN7e8cLdZDk24UyxiqD0oW
         MS2PBWCNwkz7q2wuuRAUv6Vk0bBaBy/Yo3+Q+T4o64nIT1ELwsArhFDp0n/Vtqvwk40J
         /B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohvhamPWioIQdHCtUdy8wsrWkdpMdu2+JJbbYlHRK18=;
        b=ONjlH6lk2TyrrGa8DwLpScEPYGJMwZp4q+UXmpF6h5nOX60NhkdQptcNvcdFc2tBen
         9c+6N3/oLXiUt4GFrO5UgSf0QpI18RALzZQWJFVL14WFKXenq+qjbmQ25dbu2MXWkxQL
         XzKK9JePZu3aNp/ZbNeah3AFGBd54vkCBO/jyX8F1v9DHaW0UYoCH0orXBqQKQTAxTKj
         jWHNUvNVlXvVhNwZwOK5wyrTCulUTzcJqYPDoTyW00qSU9XByh4z5cDnnOTtJJYLZA+F
         MUn7kJ2Tlr9PCWlJIamRCpH1YVnVvo6WtocxehBi8fWzSZUg5+fEeU+2Ki59OcHiV4TZ
         xntg==
X-Gm-Message-State: AJaThX6ac1g1w93zrnpq4xuBlbOj1/AlvMsEu9fGJ+hateg993vaYBaT
        Odwml2i1kJOZrVBt62kr5XtrXg==
X-Google-Smtp-Source: AGs4zMZ9dRSy+7TCQoNIntRZ9cIA1CmoH5dHPYDCpkkQUMKtkyir/GJp1JLqBHYs133bPE0Ar1pdZw==
X-Received: by 10.36.245.133 with SMTP id k127mr7956350ith.136.1511373616285;
        Wed, 22 Nov 2017 10:00:16 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:4fa:d4be:6ce:3f8b])
        by smtp.gmail.com with ESMTPSA id e203sm2238164itb.32.2017.11.22.10.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 10:00:15 -0800 (PST)
Date:   Wed, 22 Nov 2017 10:00:14 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/10] Partial clone part 2: fsck and promisors
Message-Id: <20171122100014.937f5902c3714e6e26e20a1b@google.com>
In-Reply-To: <xmqqy3myubpi.fsf@gitster.mtv.corp.google.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
        <xmqqy3myubpi.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Nov 2017 14:25:13 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > This is V5 of part 2 of partial clone.  This assumes V5 of part 1
> > is already present.  V5 includes minor cleanup over V4 and better
> > separates the --exclude-promisor-objects and --missing arguments.
> >
> > Part 2 is concerned with fsck, gc, initial support for dynamic
> > object fetching, and tracking promisor objects.  Jonathan Tan
> > originally developed this code.  I have moved it on top of
> > part 1 and updated it slightly.
> 
> Thanks, will replace/queue all three series.  I am getting a feeling
> that the first one is already ready for 'next', while the other two
> may want to see a bit more comments?

Yes, I think so too.

Jeff Hostetler and I noticed some issues occuring when some other Git
commands dynamically fetch objects due to the fact that those commands
and fetch-pack use overlapping object flags. At the very least, we
should look at that before it goes into next.
