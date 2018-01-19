Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D35B1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756307AbeASVUp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:20:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61081 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbeASVUo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:20:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD1A6CA9F1;
        Fri, 19 Jan 2018 16:20:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KcJw++Xz9WYh
        uC0jsYzMw2Zi9zY=; b=nonoDfLc0W5DuWIQRYrJJyyvZgFLoWIdYnT2oz3pkawf
        ydpJZR1MM5NFhbP8cja+MLEktPs2rBqjr9wOHIX+bLWDmqnyRHJZgpKDpm7OABKx
        AysVqQFTmeoc+1hOX8WSXBdD32KUPLf63NNc8iD6Ynix9nfluaUjKpjFAB+AZKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YMnMQG
        QyfVA8oKAQAyV9r0bFs405QHin2ZFTk4lcY9Du6g6YiXVE9m4MKH0Any16q3JXGv
        cdhxmRvTYip98kPSgWfOPAArMNhYnjbGoXCsk9UenuU+AcaPz2LGzl2Tw/GffxUN
        kpa76W0/F4LUSS1sfPkYm66yvBqn0PIEuOXTA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D531DCA9F0;
        Fri, 19 Jan 2018 16:20:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CF83CA9EF;
        Fri, 19 Jan 2018 16:20:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
References: <20180113132211.13350-1-pclouds@gmail.com>
        <20180118100546.32251-1-pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 13:20:41 -0800
In-Reply-To: <20180118100546.32251-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 18 Jan 2018 17:05:46 +0700")
Message-ID: <xmqq607xpmty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9B5BD296-FD5E-11E7-88D0-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>      Documentation/merge-config.txt     |  4 +
>      builtin/merge.c                    |  2 +
>    A t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++
>      t/t7612-merge-verify-signatures.sh | 45 ++++++++++
>    4 files changed, 132 insertions(+)
> ...
> With this tweak, the actual printout is like this
>
>      Documentation/merge-config.txt     |  4 ++
>      builtin/merge.c                    |  2 +
>  A+x t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++
>      t/t7612-merge-verify-signatures.sh | 45 +++++++++++++
>  4 files changed, 132 insertions(+)

I like the concept but given that additions and mode changes are
rare events, I am not so sure if it is worth always wasting three
columns like the above.  Assuming that this is solely meant for
human consumption and machine parsability is of no concern, I
actually prefer the output format you said you've been using your
personal fork, e.g.

 Documentation/merge-config.txt              |  4 ++
 builtin/merge.c                             |  2 +
 t/t5573-pull-verify-signatures.sh (new, +x) | 81 +++++++++++++++++++++++=
+
 t/t7612-merge-verify-signatures.sh          | 45 +++++++++++++

That is

 (1) do not change the starting column at the leftmost end, and
 (2) do not permanently allocate the columns for "compact" summary.

Instead, the above may be (a) just stealing the columns needed for
"(new, +x)" from the pathname portion of the output, and/or (2)
widening the pathname portion of the output for the whole thing
while doing so.

