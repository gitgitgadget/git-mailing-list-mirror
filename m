Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62EC1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbcJTQRA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:17:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60162 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932817AbcJTQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:16:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B215046B0C;
        Thu, 20 Oct 2016 12:16:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMWAhlBaxUcvV1bYO059yfw1w0k=; b=fTBYf0
        dla9WBU5gkTngNkjsdFpU7+khM6C9A/hiLukovCysUU5mzFPj24HUi8ODoFcTQgw
        W0CXb8eYOCbmL8hg0s7ft8o9HN/HcLr/H0z90uTM7Nk0RQN14Nf/DVZOj84cFQoT
        3RvOMhtoYwy+Eav5JeVKs3KZaIokOpcSqnqZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YJgCoUtuQwKqxl5gJdMMQYMKcjchTA8S
        iNzW4TNiODKarnXGtjEnQHpbKFal/xln8KuFHS1v0GaaHnQ7NWW5g0GOn1zz6Pd4
        k0BkyiPLxAaG2O7q8UeVubDfYbgHEN3fHo0w7idvvO5NbUb5W3o9j9YY9d4S9tzr
        uwXrxrKjx/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA8DC46B0B;
        Thu, 20 Oct 2016 12:16:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 316CF46B0A;
        Thu, 20 Oct 2016 12:16:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
        <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610201154070.3264@virtualbox>
Date:   Thu, 20 Oct 2016 09:16:56 -0700
In-Reply-To: <alpine.DEB.2.20.1610201154070.3264@virtualbox> (Johannes
        Schindelin's message of "Thu, 20 Oct 2016 12:17:33 +0200 (CEST)")
Message-ID: <xmqqmvhzhu6f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FFA2176-96E0-11E6-ADD2-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, if you continue to resist (because the problem is obviously not
> affecting you personally, so why would you care), I won't even try to find
> the time to start on that project.

Sorry, but I did not know I was resisting, as I didn't see any
proposal to resist against in the first place.  I was trying to help
by mentioning two tricks that may be helping my test runtime that
may help you as well.

Are you proposing to replace the tests written as shell scripts with
scripts in another language or framework that run equivalent
sequences of git commands that is as portable as, if not more,
Bourne shell?  If that is what you are proposing, well, I won't stop
you and I may even help you in there, but I fail to guess what
alternative you have in mind.  I certainly do not have a suggestion
myself and I won't suggest migrate to tclsh or perl for that matter.

If that is not what you are trying to propose, and if parallelism
has already been employed, then there may or may not be other tricks
you are not yet using that helps to speed up your shell execution
that others are using---being confrontational is not an effective
way to ask others about them.
