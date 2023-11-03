Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE901B269
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2/VbTn5"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9CD43
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:18:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D02C3FBA7;
	Fri,  3 Nov 2023 10:18:43 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=2CQGtalYLRfMl/l2HAVllHKmc
	0DB8M5OI8UkX/T0zh4=; b=f2/VbTn5durk7YptJVJrIUBdrgBSrUZQIDIc4aZdq
	yaizCouW/D6VzlYbw+xpfvCC6UU5Z9lKzlvEao7/xFXdIA2rkr1x1vDl8qOXjbyz
	w3MCbpHVhtIxeZRu9nbCUtF1Yl8tX1KcKDGx/xlD7H8how+CRPQ3V+tBA593pjPM
	xc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 957813FBA6;
	Fri,  3 Nov 2023 10:18:43 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D9853FBA5;
	Fri,  3 Nov 2023 10:18:37 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] RelNotes: improve wording of credential helper notes
Date: Fri,  3 Nov 2023 10:17:51 -0400
Message-ID: <20231103141759.864875-3-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc0
In-Reply-To: <20231103141759.864875-1-tmz@pobox.com>
References: <20231103141759.864875-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E204C590-7A53-11EE-9CBE-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Offer a slightly more verbose description of the issue fixed by
7144dee3ec (credential/libsecret: erase matching creds only, 2023-07-26)
and cb626f8e5c (credential/wincred: erase matching creds only,
2023-07-26).

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I had trouble parsing the original.  Hopefully this is an improvement. :)

 Documentation/RelNotes/2.43.0.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2=
.43.0.txt
index e66d691f4e..6db6865861 100644
--- a/Documentation/RelNotes/2.43.0.txt
+++ b/Documentation/RelNotes/2.43.0.txt
@@ -37,8 +37,9 @@ UI, Workflows & Features
    oath token and password expiration data) are stored in libsecret
    keyrings has been rethought.
=20
- * Update two credential helpers to correctly match which credential
-   to erase; they dropped not the ones with stale password.
+ * Update the libsecret and wincred credential helpers to correctly
+   match which credential to erase; they erased the wrong entry in
+   some cases.
=20
  * Git GUI updates.
=20
--=20
2.43.0.rc0

