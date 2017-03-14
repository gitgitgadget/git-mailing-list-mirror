Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9FA620373
	for <e@80x24.org>; Tue, 14 Mar 2017 01:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdCNBuO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 21:50:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751655AbdCNBuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 21:50:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A4EE88367;
        Mon, 13 Mar 2017 21:50:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7DDORyIFdh3NoScZJ8EHQS/J8hg=; b=evDLtF
        LcSGlhf5R0ixTiWK5QDJr2djS12f/fPnXaIZkgInk8HVyz8wpjl3s3aADMxNC0MW
        apCQnDNEUUEdQVxbT8i9Dc+yEBg4g0tElARUocGoEprcmBTK2XO47E0R7AC+dCT8
        zWJAmQ0wlhzSoZ+rPhoJf2pq1CLmv6i6fyGH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BqT3kVzrl5gWvx/Wzj6+EoveciIVeg4K
        Ft/MJ2t6fNEDKoYfa85mmi3JR3n1efIoMiMEax/ixJp/uxUh+vf4IuhzwiMO4gRW
        lQXAnskDrgdNpJuvupUpPH4RtO/yc+m1R31a+LHdi+r/OOEBoki4GzHoxxQZEutV
        cI/tEBQhmQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52BF288366;
        Mon, 13 Mar 2017 21:50:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4AF188365;
        Mon, 13 Mar 2017 21:50:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH/RFC v3 2/3] credential-cache: use XDG_CACHE_HOME for socket
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
        <20170314003246.71586-1-lehmacdj@gmail.com>
        <20170314003246.71586-3-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 18:50:09 -0700
In-Reply-To: <20170314003246.71586-3-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 20:32:45 -0400")
Message-ID: <xmqqd1dklj8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F0208EA-0858-11E7-9727-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
> Reviewed-by: Junio C Hamano, Jeff King

The last line is premature; neither of us reviewed this exact
version and haven't checked if all the issues we mentioned in the
previous review have been addressed.


> +static char *get_socket_path(void) {

Compare ths line with how cmd_main() below is declared.  Notice
any difference?  We begin our functions like this:

	static char *get_socket_path(void)
	{

