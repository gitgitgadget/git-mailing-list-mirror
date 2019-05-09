Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718AA1F45F
	for <e@80x24.org>; Thu,  9 May 2019 04:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfEIEt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 00:49:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfEIEt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 00:49:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4382158061;
        Thu,  9 May 2019 00:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UoNSUu75ufkM
        SMXFRACiAR6BCGc=; b=Pzc+DagS3LTFE61w3g47OsgBmLn/xRCM38tcdGfg1YTR
        qnJ0Gb+n9oGZTs9UnO59hWEAzOvYKo8giPcMZF87zK6uTFcdlvI07box/X2d/7He
        4siXBGxp4wsBdYSlYjrzdDJjaELjNrDrtc/oZ23dEDZ+ZcIjJrwYtdUupGpP+6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ti01Zu
        +vlkGq+ou4tXOBxzMmpQGOnKVFXBLTQC+reO1cRhWdTPEV4jWmSbWoVImW56JbUc
        2JopL/04H67fuqdjMWJzdr+y/TbVwzCMWQC2fTU0AydSmxl6ifinPOzLgYxUvuws
        I2ex7F6ecdUOV2UR3Tqr7rRWe62sCXzcBHL9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DABB1158060;
        Thu,  9 May 2019 00:49:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CEE915805F;
        Thu,  9 May 2019 00:49:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
References: <pull.184.git.gitgitgadget@gmail.com>
        <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
        <20190508172029.GP14763@szeder.dev>
        <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
        <87pnoshfkq.fsf@evledraar.gmail.com>
Date:   Thu, 09 May 2019 13:49:55 +0900
In-Reply-To: <87pnoshfkq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 08 May 2019 22:11:17 +0200")
Message-ID: <xmqq8svgfczw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4666596-7215-11E9-8073-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> With commit-graph-<HASH> all these unlink() race conditions go away,
> partial reads due to concurrent graph writing becomes a non-issue (we'd
> just leave the old files, "gc" deals with them later..), no need to
> carefully fsync() files/dirs etc as we need to carefully juggle N and
> N+1 files.

The above would give a nice course correction to be in line with the
rest of the system, like how split index knows about and chains to
its base.  Thanks for a dose of sanity.


