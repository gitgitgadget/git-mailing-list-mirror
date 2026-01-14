Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB832FD66B
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417136; cv=pass; b=eoXL33+m/3FaeRWqg71Y2OutvC1o1bMvzglQTbB7OhEICTf7X2sY02UY9ws5TbXfwzEOU0goTJVdRkp03wBoM8hvZcrik1Cz86T9SnwLvz2uDKbRTScmdg0Jl9yBrChqFVQGf+gWsMh/UplVaiSeRKpj58SexhKjPR+RfP82Lrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417136; c=relaxed/simple;
	bh=EvDGY5bnXYP4Vs8bPf20kB+baib6VYx9jB4EaPZtmEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlu9xGOg0xSm/xS9KNpMa7KehUw/2T1xd/LNj505pzisjDnHbKki7069FRCb21u41wnNKd2yjIxVQjckdvuZ2quPMHMhRNGNR8RnxzA7xiHQfUJMUm+zH3/VykxqQX0VxSWr/++xdPWOC0hC5489F58Sb5iZBrDtOFQVbJFWFGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gkny9BXU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gkny9BXU"
ARC-Seal: i=1; a=rsa-sha256; t=1768417120; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EpUXph3ONEjjZzkH6DUXathQfJyuoJNhl537gPPgFhdLZEiTYjisEokQxZPlHTSe+yoSQdapn3krfRWjKBIzxkYSRMA8UAeXO2wPzg1jRuDe3Zy0HFuKzkK+W41kihnbIBpbfPksb+KTvVlJ/J5DDJxauHAU32S8BNB7v/eaKw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768417120; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eDfWkuItJEtVN3KhR2xRzOMz1vXUNfUgk4ibz6MDTQ4=; 
	b=IRb+oHxKydJ7UEXVAHiJOlGJQ5+Q9DVwWJZjjv1JXbyl8ZvW3pkeFOeoqVzWz5HVoJzlgIyXQl3zUObsIwf5MiIWSqmIEafL9c6P8wsnOcyjRm0bpxfQSrb0NgEFiKeNmo51UMUSU7lyqyoBRffFrIRQPzJe5RmX0wCQr/C0S1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768417120;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eDfWkuItJEtVN3KhR2xRzOMz1vXUNfUgk4ibz6MDTQ4=;
	b=gkny9BXUtQnWDpkZuGKhqt1/Rekew4fth3TWn/mPR7Bc62bi/CCR1M+99yzFjzT1
	HA1sRjPgMyCsySi+PeTgn5iKbiYBUmP7Vu9Ogfe4Wi8raVe0DUbXQK0S8mRI6c+Ycis
	i53v7fEMxpyvWtS8odl7hGPIBZVhug9WvA9upmm4=
Received: by mx.zohomail.com with SMTPS id 1768417118912977.2041384528997;
	Wed, 14 Jan 2026 10:58:38 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jeff King <peff@peff.net>,
	Chris Darroch <chrisd@apache.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 0/2] Fix two hook conversion regressions
Date: Wed, 14 Jan 2026 20:57:29 +0200
Message-ID: <20260114185731.2381550-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260113115633.230479-1-adrian.ratiu@collabora.com>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series fixes 2 regressions reported by Chris and Kristoffer,
introduced by the 'ar/run-command-hook' merge into master.

Based on a discussion with Peff on v2, I do plan to revisit and
rework the server-side hook I/O polling & batching logic, however
that will be a separate patch unrelated to these two regressions.

Many thanks to everyone who helped debug & fix these!

This series is based on the master branch.

Pushed to GitHub: https://github.com/10ne1/git/tree/dev/aratiu/make-hook-stdout_to_stderr-optional-v3
Successful CI run: https://github.com/10ne1/git/actions/runs/21004980299

Changes in v3:
* New commit to make hook opts.ungroup = 1 default (Peff)
* Dropped the ungroup fix from the first commit because it's now
  handled by the more comprehensive second commit (Peff, Adrian)
* Added fixes tags to commits (Adrian)

Range-diff between v2 -> v3:
1:  898a21ddd0 ! 1:  77db7035c5 hook: allow hooks to disable stdout_to_stderr
    @@ Commit message
         and will continue to work after we eventually introduce parallel
         hook execution and config-based hooks.
     
    +    Fixes: 3e2836a742d8 ("transport: convert pre-push to hook API")
         Reported-by: Chris Darroch <chrisd@apache.org>
         Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
    @@ transport.c: static int run_pre_push_hook(struct transport *transport,
     +	/*
     +	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
     +	 * them to keep backwards compatibility with existing hooks.
    -+	 * run_process_parallel(), called via run_hooks_opt() below, will buffer
    -+	 * and merge the streams when output is grouped, so also set ungroup = 1.
     +	 */
     +	opt.stdout_to_stderr = 0;
    -+	opt.ungroup = 1;
     +
      	ret = run_hooks_opt(the_repository, "pre-push", &opt);
      
-:  ---------- > 2:  de3001f063 hook: make ungroup opt-out instead of opt-in

Adrian Ratiu (2):
  hook: allow hooks to disable stdout_to_stderr
  hook: make ungroup opt-out instead of opt-in

 builtin/hook.c         |   6 --
 builtin/receive-pack.c |  12 ++-
 commit.c               |   3 -
 hook.c                 |   5 +-
 hook.h                 |   7 ++
 t/t1800-hook.sh        | 176 +++++++++++++++++++++++++++++++++++++++++
 transport.c            |   6 ++
 7 files changed, 199 insertions(+), 16 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

