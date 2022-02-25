Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD543C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 00:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiBYAD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBYADz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 19:03:55 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF681F6344
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 16:03:25 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6545510F28E;
        Thu, 24 Feb 2022 19:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cGxgQYpHE6D6
        5XcG0mHkzacDYvkP9zDZoogQeixlvBc=; b=xJsKs/6yfVhXclxgxWoFDaW4cPqX
        xcXnJA+29xRCQKjM2pFAfgpNv/GysdFsdThWrChJ+EKE8cCJOidy3R8QUm720WFO
        wjpGKqFNDv+7gEkItE4w9I9+gSybkIJn9tqIErrnotHyfI32KvmCTyGrMHV7RJjS
        ArEWB9A6xwfIHkY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BEF910F28C;
        Thu, 24 Feb 2022 19:03:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7B7F10F28B;
        Thu, 24 Feb 2022 19:03:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 00/12] c99: use more designated initializers
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
Date:   Thu, 24 Feb 2022 16:03:22 -0800
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 24 Feb
 2022 10:32:55
        +0100")
Message-ID: <xmqq4k4nizhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 596BEE18-95CE-11EC-84F2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (12):
>   imap-send.c: use designated initializers for "struct imap_server_conf=
"
>   refs: use designated initializers for "struct ref_storage_be"
>   refs: use designated initializers for "struct ref_iterator_vtable"
>   trace2: use designated initializers for "struct tr2_tgt"
>   trace2: use designated initializers for "struct tr2_dst"
>   object-file: use designated initializers for "struct git_hash_algo"
>   archive-*.c: use designated initializers for "struct archiver"
>   userdiff.c: use designated initializers for "struct userdiff_driver"
>   convert.c: use designated initializers for "struct stream_filter*"
>   refspec.c: use designated initializers for "struct refspec_item"
>   misc *.c: use designated initializers for struct assignments
>   misc *.c: use designated initializers for "partial" struct assignment=
s

These patches touch really dormant parts so let's apply them and
immediately merge to 'next' and down to 'master' by the end of
month.  I really hate these non-urgent changes that might help
future code to be in flight for too long.

 imap-send.c: use designated initializers for "struct imap_server_conf"
 trace2: use designated initializers for "struct tr2_tgt"
 trace2: use designated initializers for "struct tr2_dst"
 object-file: use designated initializers for "struct git_hash_algo"
 archive-*.c: use designated initializers for "struct archiver"
 userdiff.c: use designated initializers for "struct userdiff_driver"
 convert.c: use designated initializers for "struct stream_filter*"
 refspec.c: use designated initializers for "struct refspec_item"
 fast-import.c: use designated initializers for "partial" struct assignme=
nts
