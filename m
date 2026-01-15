Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25151C5486
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514495; cv=none; b=luO+j9rBFqzUuyr//5dtmCSxqtikZpm2guJDzB2dx2Ga3whSqjVyTdi7fe/RlwTJdiQqmDwFxnOsX2cYUHo7rxmK7Ck9XjHBNe2fOVxAXZtJaI/rY9DLncjRBbBwa6/8KTLSmtHroyIN58frwCcgoq+3iH/uWQdVZyC/G323PD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514495; c=relaxed/simple;
	bh=Y7ykykhsGHTJOcd35Kf11YRnnnP59Z0omCVGqjHVSUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=KkC26IMgUeZwLZah+jVLEC06QsVo9bMHILKnaYEjq8Jcho/0YzBEgSx6EBfUw9wuxCNA271Dbge79wvasCbgHflOeyETD6Q9OdxIplXWJjvHhs6ACqVB2A6zw3DFuM0A/6l1DYs0bH6gnDf6thB/JRWKmIP+u9WGifN+FaY7mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=viAmEF03; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="viAmEF03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768514485; x=1769119285; i=l.s.r@web.de;
	bh=moDBfYUIrX1Zo54q/vi/4NwhxKZhyLlCb95/KnC4JmY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=viAmEF03EuXw62+frIOjmjTNg/4Ydq/Cjn5bLjgSXexi0YYagoHJZQYUjqEHxDJw
	 o9Ghk479oNvpAV2TyxTqd1ZIVpLgFXCd67jOhwynb1TgEo0hyiNqXPTAXSad66s0W
	 wGAzhe4VqVdMCGbzTH5kwZTzoRCZZFEWJWwiPMo0duyN+KahoGZvmGwozFP0Z056a
	 IeFHQrRFYC1Iv7xs2LxvTR8Jyg0mqdb5HqlCrXE4NMzbK/w8ACadpAgjVlO1cJjAM
	 hlpWz31KJTOgSOQV3FFBPUOLge8HCkobnlj0M2NMntJ8hf2wYu8tVfygwtaMp8v2D
	 Oj8Bw1u7DExfi20JKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbTLB-1wDNBU3BUn-00fj39; Thu, 15
 Jan 2026 23:01:25 +0100
Message-ID: <cd6e8f5a-baaa-4c4d-9d2d-576d4b6a9a5e@web.de>
Date: Thu, 15 Jan 2026 23:01:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/10] cocci: remove obsolete the_repository rules
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
References: <20260109213021.2546-1-l.s.r@web.de>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZmDTzrfrzIoQ/fb2Y2rSSSb6USnZJFRb+ZaRllGXAipELURhGw
 F8ey2zzi3YhWIrG68SCIRW8xOUvLi58EbN+c+6JZh58LICpePJyk/zsmkiCMht9qIkjJyFx
 Dqx/0oH4EdG/KVhlcUQ90JXIP6gRHMl/2q5xOMMb2SaMAlhpuCxcBTeuH5UUuwZyNygF2bQ
 2dgU378xcMOFglhn26SbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4CgKoJYabaM=;mwVCsmIlC5ipCBzaDZT6VtEe5Nh
 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

035c7de9e9e (cocci: apply the "revision.h" part of
"the_repository.pending", 2023-03-28) removed the last of the repo-less
functions and macros mentioned in the_repository.cocci at the time.  No
stragglers appeared since then.  Remove the applied rules now that they
have outlived their usefulness.

Also add a reminder to eventually remove the just added rules for
tree.h.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 contrib/coccinelle/the_repository.cocci | 119 +-----------------------
 1 file changed, 2 insertions(+), 117 deletions(-)

diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/=
the_repository.cocci
index a1f6f5ac06c..f1129f79859 100644
=2D-- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -2,123 +2,8 @@
 @@
 @@
 (
-// cache.h
=2D- get_oid
-+ repo_get_oid
-|
=2D- get_oid_commit
-+ repo_get_oid_commit
-|
=2D- get_oid_committish
-+ repo_get_oid_committish
-|
=2D- get_oid_tree
-+ repo_get_oid_tree
-|
=2D- get_oid_treeish
-+ repo_get_oid_treeish
-|
=2D- get_oid_blob
-+ repo_get_oid_blob
-|
=2D- get_oid_mb
-+ repo_get_oid_mb
-|
=2D- find_unique_abbrev
-+ repo_find_unique_abbrev
-|
=2D- find_unique_abbrev_r
-+ repo_find_unique_abbrev_r
-|
=2D- for_each_abbrev
-+ repo_for_each_abbrev
-|
=2D- interpret_branch_name
-+ repo_interpret_branch_name
-|
=2D- peel_to_type
-+ repo_peel_to_type
-// commit-reach.h
-|
=2D- get_merge_bases
-+ repo_get_merge_bases
-|
=2D- get_merge_bases_many
-+ repo_get_merge_bases_many
-|
=2D- get_merge_bases_many_dirty
-+ repo_get_merge_bases_many_dirty
-|
=2D- in_merge_bases
-+ repo_in_merge_bases
-|
=2D- in_merge_bases_many
-+ repo_in_merge_bases_many
-// commit.h
-|
=2D- parse_commit_internal
-+ repo_parse_commit_internal
-|
=2D- parse_commit
-+ repo_parse_commit
-|
=2D- get_commit_buffer
-+ repo_get_commit_buffer
-|
=2D- unuse_commit_buffer
-+ repo_unuse_commit_buffer
-|
=2D- logmsg_reencode
-+ repo_logmsg_reencode
-|
=2D- get_commit_tree
-+ repo_get_commit_tree
-// diff.h
-|
=2D- diff_setup
-+ repo_diff_setup
-// odb.h
-|
=2D- read_object_file
-+ repo_read_object_file
-|
=2D- has_object_file
-+ repo_has_object_file
-|
=2D- has_object_file_with_flags
-+ repo_has_object_file_with_flags
-// pretty.h
-|
=2D- format_commit_message
-+ repo_format_commit_message
-// packfile.h
-|
=2D- approximate_object_count
-+ repo_approximate_object_count
-// promisor-remote.h
-|
=2D- promisor_remote_reinit
-+ repo_promisor_remote_reinit
-|
=2D- promisor_remote_find
-+ repo_promisor_remote_find
-|
=2D- has_promisor_remote
-+ repo_has_promisor_remote
-// refs.h
-|
=2D- dwim_ref
-+ repo_dwim_ref
-// rerere.h
-|
=2D- rerere
-+ repo_rerere
-// revision.h
-|
=2D- init_revisions
-+ repo_init_revisions
-// tree.h
-|
+// TODO: remove the rules below and the macros from tree.h after the
+// next Git release.
 - parse_tree
 + repo_parse_tree
 |
=2D-=20
2.52.0
