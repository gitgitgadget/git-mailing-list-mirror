Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2593EC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8E561350
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhFPEwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:52:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63769 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPEwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:52:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D78AA12FD89;
        Wed, 16 Jun 2021 00:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mT7FFBays8ckCax28xCNOLt4wh+oYrcdpBLsQz
        ksG+4=; b=I4pvovbDRAdoi4/Rh7pB851xkh373J8I5sUfYsMSt7ct06AXFF7IKB
        MeyqVTeHN5zQ9DOZTThMLq+m6RVIMyVjlB5gutb137W1XqROJBD2D1eBFt/R0O05
        6B1G8mCSWEir6T7K8AOKIsiiz48CZ62FsAt3Xm02FaLkqRa12Xy9E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C367012FD88;
        Wed, 16 Jun 2021 00:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FB0A12FD87;
        Wed, 16 Jun 2021 00:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/6] gittutorial doc: replace "alice" and "bob" with
 "you" and "www-data"
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
        <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
        <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
Date:   Wed, 16 Jun 2021 13:50:28 +0900
In-Reply-To: <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com> (Bagas Sanjaya's
        message of "Wed, 16 Jun 2021 10:43:32 +0700")
Message-ID: <xmqqfsxiqup7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 602E5C96-CE5E-11EB-95CC-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> +As the `www-data` user do:
>>    >   ------------------------------------------------
>> -bob$ git clone /home/alice/project myrepo
>> +www-data$ git clone /home/you/project /var/www-data/deployment
>>   ------------------------------------------------
>> 
>
> This assumes that we're on Debian or its derivatives, however many
> users run Git on other distributions (Fedora, Arch, Gentoo, openSUSE,
> etc.), so `www-data` user may not be present there. Also, `www-data`
> is system account, as opposed to normal user account, so you can't log
> in to it; you need as root `chown -R www-data:www-data /somewhere/`.
>
> This also assumes that we use Apache HTTPD. The setup for other
> webservers may be different. For example, if NGINX is used (installed 
> from upstream packages rather than from Debian package repository),
> you need to make site root (the path specified in `root` directive)
> readable by `nginx` user.

I do not see what is wrong with all of the above.

It is perfectly fine to assume that our readers are intelligent
enough to be able to guess from the above command line example that
contents for some webserver's htdocs directory is being prepared,
and the data is coming from /home/you/project repository.  It is not
a tutorial on "how to configure your webserver and deploy directly
to its htdocs", so lack of webserver specific configuration details
is _desirable_.

Having said all that, I still like my s/Alice/Tabby/; s/Bob/Fido/
mechanical replacement better ;-)
