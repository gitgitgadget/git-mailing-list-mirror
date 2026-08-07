Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2744BCBE
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093193; cv=none; b=DdYv0F4Jq5iGJ6E3jJF2dkAfG3m4tgq5BJn+VrSTr/HJqPcaPAmyVPO6NCGrVcDepclUZzMJxDPfwYOEQki/UzdgZxIPjNFvrECkMAO2ip4+aW2iwMy1A6jl6DYExer7lJxZcWRfGp/S8SIosLqzLAOe9m0xx1w21Q9zx9LcS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093193; c=relaxed/simple;
	bh=nu4BMadI3ba34CdOO9+z7zp7zJjSVbTHYBuw1O0n9UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qneq2sbiMf1KeGMhqSqyteNXATuzR6Bd9HyCMoAZhxZ/Z1PBy/zwYbhX7NE2URiRbD1ZKuFGNiusz2sKnl8X7G6+LM3gTXNtepineltAkIrS5z153Dj/6E8id4LcWOMJ1LUDl3LVsPG+3+TB+PIdhMJd0ilM/DELk2w+GZfdaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=h8162lwJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=JTgHnRc7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="h8162lwJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="JTgHnRc7"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=h8162lwJoFXAZ4lfugbBbeGuK5PA2e3qq8uAXY62bKPw4OBuO/514mdl0e47fBSBvEFW6YAryfxYUgZqmqalP+m1BO675GvhlGoEby9MY78JLTb3rIOz9y9ZH65WTZMAuY7BEPgUKsLRjnqKHaHwx9aSHQU7+O07RhOcDUDzr0XipbmZAoUNeBIpmJDWScYfSanpM0aZ7eEJdT5L276NLh4XRNj4i7CxRgBdBf0404NrZ5quORPXrQFrdxJ64T0VmSYGyPO1YLNMBtA1/40aGqPUa/AaL2v5dqYWvw65q+r+Czg/AlnxOxjR+lnEADB28YAIUbNsssMa1BNNsw8abQ==; s=purelymail2; d=malon.dev; v=1; bh=nu4BMadI3ba34CdOO9+z7zp7zJjSVbTHYBuw1O0n9UI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=JTgHnRc7Z9Ze9vLQifKVOFWloLm0hAS2kMNyJar4WqJOC3zvYc4jlp1Znb+6ce/NzZKanW9nVkUtHatWvyAtmMcVEgIS9PsEwQVxr5vunVot7L4fj7kW7YxkD6afF/okyvu/uIgXsjQfEaT1MiYlmuOM3YwbI+PV3FN1G/Gffdiqp2HSbPEhT896nQs9ImQSa0j1cNePdDQrnJzWMP54kxXcYGNaBw1cr2V37YWF1q2LxV6y2B8zBTek2tt/JRZCTqg6rueSJgrd+tq7WPga0apmb05aq0Rd14uOjlXFFYUdAhkoTGeUbxJoLgcJZYmLkn3DCUGDLySWv3I1Uuw+nA==; s=purelymail2; d=purelymail.com; v=1; bh=nu4BMadI3ba34CdOO9+z7zp7zJjSVbTHYBuw1O0n9UI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1925904636;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:59:50 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 2/3] environment: clarify repository config getter documentation
Date: Fri,  7 Aug 2026 16:59:31 +0800
Message-ID: <20260807085932.3958759-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807085932.3958759-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Update the comment above repository config getters to describe their
common behavior.

The getters handle repositories that are not fully initialized by
returning the corresponding default values.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/environment.h b/environment.h
index e7ec5b0437..6f864c1635 100644
--- a/environment.h
+++ b/environment.h
@@ -175,22 +175,15 @@ int git_default_core_config(const char *var, const ch=
ar *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
 /*
- * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo=
_config_values`.
- * They check `repo->initialized` to prevent calling `repo_config_values()=
`
- * before the repository setup is fully complete or in non-git environment=
s.
+ * Getters for configuration variables in `struct repo_config_values`.
+ * These functions require a non-NULL repository pointer and handle
+ * repositories that are not fully initialized by returning appropriate
+ * default values.
  */
 int repo_protect_hfs(struct repository *repo);
 int repo_protect_ntfs(struct repository *repo);
-
-/*
- * Getter for the `ignore_case` field of `struct repo_config_values`.
- * It checks `repo->initialized` to prevent calling repo_config_values()`
- * before the repository setup is fully complete or in non-git environment=
s.
- */
 int repo_ignore_case(struct repository *repo);
-
 int repo_trust_executable_bit(struct repository *repo);
-
 int repo_has_symlinks(struct repository *repo);
=20
 const char *repo_excludes_file(struct repository *repo);
--=20
2.43.0

