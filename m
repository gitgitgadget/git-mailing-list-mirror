Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBFC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B9B206C3
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mkOEO9J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGJQHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:07:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55183 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJQHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:07:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 217057C2B9;
        Fri, 10 Jul 2020 12:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1IoLogtrRt0ydkGFFaWql7wpIQg=; b=mkOEO9
        J4LECLruo92KQrHjblmwAIDYtkubFMK94W1bfK+hg5cjwJFfhZhgdu9SIgsNgeTv
        ZnxK2ZjkhPgnWNVWmhUO/FhK/l89dGKUMShju0HrLmO6FUWHZ3PpM6zR8V7EquPH
        sxuf1hqHdwEON1LO+5qcA3gxhbbcLHR7cTw8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i1kjLjZTTyHR9D1nDHNntcGkNe5gErUI
        QT3dlfN+nQEVFmHC09W2TtqefypQvoVbEWNbvaTVltzs5iw915QAp1EX/zoRcQBP
        EgNqCspKnT5IUGkdNGwWTjtOhyICsAVzNF0UDpaZNvfu0LTWMoM87HdqRi5OaXUj
        Ja9ntr2kGEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16D757C2B8;
        Fri, 10 Jul 2020 12:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D0AF7C2B7;
        Fri, 10 Jul 2020 12:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.28.0-rc0
References: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
        <01e87be3-3911-afc1-e738-69446275c8c0@gmail.com>
Date:   Fri, 10 Jul 2020 09:07:09 -0700
In-Reply-To: <01e87be3-3911-afc1-e738-69446275c8c0@gmail.com> (Derrick
        Stolee's message of "Fri, 10 Jul 2020 08:58:06 -0400")
Message-ID: <xmqqa707uzf6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6908DE52-C2C7-11EA-B68D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/9/2020 5:40 PM, Junio C Hamano wrote:
>> An early preview release Git v2.28.0-rc0 is now available for
>> testing at the usual places.  
>
> This might be part of your new process, or it might be an
> oversight. It seems that GIT-VERSION-GEN did not update with
> this RC, so the built version will still have a 2.27 start [1].
>
> This differs from previous rc's [2].

Sorry, I screwed up.  Thanks for a set of sharp eyes.

I however think that there is no practical problem other than for
those who "grep DEF_VER GIT-VERSION-GEN" and base their action on
the result.  If somebody is building from the tarball created by
"make dist" (be it done by me and uploaded to k.org or done by
somebody else from a clone of my repository), there would be the
"version" file included in the tarball that would override the
DEF_VER setting in GIT_VERION_GEN.  If somebody is building from
a clone of my repository, GIT_VERSION_GEN runs "git describe" to
find out which version it is, without using DEF_VER.

The only three unrealistic classes of users that may be affected
are:

 - The ones that single-branch cloned from me _with_ --no-tags, so
   that "git describe" is run but cannot find what version it is.

 - The ones that _somehow_ cloned from me _without_ having any
   version of git that can run "git describe" in the repository.

 - The ones that receives a tarball that was created by running
   "make dist" in the directory that resulted from extracting the
   official tarball and then removed the ./version file included in
   the official tarball.

For the people in the first two classes, GIT-VERSION-GEN would fail
to use "git describe" to find which version it is building, and end
up using DEF_VER.  We can call the third kind a crippled/sabotaged
tarball---without the involvement of the person who extracted the
official tarball, munged the resulting directory and then made a
different tarball by running "make dist" in it, the builders would
not see DEF_VAR being wrong.

Thanks anyway.  I'll try to be more careful when tagging -rc1


