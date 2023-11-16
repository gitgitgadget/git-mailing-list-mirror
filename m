Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dTsz88dF"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C50018D
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 11:36:32 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 690FB1B6B25;
	Thu, 16 Nov 2023 14:36:31 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=94bDQbHobmfx7JTA+7w80xnZn
	u+3cZEo+kdcfZlE/AY=; b=dTsz88dFSb9IYV7q226rkn+AzBeS+9VW1X5DyQJnw
	O2zSW2onHgRrpP5TforgphRaG1xOYN0qt72/F9F4kNipRwT69dIINOQ60n9wjpO8
	mQL86DSmeKsTAONC9n9d1e5kvvpCa+s/oFs4NwOd7BNnoBT8IcpHUqEym69BRU3t
	ng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61CB51B6B24;
	Thu, 16 Nov 2023 14:36:31 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB80D1B6B22;
	Thu, 16 Nov 2023 14:36:30 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] send-email: remove stray characters from usage
Date: Thu, 16 Nov 2023 14:36:21 -0500
Message-ID: <20231116193623.471261-1-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <xmqqzfzes37f.fsf@gitster.g>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 71334DA0-84B7-11EE-B3D4-78DCEB2EC81B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

A few stray single quotes crept into the usage string in a2ce608244
(send-email docs: add format-patch options, 2021-10-25).  Remove them.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
[I trimmed the Cc: list]

Junio C Hamano wrote:
> Thanks.  Let's split this out as a docfix patch and handle it
> separately.

Done. :)

 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cacdbd6bb2..d24e981d61 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -28,8 +28,8 @@
=20
 sub usage {
 	print <<EOT;
-git send-email' [<options>] <file|directory>
-git send-email' [<options>] <format-patch options>
+git send-email [<options>] <file|directory>
+git send-email [<options>] <format-patch options>
 git send-email --dump-aliases
=20
   Composing:
--=20
2.43.0.rc2

