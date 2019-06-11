Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FB31F462
	for <e@80x24.org>; Tue, 11 Jun 2019 19:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406379AbfFKTzZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 15:55:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59253 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404282AbfFKTzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 15:55:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FA6514A196;
        Tue, 11 Jun 2019 15:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CHZgJEmmH1HJ+2q9wTExDMQU5tk=; b=h4q4Zz
        4EXonan+SRNZRXkPHRYMTmPmiFNmMRsFe64w9X/4auaNbOE/DP5+C4L5EA9P55rh
        jF6ZvizohAwQcJNwQ3d1seLZ6LV1OG0UlveQn7+labTs5kKkNCP6anOyCfBW2X/S
        zX3ePEB8WZ0aEhNmDELDUc0s1oSWt0dIrmppU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UP9Cvk5iMOdXSw0jOQGHMHc0o7oGFNfq
        WUwtfMiM255b4KEAGxhxZTcGmAWZeWLyZQ/APf03s4/KmWmfKEMTWE57Zg0bvGqA
        3evnN/6V6QJKwK3kBFHiww7M880zrlpDWsI4FpJ/5WFv9QE2/e0ieu4rcBoiNA80
        JvjWmDq4nmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48B0514A195;
        Tue, 11 Jun 2019 15:55:23 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B798E14A194;
        Tue, 11 Jun 2019 15:55:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <mail@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: cgit and global configuration
References: <20190611170401.15d43623@leda>
Date:   Tue, 11 Jun 2019 12:55:21 -0700
In-Reply-To: <20190611170401.15d43623@leda> (Christian Hesse's message of
        "Tue, 11 Jun 2019 17:04:01 +0200")
Message-ID: <xmqqblz3lwwm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D91C3B0C-8C82-11E9-A39D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <mail@eworm.de> writes:

> With the new trace2 code in place at least tracing configuration is loaded
> before cmd_main() kicks in. This happens in trace2_initialize_fl() ->
> tr2_sysenv_load() -> read_very_early_config().

I think that is as designed.

> The offending commit is
> bce9db6d ("trace2: use system/global config for default trace2 settings") [0].

So it does not help very much to stop at calling it "offending",
without explaining what problem exactly you are trying to complain
about, and why you do not want your code traceable from the
configuration.
