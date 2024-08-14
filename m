Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06913C820
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676615; cv=none; b=N1xfmG1GOx4REU/E0BKKA0R/Ky5/ED1BbzZxbk8WGg1sIyhqytrVVkK8F849XxaNvrVWXZH2YcP6bnzPGbBUarYeWpE+y9e7DHl2Fb8S7hGM3R/323htjjy1j0YWsvdds42/qj7sL5UQVlZcM2kqu/qFFeu3F8DGjSQ5qS2Fos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676615; c=relaxed/simple;
	bh=tuQzF/wicGShwCD/tNXoXWV/BntmsPXaNf33DsGjGko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAtWEIk88sieEYc65HmBL5NKBslC7eXL4+4eoAy/m31eE+udeu2Wv2ucn/BE/oEeCLpApPz8VuXw55D0cyz86x9mjSSExboP3yNPRFuDUAFwbBSzUzcziFB9C1RGkP0wvH+EBV7P9Y2jIZ6h0cwowk+U//5wJ2MttiFdg72UTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KVC5BAlz; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVC5BAlz"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 07E4C2C1EB;
	Wed, 14 Aug 2024 19:03:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	uQzF/wicGShwCD/tNXoXWV/BntmsPXaNf33DsGjGko=; b=KVC5BAlzMnlmTDH2n
	6DL58UfEFFHQowJV8HtE6h1ZI6aZqgO2vm7xyCeSJ2dEbSyCg0BA+DCiOYHPcydz
	lqD78dJ4myMX6A23pp0XF610Dkumzysz013a81/d/eNQtw8cSRMCXXn8DHZ+m73p
	jHJl6JrvzFi8y2YO0BkzZJESBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 01FFB2C1EA;
	Wed, 14 Aug 2024 19:03:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7312D2C1E6;
	Wed, 14 Aug 2024 19:03:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] howto-maintain: mention preformatted docs
Date: Wed, 14 Aug 2024 16:03:26 -0700
Message-ID: <xmqqikw2wvup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B11D896-5A91-11EF-B6C6-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Forgot to mention that the preformatted documentation repositories
are updated every time the master branch of the project advances.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/howto/maintain-git.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 41f54050f8..da31332f11 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -181,6 +181,10 @@ by doing the following:
      $ git diff ORIG_HEAD..   ;# final review
      $ make test              ;# final review
 
+   If the tip of 'master' is updated, also generate the preformatted
+   documentation and push the out result to git-htmldocs and
+   git-manpages repositories.
+
  - Handle the remaining patches:
 
    - Anything unobvious that is applicable to 'master' (in other
-- 
2.46.0-344-g6a33a8350c

