Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Spfuqy+0"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38347E1
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 04:05:01 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D7C01BC326;
	Mon, 27 Nov 2023 07:04:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e4J37cz2UviQ
	0S6sAcM7GTEjBppzFp/XBRS+wpyK8fg=; b=Spfuqy+0TRsvOwoW6uC9bzXo4a5e
	AZ4sxsKfR+11sDzFk+CJ43XaQaL3DdDOz6UtVPNhOrjehIGJ5PryFa16MFCIjfW+
	Nf92xkheox7grOKhARATMGN6vmfDj0LMaxXAALKMY0B89CWoy3lAlTo1qEYniIft
	OUCXiN/QyQL2dhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74D0A1BC324;
	Mon, 27 Nov 2023 07:04:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEF0D1BC323;
	Mon, 27 Nov 2023 07:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] column: release strbuf and string_list after use
In-Reply-To: <f087137d-a5aa-487e-a1cb-0ad7117b38ed@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 26 Nov 2023 12:57:36 +0100")
References: <f087137d-a5aa-487e-a1cb-0ad7117b38ed@web.de>
Date: Mon, 27 Nov 2023 21:04:56 +0900
Message-ID: <xmqqr0kb2yhj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2F168DBA-8D1D-11EE-A324-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Releasing strbuf and string_list just before exiting is not strictly
> necessary, but it gets rid of false positives reported by leak checkers=
,
> which can then be more easily used to show that the column-printing
> machinery behind print_columns() are free of leaks.

Thanks for being careful.  Will queue.
