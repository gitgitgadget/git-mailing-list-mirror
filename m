Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9780520133
	for <e@80x24.org>; Mon,  6 Mar 2017 19:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbdCFTWD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 14:22:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65049 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754570AbdCFTVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 14:21:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 791ED6E9D0;
        Mon,  6 Mar 2017 14:21:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1pZ/lZpRokffjCsatK3Ew+luo/s=; b=MWZNOw
        Gq16DBMuiXJFNOntrP+Ehk773KlCAsCCdTDWSXVe++nKZA3kauKISvxfIl77A+Zl
        vzZC77hmJh70qf9dwWDDWF5ImEqeSIT5tD1inDJml7qDPoipn+vRkgyyInhUKRSz
        k0xI7k9lw/jfuJ4rqZd+sCr2CKyzVNWMmDZdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xZAXXuKsAOYN+/Ph8Fn3bpS5ko8lSI8m
        Z/+dQ128nN5N3KEWUMKb9dqViAHlVvIjSVP2ZraxxjEwieX6o9cjT9OME9lDMrJk
        Gc4iLkBbKacVzAL11fOuY1pTVdPc7DTRNiO7h0hgGw+fXlzu0sMrZV+0cBFwejTF
        zUHf7Jjw7fs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FC636E9CF;
        Mon,  6 Mar 2017 14:21:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C69036E9CD;
        Mon,  6 Mar 2017 14:21:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        ramsay@ramsayjones.plus.com, christian.couder@gmail.com
Subject: Re: [PATCH v3] Travis: also test on 32-bit Linux
References: <20170305182519.98925-1-larsxschneider@gmail.com>
Date:   Mon, 06 Mar 2017 11:21:26 -0800
In-Reply-To: <20170305182519.98925-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 5 Mar 2017 19:25:19 +0100")
Message-ID: <xmqqmvcynrd5.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 189B5B86-02A2-11E7-9333-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> when I looked into the 32-bit/line-log issue [1], I realized that my
> proposed docker setup is not ideal for local debugging. Here is an
> approach that I think is better. I changed the following:
>     - disable sudo as it is not required for the Travis job
>     - keep all docker commands in the .travis.yml
>     - add option to run commands inside docker with the same UID as the
>       host user to make output files accessible
>     - pass environment variables directly to the docker container
>
> Sorry for the back and forth.

Anything that makes further diag easier when a problem is spotted by
the automated machinery is a very welcome change.

Will replace; let's see what others think.

Thanks.

