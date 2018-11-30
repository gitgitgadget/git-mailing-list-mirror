Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD24D211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 01:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeK3MrL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 07:47:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60974 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3MrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 07:47:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A0771CC16;
        Thu, 29 Nov 2018 20:39:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MTvL9umzYCFg2TGQQiLaR1+Ii08=; b=gi6o2B
        H4iG0D2zQGlkWS0GxcPASnOnB5CFvS81d+FOd4Q9aC5GtrDmH76o202jORUl6en8
        Bn9SEqvvsdUR45FaCplsdJq8tB1uAmq1WwKDEihwd9M/piHv+t7CEEDFuAyCtmn3
        +PNq0SjNupLF5ArR8oA3X3Cx7AE/8MGriyuew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QqF1997OvRKDVM+5bQ/AU5/GfbyFAvot
        In7+8Cv/Cd5ecZQUGSecDc5y5DOB/5dbhNWJsRThqcPC/bRkE5yZB7D8GBljtmZH
        eW+k4T4aCFFH9WoeK418oYoWrYRc/7eLnCLPe9/iFROdr2140UoECSmkXI+XLpg7
        ocl1WSKbVeo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7273B1CC15;
        Thu, 29 Nov 2018 20:39:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BC7E1CC14;
        Thu, 29 Nov 2018 20:39:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
References: <20181127045301.103807-1-masayasuzuki@google.com>
        <xmqqwoowmfzt.fsf@gitster-ct.c.googlers.com>
        <CAJB1erVBMq84gXir1YD=3R_RXS+qXYAsPKo6ecEJBBNv-4JOFQ@mail.gmail.com>
Date:   Fri, 30 Nov 2018 10:39:31 +0900
In-Reply-To: <CAJB1erVBMq84gXir1YD=3R_RXS+qXYAsPKo6ecEJBBNv-4JOFQ@mail.gmail.com>
        (Masaya Suzuki's message of "Thu, 29 Nov 2018 11:10:27 -0500")
Message-ID: <xmqqsgzjmjho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9D229E8-F440-11E8-BE56-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Yes, I did. And it also didn't end up in a build error. Do I have a
> different build option...?

Passig DEVELOPER=Yes to make turns a bit more warnings on (in this
case, I think it was "unused-variable") and also uses -Werror to
turn warnings into errors.
