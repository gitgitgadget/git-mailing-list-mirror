Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257922;
	b=qsCGxfAx+WlHJiA+H6p4Eoun/tJPiwBWJDzzuDuqQGAvUWIhSP1j04UWJ4WUD4fPdwfv
	 dvdqVhPU4TUR+2VsTSV0S3i1lOBJTh/D/PEY883ZossXf4hg7xSsDvuUbOL0tqR1xOqMo
	 /Gbwo4J2IV8Ule9nB033cOKSHaBIBb/0iLNoBsonWFm0orQclPGAHhUEbkD4Hv63MctpF
	 Ldz02eDI937fpVADTt5eK0J0uEFQU2/4uw43Y1SxUrR+eZsNgkZxXGZTY/Yo7uJ1CCpG8
	 hNKcMUdO7yTEFS4c3vPjWzl0KZuq1zgwkDg7Ner6zng8Gk58KIjmZZ/Y4n8+nXX0SJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257922;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kZ+X6RMZswzRsH/4/T+esD6wAGGfMlxt9huFH9rey4U=;
	b=Tcti64qBpk0LSP06x4Q7XenRDnY9TCJK1Eii3Kz/G5ZUTjNfjSrlGvdcKGC1vsvLbJZL
	 3JQVFUQmkMP/++Hp3n3xoymuBrARJJdkwg3rYNU90m9Ja77xvwsyq87oRb8lEyOJAsXji
	 ttA27ZMMZnRR6jzgk7Y8dzicM+D7FMi4UF63n3oBI5rPOnL9kmVaa73xq0S7HR2suKW0D
	 tIWg1ZJaczpx9X6cnkHKvTg6mcdErpyWe357Z8W44KY6Xk+51ct89NB5CUCTLlznhvunZ
	 vK63Nf9+JW2AqJ87U21ZoQLDiubZWS3gNPYYX1jtlftnvvjsoclMY7HPWZ2mEI0oJFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nIJx45+V;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GVvrnhmc;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE1606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nIJx45+V;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GVvrnhmc
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F885EC01C5
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:58:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 15:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794257921; x=1794344321; bh=kZ+X6RMZsw
	zRsH/4/T+esD6wAGGfMlxt9huFH9rey4U=; b=nIJx45+VE8Xm37wpqRDpUpowYh
	wZhZSh+IVf+A1zPJgyZCLYKM4cKGGzxkKpyzN0aQXE92qVXkPrvtfyIJxUPtZCED
	7o1GWoS9w91qpHEkpDUH5xP3Q/7q6UCM8Vg1YelAhrYt81vm2S8wldmJSjObLS2H
	ZVKtHsBxvWDem2CbwIT9OblLmMoY9j5URn4InAlRttUwr79e05zQFtnqE3N9Paq+
	uTGPmJdpwS0Ez+DHLGQsaTEFKxcjzl5Ej6OvHqgJy6E2WI41iMXey/j/8O60J9So
	OIwdVSFi5kj0tPY0zrk10gLrHrr68hppp0seO0SC4CS+E121lXIL4uA9GsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794257921; x=1794344321; bh=kZ+X6RMZswzRsH/4/T+esD6wAGGfMlxt9hu
	FH9rey4U=; b=GVvrnhmcO5KwQq6btpGGihi8OZSkaHz7Yh5xad9/FZviwJS/y+c
	+dgDW5a7yKlNYhCSzdRYNHteD0q7OW9n3too63XoHFJt4GOqSotRvRz4Fg4b7Mnm
	3zxNBVkLXzDe0CiHcxKu8GlPk7FOB/MznXnfasdSUll8QVpwVAb81YLghnNg16+s
	pwFnr9hMT2d/mIWUED3MyCapZQBsxQQ7WhI2XAv9DAg7V3qI/Vd57f9TNir7RjZh
	2F40tA0PcpNmZWgnUcHFDv5eZfuX5dDUdGTrZKWcajF1GaJMy1L6+oCB2Zg99O3Z
	gx5d/aX7uRPv874J3aZlu1J34NG4F0AOMZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257921; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c2VuGW2ZrfQlTpKi4FXev+kaoYRl8fkC8JPBQ8FYdEiNOOR
	SlcIKD5QxkPw+e7Rb3p8SAKplXDorU0+ZU+vTnh32ENW+H5vcj5+UuOIfR/2EdeU
	MTSD3H5wEdNJ9dgfwZ1BrjoHzdcGiyVXsTcvHiyFodBSFnnNXEK33D0xUTXNC/jn
	ZFqFCqe8O6QWzQ7q/ZHz1F9TOCn8bm6t7CRa/kj7es3drF4Ld6V4lfcQBQTNtQwZ
	lv/6d5dE4iFLcOepTZlhje7BPwbgn0axfHkduS+Zatglv7ftTYGs4BFE668y1Jvd
	ubcxbhsIj6GoAmlgjjVKalnQyq2Mq576kA++mYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zB9SpR5gEGJDWbAN0DdK98ICnnVYHvIo2cAq3zixIqs=:EtYxbgR0bZ0CNyFr8e25RK2uMOAW/468b9HhTRf9K3Y=;
X-ME-Sender: <xms:ATTyanOo6xizzYXd2U5jYIsuMgsQIHKL2oYFpKuCQT94s3mPESGAJg>
    <xme:ATTyao3x3nRRsfnBN0zUPaZPZxnJckEnY_KdBEUapXgpYlpW83_R0vY-Ovg8uohIG
    2xiQPVPqTQD8e8UVlS9LEAiSMcDiE19OkwyR6b4RFORZVemzgzhHGw>
X-ME-Received: <xmr:ATTyaukZAKefbMgKlZpHpR54V7j2AFLEbjLVHUOGThOFQcTpCnzz9K_4AnkuldN7P8DF_nhSrgjmjUvXSF8hpDjRw7qJwQymqJst>
X-ME-Proxy-Cause: dmFkZTGGN6+Rkdg+UesZ+6b4P6DyE6w0HwX+0ZyNnwdw5qAe2p3IVwYbN1JYCvf+uS1Bvh
    8l8DzP2rCBT/d9TBBGFDnxPMyhr9cYxz9/F+a1gLq0X95Hb+SBCJhGoa9AFMTmzhfmo1kt
    U+8Q3y9REaEKQ5eSbgR24sRtv/yEHULCgJ90pv7dhQJUSjoT+YxgpGKlu6NslSOnwTw7HF
    7EWAGaryPlZw2GhTkMIbqgUvEzF3t84+wQdxEihGWEMSYqjwLwtnVMB7jSODB6nMUNR0Ke
    pdRFfSro4fDGax3gxpQkw2E8a7Zwx75Wwqp97LhIqaikfUPPjKtufNtpvuOpZ3nsvNWFqW
    +rQQau3LKBfBV8/mzPh8YeyRgP5J4XN8ARtuWZnzGjqn7/TavN0WU4k+oSEAeqTskOcwls
    X5JZF7GfE6ucRnAllfrahYHXBtoArkgVuAueraxtb5xm8tnZPzPTWhDlrEDA9JQE1EGOGl
    II1/lPUjynPhYnIOeCWqTGfdYEgsjkOCUEutqg7HPvlony3dWs4wU6DmWIJxhrJ5Hcncvi
    iwemR1PpyV4jxQaQzpB0vSTkMccpR+OmwzsIDlrCuKc039olTtH5hoa3ZUKvTnBPwdwFOr
    pQSIq/g0W7CMHIQ8YbJtIeM8nbXMMgSuz0Bmns7Xj9t+NgW1Y+zAnp82yShQ
X-ME-Proxy: <xmx:ATTyanWIv6jpjw-GkYk2lN2UyD5TY3QtqMQp1v0SF9HDvuoeAqPdKQ>
    <xmx:ATTyasv0F2WJHghwIXRd4QfQG5mb3Wm1Mn1IvXimkEwZPDPnRvac5A>
    <xmx:ATTyaib2QUoEyBc2vntB8JUGK3M-fs_XhHhV7QtsNrI3T6wfCvBG6Q>
    <xmx:ATTyajU6fRYCMuocvWzPqFq3_hTZ6bQ-tfOXMvOmTO_F9Z_w5BcX9A>
    <xmx:ATTyagECcfxGw9LC4LzrONQPm46RsceEBtHRyUgv4bhLuJH2bw5ikS_c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:58:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Ilia via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Ilia <ki.stfu@gmail.com>
Subject: Re: [PATCH v2] fsmonitor: check the untracked cache after a trivial
 response
In-Reply-To: <fefa2680-695c-41db-9975-7e972590b969@gmail.com> (Derrick
	Stolee's message of "Mon, 9 Nov 2026 15:47:33 -0500")
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
	<pull.2247.v2.git.1794251653636.gitgitgadget@gmail.com>
	<fefa2680-695c-41db-9975-7e972590b969@gmail.com>
Date: Mon, 09 Nov 2026 12:58:39 -0800
Message-ID: <xmqq8q31yb5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 11/9/2026 2:14 PM, Ilia via GitGitGadget wrote:
>>     Changes since v1:
>>     
>>      * the whole untracked cache is dropped if !worktree
>>      * removed the comments as per nits
>
> Thanks for these improvements. The v2 patch LGTM.
>
>>      * rebased against ToT
>
> Generally, you shouldn't do this as the maintainer will apply
> your patch in the same spot and handle most merge conflicts
> via rerere, but rebasing interrupts that. The main exception
> is when you rebase onto a specific topic or with regards to a
> large refactor that merged recently.

Good suggestion.  Worse yet, the topic is already in 'next' so a
wholesale replacement is not very welcome.
