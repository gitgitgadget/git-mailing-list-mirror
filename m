Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527F41F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756364AbcIYXSu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:18:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755680AbcIYXSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0DE840903;
        Sun, 25 Sep 2016 19:18:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UxXVNejGPkM4ndceNeNw/lTuXLU=; b=laJg9q
        navwYw6ReIGR76YiLeF0fp/kw1uTUIcioh7ZZJpZGved9mnhbS12ylPmLTc8/Es3
        btQ9vYY3BHdbWCb8qfzOdsanEhmqDUJWjp+vktsk1pJhvqAQ7NPN0rG6GHx5TMNZ
        owW5Fq+Ow44hQ5+a790fng1Y+xsCtOKdiXYZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2L7/7n7gdeSz2udiIn5lkgjaOcnAWag
        8vUvpz/xhfYbV+cskQQ2TBe8H2SfxiGC0YyJsHe/q7k4XhYOK0T8j2XXvRnNv7f3
        CmMEYqUmPljAhjkTvj937aRmoLt29U8yaNVnkqGEoNxuFobxroxvSWDKG53BDnGJ
        fd+WOz1GQ+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99CC940902;
        Sun, 25 Sep 2016 19:18:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DAE040901;
        Sun, 25 Sep 2016 19:18:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 08/11] i18n: send-email: mark strings for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-9-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 16:18:45 -0700
In-Reply-To: <1472646690-9699-9-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:27 +0000")
Message-ID: <xmqqy42fwotm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68F0C0CC-8376-11E6-B941-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -1403,7 +1412,7 @@ Message-Id: $message_id
>  	if ($quiet) {
>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
>  	} else {
> -		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
> +		print (($dry_run ? "Dry-" : ""). __("OK. Log says:\n"));

I am not sure about this change.  We either say Dry-Sent/Dry-OK
(under --dry-run) or "Sent/OK"; don't you want "dry-" part also
translated?
