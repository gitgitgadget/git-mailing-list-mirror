Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A8E1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKZRer (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:34:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51856 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZRer (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:34:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFB95347AC;
        Mon, 26 Nov 2018 01:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=igvkKN6wVDYr
        0sVjv5ZXgXz8VXI=; b=xmMq6VI9k+EN2wBdkyrxE4drYmiPntNK5hZjxVs6Tww5
        OfC6x13cjC+LP5Hvsa0aZRvv4z3qrFtFrbB1ZXzL1ekpIxYQM60h9Sf4qFhXm0Me
        ie4Nvk6VmOkfFiQtB1T9H+Kwj1LMo1Q+L1EUhCGnVUILJ4jkZiVnUV4V3ltVM8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=g9axpS
        HfQ8ASsGneEfvqkwazd4lkwvGlx7JkUNgQR4wsgmeZ0Ui7nMipnVcUawE1Y3Q/mM
        ICFQ8fY+Smq6AXgu20PwwYdi9zbAGBTSDkXx48bIWWd+E+elzBO+TM9jttv7pNIU
        +RGiWlJ0vjYN0kbDVVeRdkRKhgsX3veNORhpY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7AA2347A9;
        Mon, 26 Nov 2018 01:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB432347A8;
        Mon, 26 Nov 2018 01:41:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] config.mak.uname: NetBSD uses BSD semantics with fread for directories
References: <cover.1543143503.git.carenas@gmail.com>
        <80755d37b29d351b7d5a8fa5d9a22b09ba7e1d0a.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:41:34 +0900
In-Reply-To: <80755d37b29d351b7d5a8fa5d9a22b09ba7e1d0a.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:46
        -0800")
Message-ID: <xmqqlg5gxrvl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 526F54AE-F146-11E8-BC6F-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> this "fixes" test 23 (proper error on directory "files") from t1308
>
> other BSD (OpenBSD, MirBSD) likely also affected but they will be
> fixed in a different series
>
> the optional 'configure' sets this automatically and is probably what
> most users from this platform had been doing as a workaround

Yup, thanks for straightening this out.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 3ee7da0e23..36c973c7e6 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -253,6 +253,7 @@ ifeq ($(uname_S),NetBSD)
>  	HAVE_BSD_SYSCTL =3D YesPlease
>  	HAVE_BSD_KERN_PROC_SYSCTL =3D YesPlease
>  	PROCFS_EXECUTABLE_PATH =3D /proc/curproc/exe
> +	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),AIX)
>  	DEFAULT_PAGER =3D more
