Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F39C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF7E6141D
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhGBPls (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:41:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGBPls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:41:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D20DC14CAAF;
        Fri,  2 Jul 2021 11:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SFm6dMSyjfOOtFZZ27KMOoTEq2jn8fQvHx3lO2
        mxiFo=; b=ReujDgQoHhUD0EfUj4jmnPvlZLYHLUGeIKzaL62UeyTNOZBHkw9WKF
        llstwI4fgHsLnPMMEP4gW3CCyvGrKgRRs+IB4vyq5aP+J0VXUKawxREgduXsuhkm
        JDLB4+iOfLDBhWpt5Tqzs46J2uRs8aJKiM159xOYY2cpCsr4QP8bQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C37D714CAAE;
        Fri,  2 Jul 2021 11:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AB3914CAAD;
        Fri,  2 Jul 2021 11:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'martin'" <test2@mfriebe.de>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Andreas Schwab'" <schwab@linux-m68k.org>, <git@vger.kernel.org>,
        =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmaso?= =?utf-8?Q?n'?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 5/5] config: add default aliases
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
        <20210702100506.1422429-6-felipe.contreras@gmail.com>
        <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
        <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
        <60def07e686c7_7442083a@natae.notmuch>
        <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
        <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
Date:   Fri, 02 Jul 2021 08:39:11 -0700
In-Reply-To: <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 2 Jul 2021 09:26:30 -0400")
Message-ID: <xmqqr1ggpvxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6BB7CDA-DB4B-11EB-8CEA-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I am sorry if I am coming across too strongly on this subject, but
> I do think we are overloading alias capability and intruding on a
> domain that should be reserved for our users, not ourselves.

Well said.  The customization feature is for helping users, and we
shouldn't get in their way by adding unnecessary ones ourselves.

I wouldn't recommend us to force to our users even "co is for
checkout" that everybody seems to have.  Adopting such a
customization or not should be up to the users, and we should not
get in the way of other users who may want to say "co for me is
commit".

One thing that might (or might not) help to help users and projects
share the same set of aliases is to make it easier to audit shared
configuration file before inclusion.  I wonder if would help to
introduce "include.allow" and "include.block" configuration variables

    [include] ;; or [includeIf "<condition>"]
	path = /usr/share/git/contrib/svnlike.alias
	allow = alias.*

that tells us to only pay attention to the configuration keys that
match these 'allow' patterns when reading from the given path.

But in practice, 'alias' is one of the riskier things you can set in
the configuration file, so it is of dubious value to say "with this
allow-list feature, you do not have to worry about random cruft
defined in the included path---you only need to concentrate on
auditing alias.* configuration items in there and nothing else".

