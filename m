Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9712C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794F8207F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="phzG81Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgG1Qpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:45:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgG1Qpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:45:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5740476700;
        Tue, 28 Jul 2020 12:45:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=o/lTW6diNpQJ
        xTpif+Ua6+CBpZ4=; b=phzG81Ujo9MZ2Mr7sJceFbkAogHOSFAHMl+LUUwFzcWe
        3QgAtysBD78savUezeIcPsZuE6CQt5drQWazIgVnEkF3jYlW0MY8OTQeXDiEA6go
        4Zsv8RDltHfZg7VQ4aFBMPTroRD5hAoVqPLD6z058e/ZoL6HMc7sbMFSkRQLbgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kkKpfn
        HXCHHyxtYsoKhFeOtxwPw4cSi8TGUhAdEreFkW5SH7J3EW3X2TuQYrAIN3THlkVh
        KWXEagA2nMubq92Hsul8Y00P78zAUIUhK6f5D594kesrW4nYSb4GuaTzkbRVnNZo
        9ukEY/QmjVhYpJSO+Ei1mJaI2zClu77cxZ7UI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C9BE766FF;
        Tue, 28 Jul 2020 12:45:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0A8C766FD;
        Tue, 28 Jul 2020 12:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/5] ref-filter: support different email formats
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ade8.1595882588.git.gitgitgadget@gmail.com>
        <20200728135803.GD24134@danh.dev>
Date:   Tue, 28 Jul 2020 09:45:40 -0700
In-Reply-To: <20200728135803.GD24134@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Tue, 28 Jul 2020 20:58:03 +0700")
Message-ID: <xmqqime7eggb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5805088-D0F1-11EA-AA05-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> This is not correct.
> RFC-822 allows @ in local part,
> albeit, that localpart must be quoted:

We do care about truly local e-mail addresses, without '@' anywhere
inside <braket>, simply because they are common in the result of SCM
conversion from CVS/SVN.

But I do not think we are pedantic/academic enough to have cared
about any local part that is unusual enough to require quoting; we
instead relied on the fact that we live in real world with practical
people who would avoid such an address ;-).
