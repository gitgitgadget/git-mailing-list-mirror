Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A614252BB
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008383; cv=none; b=qxuRFcNetE+m6yS1HpmhIfs5k38zuZ+LGxyO6boPmzllwBk1LbWppDnw3M47VRAmKItyAC9UvbvAI44wixHZ1e1rbKqQcPwma6U/Qcq+RDJZ1EK28gBh3rMToGyL9ygPnsEt5la1q5G2YKbcjCkS+QxFLvswqbXNNVgJTtsvVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008383; c=relaxed/simple;
	bh=ClsR060oZh9k6Q1IlHGcUb1/tNNZFw7zSH4UsxgMLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBa+x+VaDu/kS87oteTwvR1LNDO1ee+Z/mxh0CL5TVFUaqAdImdJh9mFj17sULFxbwS8O0+Yh5j6FXxOxQmnoGHeDeO+FqSnUHRA9/OlinjPhXd9I44qXajAsQJZLnVH7ouAO6e27DNpT6KUlwYf2TLsmMWSbJjSLWxVEwT4xPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=CeZ8fqoq; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kwyoWAH/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="CeZ8fqoq";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kwyoWAH/"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CeZ8fqoqh5+lTOQ5KY0fj8Z1UPFHH3IpIMOGOwIIAtQx20ZuHvz+B+wFAN1wMU8gWZ9/KTumg3Yb97Xg8kytNkuWOdFSNUh7fMEjvfoUzDQVwnWuOira4tdFB554RwCtP9luMKEAYDlpCnCRp3/JeLWA6xAvRaTOj78vPBW8kBRwY2ptaYGyGdD5SPE9Mdgrs+eR1gSF9QsQgiFUEXcd9K+5uRBVTMPNMlt2OPrmW0fAdZfy6hGkJrO11iAmoWfAI5mSUtws0JJySGNB4v8oeNdHiwiTLYw/QrPLS4WA4y7V97RXgp5vsEiqrTd6RPCICc0UnUXEZ6WprFerF8uWvg==; s=purelymail2; d=malon.dev; v=1; bh=ClsR060oZh9k6Q1IlHGcUb1/tNNZFw7zSH4UsxgMLdw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kwyoWAH/Y4usChwLiZPbR5q/Vmqf/eMp/keKZoTbWarEMEE0XbSPDqzTZnq7CU/YpMtQrLof6jn1uOkrDISLRbOFQksBMNPOevCmP0Rdq24WrzI75eCD1K91LfHV/KveidbA1aqkyWaXjA9vlCZCF7P2Z4/DcDWm25I/tZPvStoB+7a1r3E+4RDXSKGjUuKcMl4RBlNEdzDMbL+TcV7A2yFsd7SH9qzyL+FPL/B9Kwv8Bj5XPZxIpW8lR1cNnfI6h905CQKXohvM0vTIhVcYjIkGYQUfHcdEolnaDddtI0y7FP2V88fs5ZyrvC6XL9gVHR5MuHue8zSKZujlNOnEog==; s=purelymail2; d=purelymail.com; v=1; bh=ClsR060oZh9k6Q1IlHGcUb1/tNNZFw7zSH4UsxgMLdw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1822299684;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 09:26:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2 0/3] environment: clean up repository config handling
Date: Thu,  6 Aug 2026 17:25:54 +0800
Message-ID: <20260806092557.3951208-1-cat@malon.dev>
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

Changes since v1:

 - in commit 2/3, drop several blank lines to group the getters under the
 comment. Note that the comment does not apply to repo_excludes_file.

 - in commit 3/3, do not change the order of the members. Instead, drop
 the original comments that do not accurately categorize them.

Tian Yuchen (3):
  environment: simplify repository config getters
  environment: clarify repository config getter documentation
  environment: remove inaccurate repo_config_values comments

 environment.c | 18 +++++++++---------
 environment.h | 19 +++----------------
 2 files changed, 12 insertions(+), 25 deletions(-)

--=20
2.43.0

