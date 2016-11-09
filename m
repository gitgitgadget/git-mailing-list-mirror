Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6609C2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbcKIXEQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:04:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59949 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751420AbcKIXEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:04:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C7E04D7D4;
        Wed,  9 Nov 2016 18:04:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s513xxjCrMPvNugdGY8xsEmZANI=; b=vg+swB
        KWRhW9BdhGucaqAlEHS1dgWEtKu9RSe0bFtWfkamgsWF3xZut60osizy4CYFerNV
        Jk129AaBFzijT+9KWbVrrXIV3MLMws63XgJw01Z0XjRg+wUVKlEX9gsymUTO0xVh
        YDkmspfGSW5s0kQ8ztd8ew7hcgelmrFyFjhnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EFqkeXnl3ZwSV9PT2fc9nJ90zDt5a1sF
        nS+Sz2H3u5muzETTr9jprvN1m1IfFu5DXF+eS89vP8vHefBa9T4d5cggVm7uN3r8
        ba1jiWRAMmGAN67rkRWYRCkSf4Ngi2OjY3Fi3J7392CcdhVirn6MSTvJkkzLFtvB
        XcP1nl7MQSE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63E304D7D3;
        Wed,  9 Nov 2016 18:04:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB12E4D7D2;
        Wed,  9 Nov 2016 18:04:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Markus Hitter <mah@jump-ing.de>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 0/3] gitk: memory consumption improvements
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
        <xmqqtwbhbql9.fsf@gitster.mtv.corp.google.com>
        <8eac2a5b-071f-6d17-4d81-0744db16910d@jump-ing.de>
Date:   Wed, 09 Nov 2016 15:04:12 -0800
In-Reply-To: <8eac2a5b-071f-6d17-4d81-0744db16910d@jump-ing.de> (Markus
        Hitter's message of "Wed, 9 Nov 2016 13:39:34 +0100")
Message-ID: <xmqqinrw8dcj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D50C1464-A6D0-11E6-BF92-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Hitter <mah@jump-ing.de> writes:

> Am 08.11.2016 um 22:37 schrieb Junio C Hamano:
>> Are all semi-modern Tcl/Tk in service have this -undo thing so that
>> we can pass unconditionally to the text widget like the patch does?
>
> Good point. As far as my research goes, this flag was introduced in Nov. 2001:
>
> http://core.tcl.tk/tk/info/5265df93d207cec0

Sounds safe enough then ;-)

Thanks for an additional research.
