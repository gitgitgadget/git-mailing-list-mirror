Received: from sonic312-22.consmr.mail.bf2.yahoo.com (sonic312-22.consmr.mail.bf2.yahoo.com [74.6.128.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFC28DC1
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697867; cv=none; b=dc5h3LyQjEnJJEZuAVDBq4s/dDTYWRtYXVRUQKkbhTNm7CfsEZkIoKTuROqrpUFd2qY7sy01gPIgKf3OZiWdEdKtctWHheu+UNV49s6piwyXKVEbETcmPwoyB/a1oU0CNTFgZ73KBXnf8BmMXqsZRHfCGTuV/2QgTMUypprxmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697867; c=relaxed/simple;
	bh=41kAopJ0ffz2QP29y3RUorDN61Y89e+Thc0NIzYl+a0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=k3PJSEH1LdehkhRsXGI2k5Z1Iy2jkpCvEU5u9ajyiExsg/6iuY+OB16qP/0kjEaFCSQsic0Y+fvhjZCRpqlwW3SMyXJbhhfUUlEaD3xN2P469FnzzfW3fiB6bohEHgRyipIcglWH3DE30+7/k1GRmIz1maktGL8Fr7PIH5E8/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mLXyW0Wm; arc=none smtp.client-ip=74.6.128.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mLXyW0Wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723697864; bh=41kAopJ0ffz2QP29y3RUorDN61Y89e+Thc0NIzYl+a0=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=mLXyW0WmrVKvH43Q9wzQf6poWIzHncRFiyORpzywaIt0U9rQtBUSPIRaBFOC5DGZFRbLVau0pTkeeymwqOvOTLcNUyK1tIWfqsYG8dXWRA96ZLFpLNNUGRFLhkeOqAs4LufShLwHF0B1oROlLuNRn9K8uSJunbrSXbIRb/hBl4kHaeQPaDhckr6Og/Znd67YrFfMrrjggfyIQc8kRFNJzIarkI8HYZ6+6OilrZjPso11vUWmPlqBsorHAWH8sUDxZsStbEIzB35VKLRD2ab1EwWJcbjXTJEE2LWcULpyq99FWp1obqVyYviGKetiUPpb1s8NBGZCldUhKHWzS1TTjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723697864; bh=0nlnyn2vMLYNUpmQc+w9VugjTfP6wr/v79uG0eaWITi=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=LHvIqiyaXqNyP6pvR5/vSJDOO11dm63DJvgr1rlAJeiTGcEB801z7gr48IVdd9KTeCp5DxzQoLqewk6Ca7nh7SsN5uuOmEVlQYFyi2yYhsfDabbKH4cZnwqn7vgK0dyKdkAs4BsoZiaXkSLoQSkx8h0H2ZdLboudQEljOccGV+Fabv9iLSv2kF3KqAFLKntb8u3wO6e2Rfq/9Ukkey4AZ1xR6VXPmXTiairMtTZ1/FV3wqeBIAxAmP0ul/yrXOtNrCRV8QU5yQDXhMeDTi5Pk+fLe7xpwEL2gj0/1oYbesqdV+V/HTec21eG8EyTO7hHGmfMXpu+BqfN0P5+xzdppw==
X-YMail-OSG: JUyKp_QVM1kyFjTbIs4DhiSQpr1sgd21QDUvW2gQ9jf36SR9jZJeM0XD6Xa1Pep
 xQi9a3qwXSyA9i8Ord3Gw_7uTG4pm7WyfO3OkjeT9myyL1GSlywsb5spBCet4eysOCJkgWx2Kmlc
 24LnF_1ZcpbwMKDDem7OT5SAQU2lHdkCTlk6vcoPT5sPRYiaq5a2v3DJqf6fntWQAiRKL97j_UmT
 CP6AC1xbVh9R7aHDe4rPmMIpkjZaZKPOE4kKzb1WlH66ce8V_iRXl3zroFkehc30hW.ONL286bIw
 zptdnD0MciX4DkD37QVeKhq14QYk4oRsl691b4UKaShV7BlA06XzbobuQ75E0mEjv3.bSaOhEsCk
 od3op0tX9pzYuZUP6_OQwYa6FKA8fVwZlF0s2EW5re7fZ6CmdJLrcbMRHnYgnISsMnMjiBn63Lk2
 wGUuhGflbzAGYdctICdoao8HO0gt3LlFgSUApih9sVNEizCz2UVWhcExBPnbIEKbWIZXj6rL.vpC
 .8baML3vcZ7IqMtOgFboGX0YOVtzaV5L9pmkFMLl9m5cSPnR19mxy9t7R.i5lhAWSM6eVzB1jAEm
 Sy75.Cn873DTwVTIzaBwRNuBEDpaHWfG3BAnvQwddD.Vuo2HBqLnL.Txu_ExGxKGeci.1JK4zNmH
 9J8YnR_mfb6EQ4NEW71UXfpZDMdFdTJ7f6teeSiDSuuq86eNXqJAgt7mRb2ISVCpxJ5_Q1u78s9i
 RXCGbcnOFKbXX_aJdP_6q5mftqagKo3cEhZkV_Du.PAWSqiDDC3AqzKxtTdog8sqG1OVphWCpXLM
 V0_5rUXtwDyX_SKEhhUgQ8v84wBBDeYjHAWjyk7DmMSqMtKzP.ZoLQD2LTHE701PKYpnS6zt3__c
 .Yh2src69RJJGXe10XfAuIk7yOIw5mgAehMtoHire7SYtqlFoRuanBbRxeeKZit9iFjf9GMGfJ.W
 7Fx0Zkx_0A0iGzDhpFkfXWRiExczjEz54nybvrhR_kRo1kHMx4eqmQ6pkqyZMa4V4yMkRdEXz9X4
 Wo7kGYVT4Zoui9CpAskTpXFwzIQeVGJUCAOUWRkx5If7SCHt6e69sIt6on0BvF9nMGQEbrkFpW6k
 pTK6I9.ApDu5XXjkWNZxGUAZyOwxq_ho3whpz.dhJd9lM8QMtaX88EN9.5Yw7S8oZoM_0lFUGgLi
 V5aPoIXSxxqMS96X6gP9LzC6viM0AMCDsZg2mRAcpWLX8Pu.wIRAlRlFCpes0jigZVbLroB9Os.D
 Y.HIP9fPucDHW04Sg1sJjzId97m2inVOKPaTBT8LNTunAiq8xqizoCM06In1Xs0bHsjnyuXJcnHT
 H..XRrYAFXKdHjAYkWie23bGfMyuopQKDZKwc8rzojx27LR8d0ZB6lAX81cF8baq2hudpBaO3edX
 WALcnHqSEXkC7Gv6oeU4Mbx1iIQpsQ85j4Kl.m9.AXlQTaOPxf4AOgehe5e48RJ.sy6cwfxbv7SL
 0_LPal8ZQWkN_HVSk5RQF4D4OYUHDgXgTetPx0v616k4V1Q187qmwj3tBCofpGkX.1Hnaa33a2rT
 u1jOLgfDVhHY2mWt4uOT3SJAnVhC_lfaOfNwxzygN96YU11h1WvKq0gaNIZh9nK_6H0vrhLCo.FS
 HaNfZmItwnksq7aiK4z8IFavpqwF01rc7pRaGg_Pa8GERqH4GHOmp8r4.nYPKnVJL0paf82CUxrZ
 ntrGhJpWbijQCMRf2nXwK6rVDpsM4WsNIC6P_yWvFxPvybSzTY1.az78Qoqbe_HUMAq3TKT66WTI
 W0QiXUeAkGGg7oyp8wkpLCQTZpEheW.OQ_Jqyk0qk_X3k1Uze0Lo9v_AzIVFs26OYgNEA34E4.xt
 bKrAZ1OPxNVtmE7Kbt2XIN46JspwVwWIe9vpNH9K09vES1xMpV5xlk3yZhukJI.j.AKWB1zd5e66
 Erq8ptGBQZnk3vWlOqhOErRXaoLRQ9.Oj07jYkf52S7Ijstvji9nfCg8M82dN3Yk1kkiExaKYMC9
 q5sY5G_GZObr3Ux9SG.Hwt7PY6a0IlQ.nB.dSh0nWk8.ANJAGGa8TDrAtPRcSqyorKrdImkaAW28
 jY5zqRrL_RA_MeCHiOcerVGDuHxLG6ppsmOn2A5g8rHMhVJ_TaylPXeL1PbyejxpnOdYGZLKxkq4
 Y0fQr_yz8MfVi8TwIQrZrKPqCbW.kMtpouzmhS7QlXkqRrRfo.ICfds9VTvmxlGY0POdtXZGS4_H
 HlGW6aSkiHg._AlbOaFef_.Ql
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 084f13d6-8b81-41a3-977b-877dd9fab233
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Aug 2024 04:57:44 +0000
Date: Thu, 15 Aug 2024 04:17:12 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <12887914.4232362.1723695432887@mail.yahoo.com>
In-Reply-To: <xmqqfrr6yk73.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g> <2007960310.4114358.1723658954502@mail.yahoo.com> <xmqqfrr6yk73.fsf@gitster.g>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Wednesday, August 14, 2024 at 10:32:19 PM GMT+3, Junio C Hamano <gitste=
r@pobox.com> wrote:
>> avih <avihpit@yahoo.com> writes:
>>>=C2=A0 On Tuesday, July 23, 2024 at 11:25:29 PM GMT+3, Junio C Hamano <g=
itster@pobox.com> wrote:
>>> I will not look at this series futher during the current development
>>> cycle that is about to conclude, but ...
>>
>> Ping
>>
>> Reminder: I'll update this part to not-use $'...' and without
>> fallback, but I'm currently waiting for comments on the other parts
>> as well before I update this patch.
>
> Ping for others.=C2=A0 I do not recall having much other things to say on
> the series.

Not sure I understand.

Shall I ping the other 7 parts individually?

Or shall I go ahead and post the updated part 6/8 (and rebased
parts 7 and 8 trivially)

Slightly off topic, git-prompt.sh was not modified in master since
I submitted the series, so no need to rebase the series, right?


