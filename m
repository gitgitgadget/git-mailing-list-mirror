Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31AC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 16:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJMQdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJMQdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 12:33:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC761382EE
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:33:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1016A1BAE80;
        Thu, 13 Oct 2022 12:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0SB0MatK+GCD
        72CDuK1ST6xVcFt+3I8sBUw9WUIeMcQ=; b=nhRb0g81hU0L+1Yy86+gs0EfRCnG
        cfOT4F9DXuvHOrG+/OqlLmlNV19dhgWPE88Nnk7EXgrgdA98tAqw0cDo2UoSJFEI
        vs4N5maWwy1Z9RxzmQLx4ZCpBueEzfs5/VC1xtKV7shsLuEO53JXOA+yQlqm43LY
        NRY9IYpgdMEipIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 083C41BAE7F;
        Thu, 13 Oct 2022 12:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C01AD1BAE7E;
        Thu, 13 Oct 2022 12:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/34] doc/UX: make txt & -h output more consistent
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
        <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
Date:   Thu, 13 Oct 2022 09:33:44 -0700
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 13 Oct
 2022 17:38:54
        +0200")
Message-ID: <xmqqpmevhedz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF51FC20-4B14-11ED-A02F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We are currently wildly inconsistent in whether the SYNOPSIS in the
> manual page matches the first line of the -h output, and as we add new
> options we routinely forget to add them to one or the other (or both).
>
> Without a more complex approach it's hard to do something about the
> "or both" case. But we can rather easily test whether the -h output
> matches the *.txt version, and report differences.

Nice.
