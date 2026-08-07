Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181544A410
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093196; cv=none; b=hzoYjDAP+o+H+YuOdqit0CZ+I7XVxDmthAPvenPVvYQVtzdij3RlyfhWLMny7UgDzlwTZoZFhWvC7QqnC+giJ4WoaWlFhvHn9Z60JFBVrA7WrwtP3IB47NLjnTCAyI8RClAyNhL6qqG4IHDKGD2/BxAzdT1g86VarpMIWRXQHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093196; c=relaxed/simple;
	bh=8bIl4fw1Ondvce9pB1cRS5YQS9aeVAAFJGx9Zh229gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfuTJ5k5OFaCAvvdr+TszBDy+QWRjdtIwvifyQXT++Jvj1xRGvfte1/mcU8LgW5mqRt2P+bLEHy0TcNlN9ToLC2mHxymHsQfCNf/Vqw0f9RzxaQxEquxSjngHJrrjZTnSIo4PfWaFc9dHpsyHDyVjadJdFAOSAJXuIivtLhm26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=BHiX+auG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iXPLWm/t; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="BHiX+auG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iXPLWm/t"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BHiX+auG5NsfIwxg0IGhJz1ZCicZEfjEdy/05Tw0Ca924L2mYFpawoSyWWyLKHols+tuO1hwstKuTajFsGKPY/PtyVzqwH+oeQCxoaHUcsPvPUtlRYZe1WvPYR8FAmVdPXJ8+qQt8wp9gmtGu1wBXLtqV9OBuHQw0CxQIkYN3/cFwQQ4joDDOBPWnBvrpt0m7fpmZ+F511dX2douvU33GArKSck/EUcpiL3r/UkbsAeATn5jC5SHq5+Zz0xIAH4vvRLaC9igohSqIYZwgCN2TpvA9YoDI+3b1e3K9iXDHWDt22ZbBCWJzmyX67EBB4neH4OVB8b7hFJD3u6zbLGTsQ==; s=purelymail2; d=malon.dev; v=1; bh=8bIl4fw1Ondvce9pB1cRS5YQS9aeVAAFJGx9Zh229gs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=iXPLWm/tEY9o/Ovf6o4hnVhruaLye9RT0nZxveZitBCStn1iyt1X/1Ps/8rAEUoS7ZUpULuNpN+qI/qvhMcXWme8HwkyLntG0hUUzWnqROxR4OApA7dFkd+wbSsowfhvLcN0cSgT1EA0v1weEhLjWcIk5zUzjxeNqEfYUrF/aq3Nbn/FUNjUh1SCHmJcF7dIs7RQ/YatT2dRwKR/YFnwsiUDEPa1zFi2oXNzfyBPyoTqp9vkji6DyeGxtv9jl+gqQbHpaeAGK95DwycBPJ79oGPAQb5vox1be/ZED4qAfNQmvKFabecL7NRJfcY+yZzWJGOkO84QenqO9iC9facNlw==; s=purelymail2; d=purelymail.com; v=1; bh=8bIl4fw1Ondvce9pB1cRS5YQS9aeVAAFJGx9Zh229gs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1925904636;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:59:52 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 3/3] environment: remove inaccurate repo_config_values comments
Date: Fri,  7 Aug 2026 16:59:32 +0800
Message-ID: <20260807085932.3958759-4-cat@malon.dev>
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
index 6f864c1635..67fd387d35 100644
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

