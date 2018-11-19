Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867071F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 00:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeKSK2u (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 05:28:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60476 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeKSK2u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 05:28:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C38591C5D3;
        Sun, 18 Nov 2018 19:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5Pz+RO9dbFfn
        WZY9xsM7PdvwZA4=; b=GuRX+YBTJ86bLvY1R89vvUbjrR/GFGhYtdd3S34/Ygax
        zRU88KlNoJc3kxRwE/FH2zZ+AqtEaz4/a9bK3J+SkXqwlBKVGW8omBXuFoVw0qxK
        ckNWXC6bMI8qVB5HcH5kamgaDTf8gFKKlhI6eSt7kOvwJIMNXCFDRUxHjRLMnH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r5VWyk
        zPeIo0pDyTl8+AjZVHVa1T9HGIMVmvqUnPBJ3kZhyzDBL9qA7SAEkey5cLJ12jV8
        vZPCjSKyR95gWQy7L2X88BUjhOyu5NsQHw1R2ekCuK8ETjntYIAp7Wt5WBqFfKTP
        G4HacViLUjEwvBHh7tuhABFX2QkFtC2uXekSI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC50A1C5D0;
        Sun, 18 Nov 2018 19:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEF7B1C5CE;
        Sun, 18 Nov 2018 19:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
Subject: Re: Cygwin Git with Windows paths
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181118154124.GA21680@tor.lan>
        <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
        <20181118171525.GA25854@tor.lan>
Date:   Mon, 19 Nov 2018 09:06:56 +0900
In-Reply-To: <20181118171525.GA25854@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Sun, 18 Nov 2018 18:15:25 +0100")
Message-ID: <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08675C9C-EB8F-11E8-AA84-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> And it may even be that we need a special handling for the "\" to be tr=
eated
> as "/".

I do not do Windows, but is_dir_sep() needs to be tweaked if you
want to do that.
