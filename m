Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557910;
	b=MvV448tskDPsYEn8Ni/oGgaZVXVznaHlMWhaaHkE5+Z/oob/2YNAtkyOKeGJ6VBVbZ+8
	 dMYOiG1jHHx4cu3ZGtZXp0z7xyBiS5YHFP1tKnrMgacK978L0juWr59lVlnDDGnFIFZKz
	 +BVrVDKSW52xKo1i6WhzTPxFEI++W2W/NXK4BeaqaO7O6KNHDPUU0rHWE52q5u/ZrN+rY
	 gnWngy6OiEtzxB2okjA+4uqM4nsY47ZbpwZvsygPMWEocKbVJ1ytFZ6HFUDz6uID6gGh6
	 ikPD40CnRc4NrDNjBFSDEVHHdOxPJloPp/z8bS+9qFwPyotCNGriFH0p8vhwTCWwuKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DvQlXb4FByZI6lE7SV+RNYeRydzVJrw5fK9ARsvQelg=;
	b=UTeNWW+SGgecSeaffJzC2WpoWfgFvw6e/VfFt2QHR9bir+hBMs39F4IGlEtShCJGZJoO
	 ZlCG9/Oj8xNu1AkRMZl0pdkYC3UuXvl3vFhtvCC+kSyRl8SdOsWXccG8+oEu3lHL06EW3
	 f2ppTRFKBRCozRd+tY1XPxXTkoBuztEFlpqh1gHV2/1gUSXiQNdiOw2MgG/RFDRdiYA6f
	 N22dgE/aYkBh1be8pl6VZ1Rj2nu4Q4kYvoT2DqhjtKW4/RH+O4LJUkYtCAi/MYncW78aY
	 Cl4L0WoYixggdYNlkyuJ/SwYU67TruzG76pKFKXihA0NYFC5mObxI9XpZ+6DhB4LiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IYUhjubX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DOtr6igw;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B11606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 18:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B11606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IYUhjubX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DOtr6igw
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BDB5BEC01D2
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 13:31:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 13:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793557909; x=1793644309; bh=DvQlXb4FBy
	ZI6lE7SV+RNYeRydzVJrw5fK9ARsvQelg=; b=IYUhjubXnCVksOcmZYfE3lrC1M
	WJ7c4l6PE/y5plmJAXnRP2EECjox6rpvrMb5TMFCVYviOBh6BgGW6G9DihC3c6Y1
	EMtUfDgYH4xZCg80Tr74A+KWNtdxDQYM1UpN6SwPQeYZjZCsGrkECZ76yyg1UqUq
	UfZYdluRsuuKVFHwKiHEyHaupCLA36VkDfFG1ddsog5Fh7k2aJRUDAo+VCA5CwHj
	mmLjRIE9ZisHMuaj/xa3vRi7Imz20Lrg1Zqk99R6x3DcBKRtAji17e3M7nXFkhsB
	QYmygsNJ3NRhXBAXCS+/A1CaQ3+m1TF70Ews8acoRi81+IvHcwr1cT3x4AwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793557909; x=1793644309; bh=DvQlXb4FByZI6lE7SV+RNYeRydzVJrw5fK9
	ARsvQelg=; b=DOtr6igwyHWVlf03K0bpKfWl9CdeDsjbuUOG2Qcn3pP3vMZdwBR
	7/cAScIhuo2Y9rsb8kZ4Grzrwy3JtSNsAJvy82ydFPXtFpUWtl9pbnruHmOLlCZ8
	OZWvPZZ9F7MLfA3tgowqtYFUqd8LuzeRi4WfhWo1asCwRhFPxbJzFXb/9FMQ157k
	TbhX7YnFuDDeeF9oM2k91iL/FyPWP//5rW4O1sypu03ZVb6w+Vk/xRVsAHl3MKjo
	vrgum2bAqt8f5FB5zOX3hwCylcYM15eWsQ0lzg5e14snWEgwjXzpc2NhLJ6aQB+2
	JYAES3f+Tb9JJkZQohxKm76v7W12Bsj5nCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793557909; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZGWt2xPAydYsHMgFPWV+wHUqTt6BtaEBR2dqi1KTqjSgtVg
	sCYNZBocnKUnBKu6s+6tY/OOWNOO7RBg5bN8/No5bY20KU14gvDFALhM5EtQhMPZ
	pt+5qMCryxuu9e4G79ImItfIqTwDjJjYbIeYrjhVI7lW8EDQYY1wo7oHJJiISZP2
	bLfhK8xRIL/TRykGhxdoL/zIJ6/qaCkYiFdqwvloRa+m5ownEiybnBMfETvl/aP3
	3ycNS4hTNQ4c1FXhI5BQwHXcm7AK4bgKAbSlMf9Z6WfsSyqzmVFXY6trlzI7svpL
	FApJLR5C6N9OLOS60SBVa/kAF6L0Vsr7W3xFTig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1nuZJAxe/h0N6kBkmjn88Q4BIfxXgrIZaQfWXn9T40s=:mh5DzAf31kfu0QSARca1OxHt+5YLNK341h3kDoaKxKA=;
X-ME-Sender: <xms:lIXnagizmCPUyegtIZzVJ2o3cBYJWK2ZqxXrN7Zn8t88RQjbnw55Mg>
    <xme:lIXnasurrksesEgr7lFZsXmZ_6DyLP7vcFapx6ISE8sXrNYOjU_ZqRfNmsnrCfikQ
    5KbXrU9_SyVA3eVn6muxwLeMCWxOvtuEAVn7vLf6Vs0bMRr9-HNrKI>
X-ME-Received: <xmr:lIXnah7intkQrjQgLY-qxX882UNd7kFCy8LvB9wKHS1iQpkJ0mAwK_8O4buf-luheTdkYi1xugmnPHtWRZvyT6v8HqWn6hU9wMzl>
X-ME-Proxy-Cause: dmFkZTGRxbznt0IckgJ7XPVuLlhLfIK1iL/R1znP4nI59YUfL7XogVZPqDyx6JA+A4XSQ/
    WyahGLd8OqOvZDiM6rXKkoXZjmPIF8NqrMFo0vK5nHubpXdVDVw9LxHe8bl4dSUR7OcWCS
    zb2rrstIjevYZPfrVX71MpABY432aLKBvWsTzabHlf5FGbwVb0RwQ3cpR7DZJYWqQzllzC
    u2QjBdtOmtJFjeXlIlAGeCTcJWJ1uxoHi9fBRQChjadG/03kg7W9M7rXsadU1bzL86H/OI
    mZJaXRaNNnI6ooyaXS+ibCjgmsR/6bQ7L2KDAJUjue88R5dgkVut2ATVpuJeL4o81n41DW
    QRp9XVfWIUg9o56cqbDhmm1kD+S/JmIySNs7m0DBBxNEclCZRUXV3sPufZCYnJ/BilxAqC
    e960Ehbzz8UOzisxtcprBBww18PPENt2izxnlkIe9kpUW+CpHpfz0BNHs88XYP4Q9A6akW
    rgdTJH/YtZrPqWt3wf+LI/67JwkNvkB66/CXF/KMlG9hYeB++Bk4mCJlVZnRP1YwyPV+v/
    AFjskrEh8BZ1pLXZHrX9yryfzwOR739UUDjzwBsH4k58PAwM/WmnCBSZHLRomT4Wr6bjhk
    nMo3Mls+sr7e8zKe1mYgffNayOJHijZrHuyq6fcgXHapnSWGvW0iNcG/Yn8A
X-ME-Proxy: <xmx:lIXnaoOqYsOvLb_l_shxVxEFfgkYHncBBq94GjNxNAyamE7Bigsvtg>
    <xmx:lIXnavsabgfm4lB10cVZbAHKNByoEc8L8cti3EXzMESlN98v4j3tmg>
    <xmx:lIXnarYdsy5tx30Le5il3sH2KBrCPXUc2XfCZ_ECJYhgCX3XUpYh9w>
    <xmx:lIXnahyhxRQPY1onPPmzCZSXgRyjhzkMjOSJQzSZdN9-vpk7MIvshQ>
    <xmx:lYXnajwK0S8XZk1T0nz8iLXS_yWX97xpPyWrUD2wXNtHN6JxQbLbiezP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 13:31:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Toon Claes
 <toon@iotcl.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: clarify Git's security boundary
In-Reply-To: <pull.2286.git.1793362370899.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 30 Oct 2026 12:12:50
	+0000")
References: <pull.2286.git.1793362370899.gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 10:31:47 -0800
Message-ID: <xmqqy0bcz9m4.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +Serving an untrusted repository to `git clone` still exposes
> +linkgit:git-upload-pack[1] to that repository. For additional isolation,
> +`upload-pack` can be run as an unprivileged user where the platform permits it.

This tricky thing is often forgotten, but it is nice to see it
mentioned.  'git help upload-pack' also mentions this facility.
Overall the document was a pleasant read.

Thanks.
