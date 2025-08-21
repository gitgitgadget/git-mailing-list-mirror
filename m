Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7E2EC560
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784791; cv=none; b=G8aCLX+5+o2J21LINs//8xCkiKW7YIlcrpwE8nAuKF+w5sqjYf88Cy/H9bpg1fxJiPKhlqyrkjUGfWzNwvFx4jtO3fpEGcmANH+UX5uiiNdt70XgIubmbjmAXq0j46L6bQy3F03uDm9TCD1NyTDB12DsrYFpecPkLuyBv7fdsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784791; c=relaxed/simple;
	bh=MTlYY/JQV8EtcGbQu/ZiTSQjUq/JDWvdPsX5BE6LraA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFOrEpQG80haFB+tLFmvwsqOFXzQeo4I8e1vhDi5GcS4fXO08E8FFlhXQ4QA9wmfWdfwfZlhv3x735UxRxzjoetNreg2Z0gJMUXk0zJWZV1RX5METw2lwGph7P1ZD+bB30aTuHluF5RZWRi4yyA//Jw8VQ5h3rK9uF7Vn4OjhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57LDxfPi2948483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:59:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Git whatchanged --i-still-use-this breaks Jenkins GitSCM
Date: Thu, 21 Aug 2025 09:59:36 -0400
Organization: Nexbridge Inc.
Message-ID: <020001dc12a3$d7c392c0$874ab840$@nexbridge.com>
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
Thread-Index: AdwSo08O1mhfDWV3QTW8DJJDM9dWCQ==
X-Antivirus: Norton (VPS 250821-2, 8/21/2025), Outbound message
X-Antivirus-Status: Clean

The requirement to add --i-still-use-this for git whatchanged in 2.51.0 is
currently generating
errors in Jenkins GitSCM, which, unfortunately, still uses that command. I
have reported this
as an issue to that team.

It seems to me that we could have some .gitconfig option, maybe
core.ignoreDeprecations=true or core.iReallyMeanIt=true to suppress the
requirement
to provide this option on the CLI because of unintended consequences.

Note: There does not seem to be a way to add the option in Jenkins.

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


