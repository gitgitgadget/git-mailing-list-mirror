Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F015539D
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731158058; cv=none; b=XhWQD2fVsxHW526Oqk8OYi5pP1yDbvYYWjT5DUfZ34bGh11BN91Uy6vaLkaGujOcIUtNF+SruMz7Gh1ksD4Z8M+UiDx0AHDDX3xPzqyrHXRaaphN0lk5k3Ka+0alz114KnMN7CzA5QBJpqBf+zX6mABEFU0DVpeKmkBIudqDc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731158058; c=relaxed/simple;
	bh=wLcx4UvLVHBCvqAtkldww2AuyVdo/jwmF29e1OGmTGc=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVIaeearF8cos6AapAmfuqVgxP93yTd+TY6XdZ+BkiYDe8qEQoqbytuCS1eg9z+5DuH98WGC/DlFctIzY/cG6pnkU0UoWjsuiHZhIQsmUs/hx+Hd+9OvF0Fx2+RTV0Vk1pyDaHA2e5Cl1NVCS0kn1NVJBANDYRn/clLb8ZbDEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4A9D9IGF2391819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Nov 2024 13:09:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Martin Imre'" <martinimre25@gmail.com>, <git@vger.kernel.org>
References: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
In-Reply-To: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
Subject: RE: Feature Request: Interactively pick fixup revision
Date: Sat, 9 Nov 2024 08:09:14 -0500
Organization: Nexbridge Inc.
Message-ID: <03c201db32a8$96e66e20$c4b34a60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIBvhv7Hh85Rin8tkn5B9o7wLB78bJh1HKw

On November 9, 2024 6:41 AM, Martin Imre wrote:
>first email to this list, so please forgive me if I'm doing something =
wrong.
>
>My usual workflow is using `git commit --fixup <revision>` quite =
frequently, as it
>eases the code reviewing process and allows for a clean history later =
on.
>
>One thing that is always cumbersome is to first find the SHA of the =
revision that I
>plan to commit a fixup to.
>I usually use git log and then copy the revision.
>I even wrote a script that eases this process using fzf:
>```
>#!/bin/bash
>
>res=3D$(git log --oneline | fzf)
>ref=3D$(echo $res | cut -d ' ' -f1)
>
>git commit --fixup ${ref}
>```
>
>I don't think fzf is really necessary here, but it speeds things up.
>
>Anyhow, I'm really surprised that this isn't a feature of git.
>I could see a `git commit --fixup` (without a revision) or `git commit =
--fixup --
>interactive` open up the git log and let one pick the revision they =
want to commit a
>fixup to.

You might find that git rebase --autosquash -i <commit> might do what
you are looking for. This allows you to clean up your topic branch prior
to creating a pull request. Loads of documentation online about its use.

Good luck,
Randall

