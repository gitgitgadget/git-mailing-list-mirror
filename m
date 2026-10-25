Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955937;
	b=SMnLgUbLboBpbG+BSolNaP6V4wELbwbpkAuemOwTnTytKO7Jj2KCHYmRKW+Eaj975ILj
	 +X2akZK/q7FdX6CmbCZACAIjsHe4xxeX85Sq9Z0/mY8hzvjb6xNCrzmw4iLM1CV1ldhTX
	 SIksYrVyA/i8h7IY0bTHSVB5nDMU7R1v35v88yQb6R1CpHxOtJ+QhtwxWjZiIDAH3I6v5
	 /J96Z7pkaCZpHqdGNWp8/7JCsulq8Mx6HDcdrnvPXp8ub7kLtSUO5bQ5E8HrGIfPkEMfh
	 nSWCNjoojLuLZOvFReMAN4FmRBYAoVHuxcqv29ogxKg0B6+hFiiN+ADyDkY8XVwLmxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955937;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=/dwdWJHA5NLEzacZxAQXCMew2NWJK/AsS8KebfsaR+Y=;
	b=qalHpCgGF6Ykx9HLRmvM/f2F+NzHlADOwnqCMAgj+bwbO4IPca9Bh7a6LweEPPiNgTCI
	 BfDMvxjKRbrT38QlnjAhL8z81zSOo5RlUD44jP+N1oW7rdA2WJ6RpjiWmJEvIhTNqABuz
	 PVTJgTBql0VyK5oWLI9OYhq2+UgyquKJWO5bymvbAnmK8g13LHYr3IH3s4mKzl9qJ1GKB
	 ul3oRVtPLt1KnvX4AvZqjrHDQppjBSBTQrY/aVNsVuK4WfkkaRyG23JNozJBS7Qvfhhwu
	 YZrpa829eHdzHFg6f6C54Kjv6itoQCBSMoydeQQcblzoUrOd0pxw/ktQa4bIXon3CAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=KkKDpC1q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hS5b4u6C;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771606A31E
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68771606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=KkKDpC1q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hS5b4u6C
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FF431D000BF
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 15:18:55 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 25 Oct 2026 15:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792955932;
	 x=1793042332; bh=/dwdWJHA5NLEzacZxAQXCMew2NWJK/AsS8KebfsaR+Y=; b=
	KkKDpC1q8QiSA7eOjzDKIPhbpbrtwPdE/oqR4rSsOnf4tjFEUnY4HrqfGAKY4ApK
	Nc8j7sPm2vQiSWjtaUx8osfyXWv0MAzbMuxwhmtlhyJKMhQ10CYbHEUvrz1abik5
	YbjZ7G2faUxZxrMV48TZUNrBgQ83SdTEoTPQ4FDd+XE9SV2fIQhgwd7n7fL63htB
	6h5eMAnvOI3dgNOdf3b1dbkST+IPXvfHt0RxpTRYZLfnC2FdrUKcxXNuOZRo9A2i
	3647lS1gaJzSdPWAXo5rYvEFsLJA3jsfw7tYLh8dAxpzq4eXnhr/5DEzTh6+WI7l
	Y2wmN4ZxqjQoAdXWwshgaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792955932; x=
	1793042332; bh=/dwdWJHA5NLEzacZxAQXCMew2NWJK/AsS8KebfsaR+Y=; b=h
	S5b4u6CVmSLnQm5wULXCA/ypYH3tFSkaG4n9lFJ0nu0ctxbgbI8OdNUf3Gl95yWE
	6tS0KcXwULJS54as75A/oLq71MvFccVooLy2UV2QRlVjsuxL5rOEq7LgNZi2vZkw
	W40kN8YUOy1XOgE10v1LhZA3VoUCXoNilm5GY4Bwlm/xmm5cWm6Uv0EHsLC350kG
	CaYLpCKfT1Jt2MqCNrdpj7FZcLETvrsDqxOzOwXaSpAus5U1cS1ft3RnOcVObwrd
	EIwf4nb3dFeQQu6KwnyfjwfboMh6ZIiMr7m/eYK6l8TCD6Dw0teqdBwJtMuO2YFx
	cT0gfkbQivITt2rpQYvpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792955932; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oFEYb12cYOyR6NxsfDMw3jqbDAOAZCiHRj9b1xyUNaacf4P
	T9H3YTWiKv8ZPpJxX7Qs0dY/RG8V1dLbCRHgkMX1p4aIwG0BMFMsY/CA8DvxQORA
	ueNFcvlkDeWIePP2zyC2fGJ45ou7+yaWlfq/r3ilprSR59JWdAZa4+VWBHi/8rRM
	qmojwIxsmIcbjDsOPxupjCfQhWd4mPug3jYHQrVpVA+wf7k8KCwkwerqRG+iTTQO
	/u6FFE2qgr/Bsj+EiYn5VBGBHQmReXGAA24rHlCO9m3cvK94/D5avvoQwmMm79+d
	gq8BykiJ9Cc4hbRO/oWDJFT/Yuf+R8RG37SDujQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Q5XqCK+9+8lqJjnHRuLs4axosJBk5k+Z+w9Zur4f9H0=:W9QRZlF5YUpSDpB50knjKRPmmm29hEtWk1NdrMaHBZ0=;
X-ME-Sender: <xms:G1beajMZLf4hho6DUQHkBLASlwnG9q5J5uwi95sa8YGY7qbw3J8uLJM>
    <xme:G1beaoxgag7IFQTtvZtpYChKQtheqDmVdZmTbIjOCdGpTwXYawIQ1lZfAGhWlIKZa
    23XiQTfcbXlEV2vMbMyb7zhrvKgyIqMB_K1-wddZ9HdRd9a-0z58Xw>
X-ME-Proxy-Cause: dmFkZTFyXUa18B8L69tDyWmzXUW2xXDTHTP52IllVDZKLZRM2gNd5gH2C70/XYZE/x7Ks0
    49TKwViZ4c3MdNLb0zwRf71qItcPSEBtbSvTa1Pf3bxqlwgU6cfbnrDQ0hzuAr8mUIAKK5
    c6jjGxQgjLDjK0WW696DE2OyiIF/50VGZqh6V0Ux5UoMneaSTPHMlWMq0C1+joBdrc3Hv2
    DYoTR4Hywc/XQZAE5Drej0RKrqWNLAv63HkJeNrZJ0w9Xjswk3fXLC0ZHdDt1O4X/Wf3KF
    Nxt5sRYxXmUKsMHdsL1rClRJK9C3AqgacJrwyJEbh9indQgA6StNqfCJI28WnLavkXkvgX
    W8Vatdmf7oY3hZSG+k+rBG1mfOm3faIpzhH8zbXv1VtHbK1gW7134n06SY0pfm5JTYRtBw
    2TWHMJRuSUGOs1yS8/Oqss9vl24o60NqllnuXW5T2VVaJVO/NXZ3ddymcPkpeLbXJX7v3c
    kA6Kd2eJ5JFYzLPNnXNloruVAtS8OpuiLyGi3PvTsKYjc/ObV21gXXCBxVEoIY0ucV0iD3
    HujtznWSAsxZAS0h/3jOi6kT02a0OPj63wyFecsN8h/JMQsDb1Lx36sVwc9r113uYzlZ2Z
    Mc0JriUqtCQps9Pj4i3D/afnAXQO7JxOqHfPp1iMNYfc5N6ZlqmeHNMqhi9w
X-ME-Proxy: <xmx:HFbeai1P-WLcXy1kDjJWWlWVBI_nxpiQPpBS84qYRXV8gEIMLIFwKw>
    <xmx:HFbeai4y5f1GZfZkwLL6-i4DhXQItqlkn86eszdH9GLv3CcshgD2Og>
    <xmx:HFbealXnVNkSTewve1V-n13LHSjJ1MNO4AsJzs7vEgPfs9G3jaE7Wg>
    <xmx:HFbeahAr7xfIJ9GmRvYLycbzPRquR5YET8Q-WFR-4alYcjcnxCtvqg>
    <xmx:HFbeaqGShIN13k9EJEjp0QZmKzAOXn-sk6nyOpDUgmSvbgssB2Ic5aDt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 55F9622C009C; Sun, 25 Oct 2026 15:18:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A8mddxQTrPbZ
Date: Sun, 25 Oct 2026 20:18:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <8ffe4cb4-fd89-4086-945b-735316e6d501@app.fastmail.com>
In-Reply-To: 
 <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
 <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 3/3] reflog: add --historical-branch to name the branch of each
 entry
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026, at 20:27, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>[snip]
> diff --git a/reflog-walk.c b/reflog-walk.c
>[snip]
>  static struct complete_reflogs *read_complete_reflog(const char *ref)
>  {
>  	struct complete_reflogs *reflogs =3D
> @@ -178,13 +257,16 @@ void init_reflog_walk(struct reflog_walk_info **=
info)
>  	(*info)->complete_reflogs.strdup_strings =3D 1;
>  }
>
> -void reflog_walk_mark(struct reflog_walk_info *info, bool operations)
> +void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
> +		      bool historical_branch)
>  {
>  	struct string_list_item *item;
>
>  	for_each_string_list_item(item, &info->complete_reflogs) {
>  		if (operations)
>  			mark_operations(item->util);

This was from the previous commit. A function that uses a `bool` param,
iterates/walks over a list, and then *if* `operations` is `true` (1)
calls a function, that looks weird to me. You=E2=80=99re either going to=
 do it
to every item or just walk the list without doing anything.

> +		if (historical_branch)
> +			mark_branches(item->util);

But now you have two `bool` and you do two checks.

This is less weird to my eyes but these conditions inside a for-each
construct/macro still looks like a bad approach. Can=E2=80=99t you check=
 each
condition and then call for-each with an unconditional `mark_branches`
for each item?

    if (cond)
        for-each item in items
            fun(item)

>  	}
>  }
>
> @@ -287,6 +369,16 @@ int add_reflog_for_walk(struct reflog_walk_info *=
info,
>  	return 0;
>  }
>[snip]
