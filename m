Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C3C585C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837859; cv=none; b=TIlWW47CnED3AgZqoN5KaDojLJipoDadMXe+EnpZjwvm0JbPpzyMzmAG+3KGbdHmNjyz+f7fDn5ByNhSugWGfR72UoHdEfse7+pZFeNNXTcb5CindMg+F69v+uW6oXOOo6h1sEgXuf9WeLnsbJ43OebJk5yDX8At54KZyPEYc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837859; c=relaxed/simple;
	bh=UAZhUzP9T50sF1krSbsYYtvX5L9DcPo7GH6RvUgV9Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp0e019/+E6WmHroCZtS03TbdX+W0GFL8gVqCz5M1430igYMlpg3/JKGoi7bQI9EhwSdOcnWAXKqiwhrNIlVLHpMVlgn8smiDUESU89gwMEDbrp9OX8Z8lNDcQfble9eE1q/sx5+LEAxT3RQ0XHTiQujMezH2Wtz1q1KSe8Ui/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=1n9X3Kih; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Cqk16jGy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="1n9X3Kih";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Cqk16jGy"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=1n9X3KihZPu/xOned3V3P3HgqLn/LU9BrSc5PzKf+GXsGx7DIXnU26THSzXIIwaXWPbinxUICeEOy+rvNz6Ng3lpMKAnOoZJro9IJIwfYbijP2tNId5ugYPGQHssQLzH6STaf6fHIBydeoKgmk8kyWH6mhPeU667exfiWykFE1eMujrujv+jSplbT89yTidHLUEknM0P5Qo7ZmYZUHSAXQpVN/gXc/Wan1dUtlnk2WSxgwqVRuK3vyC0eBucboeyg1DwpU4E37qEcmi7dEgtWNo0pKTsPEgn64DPtqtBQtcuHgst+4qdvi4iHkWgdAH9+1EhanNipmUdE5cB8GYOyQ==; s=purelymail2; d=malon.dev; v=1; bh=UAZhUzP9T50sF1krSbsYYtvX5L9DcPo7GH6RvUgV9Cc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Cqk16jGyzQaRxibsPhH8dnJGQvop4m7nBBZS+Has4DV+BwZ7Zp3Cg1RUeS80oHnihgmSkiYm/KDINGbQSsiEudSYp2q2XBq6bOZ1l2K1S57+OwvLBPCFUHiAbVCT7MU5/12s7tm5rlOBcUgMROCAZ1sApiu9Q1snUexRtwnVM3MdgEpJDuXBwA7DUhQ3BInN9VatLWjUOgBf/RHHQqE1TKvjGn+EBpjhnfIxaTgM83WjJUt0bn+Tw2dX1TVUIMleb+Efy6ZVdf1Iw2wFaK4xc0wIHhFozxUR9NdyD9ysdvxcgQMzQq1QNrcUCPHNv664NigpRM8mKBFopqYVu1rv4Q==; s=purelymail2; d=purelymail.com; v=1; bh=UAZhUzP9T50sF1krSbsYYtvX5L9DcPo7GH6RvUgV9Cc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1862105654;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 30 Jun 2026 16:44:13 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 0/1] environment: move excludes_file into repo_config_values
Date: Wed,  1 Jul 2026 00:44:00 +0800
Message-ID: <20260630164401.2906091-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260627160813.1074201-1-cat@malon.dev>
References: <20260627160813.1074201-1-cat@malon.dev>
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

Changes since V4:

Defensive checks are retained in both the getter (returning NULL if
uninitialized) and the destructor (bypassing non-the_repository instances)
to maintain bug-to-bug compatibility. These are marked with 'NEEDSWORK'
comments.

Future work will track down and fix the offending callers to eventually
replace these shields with stricter BUG() assertions. [1]

THANKS!

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

[1] https://lore.kernel.org/git/054b3fb6-0e69-473d-9778-b1b11ea82b3a@malon.=
dev/T/#mca0730b6735298316ec00a53d4719935d18837a6

Tian Yuchen (1):
  environment: move excludes_file into repo_config_values

 dir.c         |  4 ++--
 environment.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 55 insertions(+), 6 deletions(-)

--=20
2.43.0

