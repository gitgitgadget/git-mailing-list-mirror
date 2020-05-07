Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77247C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430582063A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iISoioe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEGXIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:08:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgEGXIz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:08:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B6454D4C;
        Thu,  7 May 2020 19:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymqSukwfA3sU7BtR/F1p5CCL7Kc=; b=iISoio
        e26TFqFt3eZ0FcDRl0wpkW5oW0xZWtTejPJhMjifGNGeigCoznxgrW5qbexHk26r
        JS/PfM+AfvBLp3hJ3OKR1kVilueu2LKv3DaCzHraP9k5hZhunvCSQEzXtBoQcYum
        MLQ4FB1/WKNN5HFvuUZKp+s0l92yuYdSNGLrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qLURFze41Hn4MgHDGtrug1FxFptdVwsR
        LpG0D6fqZcKiGX4l9g/Fm15sQo4ogkXOHep8Oc6NNnlTT+49whzEJabROeWSQsE7
        BckxJO4EylG4HA5Ul3jwG1jxg+XK2044UIGqza6xeFZjSjn22XKvXcPaRi070Zg7
        MqwVfWHflBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C8B754D4B;
        Thu,  7 May 2020 19:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0970954D4A;
        Thu,  7 May 2020 19:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: check if one branch contains another branch
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
Date:   Thu, 07 May 2020 16:08:53 -0700
In-Reply-To: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
        (Alexander Mills's message of "Thu, 7 May 2020 15:59:16 -0700")
Message-ID: <xmqq1rnv2vi2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8B577AE-90B7-11EA-B0DF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Mills <alexander.d.mills@gmail.com> writes:

> I am looking for a command:
>
> 1>  if branch x contains branch y
>
> right now all I can find is
>
> 2> if current branch contains commit y
>
> can someone please accomplish #1 ?

Study "git merge-base --is-ancestor" perhaps?
