Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CB2C0F91
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764298; cv=none; b=iPL4lEbq4IKPyINzQYa2n5oAH825bMNFEpx5DaKSIFB6XhD5Uy6TjEQilb79/uVCmBqkgIulvdwfa7J6Z9ez7x5Gy8GQmBIsLDc22SCdaoes+VXp7MVa+/Yn4NVErif/FHmVoLw1WZ/S75F4dEavDXh6vByZJfMKwLFBkPah9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764298; c=relaxed/simple;
	bh=CLXhYIeSP3yANYCJ7tT1su8kEB62ogPn/6kK28jcrOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY7jMjUjziRlEuYvKjP7gPPemHZyiTxqhK3TuU0PdaQPbHCfVC2gnc6t0bcN/f+OiCFF0UHMRfy0e6NVXNBAHOYFdn8Fedx9smqAW98hflbU864yywgJji5Z8u8RcjI2vcEdWuOJJZWnNIo6keDF2KTzwOnK67iwERLkV/hA3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KyW86tBo; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KyW86tBo"
Date: Fri, 6 Mar 2026 03:31:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772764294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDBjsK6xzbBILgaUhu4l9s3u6g5U+GgJSh0YXEGK5Do=;
	b=KyW86tBotHQV7fS6tcByUMVkrO45R3myuAKnjOOk8jzjQqvoO1cmohpdKgb6Vxx7D1FXiV
	5e3VE4okXvs/hVKgm8rZ2b1zcQMwVQXLNTqYXPzxOWVEjeqVWlpWu+udLBYdKYN2YsV7Lb
	LhVV9AJO5dmnmpSveDqtS91Vlp7DZfopeqlC65wrlC8hTykb9gcl4VkGy+lqLZppqML31O
	VnqTnoYcadcSzgAtC4sgYYqRLEHrMddlnyJ4coBCo386wNcYATaiM3kfjX0UE7Shjwphc2
	6iQVOrAERBlAU+gtCm+6cG7yAFZ8t+xvw+wkhEYkuPpwCqTnXrgBudb1fnhaMw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Aron Sigfridsson <aron.sigfridsson@gmail.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: Git reference git stash
Message-ID: <aao7uLxQ0ir0m6s2@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=mroik@delayed.space;
 h=from:subject:message-id; bh=CLXhYIeSP3yANYCJ7tT1su8kEB62ogPn/6kK28jcrOU=;
 b=kA0DAAoBSHl+oZwZvtEByyZiAGmqPG+iHVLZdxFsAWH55aAdIQHAkS38XntbDIfPOYNKq7RGN
 4kCMwQAAQoAHRYhBP8rLfsrSlLCbCzJtkh5fqGcGb7RBQJpqjxvAAoJEEh5fqGcGb7RqqIP/07j
 q7LmCnVm/7++txKz8aW9JIfXkpEQS7kpdONGl5BKxHyrpsH/Np0Tae/Zvt3ibsbAoe9PgCyDito
 u7znZvaTMNnjtlE2vxY37/czdfRvU19uGLkMYIdsrx93SIIyBAFe4hSRDSBandIU+uMRO7WVEqr
 F5x6ugxH8DgKNvYBXLZmAhP+WCnGeNSJ98qCLl2Wonv3g90i5Q3OoTKjewYQKYuq39cDM7EJ0Ly
 5PDDtRVeimufKy7aarRl10M5lWMUdcY6o/a2Hp9SFSNL+28SKgq9AY5AAwNGwk5G6xjGuBCsgT2
 1KZYv2X/KABJt5ajWg6IUanG/ggVeSC5SVUDeTwI0WZxP2pmz0AwrDJ/gpMmfAdVA7l2d/13MUc
 hSVtELZlnpa1uDmelKa6sRaKpMli6xQjcJYzjN7wCgUfl6zW87JHGUgP1A1NaaFUPi4zvSWChPN
 6DL45ie26MATY3kb3YesEWzIImtybPit0HOwQQKCKM01hhmBtj3ZplnQ7xM7eEvYOMF+SxGmf9h
 Pg1QZBgW7CgsdhCD09veQajNsTJBW+CfU6ECX2VY5y0PkRZpRLpSBIrGhOhb/QcqvaoPl1ZoycR
 BOC8BN7vYtKjAzTQ1/iHyqO4IgIJOU2ZdKPH3XnBoZeMHWm7+pVDv/Uw6umXg/can1u/un60zke
 DcGLJ
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <CAB0c_PjtTs8dWJCoUnQfCUM_YOaK3e3FcZfCgWjTOLcNWj-6nA@mail.gmail.com>
 <aao1hFwJYpJymY3o@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aao1hFwJYpJymY3o@exploit>
X-Spamd-Bar: ------

On Fri, Mar 06, 2026 at 03:09:15AM +0100, Mirko Faina wrote:
> It doesn't seem to be specified at all, but from a quick test you can
> see for yourself that "git stash push <pathspec>" uses relative paths
> from the current directory and not the toplevel one.
> 
> To be sure on what's the relative path to use you can check the output
> from "git status".
> 
> Maybe it should be added to the documentation for "git stash".

Looking at the docs for other commands that use pathspec, it doesn't
look like any of them explicitly say if it's toplevel or relative
neither. I suppose the author thought it was obvious which one it was,
besides, it can be easily checked just by trying out the command.
