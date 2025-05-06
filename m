Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D0283125
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536247; cv=pass; b=fu2jLHx/6wt/qLSUUwmZXcullmqsVR6fJcLwNcx0dXzgaLbz+cyNtLucbGoDq2z3+1f2/VxPi1imWXj/857tLl5rghB2nS1lLjEzMwqqLNFt/GGlptSAnria68zTk9C9eR+w05Az8zZgAzOK+zYYPFKSO3rRGb7BINGQ/UX5oTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536247; c=relaxed/simple;
	bh=7apM2pNRk1xvb1ZjBQvM1VuKy3STrdXKkbwKo98aZMA=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=PyGvENuSd7Rzc3C95b1HoeGcbAmnEYxqfbytN1kox52EU94DrG7xn8e83KC/PBqqV8fIC5WeAToZjdqGiGcmUI5iI16tHDk+PE2Rgrb5weoH3T+iMNai3WygKB851lH286vEuULz7khkS2k+LAloc3e1qcLEDzWTBgzLunnVnow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=HEvGyp+i; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="HEvGyp+i"
ARC-Seal: i=1; a=rsa-sha256; t=1746536242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mgVaRySI0pO2xZRgwhMk648gYLLWMLXtLbNVVi1qyd7WHh0CrE8sOBYbhuG59HFAWDkOTykkdzcTvQ8PN8pviz69jkLjBv3JXabf5M+Y1DtvoRDHTQqQ2Pi0d3CxFnwUpyyuT8sQTQbhrQspWpcp/azLFr6nsmNZXkrdwZrnNBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746536242; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=jm9q5HG79/mIrzoWWrsVLfYj0DoO4999EzAU/OjB2as=; 
	b=iheeFmlrn0I7EPx9cRT1l+FNVOdpwdXvjjknvEZfihE5P4RvdPo0UrN60sxZiR6njn/xng7gHTRtEKiuWiJksT3MT2vkbS5Rxhh94b6pj1bH1yy8MQKZZw7rN4bd+htrbviWJjtp4mzCz0pPZ2AEZmVJgi8rjZd8wVtRkeG8N4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746536242;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=jm9q5HG79/mIrzoWWrsVLfYj0DoO4999EzAU/OjB2as=;
	b=HEvGyp+iltL09i/67TRGfRDUCDCU5XLh8wG5pKfYEDrerFr6z8ah9x4kqzNnPfhp
	/TReiFbqQT4AcA5Ry9kCPinxYcTp2b75KWLNQ3FggQqUyY/n5/TeI9IPF+Z6MDX2cM0
	w9KGz7jJD1E5aKXSWuiqksdnMlt1yd44PkZg9Dj0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746536240099834.5555623665003; Tue, 6 May 2025 05:57:20 -0700 (PDT)
Date: Tue, 06 May 2025 20:57:20 +0800
From: Li Chen <me@linux.beauty>
To: "git" <git@vger.kernel.org>
Message-ID: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
In-Reply-To: 
Subject: [RFC PATCH 0/2] rebase: support --trailer and add --reviewby
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From: Li Chen <chenl311@chinatelecom.cn>

This patch series enhances `git rebase` and `git am` by introducing three f=
eatures:

 1. `--trailer <line>` support on rebase's merge backend
    Allows arbitrary trailer lines (e.g. multiple =E2=80=9CReviewed-by: =E2=
=80=A6=E2=80=9D) to be appended
    to each rebased commit.  The apply backend (`git am`) is explicitly
    rejected when used with `--trailer`, since it has no message=E2=80=91fi=
lter/trailer support.

    This is especially useful when reviewee add reviewer's Reviewed-by, e.g=
.,
    git rebase \
    --trailer "Reviewed-by: Bob <bob@example.com>" \
    --trailer "Tested-by: Dana <dana@example.com>" \
    base~1


 2. `--reviewby` shortcut flag for rebase
    A convenience alias for adding a single =E2=80=9CReviewed=E2=80=91by:=
=E2=80=9D trailer using your configured
    committer identity (user.name/user.email), analogous to --signoff. It w=
orks on both
    rebase backends (merge and apply) and automatically disables fast=E2=80=
=91forwarding to
    rewrite commits.

    This is especially useful when reviewer adds his/her Reviewed-by for a =
given patchset
    which is already applied, e.g., git rebase --reviewby base~1

3. BTW, `--reviewby` shortcut flag is also added for `am` cmd, because it's=
 needed
   by rebase's apply backend.

I=E2=80=99ve run make test locally without failures. There are Github CI er=
rors around leak checks that I=E2=80=99m still tracking down (see https://g=
ithub.com/FirstLoveLife/git/actions/runs/14859027869).

Looking forward to your feedback!

Li Chen (2):
  rebase, am: add --reviewby option
  rebase: support --trailer

 Documentation/git-am.adoc  |   6 +-
 builtin/am.c               |  31 +++++++++
 builtin/rebase.c           |  84 ++++++++++++++++++++++
 builtin/revert.c           |   4 +-
 sequencer.c                | 100 ++++++++++++++++++++++++++-
 sequencer.h                |  12 ++++
 t/meson.build              |   2 +
 t/t3439-rebase-reviewby.sh | 138 +++++++++++++++++++++++++++++++++++++
 t/t3440-rebase-trailer.sh  | 108 +++++++++++++++++++++++++++++
 t/t4150-am.sh              |  75 ++++++++++++++++++++
 10 files changed, 556 insertions(+), 4 deletions(-)
 create mode 100755 t/t3439-rebase-reviewby.sh
 create mode 100755 t/t3440-rebase-trailer.sh

--
2.49.0

