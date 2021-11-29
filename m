Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F911C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhK2Vl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:41:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54497 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhK2Vj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:39:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77388E6D26;
        Mon, 29 Nov 2021 16:36:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fH4/iTfXoOYx
        DF2w4oFecF5ElmNNumGsUkABo0gQR3M=; b=eYFTyPOypbtpiKawF3Ppckh7be/l
        5kBAQkuE+6rk+OiBwi9e6mTV8eK4EDlixIy7fRV78uzYsqCzoXdltowR22Esg7Ma
        GxdUklECxp1WWXbdaAA/6/V1RSQPylKUecvPML2QlO6ZZB3OJ+qYcj5JMHHx1ngi
        lPrGrfKC4vrsw7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F585E6D25;
        Mon, 29 Nov 2021 16:36:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB00BE6D24;
        Mon, 29 Nov 2021 16:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/7] grep: simplify & delete "init" & "config" code
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
Date:   Mon, 29 Nov 2021 13:36:07 -0800
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Nov
 2021 15:50:46
        +0100")
Message-ID: <xmqqfsre63w8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D7FCA80-515C-11EC-91FC-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>   log tests: check if grep_config() is called by "log"-like cmds
>
> Simplified the test, and it no longer depends (optionally) PCRE. We
> just test BRE v.s. ERE instead.

Hmph.  I see tests between fixed vs basic, though.

