Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CCAC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiESPbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiESPbd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:31:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA1F4DF69
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:31:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE499192074;
        Thu, 19 May 2022 11:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QnC15M1jsqtV
        Agq5qDNG8NSKuVHltSAWSUJsB4QbjIk=; b=a+BNjw4yH3X3DstXFAmTWBquDvI3
        kD/jOkwTt3AkFnVu85pATgbg5uObAeCU/f4/5e+zN/ffnm1PefYh7oLVB2VJM/gc
        KZ9gQE2c9IVfye9u4NcH42V12vhrz78YzgRvFOGeUn2zuYetBx07U3Jqk6Yxg4h2
        9XtfSO50vxqjRVo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5925192073;
        Thu, 19 May 2022 11:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51E5019206C;
        Thu, 19 May 2022 11:31:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [RFC PATCH 0/2] Utility functions for duplicated pack(write) code
References: <cover.1652915424.git.me@ttaylorr.com>
        <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
Date:   Thu, 19 May 2022 08:31:24 -0700
In-Reply-To: <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 19 May
 2022 13:42:26
        +0200")
Message-ID: <xmqqmtfdr12r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BE84A172-D788-11EC-B242-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Minor cleanups thath would semantically & textually conflict with
> Taylor's
> https://lore.kernel.org/git/cover.1652915424.git.me@ttaylorr.com/; but
> which I noted while reading through it.

Very much appreciated that you marked this as RFC.

It is natural and easy to notice problems in the code that is in
flux, because it is inevitable for anybody working on the codebase
to see the changes in-flight and the original code as they review,
or as they make trial merges of their own work and see conflicts.

But making patches to address them immediately out of spinal reflex
would not help anybody.  Marking them as RFC and calling attention
by those involved in the "other topic" while the code being cleaned
up is still fresh in their mind makes it efficient to review the
clean-up while letting the "other topic" to either proceed without
clean-up or with it rolled in.

