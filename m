Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D29C2BA1B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811DC206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ohg6CCM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFR4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:56:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62108 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgDFR4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:56:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EF6ECBE84;
        Mon,  6 Apr 2020 13:56:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=umpbdNPfFvhG
        7gVZhQDU6sZ8zOE=; b=Ohg6CCM8qaklUbeIRMbNX5lbUH6MkLsUr6u5Dv8kYfBh
        cbCShOFZzcOI1l7S08b6MF3JdYA6CPVVlPL1/SBthY8nRlE5nC4GjAdB+Ay5sjI3
        4slCpdzr/16lOJ+0Y+XfQlgTQDf61C0KdtgTPXBmuYYCijnDAcuMrlO6WOGRTv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=He8hy9
        JjRHuEw1UfxlfqhNNdjrLSci91AWmixIOoUCwsKPwroho+koTda7gVS13ExGI+X+
        QICrTyG11+JCKIePcq3llgue9hwu3kUMtgjNjQzePBn6XmKHE9NAS0Q1fDSORmq4
        iSdZMyxDsC0PxTvoD7tb0mcC+fJ9uUfVP2jmI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17235CBE83;
        Mon,  6 Apr 2020 13:56:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A1C6CBE81;
        Mon,  6 Apr 2020 13:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 4/5] doc: be more precise on (fetch|push).recurseSubmodules
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
        <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
        <xmqqk12twq7x.fsf@gitster.c.googlers.com>
        <20200406134926.fid74suincbqlibu@feanor>
Date:   Mon, 06 Apr 2020 10:56:49 -0700
In-Reply-To: <20200406134926.fid74suincbqlibu@feanor> (Damien Robert's message
        of "Mon, 6 Apr 2020 15:49:26 +0200")
Message-ID: <xmqq8sj8wl9a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE527A78-782F-11EA-AA7C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> From Junio C Hamano, Sun 05 Apr 2020 at 14:57:22 (-0700)=C2=A0:
>> Why did you lose quotes around on-demand on this line?  Shouldn't it
>> be typeset the same way as the other one in the sentence "Defaults
>> to ..."?
>
> Yes it should, sorry it's my mistake, I'll send a new version.

Thanks.  You may want to wait a bit so that (1) others can spot
similar mistakes, if any, in the version on the list and (2) you
yourself find some similar errors while waiting for others.


