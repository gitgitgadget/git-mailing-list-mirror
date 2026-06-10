Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8833DB30A
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084221; cv=none; b=lggEjPN/Sz+BKO3idW15b5nFylk+PrL+DBxq25+Iwizjr5l+dUX+apArsTkpADRG+n7VbTAZHbMaDHBaUMxHd/ujnLPdVjsStMkNqSFJ6qot2BcdRxWbU982PixVWE+WG+/aPwnD3Ah7BaGpiFUeyyY5ynP40gAQmUT80Tl4TqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084221; c=relaxed/simple;
	bh=zjFVcwTC9hn92aHwzAUvv0PIwO1hL8/06V8sJk8MZtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRhDX4K2LG6T+tILvxemMgs9X6N0Y8D4Cwf4EOKNQlNeGqaCLVQv31SAbS1+R5DOLBeVjWO9mWLFPNSns6oneD2d1FqhcnLAhZXBvUuNbcx7xygaKEP7jm397ugHXpxVX+6mtvPAe2t2SXbkhAuucKIcir+HWMZCxi+yBX8tvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=C3DjdMcs; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HpBH/ZEW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="C3DjdMcs";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HpBH/ZEW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=C3DjdMcsgo4PBJEGj9vv+63Xurn/Sm79gutXWCx22/QCDv9JFnw5w4AXkitSeIxWL6NggXE9TuP74JTMcBCfhhs4li0olshmG10Ds58yFskFEYGgh3E7SFDftwSqBngio4u1JeGdH9jIA8wyT908v7I6KnhhY2m56Dn2qIriiyA7+2MvSGHRHl3uL7XhWVdhIZ0aNOKPOYzy1Y+GqaLG8Vzo3HCfdkVVglmdtlnuaS0brXFnWoihwVkY33DEs3ZsDn0Bp958JYQRA+YhsjOcDRxYIuwkorsuUbmbs8ddQqQ35/lv/bBxc2soN/SaQN410h9C9qpMB8GkD3csnm5bsA==; s=purelymail2; d=malon.dev; v=1; bh=zjFVcwTC9hn92aHwzAUvv0PIwO1hL8/06V8sJk8MZtw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HpBH/ZEW94aJU8OvPRgZPdUysQkBX6yvDUFaxIBZiTrB2i4fLGSSGV1zNjVfDdFfhT9M1fPozDp5oPluw5lfZSFANIyzs8qpx31+Cb+guXMdXo2LNBm90QzBSdWG87U11xN2P0txnItxAzv0vIprYlrXkjLmUoMWNPA2pUw9nTJCfIAzkUf3QHdAWqEAOZWEu6mwJypLw2O/ZeuZzO8+TLb/PieuUyJ1D6DmE2IlQintA+5ZmsZ3Ph+JNlirX7K/ILkqVM2YaBfOYcwhV0xiKje2DPhXpzns5pTX8QS8Lnf0qRZHGY2755AErUjFdbK1VJMDfdR+0uhF66FjLqqmhg==; s=purelymail2; d=purelymail.com; v=1; bh=zjFVcwTC9hn92aHwzAUvv0PIwO1hL8/06V8sJk8MZtw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1035819346;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 10 Jun 2026 09:36:50 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 0/3] environment: migrate 'trust_executable_bit' into 'repo_config_values'
Date: Wed, 10 Jun 2026 17:36:31 +0800
Message-ID: <20260610093635.139719-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160520.77859-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.filemode' (stored as 'trust_executable_bit') configuration
act as a core filesystem capability flag.

This series moves it into 'struct repo_config_values' to tie it to
the specific repository instance it was read from. Eager parsing
is maintained because this flag is heavily consulted in hot paths.

Note: 'repo_config_values()' still does not support any struct
repository other than the_repository due to how deeply these flags
are accessed. In other words, this series of patches is laying
the groundwork for the eventual elimination of the_repository.

Previous related work:
[PATCH 2/6] config: add trust_executable_bit to global config [1]
[PATCH] Refactor 'trust_executable_bit' to repository-scoped setting [2]
(This previous attempt was unsuccessful because the target location
selected was 'struct repo_settings', which our analysis indicated
was not the optimal choice. For further details, please see: [3])

Changes since V1:

Dropped istate plumbing: Dropped the last commit ("read-cache: pass
'istate' to stat/mode helper functions") to keep the patch focused.

Introduced safe getter: Getter function 'repo_trust_executable_bit()'
has been introduced to retrieve configuration values safely.

Added comments for 'ce_mode_from_stat()'.

Thanks!

[1] https://lore.kernel.org/git/837b5360b40f992351f489a0ae05fedf49884c6e.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20260301190017.53539-1-dronarajgyawali@gmai=
l.com/
[3] https://lore.kernel.org/git/xmqq1pht6nyx.fsf@gitster.g/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (3):
  read-cache: remove redundant extern declarations
  read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
  environment: move trust_executable_bit into repo_config_values

 apply.c       |  2 +-
 environment.c | 11 +++++++++--
 environment.h |  9 ++++++++-
 read-cache.c  | 28 +++++++++++++++++++++++-----
 read-cache.h  | 16 ++--------------
 5 files changed, 43 insertions(+), 23 deletions(-)

--=20
2.43.0

