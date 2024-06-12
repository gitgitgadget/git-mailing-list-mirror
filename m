Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3B16D4D3
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193036; cv=none; b=W7oV/iCiHN2P01w4S/+m6rsqjwGk5bC9PeLyWGYd3Ydi2/JH3LZuq2UpMCxu/V45m39xkT6MvitZXVHFep43HIZ3akQGrO9eXi8XD/rgbAbi1f82ai81f1g9Cfg8Q55dWflUR93175Fg1cIcnuhycMPJ/uzoDo/vZSPC2dJvv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193036; c=relaxed/simple;
	bh=XaXRuxznQJT9JKKQGUlOKR39zEXRDbsQ5u7WiQkhV8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OuUyz4twYldVxPhOwqQAfsUETaEHwV0OYodVeeInNxa0C4qLmON8PwfmLJ3A0q/Q5N4rBOODeKZb8jZfwi9m1v2xuoeuQut8nerjkiTABP9zriZxSE/1RJgkKbufypSrPrbJgY/vS9UW2hdT5KuwIKLNoGP/8g8r/o/5POJbTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=RmXJgZFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/UTE2y1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="RmXJgZFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/UTE2y1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C293511400E9;
	Wed, 12 Jun 2024 07:50:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 07:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1718193032; x=1718279432; bh=TW+KnCzNh6
	9A/Gkd1hK5RDukh463a5Xk8O+1i0KnRBc=; b=RmXJgZFN2ssQl1c9EYOfBpLHC3
	+HZ1ZMFnjsesbEHeTIuREUouxgodPMASiWCBAe/bAXjyi6YjmdNw5WRSwMaJ59KK
	BnckwAnEmiYDHPIcdaYUB4J5xCySzE9qk/YdJz+Mux7nh4Kk8WHfyaGBxTRSPOh0
	2Dwk2AN9l2NyeqA7FGBmih7J187i3AUS0G02ShSMZX5xFjwgtI1bMk+00cq1Sv65
	YtFIuoilDdKtOWjY3pnHinYVm4d2b6NC2VXvk5qGle73W62GB/jXwJZpkyLhjDhX
	1VbuqIETH9FU5kE2W59cbzBTVpynmoe6lr51yXEISxHr4o+dO4Dmdl5kfz0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718193032; x=1718279432; bh=TW+KnCzNh69A/
	Gkd1hK5RDukh463a5Xk8O+1i0KnRBc=; b=b/UTE2y10GgHpQdyRljMhUfMKdrMh
	UQvZnaOm7MdnF6aLjf7t2U0wNGzxo9OChp/0w4uShNiCojoMuzzWlc2yGF/hSk0o
	9PRR4OWBs1IBZIKvyOX0xIQS0zF8756m+ElNLdn2M4+/e5sNKvCi/O0t12ZwjTQG
	tIJeklB5rp7mKWaR19eurVooIA47O09rBAOx4dqD8EkVDUCFYmTjYspF02JZcfwl
	2decsVx+4UKVFhqpFHCVAA6it4SJ13kI1PMqJeFLzIZxvnVFVuGR1J4confvIpjW
	5EzHBS24IknRZFRwcwjeWB3WENyKBFFGFmybwiJmAIcZotVcEQmP4m9FA==
X-ME-Sender: <xms:iItpZu30ox-ILxpTnxzihkHrwwUrWjN-mpuPPJpaPuQrUOjr5nQYuQ>
    <xme:iItpZhFTTl9umFsETDlf3clKVtudm1kUPlhyyANHefU0TsQChXXe_Fei-8K98OMng
    duuAHGGk-tYxTW8OQ>
X-ME-Received: <xmr:iItpZm78BjxcUqvquSFzeXK3a64dwKPvrOCWttuDsRl89aSqm3WBTSD50nETZCpT5iBPaSL07YWQPR_Fl1Q2nhZlTcj4KREjo60M1IGsBSuTRO4dTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepvegrrhhlohhsucforghrthovnhcupfhivghtohcuoegtmhhn
    segufihimhdrmhgvqeenucggtffrrghtthgvrhhnpeegudffkefgteegvdelkeejheejue
    ekuefgieekieetveetieffhfdujedtkedtudenucffohhmrghinhephhhtthhprdhshhdp
    hhhtthhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghmnhesugifihhmrdhmvg
X-ME-Proxy: <xmx:iItpZv26DzQ4f-6XOpA1aXxGmRm74OJCOeCf9P6BmyHKNFE-ucuVbw>
    <xmx:iItpZhGwMVAPAnIyt-uEZeVmWwaWe9GehlXPCCWOYb5-BlZkr55DPQ>
    <xmx:iItpZo_Z6VcDPtDxZiMpwY7IYLumZf7ElBvHODM7QW8-pkGSH8C1Qg>
    <xmx:iItpZmmteYxFgA4vHW7pfMwZZC1NICobb4tr8RquyGfvGjLt0BjTvA>
    <xmx:iItpZmROAvHgvxzYzhyiSBz9sCDWHYqL9r1QcnX9G1xZnOsSQJEhMFc7>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 07:50:31 -0400 (EDT)
Received: (nullmailer pid 1169202 invoked by uid 1000);
	Wed, 12 Jun 2024 11:50:29 -0000
From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH 0/4] Report rejections over HTTP when the remote rejects during the transfer
Date: Wed, 12 Jun 2024 13:50:24 +0200
Message-ID: <20240612115028.1169183-1-cmn@dwim.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello git list,

While investigating a difference between HTTP and SSH when rejecting a push due
to it being too large, I noticed that rejecting a push without receiving the
entire packfile causes git to print out the error message "pack exceeds maximum
allowed size" but it also shows "Everything up-to-date" instead of the rejection
of every ref update like the server has specified.

This is the result of two issues in git, of which I aim to fix one here, namely

  1) when the server sends the response and closes the connection, remote-curl
  sees that as an error and stops processing the send-pack output, combined with

  2) git does not remember what it asked the remote helper to push so it cannot
  distinguish whether an empty report means "I had an error and did nothing" or
  "everything was up to date and I didn't have to do anything".

The latter issue is more complex so here I'm concentrating on the former, which
has a simple solution but a complex test. The solution is to read in to the end
of what send-pack is telling us (it's creating the whole packfile that we're
throwing away anyway) so we can report back to the user.

The testing however proved a bit complicated as this bug requires the server to
cut off the connection while git is uploading the packfile. The existing HTTP
tests use CGI and as far as I've been able to test, httpd buffers too much for
us to be able to replicate the situation.

This is why there's a python Git server in this patch series that doesn't rely
on CGI but streams the data both ways so it can close the stream as soon as
receive-pack exits. There's already some python tooling in the project and I'm
much more familiar with it than e.g. perl, so I hope that's fine. I tried to
make it as simple as possible while still being able to stream bidirectionally.

Cheers,
   cmn

Carlos Martín Nieto (4):
  t/lib-http: add serve-git.py
  t/lib-http.sh: add functions related to serve-git.py
  t5541: add test for rejecting a push due to packfile size
  remote-curl: read in the push report even if we fail to finish sending
    data

 remote-curl.c             |  24 ++-
 t/lib-httpd.sh            |  20 +++
 t/lib-httpd/serve-git.py  | 353 ++++++++++++++++++++++++++++++++++++++
 t/t5546-receive-limits.sh |  24 +++
 4 files changed, 414 insertions(+), 7 deletions(-)
 create mode 100755 t/lib-httpd/serve-git.py

-- 
2.43.0

