Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xTbUSHxQ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7046196
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 09:40:25 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E111CC645;
	Wed, 15 Nov 2023 12:40:25 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=0r56WQWO1Gahb8ZkH1Ded2way
	xXGSGG3q5vWjN1iXg8=; b=xTbUSHxQ+YeNAEn1AeOSBcTCvN0pabOrtsDJjBV1e
	hmwXK2ImLVTmYr8Ftkgk5/bBxqzWM4cNsj21Aabe+kuyPr8aP179KyXqCv00XExN
	MAhBpZWEbBK+wNdcXzDaomICrK/4k/AN12lG4LcFalMDFkjYf1uJCFOtDzKy3lTw
	78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31BBA1CC644;
	Wed, 15 Nov 2023 12:40:25 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E4C71CC640;
	Wed, 15 Nov 2023 12:40:23 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [RFC PATCH v2 2/2] send-email: remove stray characters from usage
Date: Wed, 15 Nov 2023 12:39:44 -0500
Message-ID: <20231115173952.339303-3-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <20231115173952.339303-1-tmz@pobox.com>
References: <20231115173952.339303-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0E966724-83DE-11EE-A9F1-25B3960A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

A few stray single quotes crept into the usage string in a2ce608244
(send-email docs: add format-patch options, 2021-10-25).  Remove them.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
This is not scrictly tied to the previous commit.  It just stood out
while I was reviewing the usage output.

 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94046e0fb7..cd2f0ae14e 100755
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

