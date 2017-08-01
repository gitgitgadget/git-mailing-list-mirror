Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098A82047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdHAUzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:55:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752492AbdHAUzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:55:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B712A0C6C;
        Tue,  1 Aug 2017 16:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1RoWet/705nIuZHtHJ1XYJDqzFw=; b=BjORkP
        aMfnLwxoInGyJ4OAO86V+SghBEJEa+D1zpz+BCtr4RvxG6RDd8SkZHDSGIiDj1DH
        EwY7HZQazvL8HP0M7AcRhKB7rW3q4TaqMWCrzIqnSzdDII3YA4sk64D3JTkxOmvV
        HNVmxjVG/AucwmEIuN2nhioCaPTlHYqv7YVfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OBfbseL2uLU84Gt4oOWkd3UAAr8CTo0g
        KHGjSMtBRDVnppsHF81rsO+dsvPkifGHivpcoNjgzxtK89BSBHL/dGIzemGKhFmn
        iOeLgH0XAeaiG9GAe6OsdMnX4VjaRqoDEYXA2Yxb4zj6CUKcg4XeW1oUVpQmVX5f
        //gCz7AfJtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EFE6A0C6A;
        Tue,  1 Aug 2017 16:55:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60988A0C69;
        Tue,  1 Aug 2017 16:55:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     greened@obbligato.org (David A. Greene)
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Moving main git-subtree development. to GitHub
References: <87mv7kf369.fsf@waller.obbligato.org>
Date:   Tue, 01 Aug 2017 13:55:02 -0700
In-Reply-To: <87mv7kf369.fsf@waller.obbligato.org> (David A. Greene's message
        of "Mon, 31 Jul 2017 21:10:54 -0500")
Message-ID: <xmqqzibjdn4p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0DAC51C-76FB-11E7-A458-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

greened@obbligato.org (David A. Greene) writes:

> Going forward, I would like to do the main feature and bug fix work on
> GitHub and periodically subtree-merge to git's main repository under
> contrib when the code has stabilized and we are reasonably confident
> interfaces are stable.  This will allow us to experiment with new ideas
> while keeping a stable codebase for end users.
> ...
> Does this mode of operation work for the larger git community?  Are
> there suggestions of how to make this work as smoothly as possible?

As a reasonably well-known and mature project, I'd actually welcome
the idea of git-subtree graduating from my tree and standing on its
own, managed in the way its developers and users prefer using the
workflow they choose to use.

If it is a good idea to keep a copy in contrib/, that will stay to
be slightly to moderately stale depending on the phase of the
"upstream" development, by periodically accepting code dumps?  I do
not have a strong opinion on this.  It is not too much work for me
personally to do so, but

 - I think git-subtree no longer needs the "contrib/ bump" to
   sustain its userbase and community; otherwise you wouldn't be
   sending out the message I am responding to.

 - Seen from the world outside the Git world, it may be confusing if
   two different "sources" of git-subtree exist; the users and the
   distro packagers want fewer choices in things like this.

So I do not have a good answer to what should be done to the copy in
contrib/, at least not yet, but I think it is a good idea to separate
it out as its own development project with its own community.


