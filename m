Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347B720986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbcI0UnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:43:24 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36541 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbcI0UnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:43:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id qn7so8977785pac.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TqVqeiw69hs4iqS+O6wMfUx6kvkvJdA+nww6VlvzMSk=;
        b=KBMZ0pd7oKeORJ3P20+QHmUg7QQYypGeo1BV4VMT2gB+VYu/uMTVEnOoG5/S8ioCtD
         K6RkwYMowOxYFrXmwxz7SKVYrq2qSKLTPWn0ogCsolL8c3ZeD3sfy2TMFbwf8TEfOLQr
         5Y9FHglqQG6qQvLudNPrg3c7Ii2R75+HgeC42D7a31X2YTqDmjRo+uTfMPWwMV4nEbpt
         gnC+e27YFiAfpe3uYxWht4PvGh7rFi0effY8V28je8lUcO23LIrlmmos6+jmTdviq4pO
         l8lZScUEMUWDztS1OQrv3n+mOm04yka7mF412IjBVn8/dvUrnEyCpVv5Q4FM7Wb1WNp8
         s4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TqVqeiw69hs4iqS+O6wMfUx6kvkvJdA+nww6VlvzMSk=;
        b=H2zqqClP52ku/DXBDvX6jCa/dhJoZidf45m0tgDHXsW6DEVP6j8jNrZeR+zNlIU5Uo
         YB6bp+hr6H7U3lY+jq9KE2ROeduqotlGZs98NYoCwq/WNxjCgMELqQPgLAoqYYqF5uME
         QIEfFKypiJ+sIHQ01FNjd+V2nATQvIGfH30Gx4RHHIKQHLVq/ne47nhyp9+dWGWvEnVi
         XC33aintdsm930X0zhhTC0wDoqFC6VO/vEvYy5EmHsA03tuOCVawYrelyEt2g84IcdBL
         u2+8MGupnt1eKfDiu3YGmEzHgE5iMI0K6bDPDrCOF9aXkiheFAyxB1I0Y54vVY1VnBdV
         hn9Q==
X-Gm-Message-State: AE9vXwOvi2buYl54NtkEQbwahFoBYxm0KbknIVQa1RwBwjliZ8xLAxI85pqhBn2pR226pzZO
X-Received: by 10.66.246.227 with SMTP id xz3mr50374979pac.24.1475009002539;
        Tue, 27 Sep 2016 13:43:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id 70sm6928669pfy.81.2016.09.27.13.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:43:21 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:43:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4 v4] submodules: make submodule-prefix option
Message-ID: <20160927204320.GD32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-2-git-send-email-bmwill@google.com>
 <xmqqtwd1nr56.fsf@gitster.mtv.corp.google.com>
 <20160927202925.GA32565@google.com>
 <xmqqoa39m67l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa39m67l.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> s/submodules/submodule-prefix/ at least.
> >
> > So should the #define be SUPPORT_SUBMODULE_PREFIX instead?  That may be
> > too narrow minded and not looking toward future submodule options
> > support but I'm not sure.
> 
> I am not convinced that this prefix needs to be tied/limited to
> submodule, at least not yet, though.  I view it as a prefix that
> points from above the repository's top, of which submodule support
> may be a good sample user, but the caller may not necessarily be
> doing or interested in "submodule support".
> 
> That's also part of figuring out how we want define the semantics of
> this thing and how we want to present it to the end-users, I guess,
> so we may have to rename it when we know more, but that's OK.

K we can leave the name as is for now then.  Thankfully it should be a
simple name change since it only lives in 1 file.

-- 
Brandon Williams
