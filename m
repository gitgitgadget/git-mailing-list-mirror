Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD83FD969
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869394; cv=none; b=CpylY8azq2omvwhvetH6hMgBV9tJM7We+0DS0jvXRD37lhyGLyqbOs0ztYvtfLH0vsBeFc3ugr6OIFFmZxROq3IdfFElG6p7WNLCYZu+pvtC+sY9vIGbSHQfTH7nEpe3qt+3PY0yGt2HeUmwdVhA8dtX5lDHrzUta4+mS9/xb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869394; c=relaxed/simple;
	bh=gcz57xMfYrQ5g6IlNYs45hm3Kim7D+V0XLy788c/RxM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QnoW0mexHrZ+NiEFu2l8gfSUA/L+5eQD4U+tMsHMyziiYP2vCqPcuX8n8yKxX+qQpSshSr/KZ93IkezXew5rN207pifa26BV5fsrsCUYzviwNdc1rekqKrDoThtKcguldzFLDOFv91cvC/57kvz4GRiE0nfoc7O8cTvoal/TFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 674IiSed2016933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 4 Aug 2026 18:44:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Question on textconv
Date: Tue, 4 Aug 2026 14:44:22 -0400
Organization: Nexbridge Inc.
Message-ID: <017e01dd2441$476839f0$d638add0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Ad0kQJ3HVBZWmwk0Q/eOW9C8uSxoeg==
X-Antivirus: Norton (VPS 260804-10, 8/4/2026), Outbound message
X-Antivirus-Status: Clean

I experienced a change in how textconv works since about 2.50 and it is hard
to get past. I would appreciate advice:

When I define an external binary textconv, roughly like:

.gitattributes:
simple binary diff=enscr

.gitconfig
[diff "enscr"]
        textconv = run -debug ../../enscribe-conv --verbose
        binary = true

The supplied file going to the textconv program looks like
/tmp/git-blob-GFtIhK/simple
and is always empty regardless of the file contents.

When there is only one file named simple in the repository I can find it,
but otherwise
any ambiguity in the name makes textconv processing impractical. Somewhere
prior to this
I was supplied with the actual file in the working index instead of a temp
file.

Am I missing something?

Thanks,
Randall

