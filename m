Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310E3ECBF8
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813673; cv=none; b=FbuNAYo1ivB3djU1IUalW9j+uJ7dHrh4udwgZtEREqkB7u73lezvvkJlR3wjwnrs02JqAWps1s55kofg4Z4sJmw/W0nNJdYd9Zp61XSCJXVfuSH/OhUOTVwaPCF12tLbTikCD0vpbccEfLxBUlhQrDe4eoW+a65c+QiPyF9Xg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813673; c=relaxed/simple;
	bh=uErrcF4oN8vZtQoPtBfmu8K16q7ex/caRXwx3x7Uu8s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CFSxNNtH7p5Gfswajjz1VEbveAzGN66HfvJC4AEoPF5eBhe3N4ynWwwE9/9QiWU80DDAUuLPRnmKd9OaaunNd8wwfeHy+nnktyX7OUxp8dPKK29lfKM7pymOdt8LKYFC+lObwzq6fgf0/5UyDE1aDW23vMcJ7dZMFlQYvGbCZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=eBDAPRR7; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="eBDAPRR7"
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 7B67963C5
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 17:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772813140;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uErrcF4oN8vZtQoPtBfmu8K16q7ex/caRXwx3x7Uu8s=;
	b=eBDAPRR7l3Cp+hRuH1bVRTyuxxXGE5RkSg1DoZAEwrVFxgCZ9IEawpHs6rhFiIz2
	IY8h44EYjLNBm3/LdmexxaV+svUKTz88fdLzTbhC0lVcSgbwDnzy11mg87GacuHpIz5
	lQyCtPVbYtgu1aNmudmqP8ZUxDMv1iM6Y+oOE954=
Received: by smtp.mailfence.com with ESMTPSA
          for <git@vger.kernel.org> ; Fri, 6 Mar 2026 17:05:37 +0100 (CET)
Date: Fri, 6 Mar 2026 17:05:33 +0100
From: Clara Engler <cve@cve.cx>
To: git@vger.kernel.org
Subject: git-http-fetch vs. gitremote-helpers
Message-ID: <aar7TReHwAtxmD25@88f9ee5bc6521746>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ContactOffice-Account: com:620022785

Hello,
I am currently studying a bit of the git internals and I am having a
harder time to understand the difference of git-http-fetch vs.
git-remote-http(s).

To me, they both seem to be tools that directly or indirectly utilize
libcurl to communicate with an HTTP(S) server, yet there must be an
incentive on why there are two distinct binaries for that.

Thank You
Clara
