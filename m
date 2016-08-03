Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05A41F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcHCP6z (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:58:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751351AbcHCP6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:58:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 256402F438;
	Wed,  3 Aug 2016 11:58:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cDBJTHqgKuaaDr8pzd4UeeLopCk=; b=DVR26S
	ujr4iI6OCNM/qJfQLl5Q+xcaY6DlnFSlbis2bBQXQZprb85/MVcg6kNZf2HMmyZe
	Ad2+Mg3nvd+vWMSibiKC2Y3g9m3Lip/9FovCtghVrM5iPhIbo4LzKKvdVN4U3KQg
	Gsj9dmp23DljGPcPR3L8eCQLK/EHuf06wnXmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6qdSaYhfYrPEXalkm7aQvpzA8TZb650
	GMPm3wLN52PdFanXz39tW+SYGlaZ3Bl3rbucZ90gJGG/UHbuyP6tnjdtkoJ+2AQg
	T2tHn+gWe+rohlZxKu2NtasMe0vPZ6sfKJZEjS6RL9566Vl+1yaLErHUvsqw/+1g
	mTtwRbymKJc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D48E2F437;
	Wed,  3 Aug 2016 11:58:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DBA92F436;
	Wed,  3 Aug 2016 11:58:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeremy Huddleston Sequoia <jeremyhu@macports.org>
Cc:	git@vger.kernel.org
Subject: Re: 2.9.2 test failures on macOS
References: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
Date:	Wed, 03 Aug 2016 08:58:16 -0700
In-Reply-To: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org> (Jeremy
	Huddleston Sequoia's message of "Wed, 3 Aug 2016 00:35:55 -0700")
Message-ID: <xmqqziotalpj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 186804B0-5993-11E6-B89A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@macports.org> writes:

> t3700-add.sh recently added the 'git add --chmod=-x stages an executable file with -x' test.  This test passes when run as a normal user but fails when run as root:
>
> $ ./t3700-add.sh

This has been spotted and corrected on the development track
already, I think.  It will hopefully be in a future maintenance
release.

If you have a chance, perhaps you can fetch from my tree at
git.kernel.org:/pub/scm/git/git.git and merge 766cdc41 (t3700: add a
test_mode_in_index helper function, 2016-07-30) to confirm the fix?

Thanks.
