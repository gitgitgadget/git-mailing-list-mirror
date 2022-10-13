Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6010AC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJMUGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMUGY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:06:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374DF13ECE0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:06:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FBC315DB21;
        Thu, 13 Oct 2022 16:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hcs5Qi/Mt3mR
        +FasQMFrNv/gDDqSRU3X72rKIvVXB7A=; b=thEDfAsLZSf3cEbg6lVxksBixWIb
        K9CrSzRj9i1NX64Rlmp3axNekrIBPqewGz8u8laolvF8rtQr+4HCQjNzl8WGNaOQ
        rbq5Lk7isE1SATb2hoQQ73idtBunPo/zoOrcsRE6Gk3DWnC3i3QmEc7ZL53Pl5F1
        8G9pDOoQtb+JXSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 377D415DB20;
        Thu, 13 Oct 2022 16:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B63415DB1F;
        Thu, 13 Oct 2022 16:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
        <xmqq7d14k9uh.fsf@gitster.g>
        <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
        <xmqq35briuel.fsf@gitster.g>
        <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
        <xmqqtu47fti9.fsf@gitster.g>
        <221013.8635brldj4.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Oct 2022 13:06:20 -0700
In-Reply-To: <221013.8635brldj4.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Oct 2022 21:33:28 +0200")
Message-ID: <xmqqmt9zfpz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81C3513E-4B32-11ED-934B-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Would, for those users, be less confusing as:
>
> 	diff --git a/RelNotes b/RelNotes
> 	index d505db645be..758368388a4 120000
> 	--- a/RelNotes
> 	+++ b/RelNotes
> 	@@ -1 +1 @@
> 	-Documentation/RelNotes/2.38.0.txt
> 	\ The symlink above has no trailing NL in its filename
> 	+Documentation/RelNotes/2.39.0.txt
> 	\ The symlink above has no trailing NL in its filename
>
> *dunno* :)

I do not think so, but "The symlink lacks the terminating LF and it
is perfectly normal" would be an OK thing to say.  It would make it
clear that it is not a warning message.
