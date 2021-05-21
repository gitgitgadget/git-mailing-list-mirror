Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CABC04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F5961168
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEUXdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 19:33:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53895 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEUXdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 19:33:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68F9B142EAF;
        Fri, 21 May 2021 19:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KU4pDlFxAxl8zzOzlozg44M3LkQ1fA0K3andUD
        yW4zU=; b=AJGu+y5GQ16auPgN5zRZfERKsKnoocLl9wd81dxazDUi242oy8DLK2
        Qr+kjC3y2EjRrjkyxmh0YkIYhsubcTcCEoJ1Qv5FYBwArSWVL12/TGXVNK81R81g
        qZj7Q7Ye1TXIcvVERJozXWilZXSrNhLmkqJHfYjX8WTvXzOpkkt/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 629F6142EAE;
        Fri, 21 May 2021 19:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAD50142EAD;
        Fri, 21 May 2021 19:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Subject: Re: [PATCH] help: colorize man pages
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
        <xmqqfsyj1qe1.fsf@gitster.g>
        <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
        <xmqq1ra3z23n.fsf@gitster.g> <87lf8bqdv0.fsf@evledraar.gmail.com>
        <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
        <60a7f7427eab6_55039208ba@natae.notmuch>
        <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
Date:   Sat, 22 May 2021 08:32:19 +0900
In-Reply-To: <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com> (Igor
        Djordjevic's message of "Fri, 21 May 2021 21:48:17 +0200")
Message-ID: <xmqqpmxjr7cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9B444C2-BA8C-11EB-8DDE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi all,
>
> If I may, NO_COLOR approach seems to be rather straightforward to me, 
> as per description on their homepage[1] - make all software supporting 
> it behave as colors are an opt-in feature, thus disabled by default.

Yes, that is correct and this was discussed already in detail a few
days ago.  You can start from here:

  https://lore.kernel.org/git/YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net/

and read two or three messages.

Note that you probably want to take generic NO_COLOR support
(i.e. teaching the "now we know the user wants the 'default'
behaviour by not having an explicit 'yes/no'; do we want to color
the output?" helper function to pay attention to the environment
variable) as taken by somebody already:

  https://lore.kernel.org/git/YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net/

Thanks.
