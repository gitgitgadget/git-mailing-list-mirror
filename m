Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAA7203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbcLMT2x (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:28:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752112AbcLMT2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:28:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D52577A9;
        Tue, 13 Dec 2016 14:28:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D6zjJdzN4u/RQILHAVOwhaREoe0=; b=SypdQZ
        dzl+2c005axHlCUO7OcyiXayX5wGvw33xR4ZJEbCG97AWwhLWugr4ABBooc2pb5l
        8L6Dk8WYuJzM8UseZEM8wIk50yIioiQoeesgMFwbi937PtaeM1xmuxgm2W0dtw3e
        BdQ2LE3HXsolCs5hUNQAqlY/PsHXgz4FtbFVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rkyucy8qOxooTj/QH+yBUOanR53/JHx4
        GiAiN5Y1ii5mZxt9x+deb4Gk/dvTqVHrxLuKwYWZz5vvwKn8fmdE27cC3tkH+bV1
        kKeRPXn7fYrtRxpVVciKHIHzOIKlP/q0yOudn4wAC0Y/jdj2LfZ9uVd3ortEDAZ6
        FXgclNb7vXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A5C0577A7;
        Tue, 13 Dec 2016 14:28:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E56757792;
        Tue, 13 Dec 2016 14:28:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612131839220.3147@virtualbox>
Date:   Tue, 13 Dec 2016 11:28:21 -0800
In-Reply-To: <alpine.DEB.2.20.1612131839220.3147@virtualbox> (Johannes
        Schindelin's message of "Tue, 13 Dec 2016 20:19:15 +0100 (CET)")
Message-ID: <xmqqeg1b39yi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FCAD696-C16A-11E6-900B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ok 13 - grep tree and more pathspecs
>
> expecting success: 
> 	git init parent &&
> 	test_when_finished "rm -rf parent" &&
> 	echo "foobar" >"parent/fi:le" &&
> 	git -C parent add "fi:le" &&
> 	git -C parent commit -m "add fi:le" &&
> ...
> 	test_cmp expect actual
>
> ++ git init parent
> Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
> directory.t7814-grep-recurse-submodules/parent/.git/
> ++ test_when_finished 'rm -rf parent'
> ++ test 0 = 0
> ++ test_cleanup='{ rm -rf parent
> 		} && (exit "$eval_ret"); eval_ret=$?; :'
> ++ echo foobar
> ++ git -C parent add fi:le
> fatal: pathspec 'fi:le' did not match any files

I think !MINGW prereq is missing?

