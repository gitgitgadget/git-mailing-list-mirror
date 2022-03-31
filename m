Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB6C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiCaBwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiCaBwF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:52:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0742EED
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:50:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2A2C17D525;
        Wed, 30 Mar 2022 21:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UjMSwim4M+Uv
        hgn4BWDszuqgB6ImTlX76J2aFALsZg4=; b=Bj0GTzM9rtTyoHSTRPcJYzLH9JV5
        PhWmOab3MFl3dIiyameSN89CKup6s/pJkcPRv7I+M8CF+h/AXjYS7xFsiDF8Ndoh
        e6oV38MlD22kFO3+MzydiBHsp8/cyg9g5XfOv9EYXak5vn/mE75p4jGZ5bnmE06j
        SWa+Hk2/dbEcmus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C24B17D524;
        Wed, 30 Mar 2022 21:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 137E217D522;
        Wed, 30 Mar 2022 21:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 0/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
Date:   Wed, 30 Mar 2022 18:50:15 -0700
In-Reply-To: <20220328191112.3092139-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 28 Mar 2022 19:11:09 +0000")
Message-ID: <xmqqk0ca51rc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E982AAEC-B094-11EC-9DC4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Sometimes it is useful to get information about an object without
> having to download it completely. The server logic has already been
> implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> info, 2021-04-20)=E2=80=9D. This patch implements the client option for=
 it.

Merged to 'seen', this seems to break a test in t5583.
e.g. https://github.com/git/git/runs/5763421702?check_suite_focus=3Dtrue

Thanks.
