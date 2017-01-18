Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA211F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbdARTKN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:10:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751479AbdARTKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:10:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95ECB5F4B0;
        Wed, 18 Jan 2017 14:10:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VnoMPm3aLiiqNARPRE44ozTtBxw=; b=GXLgg1
        RlZj1Kh4ksZ95Fc89mDdUi9miDiduyHQDL6VRya/L1DU/BXQeRLe68K7Kus17Y3K
        9+L0CX/KuhQs9MyqSxMMM4RLxxR4/PtUVerzhP4v6cnvT5Mx2J51YQzHXTvsa8lm
        l5ynCkMy8Oy8qrd/JLC6TjjA2FbCWi4UhIF3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U8YYIFxoNg+WkvA1jJM0yxE2N+NREr29
        diBkNA9sMk8Aj5VWG+5/hbDsE0lXlX5LShRsZprrTACTBz9piBeNLsNisZHuVjtW
        3u+qhdBCpTXLSA2SgauRC0/9Lrv1mcixaGSN1sy9Ju25ffvjHWJQJYQ7na/11QlV
        kRfZB1LL+JU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B6D85F4AF;
        Wed, 18 Jan 2017 14:10:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D16915F4A8;
        Wed, 18 Jan 2017 14:10:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
        <alpine.DEB.2.20.1701161153340.3469@virtualbox>
        <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
        <alpine.DEB.2.20.1701181725130.3469@virtualbox>
Date:   Wed, 18 Jan 2017 11:10:09 -0800
In-Reply-To: <alpine.DEB.2.20.1701181725130.3469@virtualbox> (Johannes
        Schindelin's message of "Wed, 18 Jan 2017 17:34:58 +0100 (CET)")
Message-ID: <xmqqk29s9oby.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBAB15DE-DDB1-11E6-982D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > More like "git stash pop --continue". Without the "pop" command, it
>> > does not make too much sense.
>> 
>> Why not?  git should be able to remember what stash command created the
>> conflict.  Why should I have to?  Maybe the fire alarm goes off right when I
>> run the stash command, and by the time I get back to it I can't remember
>> which operation I did.  It would be nice to be able to tell git to "just
>> finish off (or abort) the stash operation, whatever it was".
>
> That reeks of a big potential for confusion.

Yup.  I agree everything you said in the message I am responding
to.  Marc's argument will inevitably lead to: It should be
sufficient to say "git --continue", as Git should remember
everything for me.  I do not think we want to go there.
