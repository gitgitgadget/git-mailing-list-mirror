Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3753620951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdCNWF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:05:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750760AbdCNWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:05:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4383D6D5EF;
        Tue, 14 Mar 2017 18:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VNkx1CO14h+k1GhbX4ZSs57XVDc=; b=lUTTGj
        c3f8uuY6T1PRXIY+F+HF8AKS99cT5hNQvHpTgKKOjjInPoy/gFRqeBWyCQc/kcow
        VvCZ+KjSE4Lrt15YruWCyvZufNIrk2ew8Xj66UK3h40zVKBE0PdeEuePAYxW1nFs
        PXQoiv/qinFRgt9my4xWld7FO0cOgOYZ6yay0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XjgG9in0exIt2xs3jRxWmZgALd5XZ3Tu
        ECSa14pLEog3HZYa1ZC2RuoZrTAitVAcNxatNa5PH7olzXZMPez8rlWIjU9YLKmS
        MWo6afbN96oxzR+LEj/TdAH2oTm617QBITxv7K0+AIEzGs5/JlMq84ze2WNxjT25
        DCyc++M4CNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D7FD6D5EE;
        Tue, 14 Mar 2017 18:05:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A98DF6D5ED;
        Tue, 14 Mar 2017 18:05:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-status: make porcelain more robust
References: <54df68bd46f7a417e77eb71b636f6f7afd4fce75.1489507239.git.git@drmicha.warpmail.net>
Date:   Tue, 14 Mar 2017 15:05:52 -0700
In-Reply-To: <54df68bd46f7a417e77eb71b636f6f7afd4fce75.1489507239.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Tue, 14 Mar 2017 17:02:02 +0100")
Message-ID: <xmqq8to7h5tr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 646635FC-0902-11E7-88C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git status provides a porcelain mode for porcelain writers with a
> supposedly stable (plumbing) interface.
> 7a76c28ff2 ("status: disable translation when --porcelain is used", 2014-03-20)
> made sure that ahead/behind info is not translated (i.e. is stable).
>
> Make sure that the remaining two strings (initial commit, detached head)
> are stable, too.

It seems to me that 7a76c28ff2 already missed these strings, and
their _() markings survive to this day.  Thanks for spotting and
fixing.
