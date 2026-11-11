Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411604;
	b=HZepK+jxITYCdV/mQGcVx8Lnleeb9z+hz5P8t0zJvrmTGxNEQVTDO4eNoMVeDZYtzgA4
	 zirAJS1IHGeug5yuKcs6vewVOo8CF9nzSuTr8cIxyihfzYk2OQFcO3OQubM0fBBzPQp+A
	 4CzaVMKhVJLNQ4gD5LyCTHx4+z09f4a7PbBBePg4darEdwU6Jqp174juQUq8aOjEkhT2u
	 7dAKl9xD6r6BtbBF2Ub1Grk0WRgt/S6GjzD+JDWp9LxlCxC/MRTESOA8HHcLGCUGS8QRd
	 xPWPE7rVAU3EgyiDMPXUGwl8mcZNIAAYMeBhRXcg/B2wBxiHs3KPMEXADzNVLYqz9UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=zE0RBqUihkEn6+uEWymsSdBJFN0qKJm7NQBGIWUCiO8=;
	b=qWpVQuSXeVIBZ43ixYTOa2DjrptzJMvf/ty1Z8x7CWusObyirMvn4wtUD8VFJbuOpDRF
	 spTPdZ2iwxEo7Y6OjN76pqZhxvU51xWAYx1g5g2dgAV7OQ4EteC3pR6nlBf0vaPLVXj0K
	 3VrJLpx+sHemm+6qnu8fC6NZXfG1YvWWLFiZQopmBPEFoG0Pmmo5kEaiwAxRB3bnF5LrH
	 /4DZ0Ad284h/2CCf1jp8wzKpStW0pY7/I/4ugm+xCp3I3vkQtR/MMEvB9vEgDnr8OjMzQ
	 KnH1BZI0rkM2tvi6C0JwBppPCwR3XYcVEw3fYRhdRbJi+UD7/RlOjE1jlYEtVObT43A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h/OT5TWw";
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E815606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E815606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h/OT5TWw
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798af41644so2755233d50.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411603; x=1795016403; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE0RBqUihkEn6+uEWymsSdBJFN0qKJm7NQBGIWUCiO8=;
        b=h/OT5TWwgOM7TcJ2AYpFfYCimFEEOBkCeQlZgarIsoYK3UyeVfoQAXUraNMsCAwe0W
         CqnOIhl+MSTseWEhqiDSLYsSADYdoaT4QP8PEEMy3bBlYbo5Gjalu1IwhRAg3DkX9ZYf
         CwRuIL/NI5nI3/U1sHkjDfyKgKg0XhGuSq0TYswmbyKfmtH5NJYF03Y00pv5Pee7sMUq
         N5/nYhhV87d7HZDCvZ376mZHsCSEvgTFFf2rq3vZN62Bi//8JM/sh7NrTomCANnzcO45
         yvDPISP0ylAz3L0IuzFuWwT3kGB+r6Hipr/li8aEmN3JHd5kVNNDUDZPuXabhXF3tSyH
         N4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411603; x=1795016403;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zE0RBqUihkEn6+uEWymsSdBJFN0qKJm7NQBGIWUCiO8=;
        b=xFAX4DhoCMjCXqy5iQ57ZgO23mRBlOeCH2FHTLxwRnj/gvMazXFimoR8nkbwPzfpnA
         ZFAAImWtnufICLt39J1nxrGrOoChuFO1cb7yNjug50TqFaVd5G/OqL+aDpCtMjCqG3+q
         LEi4AkkEbAmiX4PW7RXjLLa9UkZoRVm/5tpsJTAhXGZqlpV2u6Nubnuk5ixv3D0jQ9Mz
         TQWVBNfZdUNaAdmpGQzimX1PcApMdEKHc8x9KkMf0CbKMnKNDmflr8ZW5a+ewt3dqRXY
         maKKvqaHGuJ89tppGaO9pq7Paj3YEgzjtlg0pJCBViy4LnD5eCZyJXWmJIuq8veJ+7fc
         2Uuw==
X-Forwarded-Encrypted: i=1; AL+hErFUgY01XL4Ht73XF/2kNWyBRJ16ItVgQBtxVAqK7XxFhbQtuA9yJKeziqhPhslfaRpUQOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OtYeRSFkB/zSVfbnsVVVAyCB7CB+nawhjhqIWQc99+yfRI294
	f03CMyKwempbnZpvqCHJsMMIZsKfX6znugNzcPtoAyhVVBVAIhtCmdZ0
X-Gm-Gg: AYBFou2f6MoNO9WFPvSVQFaaM/AQcYMUTtcmQf8puyyVSlwjR47GL+R5YRxpgz7b/PC
	peln+gu7nGmavv7IXBvN3vIhUTE01vwZGighbau9+UQdHvZxXu6LfcTpR+ceI3bVUy40+js2kvN
	LyNde4zicuhMeiIbHMr1WxQBa9z+K6xTflHhzaPEXuFu1xwmNg8PRSUQViNfvWEELdFnG97lJOk
	omBeLA5+cR+ZzStD+iuMWMO00T+ItS+1ieOIL9A6Znr5ZqpLo2txaudRY+sG0MOAc+6a1XSx4bb
	KLlG9l5+mkRgWmH1aTzZnDupoyC/rko7XNg2D7vaTuaaXvASQlSRxdog89XhUjwIzW0YiFoJNu5
	+fzFiGOow0mDfE8n3DC/Jl/XsaFVZ0OSjz/cvchaE2RtELN9jdlvnSQ4gQlAHgRQ01kjVQAKoRB
	x2t7y5mCJNHvvgq1nFep5F8feVVifBOldtx2tlpGMLrIWhwxmCXKEwqB5fEXbMa8tcdYK+JYWiw
	IYMrqz3YcBTcGMR0gH2qz38js0yCG/MeSYQ2ex0U3uVgsyqma8kYheXyV9eILPgrSwtfnsEshKD
	+nSb549FupbBBlxp2C15DevcsDejblbzhEuQ9mln7UmfCfGJ/ERmNBBCcRMc3U1aKY4BBpHU/1e
	m+J4ptyiwdzXHtbbeNS2TIH244aH/8cvKTXYOpxc7DDwgQlrh9Bk5ID6yPmihk+vxXpuozlATZm
	+Nap0=
X-Received: by 2002:a05:690e:16a1:b0:677:cdbf:41ad with SMTP id 956f58d0204a3-67c67c7fbe2mr2167731d50.12.1794411602789;
        Wed, 11 Nov 2026 07:40:02 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b092:7eb8:5dfc:125f:18b7:8759])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58811008sm4762133d50.3.2026.11.11.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:40:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Date: Wed, 11 Nov 2026 10:39:51 -0500
Message-Id: <6F40E344-D1D1-487E-B5C4-1ADC0B06F749@gmail.com>
References: <avR1u_y2IQ8WoJXe@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jelle van der Waa <jelle@vdwaa.nl>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>,
 =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <avR1u_y2IQ8WoJXe@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 11 nov. 2026 =C3=A0 09:03, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Wed, Nov 11, 2026 at 01:57:46PM +0000, Phillip Wood wrote:
>> Hi Patrick
>>=20
>>> On 11/11/2026 10:46, Patrick Steinhardt wrote:
>>> On Tue, Nov 10, 2026 at 12:15:20PM -0500, Ben Knoble wrote:
>>>>> Le 10 nov. 2026 =C3=A0 08:13, Karthik Nayak <karthik.188@gmail.com> a =C3=
=A9crit :
>>>>> =EF=BB=BFPhillip Wood <phillip.wood123@gmail.com> writes:
>>>>>>=20
>>>>>> Another case where we might not want the diff is scripted editing as i=
t
>>>>>> is much easier if the script does not have to worry about the diff
>>>>>> getting in the way of its edits. Personally I'd be happy to see this o=
n
>>>>>> by default - the history command is marked as experimental so if havi=
ng
>>>>>> it on by default rather than following "commit.verbose" proves to be
>>>>>> problematic we can always change it in the future. If we were staring=

>>>>>> again I'd also make "commit.verbose" on by default as well so maybe I=
'm
>>>>>> biased.
>>>>>>=20
>>>>> I'm on board with this suggestion. Plus, I see 'git history' to be mor=
e
>>>>> user facing and it's always nicer to have better defaults for users.
>>>>> Showing diffs and verbose information seems to be inline with that. We=

>>>>> could add an option to disable such output for scripts (but that can b=
e
>>>>> done later as you suggested).
>>>>> <signature.asc>
>>>>=20
>>>> I can live with opt-out as long as I can turn it off via config.
>>>=20
>>> Yeah, agreed. For me there's two important parts, where being able to
>>> disable this is the first one. The second part is that we need to make
>>> sure that such a format can work for every subcommand of git-history(1)
>>> so that we don't have to have multiple different formats for it.
>>=20
>> Can I just check what you mean by "format" please. It is not clear if tha=
t
>> refers to the option name, or the way the diff is presented in the messag=
e
>> template (or both?).
>=20
> Both probably, but what I meant is the output format. So it would need
> to be able to cover:
>=20
>  - Changes to the commit layout (e.g. `git history split`).
>=20
>  - Changes to the commit order (a future `git history move`).
>=20
>  - Changes to the commit message.
>=20
>  - Updates to multiple references.
>=20
> I don't think we need to have everything implemented in a first
> iteration. But the output format should be flexible enough to display
> these kinds of changes.
>=20
> To me it almost feels like what we want is essentially the format used
> by git-range-diff(1).
>=20
> Patrick

Interesting; I certainly would appreciate range-diff-like content *somewhere=
*
when using git-history. The original proposal was more like commit=E2=80=99s=

verbose diff in the editor, though, and I can see a desire to have that
in all of the supported subcommands, too (maybe just as a reminder).

Decisions, decisions=E2=80=A6=
