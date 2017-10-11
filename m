Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55AFA20437
	for <e@80x24.org>; Wed, 11 Oct 2017 06:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756564AbdJKGAk (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 02:00:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56496 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750729AbdJKGAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 02:00:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48987A17A5;
        Wed, 11 Oct 2017 02:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Tu+xf+eaAsJi
        iUfIoHAQxujWUY4=; b=M4jAaohRI+InYCTACljCQWFd8673W9GD2vsTiC2MeGwT
        a1jSG/2tAIBdApyDWKYq/z4KrUQrMMJ9pEB27XOPNo8WfXBAeBKIWDqd5FSLJf+O
        Q6poNfdzNedzwZChlXVql3T3OmKi1W+TyMk6UK6BIYzac6WrtSU8U8ZUQ9RWLiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oNqwJQ
        6pGcHy7nTUahnzprLbWIJ9kTiYcZzbqmFh+aQQM6IyPiaeXJwUleB6cZ8AWBXkiJ
        ovSnjJv0KJIW8dhAXXWNtJc1JwQSIIUelubY5SRYybI6ANG73LrPw6hnnd8p4hjh
        P5z1dJ4qIii0BQ8Pmmd87Esrs9raH5nAyE700=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 423E3A17A3;
        Wed, 11 Oct 2017 02:00:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB8DDA17A1;
        Wed, 11 Oct 2017 02:00:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] describe: do not use cmd_*() as a subroutine
References: <20171010134309.13803-1-szeder.dev@gmail.com>
Date:   Wed, 11 Oct 2017 15:00:37 +0900
In-Reply-To: <20171010134309.13803-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 10 Oct 2017 15:43:09 +0200")
Message-ID: <xmqqr2uamdfe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8192EDF4-AE49-11E7-97BB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Maybe you already considered all this WRT that cmd_name_rev() call, I
> don't know.  In any case, I think at least the subject line should
> spell out cmd_diff_index().

Perhaps.  The intent was to eradicate cmd_*() used as a subroutine,
so I'd rather opt to explain why name_rev() that does not return is
OK in this case in the log message without changing anything else.

Thanks for looking it over.
