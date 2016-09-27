Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9519820986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934897AbcI0U3b (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:29:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32912 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbcI0U33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:29:29 -0400
Received: by mail-pa0-f48.google.com with SMTP id cd13so5605900pac.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeljTyy+vjd7T7qWKrAp4S6Lvlf4n0FFrPPEPRK1PiU=;
        b=nc7EtOQnVlRRlRxSl6iPZZGGwb5ZylLlcs9J6OFhUwicx31rBTzIAcwlYoWaLx6B43
         sE0pxcNA3zVW8R0AXfB0clKG09ZA6ghi0ZJhc+4sZ5Ovodva/G7zqXrS89Vlownx7YV+
         3kIdOQiYeAtNZxeqjYcT4bln/wbE3amrKCY83HPllGhPclymnjqr5t2FlxTeQGUeUGdd
         FvJjINaXalD/hRZAPgPAoe0LIEut58IS+ApHKqTDFqn6+9NL3eAQLO/Bt1CcaKAkiErv
         /40dfgg/y2b2inZduHHnp8NA8aqdK1PPiz0121+wWAFjGNeoEy5feqKzfhBhnyOzu4r+
         3U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeljTyy+vjd7T7qWKrAp4S6Lvlf4n0FFrPPEPRK1PiU=;
        b=iTJIZ+zPIqiCvFsFKkFS9Bz0u9uz72k8+3uouAAEB3rwJgzIWDjnjOV/itHiOH4dI6
         5NOoAeYV6M9s2PbRxiO796jlUq8+I5K7cQ7TCRQtxne9J63p8rOZb7RWtolkTbMJK79E
         QBi7ZFC5zI8s2J4gYlLzDY/wreA9fZ+DjOXQUHmss4CAnjhoV3Ko4Zyf+vuA0FiKmXVh
         ZcCrncHUwooZGREVu6x9N4zw+m2ZvBwWr1jQhob9LyTxp6N1G5kj9g1W4PMCaheCrggR
         p4u3MFGd+7BRJ64tity6k08z9jQKyencdhML8bB8YrssCWWG928HYpBJoNW+PAtTTHGp
         RdAQ==
X-Gm-Message-State: AE9vXwM6D5fNxFVdQ3vwWbaHau49BgVwx5S07R/MziGhpgHYQ7Q3h7Ih2UerrD3XXsUh2vMe
X-Received: by 10.66.190.161 with SMTP id gr1mr50197396pac.156.1475008168160;
        Tue, 27 Sep 2016 13:29:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id u19sm6916323pfa.40.2016.09.27.13.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:29:27 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:29:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4 v4] submodules: make submodule-prefix option
Message-ID: <20160927202925.GA32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-2-git-send-email-bmwill@google.com>
 <xmqqtwd1nr56.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwd1nr56.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +--submodule-prefix=<path>::
> > +	Set a prefix which gives submodules context about the superproject that
> > +	invoked it.  Only allowed for commands which support submodules.
> 
> This, and also the message in die(), uses a phrase "support
> submodules", but it is unclear what it exactly means to the end
> users and readers.
> 
> A "ls-files" that is recursively run as an implementation detail of
> the "grep --recurse-submodules" would be taught to support this
> option with this series.  Who is supporting submodules in that
> context?
> 
> I'd imagine (close to) 100% of the people would say it is "grep"
> that is supporting submodules, not "ls-files", but what this
> paragraph and die() message want to express by the phrase "support
> submodules" is the fact that "ls-files" knows how to react to
> "--submodule-prefix" option.
> 
> I'd suggest not to worry too much about this phrasing at this point,
> until we figure out exactly how we want to present these to end
> users.  For now, perhaps drop the second sentence and replace it
> with "The end-users are not expected to use this option" or
> something like that?

K can do.  The intention is that each command has to do whatever
internal rework needed so that it understands how to interact with
subomodules (be that calling another command or internally supporting
it).

> > +		die("%s doesn't support submodules", p->cmd);
> 
> s/submodules/submodule-prefix/ at least.

So should the #define be SUPPORT_SUBMODULE_PREFIX instead?  That may be
too narrow minded and not looking toward future submodule options
support but I'm not sure.

-- 
Brandon Williams
