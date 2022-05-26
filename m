Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE05C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiEZR3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiEZR3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:29:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E7674F2
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:29:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9941319DD19;
        Thu, 26 May 2022 13:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MhtPHs0JQdrR
        Drzi7PSuS18t7tyupVdLuBzvJJB8SA4=; b=XRaxq4tWFRBJIy8kYtjdI/2cfdVS
        yo33QGoldZEwKw3c7UChwWMJpLF7nPxSnA2F1ErkVwHWrdG+5F8x8z6//xiHJZ9p
        n+q0G707QLlUZmvaU5RH5qWTZdw3TrY4/zST2zMEOU2dQpar9d2wgTX3FkRaRkUN
        BX4pqJm+OoAs8qU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92E0519DD18;
        Thu, 26 May 2022 13:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A24219DD14;
        Thu, 26 May 2022 13:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <4c8ea23d-1a1d-efd4-6c11-7c08f8728d59@gmail.com>
Date:   Thu, 26 May 2022 10:29:05 -0700
In-Reply-To: <4c8ea23d-1a1d-efd4-6c11-7c08f8728d59@gmail.com> (Phillip Wood's
        message of "Thu, 26 May 2022 12:17:33 +0100")
Message-ID: <xmqqzgj4yzha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58127B08-DD19-11EC-B370-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> In format-patch we add three asterisks to the beginning and end of the
> dummy subject and body lines to encourage the user to edit them - is=20
> that worth doing here as well?

Yeah, that would make things consistent.

I am still mulling over =C3=86var's idea of preparing the messsage in
such a way that, if committed without editing, the title becomes
identifiable but too ugly to force users consider rewording (and the
"identifiable" part helps the "rebase -i" process), while making it
easy to discard the instruction for the user who do want to edit.  I
think that is the right approach, if we can find one.  What has been
floated on the list during the discussion is not there yet, but I
think the approach is a good one.

Thanks.

