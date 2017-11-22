Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABD82036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdKVCYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:24:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752069AbdKVCYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CE04BA7DA;
        Tue, 21 Nov 2017 21:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eoK/KvrnVfkeXjlQsJoekHJSVUs=; b=UgrBV/
        JJKlFRCmcu9p+8C2ZJWBCozuKFY6QPly1kFeX8GidqCVq1azvOftm0r+c/cKFqGT
        1sza4xvQPp9ghP0D/XQhJM24ae0QhYHjaazdMB5k2GknWDPiqB4bWbxM9dgrpFt9
        woJGpi3OkDFI04GA2X5iIs/0Rr2FOFtTnpzeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NrNsthjWq5C+lMheE9kD7yiUGxKsdFl3
        +dymDVbwMEwk2npdZXA+RLkVhsBhbHkR9U6a8Wdqi+V+ZSN13aAfCV4SJJTUOfs+
        QTiugWM3gw5vWtGyiMgvakNmBzu7lrXyK48JLi/hXao6w14UmMxM8gbTKMnJXnJ5
        kSeL/ZSNrmU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 437FCBA7D8;
        Tue, 21 Nov 2017 21:24:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7559BA7D3;
        Tue, 21 Nov 2017 21:24:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: remove explanation of "--" from man pages
References: <alpine.LFD.2.21.1711211607200.25585@localhost.localdomain>
        <20171121212305.GA16418@alpha.vpn.ikke.info>
Date:   Wed, 22 Nov 2017 11:24:12 +0900
In-Reply-To: <20171121212305.GA16418@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Tue, 21 Nov 2017 22:23:05 +0100")
Message-ID: <xmqq1skrxd83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B3622A0-CF2C-11E7-8262-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Although I agree that common options don't need to be explained
> everytime again, this change might make '--' even more obscure. To be
> honest, I didn't even know about gitcli(7), let alone most new users.
>
> In the #git irc channel we often have to explain what '--' means and
> why it's sometimes necessary.
>
> I don't however know a better solution to it more clear.

I do not agree with the starting thought of this patch in the first
place.  With the same logic, "git help" showing the most commonly
used subcommands, as "git help -a" has all the information, is
redundant and unwanted.  So is the synopsis section and "git $cmd
-h" that shows only commonly used options but not necessarily all of
them.

There may be some git-$foo manual page that do not describe how '--'
would be useful for the specific $foo subcommand that would become
more helpful to new readers if they did, and I think updating them
would be a better approach if we wanted to have consistency across
manual pages.

