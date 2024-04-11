Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23F101DA
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863281; cv=none; b=iloeaVsBeO6lkgn5v5+NAr990DijSpqPSaWha/6mqiVHTjChq6C1ReiH9j0B7viFGh31NUnQlhtdMTdfe+1vwWHGaRTLApG6+HrB5Jw1ToAFjbZCORXqxOjFoP+MjAP2L7/MMHsggJcpVEDJVKrYu8Cu00JHa9mxLiS/MQuG5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863281; c=relaxed/simple;
	bh=G79mmfQRZxEN7f7rt3aLPOvmGhXp0wnqip6itFrEH1s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ng3/OrKx1LmgZy8mBGoJOYYXN7DR/a7DET5e6uOl6m9uWXUH+9AuqnSJkPO/Yr42erm5hGBR10XJbyrJeEscwAHbj4MCa2Brk0OU+69Po05cDJT/UA3nskZDUmYSEdXr945TkwlqRgK4JYvYw+AG9fKrRKjHAPkkrvEIHZUKvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43BJL5iJ284414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 19:21:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kipras Melnikovas'" <kipras@kipras.org>, <wyattscarpenter@gmail.com>
Cc: <git@vger.kernel.org>
References: <CADwVmK293eQ5VFkn-J68tXQ=64u3H79ScMW7H_ukSmtwLwA4wA@mail.gmail.com> <20240411173639.81152-2-kipras@kipras.org>
In-Reply-To: <20240411173639.81152-2-kipras@kipras.org>
Subject: RE: Short form of --force-with-lease
Date: Thu, 11 Apr 2024 15:21:00 -0400
Organization: Nexbridge Inc.
Message-ID: <01e101da8c45$66d33240$347996c0$@nexbridge.com>
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
Thread-Index: AQFrSioJbU03jVGbrVX+ql034/VJGQF44a3ksjYu+kA=
Content-Language: en-ca

On Thursday, April 11, 2024 1:37 PM, Kipras Melnikovas wrote:
>I'd suggest a config option "push.forceFlagBehavior" that would allow to
configure
>the behavior, one of:
>- "default" / "overwrite", which is currently -f,
>- "lease" for --force-with-lease,
>- "lease-includes"  for --force-with-lease --force-if-includes,
>- possibly others.
>
>Then, upon `git push -f`, the config option would be consulted to determine
the
>behavior.
>
>To get the default behavior, `-f -f` or `-F` could be used.

If this is mostly about saving typing, you could get a similar effect adding
an alias. Something like

git config --global alias.pushfl 'push --force-with-lease'

