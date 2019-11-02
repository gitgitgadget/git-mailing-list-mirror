Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225761F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfKBE2n (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:28:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61953 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKBE2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:28:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3E3F9BEF5;
        Sat,  2 Nov 2019 00:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DsNOr/K5vAv+9ykBJTmBGBDLCRM=; b=F4zZbZ
        TpFhKdiyiX83BJveAGuZXSc9ZBz4Ean+68KCDzygDUNXL7ZxYY/BrBbG9zEQdPF1
        fbCUjyKyWfqaiFFrR26DwujU8RNBjxPgtntss+GhASa3Pcn1oFXQknVD8kV67/59
        ARqIyGpNpzdj6gnpH5de2ZVSvw3m6lgNTLNWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sge/IiPJ0mdhFLZlotPstTgpG/l/44R+
        h18V7TTHV2c/sIDjxZlK8BT4vXDyX0cN86iteuRryHdJld1vQ9yLY37dNz+8ZFF8
        tX4gk5KJIkfn0wkFg1A3rzWqnv5YG0GEKM+/iGogMrleVdYrF+zpIAYegA5o2GVg
        yWvc0+TXbhw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A7E19BEF4;
        Sat,  2 Nov 2019 00:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB9AB9BEF0;
        Sat,  2 Nov 2019 00:28:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] merge: move doc to ll-merge.h
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <504f1f7c892c8bfc4774ac5fec912855e74e38a5.1572343246.git.gitgitgadget@gmail.com>
        <CABPp-BEYeCwTKXLTdaORrBGAFYb0X13rMMiQXwXv=UDSBKHnYQ@mail.gmail.com>
Date:   Sat, 02 Nov 2019 13:28:36 +0900
In-Reply-To: <CABPp-BEYeCwTKXLTdaORrBGAFYb0X13rMMiQXwXv=UDSBKHnYQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 30 Oct 2019 15:09:42 -0700")
Message-ID: <xmqqv9s252bv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E14134C-FD29-11E9-9809-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks for the contribution.  I know you weren't the original author
> of most this stuff, but I was curious if it really all belonged in
> ll-merge.c and then noticed other issues...
>

Thanks, both.  Especially thanks Elijah for all good comments.

