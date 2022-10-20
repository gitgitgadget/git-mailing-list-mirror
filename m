Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F4C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 15:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJTPns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJTPnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 11:43:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F51989AB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 08:43:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80CE21B4CDF;
        Thu, 20 Oct 2022 11:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=23ij4V3H2Ble
        MKFLcWmdv+d0skgLXNJUy5HjCaf8nbc=; b=gDuhuE0H+Udhsv+h+tpxhexIb2Ji
        sfbQZE0N+DU2ZV9bEDNbg74TXc8FewB4x/FPioybq2gh5FH/iNLXu9YeYM8vRHHQ
        FgjDQYAxOQJCxif4Jobj3nWeJPcegoySyhsuvgm2yinGUN00cDDcAXXm8ZdPpCDs
        5iz0ZzDgm8PHULM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 798B01B4CDE;
        Thu, 20 Oct 2022 11:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A31C91B4CDD;
        Thu, 20 Oct 2022 11:43:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 20 Oct 2022 08:43:42 -0700
In-Reply-To: <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 17 Oct 2022 15:14:04 -0700")
Message-ID: <xmqqczammrf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FA368784-508D-11ED-82CB-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc=
:
>
>   $ make NO_APPLE_COMMON_CRYPTO=3D1 DC_SHA1=3D1 NO_OPENSSL=3D1 compat/f=
smonitor/fsm-ipc-darwin.o =20

Glen, =C3=86var has cherry-picked the SHA_CTX -> git_SHA_CTX build fix
and I have merged it to 'next'.  Can you test-build to see if that
change is sufficient to fix "does not even build from the source"
issue for you guys?  You do not have to go through any official full
qualification cycle or release procedure---just checking that you
would be OK when you need to do the build the next time before it
has to happen is sufficient.

Thanks.
