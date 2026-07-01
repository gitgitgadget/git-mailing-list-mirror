Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368C38E8B7
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929310; cv=none; b=grq3xTlDVLDWYJN3xMa3HzcbqKby1kcyVScOw8CeHD4I33d3hc0YBSDeji/saGqJurAM7siY1WUIfiGcsB2Th2GV0a8q6I4VtBcQyRh/dQK8Az8PKiHHxOCL3BLnH1WWC9/HU0EzNEGRnJmcytISOjzUSEwbvQAlyFTzk4io8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929310; c=relaxed/simple;
	bh=IqU85tsUT8iMKImZGEWRuG4bE+tG2vPzz5rBU26M+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYrlTAFy6scDWmW4D9Ravlb6tl4Q/B4SoGENVBfWYSj6bPo1kUy2WjJ5BkdO5ItnN6ZkUfmWhY4AmwIUkZAHy7BUfL85vAMrxb7IrM7OY5NJbqNT6PcAoX/a8D2SwA1rGzkQWB2h8r4Z0jrhBeuTZVReoqSUPueDk+kRHq3GqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=eLjYu9Sx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GnXVzCQW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="eLjYu9Sx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GnXVzCQW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eLjYu9Sxy4fXCJrzt8tBy0D1FAq2R6qe8MVIazOpwWW980yD/zdXFQYIueaRXAil8aA+HY/0H2b+KxQdL8PsHZaavtbJOwYaUanlzLGvNLbh2GIi16X19kbf0o5enc86z82nkf1afVLDpn8uV9XDHhd9yM8Jnne08xdMa40J3AAcjzGswbdvXrrIDs4OSiIDeHLu1x+tg5JxmFnjyz6YHhbxH5kRz2YnATxosUQycbAqJKtkvSWDGrvW+MYpbo0GKsZIEjHTZVnmxKqkOSY0wZ+B9fo1wJQcVeNV0LIIvUZDekAp3yvkT26kDTVY4i3tzlDcrUmZAq6c6mZ4YDb+VQ==; s=purelymail3; d=malon.dev; v=1; bh=IqU85tsUT8iMKImZGEWRuG4bE+tG2vPzz5rBU26M+EQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=GnXVzCQWGxaR6mm86A3MlsHG//3xXv0mcpdMqqSWEIJBdRXBk2AWxTm9Hy57oGWYweSN793G5fnCbvV+f5pBpZiWTEbR8OT4ss0BDKojBSJjgN7oy3HZpurLf2R1keWi0lP6neBw32jLbMOjkPF5YoL2eivdHJ6tQEVcz+iTjjBLryj9AEcA5HQ9rsz5uOA/2Q7ZMD9Sb11nxPRHaeFco6fc7kZ8+prgc0GV/ScfF7EvNWFCCJXhySF/5mdxasu+XGydMFNqjgpoF4GlGSHLjONt8Q2e2ZgPdASx1wqTd4GfAM7GusMh0IUVdMA0jeHJMyUb3RfLbn/YkzP8Jpx+sw==; s=purelymail3; d=purelymail.com; v=1; bh=IqU85tsUT8iMKImZGEWRuG4bE+tG2vPzz5rBU26M+EQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 308788970;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 01 Jul 2026 18:08:19 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6 0/1] environment: move excludes_file into repo_config_values
Date: Thu,  2 Jul 2026 02:08:11 +0800
Message-ID: <20260701180813.776173-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630164401.2906091-1-cat@malon.dev>
References: <20260630164401.2906091-1-cat@malon.dev>
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

Changes since V5:

Drop the defensive check in 'repo_excludes_file()'.

All known test errors that occur *without* defensive checks are intercepted
by the 'repo !=3D the_repository' check when checks *are there*, rather tha=
n
by the '!repo->initialized' check. In other words, the getter actually does=
n't
need any checks added, because all of its calls are safe. We just need to
keep the check and the 'NEEDSWORK' comment *on the destructor* until
'repo_config_values()' eventually supports submodules, at which point we ca=
n
remove them.

THANKS!

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (1):
  environment: move excludes_file into repo_config_values

 dir.c         |  4 ++--
 environment.c | 33 ++++++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 45 insertions(+), 6 deletions(-)

--=20
2.43.0

