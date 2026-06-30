Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D331E82A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807685; cv=none; b=hl1pURQp1IHjNgy7FHzNQBfPAfdDylObpCb0dtQjDskIAxulhssppg93T2A00dVlkMEMdXwbZE1BKy9eqcjvQzE+awRZNusje/7waLCEOqO+lwAN/4YzeSZcBKx/9JLQaJsThJF5l+3LTE/CeEdjO8tNXRCvyCfV8tqOCz3Y85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807685; c=relaxed/simple;
	bh=a8uid2egjg2VVe/gkgXhZJjUf7bFt/IiAojXlIUXeRM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPMrD8t7aVAjkU3laaY4nyZw2tiwdLDbwEm+MVhNxQAyYs+8ooPwOVp37RwmRUqP01FLE4HNVi+nikVjWlK7i1A4gO3GyQG+r/5/LzuUFf+GVc13EzJN5ZHPicg0hwjXaZiaYihX7vv0oh8iuGgCSTfQ3qLn2VuKtpETO1I/JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qY8ZK7hm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qY8ZK7hm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782807681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EH/7E6GWl5vOukuFHPjVqhqsfhugRAfUUYkIc5nmP/k=;
	b=qY8ZK7hm3ZtJUlKz7R6pm4qOn+gJyI9uzSs16FtFIYjmPQZXBFhd77KluqfXgaG39b1vs5
	0w+RA4ygeUvPZg9Jn29pbK+zTk+LKsBNtkVbrODy64MIunDXecaDU3wE6TB2trS6T8i92R
	QWESW0d6AUYSsGlVev002BlvfH1HN1E=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #10)
In-Reply-To: <xmqq5x36dtyf.fsf@gitster.g>
References: <xmqq5x36dtyf.fsf@gitster.g>
Date: Tue, 30 Jun 2026 10:20:56 +0200
Message-ID: <87cxx84exj.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * ps/odb-generalize-prepare (2026-06-22) 3 commits
>  - odb: introduce `odb_prepare()`
>  - odb/source: generalize `reprepare()` callback
>  - Merge branch 'ps/odb-source-packed' into ps/odb-generalize-prepare
>  (this branch uses ps/odb-source-packed.)
>
>  The `reprepare()` callback for object database sources has been
>  generalized into a `prepare()` callback with an optional flush cache
>  flag, and a new `odb_prepare()` wrapper has been introduced to
>  allow pre-opening object database sources.
>
>  Needs review.
>  source: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>

I did have some questions/remarks, but Patrick answered them, and with
those answers I'm happy about this series.

-- 
Cheers,
Toon
