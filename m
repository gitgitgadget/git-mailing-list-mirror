Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AB198A02
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693483; cv=none; b=UTD/ocZxgVI9NZOVAeIRDOPYOZS0JPjF/UWs0k1nzJP/MtXRdVD7Qms48pUl4OIT4708ho5BG0hcObz9+R7nMdkMo7WLHrPU79Z7FLPoth7fDiZ9k+HNoI6Cjdv9/P4YxFiUSUBUvQHnm+0Vd87Q89BV9D/kezu/fDFY8gjDxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693483; c=relaxed/simple;
	bh=egP4cR7adKicNJv8D5oc1pQ/ToTg6em0R6kX6d2YBJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5+wCNgUCtNmrYi+AYRV+F9BbIvkzlM197ev3LFzG0Nr7avU9TDbHj9dPNhh5C9ePed0DbFMW6BEJsnHQeFAst/6mHRHpS+NtiTKdFsqMr+JAS7Hf9Z0neS0kHbR5oXYBiAIYe3ZoXr7myS89CC8ghIQfnfQhkaWStTe30GGaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcW25hNJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcW25hNJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D0F12B065;
	Mon, 26 Aug 2024 13:31:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=egP4cR7adKicNJv8D5oc1pQ/ToTg6em0R6kX6d
	2YBJs=; b=mcW25hNJkeFi6UIUe1dvZ3ayKHi0WiXCgIr0DFaKhiZ3Ao589TmTvQ
	gVmErdF78aSN3hicK/FC5PNfyQg1CWF5/YxbS466AxNry/a7S4BLJx7uUHNpVHDj
	O6QsnVFPIL6nW5GtVyOp7Y48roGzrSNTh/MeyonFQbVqr0aO5GclU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43EB62B064;
	Mon, 26 Aug 2024 13:31:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98F6C2B063;
	Mon, 26 Aug 2024 13:31:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Celeste Liu <coelacanthushex@gmail.com>
Subject: [PATCH] git-config.1: --get-all description update
In-Reply-To: <xmqq34mrkxre.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 10:19:17 -0700")
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
	<Zsgh4LacdOt8N69o@tanuki>
	<6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
	<ZswfgYsZrzY6kc1E@tanuki> <xmqqa5gznwf9.fsf@gitster.g>
	<8c1c031b-4f36-4825-93ef-408c50b0ee2f@gmail.com>
	<xmqq34mrkxre.fsf@gitster.g>
Date: Mon, 26 Aug 2024 10:31:19 -0700
Message-ID: <xmqqplpvjimw.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 021B8BC2-63D1-11EF-A375-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"git config --get-all foo.bar" shows all values for the foo.bar
variable, but does not give the variable name in each output entry.
Hence it is equivalent to "git config get --all foo.bar", without
"--show-names", in the more modern syntax.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git i/Documentation/git-config.txt w/Documentation/git-config.txt
index 65c645d461..1ee5c89ba2 100644
--- i/Documentation/git-config.txt
+++ w/Documentation/git-config.txt
@@ -309,7 +309,7 @@ recommended to migrate to the new syntax.
 	Replaced by `git config get [--value=<pattern>] <name>`.
 
 --get-all <name> [<value-pattern>]::
-	Replaced by `git config get [--value=<pattern>] --all --show-names <name>`.
+	Replaced by `git config get [--value=<pattern>] --all <name>`.
 
 --get-regexp <name-regexp>::
 	Replaced by `git config get --all --show-names --regexp <name-regexp>`.
