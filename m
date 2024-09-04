Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [217.11.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804341EC00A
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441339; cv=none; b=VMxYVjJOKf5KiuuNn8cKfCUuPcgCzWOSQkVci19ZUl2PQTGmhjbWVV/gEEp/UmpQixGjheZV9666xsSFlhUfMsKncfcn95UlmhOGlHX/dzPHAEDbdyfZh7gx5yp07puBx0YFqcOC559DNidOZmeUfcgJH/b+MuvaUxMzPQ8c3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441339; c=relaxed/simple;
	bh=u4wz5hsFjpPktfuYmzpLm9/FW0w2fkXVef/yC+hvaQE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hgiF3xjBIotdHvIlos6k6I4rn7Akbz3S2BAPZG+Q9dg0GvNvPkkM8XJJQIqcnjoYuiwXoM9pQt74USSrRAQdaAq/4kzI8uCLVraCwfBqd1FZ1YMATW4CAO3xA5yhZbVrhNYzJbn2i20Nm5WjT6fr8tDf0xU/Xe85ATlQEWP/mEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de; spf=pass smtp.mailfrom=rkta.de; arc=none smtp.client-ip=217.11.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rkta.de
Date: Wed, 4 Sep 2024 11:06:14 +0200
From: Rene Kita <mail@rkta.de>
To: git@vger.kernel.org
Subject: git log alias with --all and --exclude
Message-ID: <20240904090614.GZ15670@t480>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have an alias
'gr = log --oneline --abbrev-commit --all --graph --decorate --color'
and I would like to be able to sometimes exclude a branch, so call it
with:
$ git gr --exclude=pattern

This does not work, though. Also does not work without the alias and
typing the complete command by hand. Apparently the --exclude must be
put before the --all to take effect.

May I ask to change that behavior and allow to put the --exclude at the
end of the alias?

Rene
