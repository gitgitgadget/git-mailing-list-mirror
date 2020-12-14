Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7CC2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CA62250F
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441410AbgLNXA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:00:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57169 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441400AbgLNXAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:00:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3082211B41C;
        Mon, 14 Dec 2020 18:00:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cJ/s2PeMDQgN
        6qi1muYweGZnx9g=; b=qObIQgcLq4m7LP6Jrg1pEuUNxzTPLNK36ioHWnUoUXT5
        t2Und7+qA+6qr/L2NnooMof9itqBlhUhYqZPMEJha1QfajXoBB4HyWXX2+K4o/b7
        R4vrnNwI6Ne2D/87Qc05XyWEy4Fd/tYkzM3g2MaVuX4cCADs1QFnIlL+8/Kq3Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=D4+Crh
        u3veHikQGrnoO1ckEWmFUcLsJJxm/vm+TIiGyGqo/euKey9AAu3QcE//IDlEKXIO
        d7AMdxgX9W4mARQzfPF72iwM41cFTNTXddRal56VeyBPd1xA31LOnEd7f4eIb5rm
        KVfbnWNUCIZDoAqEuAhggnBcTn1zYklK5buak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29BB411B41B;
        Mon, 14 Dec 2020 18:00:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE33011B415;
        Mon, 14 Dec 2020 18:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: mention Python 3.x supports
References: <20201210143017.24615-1-congdanhqx@gmail.com>
Date:   Mon, 14 Dec 2020 15:00:00 -0800
In-Reply-To: <20201210143017.24615-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Thu, 10 Dec 2020 21:30:17 +0700")
Message-ID: <xmqq4kkoat8v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 194E2B46-3E60-11EB-8B90-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Commit 0b4396f068, (git-p4: make python2.7 the oldest supported version=
,
> 2019-12-13) pointed out that git-p4 uses Python 2.7-or-later features
> in the code.
>
> In addition, git-p4 gained enough support for Python 3 from
> 6cec21a82f, (git-p4: encode/decode communication with p4 for
> python3, 2019-12-13).

I am not a Perforce user, so with that in mind, please help me make
sure I understand the situation well.  The statement "not 3.x, which
is not supported by Perforce" is from early 2013, and 6cec21a82f
talks about the format of marshalled dict object that comes out of
p4 (Perforce) tool that needs to be read in a certain way to be
compatible with Python3.  Does that mean sometime in these 6 years,
Perforce started supporting 3.x?

The change to INSTALL just drops the mention of 3.x; do we want to
specifically say that any version of 3.x is OK, or is it generally
accepted that Python 3.x is "later" than "Python 2.7"?

> Let's update our documentation to reflect that fact.

Thanks.

> diff --git a/INSTALL b/INSTALL
> index 9ba33e6a14..8474ad01bf 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -165,8 +165,7 @@ Issues of note:
>  	  use English. Under autoconf the configure script will do this
>  	  automatically if it can't find libintl on the system.
> =20
> -	- Python version 2.4 or later (but not 3.x, which is not
> -	  supported by Perforce) is needed to use the git-p4 interface
> +	- Python version 2.7 or later is needed to use the git-p4 interface
>  	  to Perforce.
