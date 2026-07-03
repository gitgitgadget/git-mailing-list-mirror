Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD84357D02
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062082; cv=none; b=q0OfGopuMwAwELjxzfX/4rfyi8ZIE0cO1Z1Ng6rLAtFjq9uj4CWOggA9VyxVNll0BUZoC4AOfAFQ+N6GrplFtYvtqOJZdY4SbrQzVkqPbKKIyLHh4qKp17fgTnRRErcBXtCfYPtPa7bWbBmBv1EgPxHr0vuaWiy0rYu4Mqq+1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062082; c=relaxed/simple;
	bh=mceSImVMa1QN6ZANWeZsPdugTwPkJOsKmBpedLf1BNM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=vFy9KDNzo6BYwVODo7iSNgDVuZ0VKy+tBlcvH2ni85eb+3wnOqOeOIHNIJmYF/ZpKsMACx/YPsj3jZPjtZjVfLYdrIvbU2TPJiJXI7Nm43mbpJ7jZai9PAvCxElxoF4Ae8E7pRGTPTdtAh80teUQnQu+PfyTaNCGLxudJFuE99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=sUSg1Q9V; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="sUSg1Q9V"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 69EE960006;
	Fri,  3 Jul 2026 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783062079; bh=mceSImVMa1QN6ZANWeZsPdugTwPkJOsKmBpedLf1BNM=;
	h=Date:Subject:To:From:References:In-Reply-To:From;
	b=sUSg1Q9Vo58ZxX+QaYox+7k3VnWj2ysiAT8XwRu3A2CeRZc8CDR7KySO/+uH65Z1M
	 qbh8EL16BYW5led8FTrv4FicADbKr/DDp77P0Ce56cgvg7OlCS1LFrpSYt8Bqi/rQE
	 fnh3klxwH7VFR4E4hvP89c+ljp9EZyBJrfpovmOg=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 03:01:19 -0400
Message-Id: <DJOQR6XMG7QZ.2UH68XH0N1D7W@lfurio.us>
Subject: Re: Unexpected recursion in 'git rm'
To: =?utf-8?q?=D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9_=D0=9F=D0=BB=D0=B8?= =?utf-8?q?=D1=81=D0=BA=D0=B8=D0=BD?= <eugene.pliskin@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <323134122.20260702104910@gmail.com>
In-Reply-To: <323134122.20260702104910@gmail.com>

On Thu Jul 2, 2026 at 3:49 AM EDT, =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=
=B9 =D0=9F=D0=BB=D0=B8=D1=81=D0=BA=D0=B8=D0=BD wrote:
> Hello.
>
> The following git command does recurse directories as contrary to the ref=
erence (https://git-scm.com/docs/git-rm):
>
>     git rm -n *.json
>
> Without directory specification before '*.json' this command is not expec=
ted to recurse directories, but it really does.
>
> git version 2.55.0.windows.1

Hi - I threw a quick test repo together, but did not see the result you
describe.  Could you produce a script or series of commands to reproduce
the problem?
