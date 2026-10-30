Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343916;
	b=Dp2WYsRr9NtB/+mAbr5oXa4LYHagK4a0L9kk25NBv3M78BpamUv4kD+h/KAEwwQ4DsmV
	 S3YjoRZgXq+lyIbE1QuuNHrrhTGkUte4aJzTYJgHNmXIVBF+WciYyqG4CoChdPbtKkbx9
	 gJdlysTmaruQjW8uC//fzDOceje0YolmefoC/GpwG7+GvIC3qXOTw2EdW/Mfe17r8REJb
	 Ev0Rdkf/23nMfzLrvQrFE4tQ32Q3HcvvLbwjW7xjjrsKr1IvRHHzmc9UHaeEcO7z5p1qx
	 R0Se1XZnFyIvWLmjkVxVH61kuVWA4jGvHMqWF0TmtAUNW5Tghjc2VrUa4ScE2hYeo/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343916;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=leOFH6kQGgY0O+gGECI7s1OG3Ts+lLdxRkEqNUYCLWA=;
	b=r3J2KKz5nDLfiJE3tOiUxsGgJFXwzhKKO8WzLzlb4T/uh19Xc5Ipf0NOI10jAdhSOKgm
	 NnNp/3bCV21k4kAMJnEva6kHuVuR/XxPX1/fh9uaC4msqXq9NF63P4hkDtRZ2/G7vhJME
	 /548krydz4wKmFv3PRsgpbgQ25asjdxEc+9pApCZWgs5cQqaSv8YT3hZkvnVL87xL7JuR
	 3ikvcCeBlf8JaGLodtRxiUfFejwlVgMVRWXucpPMhn7CnvlraQZNZDzlNXHMdYchXUhDM
	 LP8ITRs4NnkaThypOvanwuIs7w7MYxYkKtwSQD3Bo3SN7qzhqd+n8OZf4UX7JzZsrAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=dVuRh8Z7;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AA606A320
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E65AA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=dVuRh8Z7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793343909; bh=dG0XEI61g9uZsYclzN+pMLuZBSM8IMR1DnKsXb70++Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dVuRh8Z727ikLnpxNSemHhZvq8zo2WgSG+ZIoc0/bTnUGkXu4WrnJurXt+0Ia5Vxh
	 UNXbugS80J3YfExIye5AMlvm2bD94WmMC7o3DpFFCmOcjHMI0pm//UwRmmQgEH7daZ
	 Mbg7fgJYJUy/vyWjLXcFTj6AOoIySJNcu7i3nIwo=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E147562DF9;
	Fri, 30 Oct 2026 07:05:08 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 03:04:55 -0400
Message-Id: <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Colin Hinton"
 <colinlewishinton@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com>
 <xmqqecdezfr1.fsf@gitster.g>
 <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
 <xmqqmrrxdhox.fsf@gitster.g>
In-Reply-To: <xmqqmrrxdhox.fsf@gitster.g>

On Wed Oct 28, 2026 at 10:26 AM EDT, Junio C Hamano wrote:
>
>>> This part of the code becomes overly deeply indented, and more
>>> importantly, the outer conditional around here has been reworked by
>>> another topic and the code that learns follow_remote_head will have
>>> to be reused elsewhere, which would lead to a nasty merge conflict.
>>>
>>> I'd like to see this part refactored into a separate helper
>>> function, by squashing something like this on top of this patch.
>>>
> [...]
>
> The 'ch/remote-defer-follow-remote-head-validation' branch at
> https://github.com/gitster/git/ has a change on top that you can use
> as a reference.  If you are going to make this a two-patch series, it
> may make sense to first extract the code commented with "See
> remote.c's handling of ..." into a helper function, and then extend
> it to cover the lazy behavior in the second patch.  When viewed
> that way, the helper function should not be named with a 'lazy_'
> prefix as I mistakenly did.  Being lazy is not its purpose.  Its
> point is to determine which setting of followRemoteHEAD is to be
> used, and the helper function should be named after that concept.

I wonder if it makes sense to incorporate such a new helper function
into the existing 'get_follow_remote_head()', since it would be the only
place using it.
