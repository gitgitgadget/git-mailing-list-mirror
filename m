Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB432C0F72
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398288; cv=pass; b=M+bP3zTLf8fV6MBUTRknTsmWbXmvGRP8ihI34+ZbN8wU7riVdgK8nGajjrtPKqTB4VVgztVDdqy35+Hzgk+Vi4WZu75WjrOZsU05WzDCxAsqdBKrJmEqsSw1U+UawHXvGKCCr1evczFMANrxavAC/daMbFDhcZJiX/Kheh4HhyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398288; c=relaxed/simple;
	bh=LBgBE4KhQFif0VAiQVD1gd+r70UNTDCuHIDL/CG4qbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lB1DHtvuCzHdqrBbkX6gUflVmKO0mS8omoUnVpsEhQTUebSbMYXe/B9YDVkpHxXuynhVHuZntOKgc7ie8xD1YldSMPfleoesAluYqTSf+8sKlGlW4cjSHOZxdj1KHmxigvMrcT89fVOoi+uU1R5t06pDn5ybX5Zo4fZbFkdRxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=PUUKbs+F; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="PUUKbs+F"
ARC-Seal: i=1; a=rsa-sha256; t=1763398275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EBXAN5O6AYdyFux5C5mgupkhVaFoDeL1rCbNtDVBsPOtDL0Qx/UOEz3Pdq1dedxAFcA57Ef6l/8wS+GIFVAOpIA0NCWyHgShDmeLnIOM5/oB8yUdH5NAMFrTaDuhCHFQT6AO89OG07VGXC2I7AMgvnZ80w2S6WR4vazlKTBXwtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763398275; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WntBgA6qKieGL3pjD65O86ISUf8JTVnD3y2db5w8c4o=; 
	b=no68jB//r7Sc/dQUxHUZP8qxcuWP2VkLIZoJptKW1oPdkbCwap6wNstwk5SILtYpwy+J3m5Iqsit0E+p0l569fBNlsLZSmOLCtDzkkyKWf7fmpwsui8NCrlzh9wzLTXTuj9Xk/vgQNgDCJTJX38qdp1ctdU7E6/LGEV2QKWXJUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763398275;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WntBgA6qKieGL3pjD65O86ISUf8JTVnD3y2db5w8c4o=;
	b=PUUKbs+FCCcmzVAsK+XALKz8RUPJhl5+wQ9X/u0SDgHRdnWx5QUGD8vZ4qv15LMx
	11tkRJmniB5hJiSEpDpDmrzkAKfye/fywu5fYEe6NSYJcTfEen7nGCuq/AIXGDPi+rU
	qqmmcIyJSBzq/st7es5Zn015iBq0CMC697FoSeOQ=
Received: by mx.zohomail.com with SMTPS id 1763398272006872.8580795328539;
	Mon, 17 Nov 2025 08:51:12 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?=
 =?utf-8?B?w7A=?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
In-Reply-To: <xmqq346ff56h.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-11-adrian.ratiu@collabora.com>
 <xmqq346ff56h.fsf@gitster.g>
Date: Mon, 17 Nov 2025 18:51:06 +0200
Message-ID: <87a50kbo1x.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Sat, 15 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> +static int feed_receive_hook(int hook_stdin_fd, struct 
>> receive_hook_feed_state *state, int lines_batch_size) 
> 
> Overly long line and cannot read.  Can you stick to 80-column 
> lines? 
> 
> In any case, the reason I am responding to this message is not 
> about coding styles, but it seems to be the one whose leak is 
> holding the CI job from passing at the tip of 'seen'. 
>

Hi Junio and thanks for these; will address and send a refresh 
with the rest of feedback in v3 very soon.
