Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519816;
	b=Z1wFEKlziTMRDBkzoI0t9gbc3//zBzPOjpd4Yh2mqkw1DdgqpJYzmQayFZ9WQlcr0Thn
	 VTvBIl52+6oE+LPBPxrqsdKNoAnX6CNTgoZ3BmykeppHa/N7GeZsg7KGVzWBaHXcmCBsQ
	 tvbKHXcCayb8C+0Z16xQWpBJl+Sk9qLQXsHNAeiF44vTBoOHnFDZHMkz0aY8rZQJAkv21
	 /DX/yGtNRk5E6xRyH+vcDizzTtssvE+zbzXAb86ighxooZkWeuo574Kg/8m1hwlMuZadC
	 Zkx6pM2bfxT0EbJqazn0PK/EY0Fla6nzjH+xL1P2jNM2OhvbR8Ej1oEJ+2Ky2wSGiQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519816;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=0jaBdPfit4QB3KPrJ1sW/Rc6Yeatne0CLWDceA1jnjo=;
	b=oUnuqhjeluu5V83t5Ft9e6g9sW0LjVIOdaNsJgGJrUC2mFsFRjhyRopyUOtE/vwQR6rA
	 R2FnBf2LWzax3mK4GTLQp6FyWQnFabpALdJ3ITJc/ylEnW6SKtzIcB9FYpwNaSYrH61hv
	 v2x3kp7evH7zU3pfSyjmhpNFbIn/5JULH7v4awmbZduSTatyMworXlDQNkQITytlWaUr7
	 sveMzQE5qvthDmF29X1r0EO7eWe8OZ3yx/JPVSyUrRyXkj+5knDe5twD52LGCuSblT/5H
	 qUCGW4RWFeLH4hHrLWB/VQcnf9/EtSSYYAm5PpnJ5I3bBoRUSy2GvobXxttL3LC4oHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SLV8U+bb;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FED606A324;
	Tue, 20 Oct 2026 18:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SLV8U+bb
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 676F74034C;
	Tue, 20 Oct 2026 18:10:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id ABC6018;
	Tue, 20 Oct 2026 18:10:12 +0000 (UTC)
Date: Tue, 20 Oct 2026 14:10:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: git@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Rebmann
 <kernel@schlaraffenlan.de>, Junio C Hamano <gitster@pobox.com>, "Ricardo B.
 =?UTF-8?B?TWFybGnDqHJl?= (SUSE)" <ricardo@marliere.net>
Subject: FYI, git output messages are being used by other tooling
Message-ID: <20261020141011.0015d172@gandalf.local.home>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ABC6018
X-Stat-Signature: jb5fsq4ixqodqemr3pawabdaok47acsz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mjkODYCXxTbqmsXVzi3xy8+nlIZeIgzs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0jaBdPfit4QB3KPrJ1sW/Rc6Yeatne0CLWDceA1jnjo=; b=SLV8U+bbE2et6iiSLyo6doeUjqi9MyJQZ9uKCm+5e4nNX+5uAD06KNpu2mw1LAp4ISbp12ynqeShvGd3RZDRQkIh43aOTo6Ub/1wjA5JgRQE9hN7KG/88AL2h3sDNeVmIG90DdUjmDOuJZVQQiPy6ZMtL3enAwxID+ZLdZQV7lA=
X-HE-Tag: 1792519812-951805
X-HE-Meta: U2FsdGVkX19/KTJbqhUWaoUtlHWwVgyOxssXknKPtgPhV8/9eBJBJbMYTzy2xEQahab6aB3YIVZD6B9a78h0DdbyKxq1VGLdjAdBqFtfSGbVYIsvetTsT1kQdzQmXxg/zHcVG8hykCMbghFTKh9ALC5vmnmV0CBTuSKVHQQfi/znSy0bnwkVKVxw580DMWc9AovUoIko4j2w1nYEiBmX0D3m9RExHDxaOkjug4TVW6uyUMvQWc13qqzu2FelJPBpNmS/7hC/wwsGvic3qnGiWeLCpdFfVfaJEiTC7Aztumwu66BKhqwpFDa3/as5gBAkbwnNJaDbNSaYBA/C6TE7bCUKFpZrl8ku203b2s0XY1ABUf55aQxgKCMpYaFqsJHYRuWpUUxMYKM22ezMcwmqOQ==



Hi,

I just want to let you folks know that ktest.pl (tools/testing/ktest/ in
the Linux kernel repository) parses the output of git to display the first
bad commit found in an automated git bisect.

The output was recently updated via: 0c0f93e7fa64 ("bisect: print bisect
terms in single quotes") which made ktest.pl fail to find the bad commit.

The change is being addressed:

  https://lore.kernel.org/all/20261009-ktest-git-bisect-v1-1-1d1428f6cbf4@marliere.net/

But I figured it would be good for you to know about this dependency.

-- Steve
