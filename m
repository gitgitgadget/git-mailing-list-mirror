Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE251F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKZRqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:46:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65489 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZRqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:46:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B61B61DD69;
        Mon, 26 Nov 2018 01:53:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T2zZEc0ZHWbI
        AKL/MkMkNHCZkf0=; b=He3rl5I76YyRcmNsGRvGxX2p2fxtrfF2mBkUfYO7Q0jB
        iVT8mCBREtxxobX2T1c6/CIDUNZ6rII4+82UsUGsEzEaTuT39hX2u5c+pKM/VdJL
        L79HKNVq64V5JLVEHnfNSgaoht1aaELo95HTS7eZuq0oqvQ+dtytPWUGN0KQYNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Lx8iFq
        9x9S4TFHnUaJh3PEjvqIoDuyVmPPl3P9vo/tw1AFUCCBSxi9oup1XrT/F2qRmsWM
        SRYwVXVQcpqVbMBDt6riBQNIy+Gg66s0Lri0gHZ3n470l3NWMB/aCDHnNNwi2flg
        fmtg3yK4VJbVjdfh259pI+va19HLZPK/yID8o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEA1C1DD68;
        Mon, 26 Nov 2018 01:53:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 720421DD67;
        Mon, 26 Nov 2018 01:53:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] config.mak.uname: use pkgsrc perl for NetBSD
References: <cover.1543143503.git.carenas@gmail.com>
        <f7a41204f9c70e3c659877412719f17dc9805589.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:53:09 +0900
In-Reply-To: <f7a41204f9c70e3c659877412719f17dc9805589.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:50
        -0800")
Message-ID: <xmqq4lc4xrca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F081E3B8-F147-11E8-A251-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> otherwise will default to /usr/bin/perl which wouldn't normally exist
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

I do not have experience with NetBSD so I take your words on face
value.  This patch makes sense to me.

Thanks.

> diff --git a/config.mak.uname b/config.mak.uname
> index 59ce03819b..d2edb723f4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -249,6 +249,7 @@ ifeq ($(uname_S),NetBSD)
>  	OLD_ICONV =3D UnfortunatelyYes
>  	BASIC_CFLAGS +=3D -I/usr/pkg/include
>  	BASIC_LDFLAGS +=3D -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
> +	PERL_PATH =3D /usr/pkg/bin/perl
>  	USE_ST_TIMESPEC =3D YesPlease
>  	HAVE_PATHS_H =3D YesPlease
>  	HAVE_BSD_SYSCTL =3D YesPlease
