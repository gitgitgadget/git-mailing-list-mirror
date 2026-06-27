Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A43B47E2
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575130; cv=none; b=e5D3EYJvDleQsL6l7hfufaW66Jvlcfvw+rEEKChf2CO56otWnw9WHA/oRMNWvLCeNrJzOrQu9Q1zt64pKQ2N/TToTnj7BaioeWW0l5DL2ak9+TDTTvzk07d8m2h/Nukh+dAjGSBh7KOuARyvPiaiiNlXHx5Hnhv+Nw/XxYFRJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575130; c=relaxed/simple;
	bh=j2Up83zFCR9ox9HAYa+rEjKxTzgI9ghCVF8GBiUnFGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGw0mAJSAR7ButJRRQtFMhl/DapC7Aar6dsQgYxT6FP2ACJOsR+4SgM5JDM6BxJkUvxiSLRc43ztpebCJ3ekGLFyuaL6jUU+POYkVKqxewZDTKjLLNSJZm9hm8V/gxIUCQecIjnxzdT5ZqvR9Ya+v6J29Z+bGyagVXAsaQB3ZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=cP1sh+z6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=oqzxjIRB; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="cP1sh+z6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="oqzxjIRB"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=cP1sh+z6BCjTZYnDdlQ46yfHQ/b3KIJwajN9sUcL+qpDTckKMaShCA66WADfIxZKOPn1zpNu/hovmXLJJ5yIkQ7DcW3KKYtN7uGwtXDhscl5R0Xo6FCkydtbnS0LD7buGo3RI9TlUMeXgsWdkqWozOp+y+Z2cYjaf/Cec94hRVSh91iZTFYpjSgSAZKF88EMSVKk3V0pwBdH3qS8xoB+0WsuZhNIqPRsgePvUanv9vRghWXQmejwR1hxaHlm6lyGkzwNo+Qwrsy+aBwbbSjElki+C65CTtmxagQdMViUvM7TVM4E6jDCQVb5F/PyoapQXaQKET9VPSrtCQ89FYESaw==; s=purelymail2; d=malon.dev; v=1; bh=j2Up83zFCR9ox9HAYa+rEjKxTzgI9ghCVF8GBiUnFGU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=oqzxjIRB5T4f9oZOrug6RNQhSep+2sKMvKOkwla6he5twC+mLJGqDHM+wCv+TwqNUnygNTqur52sRhNkem24CMuk0m98fWlo5sWD1DRO4Cu2ee5N2esrqTAWdaD5R265Ge2uyfHQveRiU8FRKBb/9skIDvhiOcNtDisWaAzDjTnhURSeI6dYTsgNtDGRTm9x9hR/UNC6hP1sYnSNlqwStfaUI/IPur3rOq3kqr9uXkKbElkth8LBfNUf4flOW1xwxouYZ1mqLjZipL18koKEil+TLogaErAuibvjLsHwXRBaGRHUqvAkab+dtFol6anLv4vtrXjLbSlL6mc+wBbUCA==; s=purelymail2; d=purelymail.com; v=1; bh=j2Up83zFCR9ox9HAYa+rEjKxTzgI9ghCVF8GBiUnFGU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1352112617;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 15:45:24 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	"szeder . dev @ gmail . com--in-reply-to=" <20260626075037.532164-1-cat@malon.dev>,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 0/1] move excludes_file into repo_config_values
Date: Sat, 27 Jun 2026 23:45:13 +0800
Message-ID: <20260627154514.1073154-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This patch continues the libification effort by migrating the global
string variable 'excludes_file' into 'struct repo_config_values'. Since
this is a dynamically allocated variable, the migration requires proper
heap memory management.

This patch mainly does three things:

 - Abstract the XDG fallback lazy-loading logic out of dir.c into a proper
 getter.

 - Move the variables into the struct repo_config_values.

 - Introduce the memory destructor 'repo_config_values_clear()'.


Changes since V2:

 - Squash together the previous two commits into one.

 - The 'repo->initialized' check is used in both the getter and destructor.
 This eliminates redundant checks and follows the fail-fast principle. This
 is consistent with the previous global variable removal patches [1][2][3].

Thanks!

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

[1] https://lore.kernel.org/git/20260610093635.139719-1-cat@malon.dev/T/#m8=
56253610936d052a798259bfc06d598561e53c4
[2] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
[3] https://lore.kernel.org/git/20260617154929.564498-2-cat@malon.dev/T/#m8=
843984a6175a1a4c7e00877085c77b0c72f5803

Tian Yuchen (1):
  environment: move excludes_file into repo_config_values

 dir.c         |  4 ++--
 environment.c | 30 +++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 42 insertions(+), 6 deletions(-)

--=20
2.43.0

