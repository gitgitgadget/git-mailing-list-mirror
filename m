Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8201280A58
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176112; cv=none; b=MjwljM41cGQYl7eqQPM2iVnaFiOFau7xv9u0sCWpcL79LaRX3jxejZKYVzyB4mpFl8PJOIyH2tCv3G6qaWvR+UaGlHWNUMkqmOgXFnAPN9Y64n6dkih8TZ30Nz4ygCmkwOOKM9o3sHsbOeJk6A2L2kBNRI2QCe0spm1Grm8MtsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176112; c=relaxed/simple;
	bh=t/Ag1oOvKj4G74ZWM2H1bwQpXdFJEwhEEzZM+lS6jF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnhnOE9o4/3yomhGO2Z+DEBMBXgw3ltdGsML1MYXqcRWP4DoHY6/jdZ2mN0i0Psv6mz5hXF0OV0Gieccr0qFI/hIh7jr8jbTefs+INfJnPWeYOfmq6s38V+lc9UXDPFScR9SwDIJeafAoGe7bOcWOG9kxtm2PS1jBNIN3Qww0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=fKchbg8Y; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="fKchbg8Y"
Date: Tue, 10 Mar 2026 21:55:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773176108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxpSJlC1wLJ939zjrzVMuwEyOmzw3fkZ36TVMyyv90=;
	b=fKchbg8Y1uMg3lXrAR6zjCkd4DjSttq05W2ucrkBHxZDx66ZWSTLa+bBRREFjo8FJZ+AcG
	92LcrKNWIe1BEslCyVV0vz2DnPH1wHzIJ2yjxM2fgy4uKtaVO2NNprSrxytDmxBcRjooK8
	kt02GZDzT6wQSi0Co1A0VWQpEu1wqveKV09w2s7SuenxxZYaJotzKAh8m8boweQuGX7i3t
	Wwj+rBvKzlj/39WhYlrEIX3w0VU6pKod2oxMhXgtdPHOUPCsEh6mxQhwLXtkQkPWpoTYfS
	uMVPjHWQ/3S9nmxelsy3ay2MunSB5PGG/fxhRw790+JfACoz8pVjzHQvOKuXGQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v7 1/5] pretty.c: add %(count) and %(total) placeholders
Message-ID: <abCE0p6F9r4Gwl8O@exploit>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772839973.git.mroik@delayed.space>
 <8855efd5-a53a-47fc-8708-4cd6d416e441@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8855efd5-a53a-47fc-8708-4cd6d416e441@gmail.com>
X-Spamd-Bar: --

On Tue, Mar 10, 2026 at 02:32:54PM +0000, Phillip Wood wrote:
> From the user's point of view it would be more helpful if this message told
> them which format specifier isn't supported
> 
> 	die(_("%s is not supported by this command"), "%(count)");

Indeed, will fix the message.
