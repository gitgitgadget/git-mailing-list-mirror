Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4314533D
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799244; cv=none; b=WsCXLB/g05MP1jFVeO6vhviKMhq8q76r6ATgz3dhhaNaXDzuxBWqk2sJu4/zS3z3fF8B6xzedlw3HV9YJfZIEJRbi69MIDM6a1pYETHJJG1NrtbmhZo/L3bjN17ixMcSvztdQ7wLVi1YcW53xgWRcDZ/2iO2Ns3IAv1vdczXJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799244; c=relaxed/simple;
	bh=zKJ+bm207QWjAVxST+ENjs6HXozh5aCdwIPgmqkWDwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OzhZVq4OaIKEpx4U518oQF0rAdFY7zVkXvxKZbkjqy+EnEjsM5LpssFA3lHqIxeG5hWS/lpzMeyCAlH+12Pbv/IEQ9clqzECAvEV2sURAunKWb6xGCCF4YEgxiz0jYjWrbNgsnoLgJ10wd7w5WQh+9KX8bOIKGGc7zGjtsAjO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ofZcol0x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ofZcol0x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 176B0193F7;
	Fri,  7 Jun 2024 18:27:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zKJ+bm207QWjAVxST+ENjs6HXozh5aCdwIPgmq
	kWDwA=; b=ofZcol0xY/78NaTiZ6SIv60J7IsKJZ8sf1ow+g8h/cyw1lF9AD8Z9b
	abCyj93MrRN4QFSw+Q7X7ETskgYk3wjLttGOawuL30hcz0L04Df2AXKSGWVkuUcn
	8orK0rdQRtyO3FFyafU3kPLjfFGKJVIn+OOV5+FiUY0cCMZ29nq10=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FC56193F6;
	Fri,  7 Jun 2024 18:27:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C19FE193F5;
	Fri,  7 Jun 2024 18:27:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rjusto@gmail.com,  sunshine@sunshineco.com
Subject: [PATCH v3] doc: interactive.singleKey is disabled by default
In-Reply-To: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Wed, 22 May 2024 23:24:43 +0200")
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
Date: Fri, 07 Jun 2024 15:27:17 -0700
Message-ID: <xmqq4ja4e6d6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19BFD992-251D-11EF-9ABC-8F8B087618E4-77302942!pb-smtp21.pobox.com

From: Dragan Simic <dsimic@manjaro.org>

Make it clear that the interactive.singleKey configuration option is
disabled by default, using rather subtle wording that avoids an
emphasis on the actual default value.  This should eliminate any
associated doubts.

While there, touch up the remaining wording of the description a bit.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * While I think it is pointless to say an optional on/off switch
   defaults to off, the structure of the paragraph is better with
   the updated text overall, so let's take this version before we
   forget.

 Documentation/config/interactive.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index 5cc26555f1..8b876cb4eb 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -1,8 +1,8 @@
 interactive.singleKey::
-	In interactive commands, allow the user to provide one-letter
-	input with a single key (i.e., without hitting enter).
-	Currently this is used by the `--patch` mode of
-	linkgit:git-add[1], linkgit:git-checkout[1],
+	When set to true, allow the user to provide one-letter input
+	with a single key (i.e., without hitting the Enter key) in
+	interactive commands.  This is currently used by the `--patch`
+	mode of linkgit:git-add[1], linkgit:git-checkout[1],
 	linkgit:git-restore[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1].
 
-- 
2.45.2-445-g1b76f06508

