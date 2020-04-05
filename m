Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BBFC2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D034120644
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHEwQJ6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDEUj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:39:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53878 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgDEUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:39:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9953442CE;
        Sun,  5 Apr 2020 16:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/9OjdcYLb9v7
        6Rv82lyz+QgZuQM=; b=DHEwQJ6ruHntVohtMbfgKSepWisRCm6ipbwmtJ/buuKu
        eO0QaGoSqmSThLQ2c5B6X0mYcin7biLM4shXECOZfhYHQ09suNAomw7dOV70/AOl
        LtwxMt2GH403Dp0gvUPRf00bIJyGFbxgJ/UCuVa9ioBQcLzpmBjH/Et1gCtcuzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TIdgo/
        9orLuVOEjSwfhMuXEUF5rzu7aWMDNPCQPuR84vHnXyV02FWq6U3wy3sBMMdYRqmf
        Uqvp+5/n6L6rBvwhFatIisEArA8NU3e/u3zk+yestWcC9slXOfZmDISKKKEEqGDF
        6/p8cPjvmBBnpmWg+tvYhLl1xilpRG0QKZmSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1457442CD;
        Sun,  5 Apr 2020 16:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C16B442CC;
        Sun,  5 Apr 2020 16:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Travis jobs for linux with musl libc
References: <cover.1585474409.git.congdanhqx@gmail.com>
        <cover.1585961568.git.congdanhqx@gmail.com>
Date:   Sun, 05 Apr 2020 13:39:52 -0700
In-Reply-To: <cover.1585961568.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Sat, 4 Apr 2020 08:08:44 +0700")
Message-ID: <xmqq5zedy8dj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A52B39C-777D-11EA-A64C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> The series for GitHub Actions will need to be rebased on this series ag=
ain.
> 6/6 in that seriess will have UD conflicts.
> Please "git rm azure-pipelines.yml" to fix conflicts.

If you want to keep doing this, please take over the ownership of
both series and build one on top of the other.  I asked you and
Dscho to coordinate and work together, but Dscho seems to be
comfortable with the idea of letting you touch his series, so doing
so would still count as you two working together ;-).  I do not have
a strong opinion which parts should come first (it is something that
can be decided between you two which way is cleaner).

Thanks.

