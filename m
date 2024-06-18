Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F213C667
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718071; cv=none; b=iaWUdxxR6HiT9pKzHNexaxQ1sGYmN4muU+0YHrjyiTm5Fh3UwM9eQgEsGrswgiWv+t0LoypdrUrXHWSVO/h+0wrKPeaefX1LmbCthfaJ33FC8oUvJNRJwWhRB9brrGP5ynsxtmFyxLtJCCZ4n0CT6ILiRDDUcGdwQ/HSTemttfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718071; c=relaxed/simple;
	bh=okiknqibGWq5HiAGD1Mxmgzd2vhaVsi3t1e593jROzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4BU799O+Xvu7TTT7ds48IWAVPm9zdzVsAOkQLONEgipxpJ36gkkXLw7yAqhG89dgysM759Tmu5VUyWOVy2eYv5rDtMgJIAVMdGzRQsOEjR3sAN6CdhlWI6Z6gnw5XmbUREjSbxMx6OJDs//xyZxgK6h+tx+A895rDzGqrFddzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vp/mbWYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vp/mbWYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE8C3277B;
	Tue, 18 Jun 2024 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718718070;
	bh=okiknqibGWq5HiAGD1Mxmgzd2vhaVsi3t1e593jROzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vp/mbWYho31g9riSy6KeQgA/EWRkSaFt5xRsMbmXETKx26VszIxY5oHY6tWjRsEY2
	 InVWkjXLdCJXexZZclhlTEB30u/nN1twx6XgJCHGl12WQv/vvGok5B4Qxfacpir4M5
	 8pumzm1UBloGP654VtH5OeVhCl3HY04pYcTgzdR0=
Date: Tue, 18 Jun 2024 09:41:05 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT UNIT)" <richard.elford@nhs.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Multi Factor Authentication for GIT software
Message-ID: <20240618-grinning-kagu-of-examination-bb4e1f@meerkat>
References: <CWXP265MB3013B13F4BC4D7574E6E86E281CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CWXP265MB3013B13F4BC4D7574E6E86E281CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>

On Tue, Jun 18, 2024 at 12:19:19PM GMT, ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT UNIT) wrote:
> Dear Git
> 
> I am writing to enquire about multi factor authentication on cloud hosted
> software. As part of our ongoing efforts to enhance cybersecurity and
> protect sensitive data, we are seeking information related to the NHS
> England Multi-Factor Authentication (MFA) Policy with regards to software
> products which we have from your company.

There is no company, so this questionnaire is not relevant. Git is an
open-source project without any one particular entity "owning" it.

To answer your question specifically, git does not have a builtin
authentication layer -- it relies on the underlying network protocol for this
purpose. Any MFA implementation and enforcement would be dependent on the
protocol used to access git repositories.

I recommend using ssh pre-shared keys on FIDO2-capable tokens -- it's the most
robust and least user-hostile option in my experience.

-K
