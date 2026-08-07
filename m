Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058A3557F3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093188; cv=none; b=W+bCONOL+0P7NVuqEdLFKSBDykzlwCczQgrpeoaA5F38Ce+nYhsfGr/GVSUzbkpbU/nmvsbINlpdMNgoy6i1sSF1fO37k5coz8H16PgCvTt6hkIzkdhu5EZLG1gNfYhdx6Nv7wwmtpcinCbQOPxOCRfhHJdNqsENVXTwD1GSQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093188; c=relaxed/simple;
	bh=SlmkGDNoezGATVVXblQVLEzL75aAPO4SSOSbiy5JGaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di5Qy3SHF6Wr42f4VyEQzpBA+QmTMvz/flF2YncDIuaqO/k26d31uh8kSRbVMvWJc5Uy0OQvx7PFOuRLQoR8mg9j5NOpcXzYfBJHIPY+OrBJFVhvRHFNiJr+uXDikgzhjaftn2V32iMggMDPW3bSSfLVBpzhKbFY98/OXmyFMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=CpW28+x8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XQuXicHO; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="CpW28+x8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XQuXicHO"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CpW28+x8wbRYy9VePaEGSwEWtv9WPdSQ91CogW8r3+LaHwh6olrObOCiWu0eM4pdnwpKNr08nE8YQ1wWfVnLwLcWynKzk7rohBkZ/ZiYA6ppfCaP4I6NH6iwHMpPrDTuaRv1AU8lG2I/MrVz+opcQkybmEjA7dM8JyFATSRGmXpqFuENNV8gWk9ZERBc4iu4iE4zYuHyo8gvaaBEYfTw+r1CcBOKOtuSR9gdEI+Q8v1rY0XzW4rmOWFSsV7X1ts9SGNkGvSP7sW5kw+9wpEDi9PHoh5NZJWlWbRSHY4iFcbfvEjQBZG2nJcOOejSrotWz94M5ERSU9ValNpCcuBavQ==; s=purelymail2; d=malon.dev; v=1; bh=SlmkGDNoezGATVVXblQVLEzL75aAPO4SSOSbiy5JGaQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XQuXicHOQbliy3GXIJYXs3GyqozbvF77GNSB6qj9UlJ6CPWHYgQqa+5SiaNZek2TJzFVxy7jIbhaPJUfgL3Zo6UgHeBkGLrO9PBClxJOwQod2Feo5RqatfwMWedIi9ylaGzU5jxQIlgT94ZQZ2BQP24Y1UZiBBQARF5v+WJ746kt55irkACKwDfK+qDav4/WHv5oPAr4M4mwv/jwcYOz0pprhpVrNecS9r9gruPeFbno8OEPVZwWUOo100zNbfJK06vFVpjvXf45nBPbf74WYcDPqfWb7BqoOixY33Upu02LUN/uUtccks7ks/OF/jBUp1J2UqRyAZdoe5+rjUYWFw==; s=purelymail2; d=purelymail.com; v=1; bh=SlmkGDNoezGATVVXblQVLEzL75aAPO4SSOSbiy5JGaQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1925904636;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:59:44 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH v3 0/3] environment: clean up repository config handling
Date: Fri,  7 Aug 2026 16:59:29 +0800
Message-ID: <20260807085932.3958759-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115342.3939931-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This series contains several cleanup patches for repository configuration
handling.

No functional changes are intended. The patches make the related code
more consistent and easier to maintain by improving documentation,
formatting, and the organization of repo_config_values.

RFC:
If there are other small cleanups in this area that would be useful to
include, suggestions are welcome.

Regards, yuchen

Changes since v2:

 - in the commit message of patch 1/3, explain why NULL repository is
 not allowed.

 - in patch 2/3, mention in the comment that NULL repository shouldn't
 be passed in.

Tian Yuchen (3):
  environment: drop redundant NULL checks in config getters
  environment: clarify repository config getter documentation
  environment: remove inaccurate repo_config_values comments

 environment.c | 18 +++++++++---------
 environment.h | 20 ++++----------------
 2 files changed, 13 insertions(+), 25 deletions(-)

--=20
2.43.0

