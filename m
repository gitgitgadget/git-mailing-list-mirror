Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49981F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeAJUJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:09:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54216 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeAJUJd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:09:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E07C6B6B20;
        Wed, 10 Jan 2018 15:09:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LSnYXNYi0dThCb6+xx6sjC1/BoE=; b=nNYx6e
        d+EvcnFz6bdRB6UYrZEZ6b3li8SdK03tH8QF/QhZi2rpN0hb+VO4uNy3bdd7k33c
        V0ERgK8N5m+qTAjirOimvrWbPejvFceK7HN2IMNYhTNW1KRXM0PrrvMeeKd62Bhb
        SWR7vmg6Uh2zQXGtKfqqFLWeNHTOxZKvzohMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g+nX8ZBpB+/2EsSgz5amD9vfg8vcX8bx
        T9Q32LpAZ7gwZHma1pHQEdEwHxeEIuDwgqVTCn4aabbc0dDN2gfnlZMx7Zdz2XW1
        K4/OQPloB4QnFTiY2EVojxHmxVXVylMWJadEqUbv7UXaWvDsXAeEKo5Xz8hkEC4s
        Qhz76PKVqdM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D75F5B6B1E;
        Wed, 10 Jan 2018 15:09:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56B48B6B1D;
        Wed, 10 Jan 2018 15:09:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
        <xmqq608a37ve.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1801101838360.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 10 Jan 2018 12:09:31 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801101838360.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 10 Jan 2018 18:40:18 +0100
        (STD)")
Message-ID: <xmqqk1wp1nno.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF2C3C4-F642-11E7-A460-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No, the only thing that changed was the introduction of Git::Packet (and
> t0021/*.perl uses that). And that Perl module is not yet installed.

Ahh, that is the difference among other users of split(/:/,
$ENV{GITPERLLIB}).  Scripts other than 0021 may be using installed
ones and using the wrong separator does not affect them.

> Granted, we tested incorrect versions of those modules, but this late in
> the -rc phase, I would prefer to be cautious. People might be relying on
> the current bug.

People meaning those who run "make test"?

In any case, the patch to 0021 as posted sounds like the most
conservative thing to do at this point, even though we would
definitely want to revisit it and clean it up after the release.  As
long as the reason why only 0021 wants the special case while others
are OK is understood, I am OK with the patch ;-)

Thanks.
