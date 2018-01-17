Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD331F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeAQS11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:27:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeAQS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:27:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B412BCDC7;
        Wed, 17 Jan 2018 13:27:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V4c4tDuVGYxSwIay7ZVVRCD+uUI=; b=tYJhlY
        hE9U0xfMiiOc8QaDb8xnvYzE9503fbw3BuwQZFIlQxRLx3dkBOI9VLwXHfBYpJsl
        y8BaiYkTQ3nX5FMS0I2jfFpF06JZgq9lzZCAVjZko+kYMpy6DLeDMFrwyGZeFWY4
        hnZOsUzwOBj4VAn+iYjwYZIGm28c67EvBfEoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ohP5fuz/kO/yTIciEid6rPM2h8ueAuLk
        PPHjeOY1Op2QIsXn8P8VnMWfddiirPTsfMj7wRhj8hTgxv65ATg/RkPfnETXVsEa
        1bvpIkSgS336wvwA7pftqE2lhDeSUrrTxNu2SeMu3tpVyTbMxSjBu8QxC0NkpanT
        0zdE6EisTRY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03A99BCDC6;
        Wed, 17 Jan 2018 13:27:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77325BCDC5;
        Wed, 17 Jan 2018 13:27:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Yasushi SHOJI <yashi@atmark-techno.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] RelNotes: fsmonitor: add a pointer to man page and the word itself
References: <20180117050857.10480-1-yashi@atmark-techno.com>
        <DM5PR2101MB090243C1D9F5DA87565D7DEAF4E90@DM5PR2101MB0902.namprd21.prod.outlook.com>
Date:   Wed, 17 Jan 2018 10:27:24 -0800
In-Reply-To: <DM5PR2101MB090243C1D9F5DA87565D7DEAF4E90@DM5PR2101MB0902.namprd21.prod.outlook.com>
        (Ben Peart's message of "Wed, 17 Jan 2018 17:26:37 +0000")
Message-ID: <xmqqo9lss5mb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10F13EEE-FBB4-11E7-8FF3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> It's important to note that the support for file system monitors
> in git is generic - any file system monitor can be integrated with
> the proper hook/script.  We just provided a Perl script to
> integrate with Watchman as a usable sample as Watchman is already
> available on several platforms.

Mentioning only "FS monitor" is insufficient (it would merely
frustrate those with FS monitor that is not watchman, after they
waste more time to find out that we only do watchman right now).
Mentioning only "Watchman" *is* sufficient, though.

Mentioning both would be ideal, i.e. e.g. "We now have a generic
mechanism to talk to FS monitors to optimize checks of working tree
files, and this version of Git can talk to Watchman using the
mechanism".  And that is what Yashi's suggestion did, if I am not
mistaken.


