Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC51494AD
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281956; cv=none; b=tAQdAqZt0WySAEZDcss9bk1j7m4EqyZPpXRorEFZ/g5/WP+zOu/V2gGRjhyfmyfl0/tTLpMYQivyLa3l/KublielM3HP3eNC3t9fSeJ25jflH5D4JOCAzV38WExuK+O2zKTIMK67z7LYLl12JpvQx2Z6JYHbSaXlkQCZaixYTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281956; c=relaxed/simple;
	bh=jnLsHhH2vClXoHLqG226WHC0UDKdmJsO2UaTICxePJ0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kmr1mEf+YopeGmbuF5Flu8HgDRoocXOJGx0hm2FwkllxHLByXeNoimoxLkUJppSzQaK6YLNL2cVwVrmTwly8TYv1wgbG3B/lTbiPamxveZA8zLmtnhQ2fzDKcNqJ0uFm6TJLtAnn+0c659LncOxKSqCFsDjgpjR/xGM/ZPgcyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47LNBjQv3449679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 23:11:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Chris Hofstaedtler'" <zeha@debian.org>,
        "'Simon Richter'" <sjr@debian.org>
Cc: <git@vger.kernel.org>, <debian-devel@lists.debian.org>
References: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org> <gbgpxxpikhkykvhug4ugbufqm6bdh44ygiknpzc3khalibwutk@jlebwg4vsvjt>
In-Reply-To: <gbgpxxpikhkykvhug4ugbufqm6bdh44ygiknpzc3khalibwutk@jlebwg4vsvjt>
Subject: RE: Representing Debian Metadata in Git
Date: Wed, 21 Aug 2024 19:11:40 -0400
Organization: Nexbridge Inc.
Message-ID: <029801daf41f$7e994b70$7bcbe250$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGn6095VZ4V4nQmJQdQ+DVfIc0PzgKvkS9zsoLrPTA=

On Wednesday, August 21, 2024 5:38 PM, Chris Hofstaedtler wrote:
>* Simon Richter <sjr@debian.org> [240820 09:11]:
>> One of the long-standing issues is that there are multiple ways =
Debian
>> packaging can be represented in a git tree, and none of them are =
optimal.
>[..]
>> A possible implementation would be a type of Git "user extension"
>> object that contains
>>
>>  - an extension name
>>  - an object type (interpreted by the extension)
>>  - type-tagged references to other objects
>>  - other type-tagged data
>[..]
>
>> Any feelings/objections/missed requirements?
>
>In the current DEP14/DEP18 discussions a lot of discussion was had =
about how we
>should represent Debian things in git; your mail also goes into this =
direction.
>
>My *feeling* is we should do the opposite - that is, represent less =
Debian stuff in git,
>and especially do it in less Debian-specific ways. IOW, no git =
extensions, no setup
>with multiple branches that contain more or less unrelated things, etc.
>
>I think we should move more towards a setup that is easily understood =
by people
>not closely following our Debian-specific things. We should avoid =
surprising things,
>again that would include the multiple branches and any git extensions.
>
>Before pushing for new ways of representing Debian stuff in git, I =
think it would be a
>good idea to learn from all the other distros and distro-like systems =
successfully
>using git [1]. Debian is not the only distro that wants to use git to =
capture changes
>and encourage contributions to its packages.

On the other side (perhaps), git is increasingly being used in the Ops =
setting for
DevOps and DevSecOps. Production configurations for high-value =
applications are
moving to storing those configurations into git for tracing and audit. =
Git is an
enabler for good production operations practices. My $0.02 (and my =
customers')

--Randall

