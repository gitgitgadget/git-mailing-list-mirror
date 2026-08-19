Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85453B95FF
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152177; cv=none; b=MDojkQA+bAfZ2rnq1foBcXYqqy8uhLMhMNygZCA/QjVnkLKJsTF0a7oKpsFcePnHSzIKGYyLfE00ltIGjer2LndupIBoYUuSRsIU+7Ate8EIPCZGBSQCjsEN33w94QOZXNNZhZ+T41TA97TEUTAPhOE8ZVGk/v7Qkp0NRsNedbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152177; c=relaxed/simple;
	bh=tQ0b+fW/wPV9Eh06UlzlhZI3r/eTc/o5Fa1E1XhYg4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TITaBIlxyZY62DxfSpTfsf+vF2/vmwcnSXD+OWcgWebqiP/PnI7H+HqLWAQwk6O3b34PJ8BiQeqZX2CtP+yYOurlUR8hYTkehT/8qSfT2BlymHR4mInaKd2T10DKAUQL80p0WmdLM0OEZ6bFONs18JVo8aFWlBfgHsA69YjCg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id 6925B83C
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:09:34 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id F0C14BC0E24
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:09:33 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id 27B1DBC0EF1
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:09:33 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id 96E1A1C13
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:09:32 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 6636E3C168C
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:09:32 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id pic-NXG0KhNF; Wed, 19 Aug 2026 15:09:32 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 31F533C168B;
	Wed, 19 Aug 2026 15:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id BX_EfXmM9LtK; Wed, 19 Aug 2026 15:09:32 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id 01AC53C168A;
	Wed, 19 Aug 2026 15:09:31 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>
Subject: [PATCH v2 0/1] config: surface editor failure in exit code
Date: Wed, 19 Aug 2026 11:09:17 -0400
Message-ID: <20260819150922.2984850-1-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260817211936.2943278-1-keni@his.com>
References: <20260817211936.2943278-1-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.123 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record

(Apologies to anyone who gets this twice.)

Simplified the tests and changed the test names from "--edit" to "-e"
since that's what the test is actually running.  Did not change the
tests to use "--edit" as nothing else is checking "-e".


1:  d54d260aa0 ! 1:  05d02b80dc config: surface editor failure in exit co=
de
     @@ t/t1300-config.sh: test_expect_success 'command line overrides en=
vironment config' '
      	test_cmp expect actual
      '
     =20
    -+test_expect_success 'git config --edit successful exit' '
    ++test_expect_success 'git config -e successful exit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    -+	GIT_EDITOR=3Dtrue &&
    -+	export GIT_EDITOR &&
    -+	git -C repo config -e &&
    -+	unset GIT_EDITOR
    ++	test_env GIT_EDITOR=3Dtrue git -C repo config -e
     +'
     +
    -+test_expect_success 'git config --edit failure exit' '
    ++test_expect_success 'git config -e failure exit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    -+	GIT_EDITOR=3Dfalse &&
    -+	export GIT_EDITOR &&
    -+	test_must_fail git -C repo config -e &&
    -+	unset GIT_EDITOR
    ++	test_env GIT_EDITOR=3Dfalse test_must_fail git -C repo config -e
     +'
     +
      test_expect_success 'git config --edit works' '
--
2.43.0


