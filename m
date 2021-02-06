Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28990C433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D651364E59
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 18:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBFSty (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 13:49:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhBFStx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 13:49:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0367410B263;
        Sat,  6 Feb 2021 13:49:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+NGyCorkGELisEE5+X0E7hVN/zU=; b=B/AJQ3
        aFOUjbaF72ZgxR2NeiEGlvNiu0iYTPkNa+co79SjLHvlviZdUTCUsSoNYJAr0JgY
        bHrUb9t0KA+pWSOSeEJusq3WasEba2o+7hVwxn/VFpUBkHE80s7hgdUUXNzSN5hH
        G0kwuloH8SVjzTIWQsK9sToIA8FrVGAIX1ReU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LTkyAueJOjp9RDr8nxNtyYRJuNia+9XG
        l7ip5X1bS7zXviMhMgGNpwjaOu+tquEGpUWeK2HhJSYdWF1UU85VGpzpI/qcDVTl
        l9bGd7k0+ldMcJ85Vb0nawlQhtuVLRe5n3LRPTLqcksX7AjWm3PoKLMokWVVVK2s
        6rwvf9Xug1Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F034710B262;
        Sat,  6 Feb 2021 13:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43F5610B261;
        Sat,  6 Feb 2021 13:49:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [rfh] where is coccinelle these days on Ubuntu?
References: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
        <YBylBKMG4G4dbiOW@nand.local>
Date:   Sat, 06 Feb 2021 10:49:08 -0800
In-Reply-To: <YBylBKMG4G4dbiOW@nand.local> (Taylor Blau's message of "Thu, 4
        Feb 2021 20:53:08 -0500")
Message-ID: <xmqqr1lt9gm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFA9B784-68AB-11EB-9172-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From a quick search, it looks like coccinelle was moved to the
> "universe" repository, at least in the Azure mirrors (which is what
> GitHub Actions uses):
>
>     http://azure.archive.ubuntu.com/ubuntu/pool/universe/c/coccinelle/

Unfortunately the pool/ system does not tell us which suite a
package is available in (that's the whole point of it, as it lets
them share the packages across suites without moving things around).

Looking for the package availability

  https://packages.ubuntu.com/search?keywords=coccinelle

seems to tell me about these:

  xenial (16.04LTS) (devel): semantic patching tool for C [universe]
  1.0.4.deb-2: amd64 arm64 armhf i386 powerpc ppc64el s390x

  bionic (18.04LTS) (devel): semantic patching tool for C [universe]
  1.0.4.deb-3build4: amd64 arm64 armhf i386 ppc64el s390x

  groovy (20.10) (devel): semantic patching tool for C [universe]
  1.0.8.deb-4: amd64 arm64 armhf ppc64el s390x

  hirsute (devel): semantic patching tool for C [universe]
  1.0.8.deb-5build1: amd64 arm64 armhf ppc64el s390x

but it does not seem to produce hits in any of the [focal],
[focal-updates], and [focal-backports] suites, which the actions
thing seem to be using X-<.

Hmph...
