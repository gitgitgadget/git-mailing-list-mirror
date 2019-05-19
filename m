Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725601F461
	for <e@80x24.org>; Sun, 19 May 2019 02:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfESCEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 22:04:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55917 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfESCEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 22:04:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14D4462CC2;
        Sat, 18 May 2019 22:04:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nj1q4o286Fx1LmeCit/KHVr9/EY=; b=lrTCrG
        dvngN6EjIbjxMBEnHvPLLnl7w7eVOFjnjL0eJDGvFP8V0tV3clsxBOG7rnDmy00Q
        RkBnuPvCfhrJziLxVgyC2XaOKqGTF2P38OOByAr6wuLk8gjVCRTzdrrInqIfEbl6
        AT0/AqxdnBguEBXuvqw3c+PuvKhtpTzNXFzJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CYMDarOkUu8THO9hehBwgQqoZmsepDDa
        H6KYzPj3SSkuFaNV5p3dDtxCKBaqZKy+h5bdOdztDe41aN0O+HUSQRkM7xU19kUO
        4pPuyy6heHL2nu9v0OSnR9IgWDfiYA0KmEW+H4bEnNSeYicNnNH7xHmGJGV1+ozW
        1WOTmjfaHCg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E60E62CC1;
        Sat, 18 May 2019 22:04:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8735662CC0;
        Sat, 18 May 2019 22:04:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH 0/3] Close commit-graph before calling 'gc'
References: <pull.208.git.gitgitgadget@gmail.com>
Date:   Sun, 19 May 2019 11:04:02 +0900
In-Reply-To: <pull.208.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Fri, 17 May 2019 11:41:46 -0700 (PDT)")
Message-ID: <xmqqk1en19pp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60D212BC-79DA-11E9-BD7C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds close_commit_graph() to close_all_packs() and then renames 
> close_all_packs() to close_object_store(). This name is more descriptive of
> its larger purpose.

OK.  Somebody needs to go though all the existing callers of
close_all_packs() to see if the above claim is true (unless you
haven't done so, that is), but I really like the general direction.

Thanks.


