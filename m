Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA8821841
	for <e@80x24.org>; Tue,  1 May 2018 11:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeEALhL (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:37:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54946 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeEALhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:37:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id f6so17378033wmc.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kttyNHtzFSAtD7BtTBBzhYkRjyVIbehEDZAGEHEaCsQ=;
        b=IyjvOY4U7XdXPTeXmG13r4UsRFzofPoAHV395NMqemI3cDpp7eqA+dX2JU89isswib
         4TPRILwC5B1Htpn9z635srgx1iqX0oYROnG7T9Vhd0jq9K3sxt4F9jeIkeogaE6ae2/P
         /jnwr0xQF9baktWo9FapLxDgy9C6D5IrzZUpB2a329Qgk6lXVDsTe0nEJAOIIcoE6ChQ
         bA42mJPkezQgoXHhKKsqvV9TQqopvCXA33MDBcaGzdRoWRYoiQ1rzrn/d5gysJE1MVSN
         KYMt158FbXoesLoW/FKTKZFq3FI2hMR32A/FZFHtyAsygNTNVtYpzzqoLowSF6sY5u9L
         8EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kttyNHtzFSAtD7BtTBBzhYkRjyVIbehEDZAGEHEaCsQ=;
        b=EzOHUhZlSpbZK1ukKxBu7pIBFdr6UV8+DsMJPWduDgWfNe6ljOJHypmISE3iJsbbKA
         iRVLl5A9UW+F42gTFp6Db/JhaGbkvtG02wwwaK4e+eVZ7SgXrhHgmZkJwZsggmoBJnFV
         1T8AAJw+bZEh+aE/FQQ4BEEe2ybAP9EMOdH1QUeWhYQM3h7p18pHjAbU1hJvYPIDQXeZ
         AIGuV80UfB3AVcj+tnUvRqOdXBzDpJ+jvr5GyieLo6ltVIv4SrYdA3mmbEKJnKmx0xev
         DL3ve6m6NH26ari5tXVidxELtptJ+QlzdH+ovwqzmYbQ5z/0+cZkkPt6PUD97lr73g9Z
         /pZA==
X-Gm-Message-State: ALQs6tAu9lWo67SBGW18W6wC0n/3x9oLrfpMqZEY7vErdJeIggPIxWUE
        hEwODZvGNscqbFG9s/l7CNI=
X-Google-Smtp-Source: AB8JxZpMC/EXb+iVfMfbcqmEa4nndjcarka1qlW/CWx6QzTYzJ5vwPgAeAaJo2ityoJ/f+eFYFMpRw==
X-Received: by 2002:a50:860f:: with SMTP id o15-v6mr20918543edo.243.1525174629042;
        Tue, 01 May 2018 04:37:09 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id q22-v6sm5369694edr.71.2018.05.01.04.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:37:08 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 1 May 2018 13:37:06 +0200
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Eckhard =?iso-8859-1?Q?S=2E_Maa=DF?= 
        <eckhard.s.maass@googlemail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
Message-ID: <20180501113706.GA13919@esm>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <20180501094940.17772-1-eckhard.s.maass@gmail.com>
 <87bmdzzlll.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmdzzlll.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 01:00:54PM +0200, Ævar Arnfjörð Bjarmason wrote:
> So didn't we use diff heuristics to begin with, and then regressed? I've
> only given this a skimming, but it's useful to have that sort of
> historical context mentioned explicitly with commit ids.

Sorry for not making this too explicit: I traced wt-status.c to its
beginning in c91f0d92ef ("git-commit.sh: convert run_status to a C
builtin", 2006-09-08). Here I lost track of other changes - but the
commit you gave is earlier also has rename detection hard coded in the
status command. Should I add this as a starting point instead of the
commit mentioned so far? And this also seems like the very beginning of
git status.

The point I wanted to make, is that git show showed you renaming of
files out of the box whereas other commands did not. At least I remember
this form 5+ years ago.

This changed with 5404c116aa, so that the out of the box behaviour is
the same, but this is more a coincidence that the hard coded flag is the
same as the default configuration value.

My comment was targeted at the hard coded rename detection flag - the
other two just have seem to pile up on that and I wanted to clean them
up, too. Maybe a phrasing like "While at it, also remove the two other
hard coded values concerning rename detection in git status." is better?
Is my intent clearer now?

Greetings,
Eckhard
