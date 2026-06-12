Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0D3E7BC0
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280349; cv=none; b=JBFtt7l1V5xSkA+ldyRfuRRHFJ25tbK21f/F4BqX28QrCIYKNuCv99tI/DeoljF3pL2p2odEUmq8zyv8S1kk+xFij0u8xV2ktZsa+ix+M4lu5IovrgGcwQQWgv2LEWBbRvnC95wz3bMzlPqt7RY6gow92fVQGqCwvhGlF/ke5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280349; c=relaxed/simple;
	bh=M0NsWTinjQBr/4DtvpBUn4OPAh1eT1zwzG39BKEIGbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk+//8sQBA9es/vNJkJf9qFJA5QUc+GmTc47idjQzMmVi8X9SwfGMMiu81dWE65tkPcj4sWFXeJKeArBw+wx3+rdbh6zyyIW6izyDfOh/1WxQToG0Ny75l66xrGqHj2xMhI4wcA6seowl9OCoF6IzwJ4rwMUkpgQ/a6AmtrQJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Jnd6y+sc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WU+SJiwd; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Jnd6y+sc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WU+SJiwd"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Jnd6y+scQvF6/XsVS51bMfgaXk5Y2FWrVTbmJjCppX/28d45H3wXTDxxj4itCup5B59UddYLWYi2TmJpvXg3avZzxJqyJ19i179sYhjG0p7TXEtmHvEf/bsFVEwaSInWGESTBSuymccJPhHI3e71FJvGfVe3+IHKL5UVAdcwIVgt9Gc5S4hqIaEdk6tAZ6L6CQzJTp30vD43raGR9KtZ/FfghYJm91q5isKApfxOwJtNGbd4JuPR29OVQTvcliy+MBaNkDVKCXA4EuOievfvNxMgpKPo7UdPm8jlYtTddWjm8EoAInvrKwENlgnuEZZrjwPV1nnYB8ilr6u3qHiaMQ==; s=purelymail3; d=malon.dev; v=1; bh=M0NsWTinjQBr/4DtvpBUn4OPAh1eT1zwzG39BKEIGbA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WU+SJiwdu9FicJ7fhmK80SegHdW8STS/JVzBRqrAjEVegjrmk7QeoQRjrpwwMKbTPf87i7karfTuKzWtmrLuK9tZi4LPLdu1iHOc3KwyoJw8W6xb+iIoxNtm5RfzUD6ZORSXa+UGNQ2D8DjTR/UB+wHWzYUrcIiKMyqfrDFjslDKHh8wPTw/ad4fapdXQyx/+1UD//b/uXN1diW9AuYHiJHkl52aQiRpkFLjx8zzO5VCEELAHLACtFIiXJpiSno1ZB3VvVrkhsunb4ZldmjF5cu32Pm9i9pjKqVFPolxbp94H+Fm9+F6HgjCjHS4wyuoX42raa4HDSdKGd5DozcfPw==; s=purelymail3; d=purelymail.com; v=1; bh=M0NsWTinjQBr/4DtvpBUn4OPAh1eT1zwzG39BKEIGbA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -702755865;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Jun 2026 16:05:34 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 0/3] environment: migrate 'trust_executable_bit' into 'repo_config_values'
Date: Sat, 13 Jun 2026 00:05:23 +0800
Message-ID: <20260612160527.167203-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610093635.139719-1-cat@malon.dev>
References: <20260610093635.139719-1-cat@malon.dev>
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

Changes since V2:

Fixed a whole bunch of typos;

Moved the comment for 'ce_mode_from_stat()' from 'read-cache.c' to
'read-cache.h'.

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
 read-cache.c  | 21 ++++++++++++++++-----
 read-cache.h  | 23 +++++++++--------------
 5 files changed, 43 insertions(+), 23 deletions(-)

--=20
2.43.0

