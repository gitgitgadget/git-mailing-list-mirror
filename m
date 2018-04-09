Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B692E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 02:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757580AbeDICXL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 22:23:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50175 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757550AbeDICXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 22:23:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54FCBE393C;
        Sun,  8 Apr 2018 22:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=h4aWfsT3oYZBg3iUbrBMKeFnW9Q=; b=Pa4UnUp
        TWaI7hsyb1XMkgh/VtzQoKLYsvkLOHELfO1m+l5p7fyiau/ffY5+K3Efvu2rUwB/
        Fg9xuHwu+SWX7q+rf8KhgteAsdcHqwhRNqRwcH2bzGs0SdXkRmWuvT74PjTSJSbm
        pYqcUPL2oOZtHuWbwYbh/aX6JgewT6tt1/N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=onBw2kuNtMS+Y3TyBJVmCAPpp19mtWyB6
        zE7kKYVQk/CgWSv/ExmOgIDIe6NFcN9oHZGvl/GiSRX7VInYVLSzxrofemEnjBWd
        mTsBp2hOPiF3Zzj2guYX5AY4IiaUd267bvbYUIV4MN8xGxE6lJzo9Awhm/m0ZWtk
        4CxlhV+lic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CCF3E393B;
        Sun,  8 Apr 2018 22:23:06 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CABCEE393A;
        Sun,  8 Apr 2018 22:23:05 -0400 (EDT)
Date:   Sun, 8 Apr 2018 22:23:04 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix condition for redirecting stderr
Message-ID: <20180409022303.GS29680@zaya.teonanacatl.net>
References: <20180403221307.29194-1-mail@lucaswerkmeister.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403221307.29194-1-mail@lucaswerkmeister.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Pobox-Relay-ID: EFCDB91C-3B9C-11E8-B874-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas Werkmeister wrote:
> Since the --log-destination option was added in 0c591cacb ("daemon: add
> --log-destination=(stderr|syslog|none)", 2018-02-04) with the explicit
> goal of allowing logging to stderr when running in inetd mode, we should
> not always redirect stderr to /dev/null in inetd mode, but rather only
> when stderr is not being used for logging.

Perhaps 's/^F/daemon: f/' on the subject?  (Junio may well
already have done so while queueing locally.)

The patch itself looks reasonable (to my relatively untrained eyes).

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hardware:  the parts of a computer that can be kicked.
    -- Jeff Pesis

