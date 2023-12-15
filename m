Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA447763
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vucSWFAF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0881827BAA;
	Fri, 15 Dec 2023 15:32:50 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=uexs8IfaY/inYmAz7u8GlvfW3avVtRsMK+CovbGn7G0=; b=vucS
	WFAFo5MXSqHAh+6RNSW2wQKFkAzWEKoSrNYmed7LShzP1Mg5s7MiRo9ZxTZVZmnR
	p7RV2HMVSLn4QiPqvQmU4ZdYl7E8a9+clS/W82+wkdim5NFt7wnXALcQviu3DOzc
	gZDWNTU9FZYqXIVPETK+jplDqRFC0tm8B+e2lzc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0279E27BA9;
	Fri, 15 Dec 2023 15:32:50 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A06C327BA8;
	Fri, 15 Dec 2023 15:32:46 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] make room for "special ref"
Date: Fri, 15 Dec 2023 12:32:40 -0800
Message-ID: <20231215203245.3622299-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-76-g1a87c842ec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1B594DEC-9B89-11EE-A196-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick's reftable work is progressing nicely and wants to establish
"special ref" as a phrase with some defined meaning that is somewhat
different from a mere "pseudo ref".

A pseudo ref is merely a normal ref with a funny naming convention,
i.e., being outside the refs/ hierarchy and has names with all
uppercase letters (or an underscore).  But there truly are refs that
are more than that.  For example, FETCH_HEAD currently stores not
just a single object name, but can and is used to store multiple
object names, each with annotations to record where they came from.
There indeed may be a need to introduce a new term to refer to such
"special refs".

Existing documentation, however, uses "special ref" to refer to
pseudo refs without any "special" property, like FETCH_HEAD does.

This series merely corrects such existing uses of the word, to make
room for Patrick's series to introduce (and formally define in the
glossary) "special refs".

Junio C Hamano (5):
  git.txt: HEAD is not that special
  git-bisect.txt: BISECT_HEAD is not that special
  refs.h: HEAD is not that special
  docs: AUTO_MERGE is not that special
  docs: MERGE_AUTOSTASH is not that special

 Documentation/git-bisect.txt    | 2 +-
 Documentation/git-diff.txt      | 2 +-
 Documentation/git-merge.txt     | 2 +-
 Documentation/git.txt           | 7 ++++---
 Documentation/merge-options.txt | 2 +-
 Documentation/user-manual.txt   | 2 +-
 refs.h                          | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

--=20
2.43.0-76-g1a87c842ec

