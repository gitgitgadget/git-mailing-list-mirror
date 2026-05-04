Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F23C455B
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914372; cv=none; b=k0BbxWUfyccJY112OJHtTshe4EeNwLJSKvGu3N9BxFiGBDR947MAvGPQ+mtp/KkcWfRKZi2JWXviM3fWfxaFrkj/XwMScFe/5XtkXQNe/s4EJTv2OFTRdb/N4ySzXYM77pn3+Zrrm3tUZsSpQc/lalKoiExeDW+RKqwEGJDRIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914372; c=relaxed/simple;
	bh=CxkIlroyKVr3Bz9uYdLNvPknjXLAxe91NQqFvV1OaKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iM/Qfm1IhF/+qKmptPZGuEG/R30m+e1mDB2Xt7lUU3DMlPfRbK1YD3gUAV01c6fzA2SogZIpqzStAF6z9NEM+ke3cKCj5npUW2WjnpmiTEunaoIF9GLFcW6fy+Qylw0AvSscxIjep/E0Y6Jpw2Qm2pGSF8VfcI9MAWJYh4QELuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 644GvQbC1493558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 4 May 2026 16:57:27 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Question on Clean/Smudge Infrastructure
Date: Mon, 4 May 2026 12:57:21 -0400
Organization: Nexbridge Inc.
Message-ID: <079201dcdbe7$162d5430$4287fc90$@nexbridge.com>
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
Thread-Index: Adzb5n7UK+nAcoz3QzuFjdM0rQz4xA==
X-Antivirus: Norton (VPS 260504-4, 5/4/2026), Outbound message
X-Antivirus-Status: Clean

Hi Git,

I have a edge use case that I would like to ask about.

Given a directory with a large number, say 100, text files, and a few
scattered
binary files - specified in .gitattributes as binary, what does clean smudge
do
with the binary files if they match the filter specification pattern? Are
they
ignored or processed. I am not sure that passing binary via stdin is
necessarily
portable. However, I would like to be able to explicitly ignore the binary
files
in my clean/smudge filters - either by doing a copy stdin/stdout (as I said,
probably
not portable), or sending a non-zero exit code, or some other mechanism.
The root of the use case is that the directory is subject to significant
changes
over time, and errors are sneaking in when people forget to update
.gitattributes
or name the files incorrectly. I would like to make their situation more
stable
to errors.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


