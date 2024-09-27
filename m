Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A9157490
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427929; cv=none; b=jRTbs/9KOOtPB/BEJB5paXSCEUbBFyJG+ClNRh+PmqM4x1gfp+YPOoZBvAOWsy7iUI85VdYDXR7PrsX+b0g1gctbZdp3CSftfrDjEbtxTJ5vyWZeQDP+q/Ba/MP82h2eigUaVx8ZFEBOduilY2oo/ijrSmfagIZAntwxma674Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427929; c=relaxed/simple;
	bh=sgHSMesc+yAGiehK1wOZNl75LAAyFWXa4QpCJD/EXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvdObzSSeavOv7xeYxk22MTz5+oi4D0YOMQ48eWD+SanKAbdFPyzWd/qWp7eOQ1eRerDtM5oyPhTUzZTQs6O20i2o3HRFOhgeN0fS3NwRUwO4v/sc8yvzgxXryDDedBgRvITYZeNnGllrvgyqXiczOqjfKcmQtnF3Z+C+96Sy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=u/UKIMcw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="u/UKIMcw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1727427924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgHSMesc+yAGiehK1wOZNl75LAAyFWXa4QpCJD/EXKQ=;
	b=u/UKIMcwwi6x0aXDQEWFs5ryPUM2bK2WZIs0yujGX1YhobMM70qzgSuJLBNxBSpTA88sXz
	Y05Ty39A47SSHCKgq8k8yNHVzEIJP+yHQcHkGfJ55iZKWG4gIkFRnT1wlnSXX3Bbcnij6X
	CkBMApx5YaxUSeYxjIye/IQ1OB76D+Y=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH] builtin/clone: teach git-clone(1) the --ref= argument
Date: Fri, 27 Sep 2024 11:04:54 +0200
Message-ID: <20240927090455.1014896-1-toon@iotcl.com>
In-Reply-To: <20240722080705.2614195-1-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

My apologies, instantly after sending my v1 I noticed some lines in the test
weren't indented with tabs. So I'm sending v2 straight away. Sorry for the
noise.

--
Toon
