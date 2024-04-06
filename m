Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E882206E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387184; cv=none; b=erHbWAFkPXImP8C4tsbMUN2l/lwb0Zr3qys3SOH3sAvUOyZ6C9CVWhRSn1TwhMW6PQ5tyFYUGSormczcEnW0GvlPhAangNg6DiHIv3ycH2kIxGvS9LskdF+vX/NfoNAzx/Q3psvXKWXPbmgjvKRYY3v/4gDqKc3kKLLlufewr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387184; c=relaxed/simple;
	bh=kHrJS3CtmetFsemphBrlQJAzkire6t2ytc/pmDpgac8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nU7CJcdkUf9dk0JHMtTcsF/WxQxIKJPorPca+rqx2l7OFUgdozxV8wSqN1+f/Pszz9MvNH59mRa22FvGNuzWNlkA1tvE2rRYmRcC1+ThTSAO6Qp7PbIErcKgv4UFWVPH+t8v+hcvAqlupevV/5WccWlYZQW86bJo1Ww8iTj91fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NkUw6XQE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NkUw6XQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712387161; x=1712991961; i=l.s.r@web.de;
	bh=N9r+d9LXkKx2PCBSXu3glHlcqapA1Dny/RWteXLukio=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NkUw6XQEcGLn/vG6SWeV+j8Q4lspl9si6S06JdGxo1YlI9WUIR6jwxRRBgJNXIQK
	 9Bz6NX0aiWUi1GSzSJVkRv+3unPjiazMaRqQ2P6Ev/kbssMkWN5GhiFUvFJX01cpj
	 L+oChdNArGsrtsnh7ur9F2zMkCP0369kTj6OnCbOIVxCI52b2Xyg90Z4Hidz3KAa8
	 gWfh0odPhL5bsG3gKlPgDN9gkZmUj04TdsJFO2iDbnvjyVAk/iY7B/zhxRxVdIlgU
	 hAo9N0NufdSLzk3LcT55QnBLKwPxQAjI+CG6j1O10WufJ0wqG4jxmrMIbxEUIfP34
	 jIxOzZ9ZlBh3laBhoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFhg-1sOCGx1bX8-00eKcV; Sat, 06
 Apr 2024 09:06:01 +0200
Message-ID: <88f2063e-bddb-4479-a0c1-5bad582b9fe9@web.de>
Date: Sat, 6 Apr 2024 09:06:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,
 Chandra Pratap <chandrapratap3519@gmail.com>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
 <20240402204153.GE875182@coredump.intra.peff.net>
 <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
 <20240405191714.GA2561807@coredump.intra.peff.net>
 <xmqqedbjtqnr.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedbjtqnr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jljIpmUhJQhBaryNvEsa4sSUbQeNPAlKB5tKbapiCa8zq32pHAg
 ThreyecagHOV60xYCs71horl8/IYR3TfJYt0rnBFfqcGMx6HpZIKfNVPFPCQGqvv1+GeoJ+
 E+0QtFNICBtWsKeL3ZBc+dukdPd+YBVFGbbpc0+6e0k8bhLiQq4M/ecPMQ+/tZhI8PtbIO8
 xj2byrN6c+KR0GGqk3hAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KENRNBQdIbQ=;1Jw+U9adtplYiTpUQ9i6pDJiOhG
 COfvM3rBH5KXAIp0C8g/w1R/D6g+PczAXbgFw3pZ8nk1SytFe78T/Uf91+cNlpmym/ph57CQL
 WA41PIoMzui7mD7A06MbsoiHvPz9SuV6HyEzp1IIo83bpr3gDZx9urBx8ISKJb0AwlMZ9zOZc
 2GGDO+pWcxlrZmn+GHsDzqD39ymxUIN1JCdDSMgkC0OqQda7PhQ83u3MBhlDDRuNQveDJEsmC
 uXrQ03vQf/rWzZ8W6u+UShxJB9tKe4NvjtOOtCYhBcKyN1rU1gYoGO6qqGzUsPz3d5dSP4siC
 F9d2AAFbL0Dd6AbGqhiym6rmQEF1B/OrqnHxpYKjVnNJIjUtVkoST0dEvQN/YzCHlVSaJrKBT
 JUu5g0UDNQ4uZxoQ0v20t8C1VLzo9sbLc3i8GUUveJX796aCZtGNf0d88leuABJcE48usyI9f
 eAm0EINwKUKtLXXAmHbwZidI4gg6epocao43lkDFy36Kt4Lo9fzzAA2XGoHazLT99vap9/zg3
 YMQcQzEzzsljl6pyhCLYM32NNg55bA3PLph9+krXEshe3eMK0/h2ncOdSDxFmyTJf2lk/LKMa
 bootHCuv6gAt2kfaMGwAKw5PNf2k6GZTvjFZeESOVomrrhHKlSHC45kg4GS2K39l5+HW7SqCK
 y5IUZShblw9Tb/dd1aGfZml5vTljBov4K/RhTh8uYDFiZLOg+eameCSiWFd46cJ2nxl/mECF5
 yO39UTdJ81aankoEkUsyAMoKP30Iootb1dpRPsFUPveCM7V2KHq9JqvxeR0VqpHfLptl/sODS
 LYddy+2l/tXlpiAtG3dQ9P1iDKtfqifCRvzuYy3ALTW88=

Am 06.04.24 um 00:01 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> Yeah, this seems pretty reasonable. I think we've traditionally been
>> hesitant to pass or return structs by value, but that's mostly
>> superstition.
>
> We should still be hesitant against the practice to the same degree
> that we are hesitant against struct assignment, especially when the
> struct is of nontrivial size, or the struct has a pointer member
> whose memory ownership semantics goes against shallow copying of the
> struct.
>
> In this particular case, I do not know offhand if .strftime_fmt is
> safe to be shallowly copied, but I trust you two know and/or have
> already looked at the implications.

date_mode_from_type() sets .strftime_fmt to NULL in the struct date_mode
it creates and returns.  Giving a reference to it to date_mode_release()
is a safe NOOP.

show_date() passes .strftime_fmt to strbuf_addftime() and does not
retain a copy or change it.

show_ident_date() only passes its struct date_mode parameter to
show_date().

format_person_part() only passes its struct date_mode parameter to
show_ident_date().

format_reflog_person() only passes its struct date_mode parameter to
format_person_part().

get_reflog_selector() only passes its struct date_mode parameter to
show_date().

show_reflog_message() only passes its struct date_mode parameter to
get_reflog_selector().

The patch doesn't change any other function signatures.

strbuf_addftime() scans the format string and passes it to
strbuf_expand_step(), skip_prefix() and strftime(3).  None of them
change it or retain a copy of the pointer.

In other words: This patch mostly affects the read-only side of struct
date_mode handling, and the date_mode_from_type() part is benign as
well.

Ren=C3=A9
