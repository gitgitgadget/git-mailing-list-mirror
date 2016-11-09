Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA27C2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbcKIXjt (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:39:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754206AbcKIXjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:39:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0F454EA42;
        Wed,  9 Nov 2016 18:39:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LxsXwhXZPYLTjgN8Ol+RIiBsSrE=; b=ROFZG4
        9GL2/wso4RYcM9k9LXeFURTQFvgON8SxFhC/EEJXZPYj3Ur080sr+BMVtCamgb9J
        O0Ox1B401IHBn4lVvRsTGLlwVBkMknOmiwb0jG81KoXM5pTzE2Ru0TYNud1DFToz
        IiB7xRUwhx02d55p3RuGxs7ZhstuS4pjYQoSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NDiPNI7hOVcf7DFeWgikvmSpBuYo10mK
        CYJoJQ7qXh+Rsx6dOO3lKLWhRhUbpbDWnLOiKLgw58wQ/PUoDjyctV/T4a04MLFB
        RvMH6baA/hX5FXWolaj7bbbxOhQWw5B2t1zD69nCBypgzEz1fg/029ApcZcjAb7j
        qovigKqvNXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8EEE4EA3E;
        Wed,  9 Nov 2016 18:39:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BFDD4EA3D;
        Wed,  9 Nov 2016 18:39:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, tboegi@web.de
Subject: Re: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
References: <20161017002550.88782-1-larsxschneider@gmail.com>
Date:   Wed, 09 Nov 2016 15:39:46 -0800
In-Reply-To: <20161017002550.88782-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 16 Oct 2016 17:25:48
        -0700")
Message-ID: <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCA98F5E-A6D5-11E6-BDDE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Apple removed the OpenSSL header files in macOS and therefore Git does
> not build out of the box on macOS anymore. See previous discussion with
> Torsten here: http://public-inbox.org/git/565B3036.8000604@web.de/
>
> This mini series makes Git build out of the box on macOS, again, and
> disables the HTTPD tests on macOS TravisCI as they don't work anymore
> with the new macOS TravisCI default image:
> https://blog.travis-ci.com/2016-10-04-osx-73-default-image-live/
>
> Thanks,
> Lars
>
>
> Lars Schneider (2):
>   config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS >10.11
>   travis-ci: disable GIT_TEST_HTTPD for macOS
>
>  .travis.yml      | 3 ++-
>  config.mak.uname | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

I've followed what was available at the public-inbox archive, but it
is unclear what the conclusion was.  

For the first one your "how about" non-patch, to which Peff said
"that's simple and good", looked good to me as well, but is it
available as a final patch that I can just take and apply (otherwise
I think I can do the munging myself, but I'd rather be spoon-fed
when able ;-).

I do not have a strong opinion on the second one.  For an interim
solution, disabling webserver tests certainly is expedite and safe,
so I am fine taking it as-is, but I may have missed strong
objections.

Thanks.


