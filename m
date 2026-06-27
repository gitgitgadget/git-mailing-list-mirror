Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447803290D8
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782576509; cv=none; b=FAgCdvDWTc3hI7Z3tadwen0cVR+Wu87ImRsuyCqzE6rzPPwMPJFg2PUwaA0opT7Uaq2TOoOCegwKzmfYkCy2sA0U47GHoAVC1W2XLFWF8b42fsEoEbx9OyWMA0fstpx8HESlVHt5gxdA/tAyAqCw79NgaqRdVpHaXm0MwKWcOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782576509; c=relaxed/simple;
	bh=GtbCLE9Wo8yNggOtTyx0jgvVPlY919+275rJTtd7Teo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvv4C2xIjG099nMKgIFlHEhVeQ/pWUUuxFfGngOX2wIgrGZc3fmpTdruQl3sYu4MEnEEJ32qpfu5v+S4Mt4CzHDp4t/p21xrUqYsa3YWem3y/uRU6ltFldNyjlQxeK/BcUM//L8xf40tnfNomgHl+1vV0zAXsEiTxr+lrD09/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=dWePPjw/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=n/CUWqtD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="dWePPjw/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="n/CUWqtD"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=dWePPjw/Le9WD3kf7YjhEaaP8yRzhrXcQ44gFfr2j+AccAJJ/sydXSyIaf8Q3/chC6hU5A/9Z6lw7Zs8eraFCH7FgFE97dp13Bu84WWEx9q5hibhYrWebtL8CT+IvL+qFAk6eTLDnH0B3nNOedrkJq/sWRwzM0q4FPExaMhnS6YQuMYfRgszG4u3vRu3jjH3yxKMQEJTnlt3dHRT9oVhYtBTdRLe9ycrHP7FgSAXvgSJFqDirxGsRrt1Vvf5KGAg2hsvkyPnsi+jx6UP7gtWNSkXdfACMpNFSWGnzRMSddWy+SrG+kgDQXw6z3jSsmJOF7xDIgI8vNHHxgugMNfFtA==; s=purelymail2; d=malon.dev; v=1; bh=GtbCLE9Wo8yNggOtTyx0jgvVPlY919+275rJTtd7Teo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=n/CUWqtD86Cc5KFa2n4s6bk9Ed7O/+gzu0Xc6aeK1Bzw1c7qdg8wuJlRporaC7ytSypnzO3VwWF9iHcFjBFyUrUXXY4v3MdGk3fLS47hC6vHtxXHNfW8ePcL+Ym6PAwQTtH3OSOWRokCfyxZ82LHbCjIYh1iUZ34FNN68rTfBKA5QCsLcsxKeR/Yswvw/VMZfQR2TgNCRsmNqk0Sn+kcGyowACo6/MqPPx3yLWzpzXjGD7wmDfGKbv/pCnINlwnErlTfoGZ2ZHtdtqCn9AJwleP/SX4/JGPPbPwp0YHPZapC1x9c6mh1/tQ37hfbgTFD0d7xdehRfLD43Y7M3qg/ig==; s=purelymail2; d=purelymail.com; v=1; bh=GtbCLE9Wo8yNggOtTyx0jgvVPlY919+275rJTtd7Teo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1517021192;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 16:08:22 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 0/1] environment: move excludes_file into repo_config_values
Date: Sun, 28 Jun 2026 00:08:12 +0800
Message-ID: <20260627160813.1074201-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626075037.532164-1-cat@malon.dev>
References: <20260626075037.532164-1-cat@malon.dev>
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

Note: Resending as v3 purely to fix a malformed In-Reply-To header in v2
that broke the email thread. No actual code changes since v2...

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

