Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524824;
	b=SfZ7Ok0Qd5M3/sUWOyeH23YqhsEf8KIsCdlraqFIrdje+M1PEPlauDS8stwmpt91wuja
	 SJhZxbuffRqaqC8DpxW4TqH35wvdUJ/xXcD/HSIyenwBvOWAQiFhOj4S7wyqqz8RSfHfT
	 +XClREvGbMo2Q8gSup2yGc/Ely60MEaWU8dY4i3sSuSIfRI5h82fRcdghd9yOyxvxSNC/
	 b58G6aCU4XihB1uf1jUUKy6h9CzBnFxDqWo8ObQgYluTyadTANYahp9X/3nhXzRWH6WtZ
	 dCOt+4OkJIxJFrPUGK1YQdibQASpQ64bfvAvGVSDprUJer7lg8A368vzPlF+YdMWDlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524824;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=utCC5K9Wm+KS5rMEHVCM91CEJso0IGX+Mp2L8N7xzes=;
	b=G6U/lQ8J8BpJgQ2YvVS4lvYSI/wmqdTv3p1+JXnwehcx6y0I3MFKB1z2OxELUV8iW5eT
	 RoPxcA+mWdgRv3ZsCpsQ7H+nooJyZPCtt2IccK/53DwFrOpvJlpg28YTzq9v9+HSdP11/
	 iSWAsZjBOtvMFkFrxAoOyNau0O/RZyF5Y/INZGPv7MlwO7o9VUOGGqhZ/6klOc3YjalWQ
	 FhDp13wYKW7OJBg7I1SVbgNhMeHTnwd9rViCZ24D2lrIC/epIaX1mS7Ci2mp3G6nhzOGa
	 XcxnU1WFuzXMPQy/qcUUs0A6lxcDoZPF9a1pffxn/5ARZmUamzMD8iuMaMRlhVoGu6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vNOU+sQI;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCD606A31A;
	Tue, 20 Oct 2026 19:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CCD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vNOU+sQI
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B02B3403B9;
	Tue, 20 Oct 2026 19:33:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id CF8663D;
	Tue, 20 Oct 2026 19:33:39 +0000 (UTC)
Date: Tue, 20 Oct 2026 15:33:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, "Jonas Rebmann" <kernel@schlaraffenlan.de>,
 "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?= (SUSE)" <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
Message-ID: <20261020153338.54d60ffb@gandalf.local.home>
In-Reply-To: <83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>
References: <20261020141011.0015d172@gandalf.local.home>
	<xmqq8q3sw75e.fsf@gitster.g>
	<20261020152354.165ad128@gandalf.local.home>
	<83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: eria7xo1d3tcqhuwyre98farw7zhzfmm
X-Rspamd-Queue-Id: CF8663D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18iS1A4uX29HmLo/8BcU/fQtykrsNQVpAQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=utCC5K9Wm+KS5rMEHVCM91CEJso0IGX+Mp2L8N7xzes=; b=vNOU+sQIKEzV1GD3Jj3eVkYeNUrVfwPMMOueb+2UORalMAY6VtNJ1Y6Q8tnYT8/m0eLH8jpX+zg6Jib3Fv6ZEKQ314jrOL0A0fTBy2BnWieihfrx08MKmlvEF/rERqt9Jd14MoNEMr3Faw/mRxrbybZxGUwsEoUbkSOxJ+T1nc8=
X-HE-Tag: 1792524819-905542
X-HE-Meta: U2FsdGVkX1/VqUYivT3PYF++IimlQqd6clIEpBp80E650WJ4xyDBA3KuMTxzPWvoarfW5KbaSPqHStLWC74bHIOQhMIGDnzC0SQQNgmRhply2Uj1JRWEn66CWxX+uFECs1qjJBpM20FVXAKAeJoHyzdScF3hvivF/R2PdEPwlhr//UI0U1/+r/G6vS3afPFzEtCXMmiGgTlaot6gpsM4X9Vg+BdlvBH0noF0/BDHo65O1HYocIgj6xwWzix5liV6vkS94E0Mt5OWdj8HNq4aZw6kng9/k2XgPjYhZhhCVs0hgzS9uQGAnQqtvqWiZScDdBK4g2o5jojDx7uLNfmqBTjkMY5tfDPFSCVzL9ESOMqkJXXw6OHYYk6hgqo/JLcz

On Tue, 20 Oct 2026 21:28:10 +0200
"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:

> > Where returning 0 means the bad commit has been found.
> > Otherwise it keeps looping.  
> 
> Is this different from git bisect run?

Yes. It's ktest.pl that was created back in 2010 for automated testing of
Linux kernels. It will build, install, boot and test each kernel and based
on the result it will do a git bisect good/bad.

Thus it is much more advanced that "git bisect run".

-- Steve
