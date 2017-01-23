Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AFB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdAWSjg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:39:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdAWSjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:39:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F5D2617C8;
        Mon, 23 Jan 2017 13:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0TZJ9Gz6H6raBBHOE524bvkINME=; b=Ln8IK1
        wgbvfFZddQA06ueaZtnGlOnDTGgztToyjbiICq9CWCkNgZPzFvPGDkJrZ7eOaL/6
        um7T7Etc1b3qC8ok2QX5GftIhzm2oQaJdMAyLrwqEQYyxlGlHsMZUY/Pbphcbr43
        gjToPXbtof3Q2vVNkPHaZiZdWXeW+7dX45aZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HLPasRPHHg/bbNEgfajpQ3gZAw6yl679
        m30Bjq1aRBWeWGhGwY+9bftUdXqwKsJdVJgEzofMeLrareNJ2JUskFbtwO6kDU4C
        kHKPAQA2Z8quXH+qrJjK7wrPQQeUFd2mrVrxvIt3RLcTbuFDl1LGExz0EmCPg2KT
        D8qKZgnRzI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98175617C7;
        Mon, 23 Jan 2017 13:39:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA85A617C6;
        Mon, 23 Jan 2017 13:39:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] travis-ci: fix Perforce install on macOS
References: <20170122225550.28422-1-larsxschneider@gmail.com>
Date:   Mon, 23 Jan 2017 10:39:32 -0800
In-Reply-To: <20170122225550.28422-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 22 Jan 2017 23:55:50 +0100")
Message-ID: <xmqqmvehsjrv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48CF792C-E19B-11E6-8B18-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The `perforce` and `perforce-server` package were moved from brew [1][2]
> to cask [3]. Teach TravisCI the new location.
>
> Perforce updates their binaries without version bumps. That made the
> brew install (legitimately!) fail due to checksum mismatches. The
> workaround is not necessary anymore as Cask [4] allows to disable the
> checksum test for individual formulas.
>
> [1] https://github.com/Homebrew/homebrew-binary/commit/1394e42de04d07445f82f9512627e864ff4ca4c6
> [2] https://github.com/Homebrew/homebrew-binary/commit/f8da22d6b8dbcfcfdb2dfa9ac1a5e5d8e05aac2b
> [3] https://github.com/caskroom/homebrew-cask/pull/29180
> [4] https://caskroom.github.io/
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> Hi,
>
> this small update removes one more unnecessary line and makes the
> formula name lower case (no functional reason - just looks better ;-).
>
> @Junio: Do you prefer such a v2 as "--in-reply-to" to v1 or as separate
>         thread? What eases your workflow?

It does not make that much of a difference if the second one comes
within a few days since the first one but in general it probably
would help if the follow-up is threaded _and_ made it clear upfront
that if somebody is reading v2 then v1 can be ignored ;-).

Thanks.
