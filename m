Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2B12FF69
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559203; cv=none; b=p0KP6VhyOFoGwfA+qp+pdthrqPSXq8BOsOuJ0/Cnm/EK9P4GLGHSS8HkcGxohUa/13Xe6L2N7uJuurO7bcStQfhDwrRCjSc2pepvSEv9s/H7aFnJTZSmMziTp5gVKtWAiiX+2/QyHdVuopv6FqQHhdqeQLFLbFb/l7Ll3Tljbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559203; c=relaxed/simple;
	bh=QDFI/PqgbGFbcnr4DVQlIKR7bIbUMm66tAjiHR0L0tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVbxRro3w9vPg4G6/qIBSMJpCbcooSBRtd1y9U0BrKky2ZMH8aCX9QInNQo03OlczDr/zFN5rM/NviLvJ8vr7awDaVxGiJfhvsvo5eaDB0Vq9KS6pAMxxPPPi2cJMMJE8sAyQDbxyTwzVzlgMrGlBprZxzB3q0cHbCB4VkxNDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B7oj1tqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLGsRfwl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B7oj1tqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLGsRfwl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE1CAEC0122;
	Thu,  4 Jun 2026 03:46:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 03:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559201;
	 x=1780645601; bh=thktDJpNe46FkavZ4O/ee8D0X0FCxqEc8yrZoP3vAek=; b=
	B7oj1tqo/bNuxhlZdXFB09xaFppIRLIoAfFpjmxLxLOSfdxSqsFdQKOGuE7kUYpy
	12g0fElHX51O1nR6X8rTRzMgZ8z5t49jZaDp3EJ9aNfQnd1vLhN9E5b6sLppoZh4
	dE8MdfDFGlrRnnVnm7aWld6X0UvMQjijvEEYTgIS+sNDx60t2SbPCWF6ByMnI3d1
	Kgc/Ea/H9iZO2GNHwQuOk1VU9jokgWIUC51OEeY7udpRwbfHuDwb8HGwHgQ0NbD8
	vzygzRQBmQvFybTb/dtaT7+OUwG2pEjokZWIiFf/oRk5Du6tRMj7oUbf9Lb8z/Xc
	5eEJxhMsO1HC12wveHXAsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559201; x=
	1780645601; bh=thktDJpNe46FkavZ4O/ee8D0X0FCxqEc8yrZoP3vAek=; b=S
	LGsRfwlpB2ZZ4cJ6Y9I/4rj6xuEexowpFIGZtCutHSUkzWke5e9qkfK7tCK92Rfv
	Vho3UySAaoo5/bd+nLvdS+ww0r5vOVTs6jKsDbYvGyygknx2RTItiF1dpSlK9bUn
	iB8Dzxlxmmox+n1+qUpDaLQjvmAN4OTq2QurYLKsy+vwSgjbGePGF6IR1vcUH2+s
	C6gP512xVsqeBeE5Jkmiq3HwwLGbgZrvtqdvktFe4YtbEV17YApmhd21nR08omSM
	5VyUAIz5plTIJsrhD86wJHRHL7TK6lDxlyFEiPH2S4atyamGSbYvzfVFYLO/YaLi
	+v5YnzvlU+Iw2DBeascAQ==
X-ME-Sender: <xms:YS0haudC-WDISebWkFyPf8qi3Efs70ncyPWXTUa-i5jmr1eSqTf3jg>
    <xme:YS0havPGX54uMyCLoKAkuEaOmv9NupSyPilBaEV_G9ftcYb9XKJfvGuZpobg6xBs3
    jJObpS4cfUEYEhTVRY7hMBihAxnvk7hC2HW6LoC6Jfij4iS6LbIQw>
X-ME-Received: <xmr:YS0hakgVdAsJMS9ZbXc6B0gFE07e5dYFI_jQ1QzwzfHU0Rs8kpTnlfufpBES-mcWUnDaV2NRGrHcmmMmlGBLr8EpSMhtkmzs3BRYm8FLl7k>
X-ME-Proxy-Cause: dmFkZTGhxnEHpPYRfkYwrVk9CvMD/gy9+RwFxuxewttP632BuodwIhLBPqS0tGa/W0UmLv
    7dRtKxJAyCQXYHS1ssdOVK4eYn6AQPxqA2nPPXNw33ZvSAryoaIVsd9m2fF98906KDu89E
    0dwdOj/gFzkYPI2rh7o0xGlm56B6RVfGjglopqL39L4tATVvd1Z2/tUfcF9LAKFfVywOx4
    9kQmC+TuR6fWOqXkOMYNzMgYGfd1SXpHm/N0LhqxKv8HZrQ4j+pd53HQ7tm61Lb1dGIavo
    hGfj9Ry8AN4Mg7aMmuQhyLLzW5lBB/9q46FjrRfoBhVa/sD93g86VYmknHPMphOd72RxW4
    5j5euFDzSnboZiQWmGG/XNWGIO6s7iVXcL/DEKIGlngFqBMkPTeyVGktI6wIC2ZWwzI7j3
    x1irRs1aUg/WyTGNt+pwsSlH+CYUuWpFFfygAzp4VXCqQfDRoZiwwemUug9jZTQoXzUnZ8
    If31kKqApTR84dLHP3NwF7ScaYuoPdpNoPIodBtXEEQmmHsyvfMW7VfSizuWQbJwx8fkqm
    BNE+lwzZNjkpSU9rsielu/7bxDJNACffOWg2+BFIPdPWJ65y4jgAxiDh0uUpkEOXYgF0yg
    ldBGgiKse8VJOyxXDt/AbFMg1BXAJo8M9Z6a4oTMA/PQXzY9Me8QOsjz5MNg
X-ME-Proxy: <xmx:YS0haq3NCxOVuS5IrRBZV7g4ctlDvc0uF27JrRdYfMjrvrwC_C6sNg>
    <xmx:YS0hamg2jQUUWIV9LnKOO6hfTS6ABNHfrm5pXzJ22nRNzI6sigYfGA>
    <xmx:YS0haifod-ISoun_w9uo688b1FLFBT6P92ChnQKWMHf5MTwnlYb1RQ>
    <xmx:YS0hahn2f4X3rky8WwicRrvr9aGnNb98Bon4CA2YUFwhJyrtmNHAew>
    <xmx:YS0haoClw8XsUWJLOD4RSOTtU1rK5UksJO1t0XSbHSYnl5hzjhhzWSFS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 041b3c9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:25 +0200
Subject: [PATCH v3 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-1-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In subsequent commits we'll rework how we set up the repository. This is
a somewhat intricate and thus fragile sequence; there's many things that
can go subtly wrong, and there are lots of interesting interactions that
one can discover.

One such discovered edge case was the interaction between git-init(1)
and the "GIT_OBJECT_DIRECTORY" environment variable. When set, the
behaviour is that the object directory should be created at the path
that the variable points to. This behaviour is documented as such in
its man page:

  If the object storage directory is specified via the
  GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
  are created underneath; otherwise, the default $GIT_DIR/objects
  directory is used.

Curiously enough though we don't seem to have any tests that exercise
this directly, and thus a subsequent commit inadvertently would have
broken this expectation.

Plug this test gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..e89feca544 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -980,4 +980,14 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
 	test_cmp expect err
 '
 
+test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
+	test_when_finished "rm -rf init-objdir custom-odb" &&
+	mkdir custom-odb &&
+	env GIT_OBJECT_DIRECTORY="$(pwd)/custom-odb" \
+		git init init-objdir &&
+	test_path_is_missing init-objdir/.git/objects/pack &&
+	test_path_is_dir custom-odb/pack &&
+	test_path_is_dir custom-odb/info
+'
+
 test_done

-- 
2.54.0.1064.gd145956f57.dirty

