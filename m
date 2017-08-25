Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B252D208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 22:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbdHYWLN (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 18:11:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57340 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932833AbdHYWLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 18:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF5999E055;
        Fri, 25 Aug 2017 18:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EBZj9XNsOoKTMyIwTePlLY2VX9k=; b=PxQ95r
        UA77FXFLh/ZAnUpBgCIowTysAqeJtg0KVW2o4xYa8WXBwG7pkWLd2DQYcPig//Vz
        4bPZIdeFdex2q+3/u0pNNsY0f2EnE/HgetAZmtse/cFFpLNsLsc4b+rjGQZOcJW8
        D+jFj3UAGu+XiYJp0hffJqJWJLaCA9SReEqys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZeTGN52J5SBcy6OCg7ujWBAketPMg51X
        BqSXvuGSFLN+ayu53mIj9oQZOTXrzrWk3ibjktavo4JFSaVB/8Sn0UXtwXMbABok
        JaVvq9FL2LjAvvvSMSVE3IIOoRrfvuWkA9nxJvVo6U9t4jWZY6/qvLJB5XKJeM1D
        ZnHo6vVt3Uw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C87CC9E054;
        Fri, 25 Aug 2017 18:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34F589E053;
        Fri, 25 Aug 2017 18:11:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: git signed push server-side
References: <22944.38288.91698.811743@chiark.greenend.org.uk>
Date:   Fri, 25 Aug 2017 15:11:09 -0700
In-Reply-To: <22944.38288.91698.811743@chiark.greenend.org.uk> (Ian Jackson's
        message of "Fri, 25 Aug 2017 22:24:32 +0100")
Message-ID: <xmqqzianqow2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D6708CA-89E2-11E7-A32E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> I have been investigating git signed pushes.  I found a number of
> infelicities in the server side implementation which make using this
> in practice rather difficult.  I'm emailing here (before writing
> patches) to see what people think of my proposed changes.
> ...
> If I send patches like the above, would they be welcomed (subject to
> detailed review, of course) ?

When I did the signed push, the primary focus was to get the
protocol extension right, and what the server end does with the
received certificate was left as something that can be refined later
by those who are really into it.  

So I do find it a welcome development that you are looking into it
(but remember, I do not represent "people"---I am merely one of them).

I and others may or may not have objections and may or may not offer
better ideas over what you are going to write in your design docs
and patches---I cannot promise anything before seeing them.



