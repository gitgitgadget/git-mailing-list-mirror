Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D444429CD3
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008394; cv=none; b=JJxC5yAO8LSrkzwOq0a+4dt3DN8a8jZiytdFtyAb4PfRYpqy2rCmUG6AkouoHe/BrwaIfnd1PPwb8akm7CLldyeCaM9QQBYgED8Qv/YKgVt59628HCMUhSyWKq736FfhGu/hvR4AFHi+5AdL1QN+nTQ4oa9dDKhYynoGxAB1z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008394; c=relaxed/simple;
	bh=aIrRaSQpeKUkLNEc58+S58dVrdMwlhiKWyA9mgLRmWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPD7U2jbUAbbF5AQk9uizxwIEk2J6ApVOamlpjCeCEUsysAg6D0jvQSVmnIHwE8ZOPh5ydb/khO/8O1zesaSkDcC3dqTrQjTJ/9OOAMwHFUgdqjPkuNNUocbeLdi0F2+7c2C7HrP7lftSk+fbgLnuFDOXQkuvOvn/R7ymcx9WYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fSWGZJc0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dQny0ryN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fSWGZJc0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dQny0ryN"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=fSWGZJc0iMgPYijw63+JFDMkcSnp4dRqiQeDYuwU3uDfABXy0BJMemumzdwhtvyFEWDtYV44UvJqITkg5EvDQAaEpJWf5vI95UxuR2wksVfVoT/v17MhIv15t0fk0Re3FKGHVNHvqLXvVTo5hjM1BXsEiDUJGyxPyRRA/DTy4G1D4PtlAlurkvyUEyfBzs7gZBDfnxsJYukaDKaHGJPbeM6Q5wpmJWOwXgQ1rC2U55iLIrXXkJaa2vD7LgStg9krETUEsBl9V+uD5s7P58cWpqDIw11o/mlp9xZCiBPq4IuR/mRaJ/UAKUoIT1V2zE53Cdk362XD13Fl1VM49dv6/g==; s=purelymail2; d=malon.dev; v=1; bh=aIrRaSQpeKUkLNEc58+S58dVrdMwlhiKWyA9mgLRmWA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dQny0ryNZjtgUVwwzoVRXe6MTUBLIqRFKsdE9FN80si4ve6WGlXzUYegQYTpRA8X5/W7SbTMHa0Gu9St4TSUXohpKLOxQ0QFcDWmX0jorv9Q0KSQzjB5ZYwHrvqJDdntYTe84Ix17Qv9myiLel/uGiny70VnNT1maq/DCTyuBISWRRmV8QmMkqu1Rj1LuJOuPgcqnxDxsihYplZtfgWaknPWZkj8KYtleDP0VbULuMIRBhD1qTg4Mu6eWd9C7vz7WLFRkYOX4RSetO+yS2n/GaTm6ZbnEBuqL6BIc2hBC5m97zPRcOFazPm1UioylRU7aJbYUxNNvh/dDCC5Uu45AA==; s=purelymail2; d=purelymail.com; v=1; bh=aIrRaSQpeKUkLNEc58+S58dVrdMwlhiKWyA9mgLRmWA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1822299684;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 09:26:31 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 3/3] environment: remove inaccurate repo_config_values comments
Date: Thu,  6 Aug 2026 17:25:57 +0800
Message-ID: <20260806092557.3951208-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806092557.3951208-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260806092557.3951208-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The section comments in struct repo_config_values do not accurately
describe all members grouped under them. Remove them rather than implying
a relationship that does not exist.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/environment.h b/environment.h
index 1a58b553b5..ab52330159 100644
--- a/environment.h
+++ b/environment.h
@@ -115,7 +115,6 @@ enum object_creation_mode {
 };
=20
 struct repo_config_values {
-=09/* section "core" config values */
 =09char *attributes_file;
 =09char *excludes_file;
 =09char *editor_program;
@@ -139,11 +138,7 @@ struct repo_config_values {
 =09int ignore_case;
 =09int trust_executable_bit;
 =09int has_symlinks;
-
-=09/* section "sparse" config values */
 =09int sparse_expect_files_outside_of_patterns;
-
-=09/* section "branch" config values */
 =09enum branch_track branch_track;
 };
=20
--=20
2.43.0

