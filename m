Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197AAC433E1
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4749206A2
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xclPm19S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHITBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:01:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60657 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgHITBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 15:01:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D01D8E1C59;
        Sun,  9 Aug 2020 15:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SC1OhcSrojAK
        KbbuS3hKA6uhmBo=; b=xclPm19SgbsOXe91xsxGfC92wd9M7oYLjtIjLrks4VoM
        t3KdHAJ2HtzQo57KpO49MZSofCIzsy2/rGPi1pECneOSYSj8R4Q5+YMi4i8wfZgT
        NHHL79CfTIBMoCH4wJacjNnku7ocf5SrAOk8lduvIcFXY/0BcCDKry9oe3qaRX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rewdvf
        rr6dM+Wty1quMFwQHE9e8+OIRZrHjHkdhcx6ebGHfaomdKBkj9eTDSzTDHdbNbu6
        Bh9ferB+ktkmwHOv3AbJrBeIxWXdv1uu6UVtfK2SfWxixAMa5R+nAmK/ollrjnOQ
        3QjFV65nOYOU7HPJ7qnVCUwVRQOX4esDMhFf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8472E1C58;
        Sun,  9 Aug 2020 15:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B082E1C57;
        Sun,  9 Aug 2020 15:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
References: <cover.1596887883.git.congdanhqx@gmail.com>
Date:   Sun, 09 Aug 2020 12:01:35 -0700
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Sun, 9 Aug 2020 09:19:03 +0700")
Message-ID: <xmqqd03zej8w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C00A245A-DA72-11EA-BB80-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (2):
>   revision: differentiate if --no-abbrev asked explicitly
>   diff: extend --abbrev support to diff-patch format

It was not clear, at least to me at all, what these patches are
trying to achieve (i.e. what end-users appreciate) until I saw the
code change X-<.

The changes to fill_metainfo() make sense to me.  It just needs log
messages that explain the intent better.  They do not even make it
clear that they want to make the abbreviation length of the object
names on the "index $from..$to $mode" lines configurable.

Thanks.

