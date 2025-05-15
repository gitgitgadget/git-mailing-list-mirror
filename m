Received: from mariecurie.slightlybroken.com (mariecurie.slightlybroken.com [116.203.185.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C32D052
	for <git@vger.kernel.org>; Thu, 15 May 2025 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.185.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747284509; cv=none; b=I4m/35TOv3W2lA2HZMF9YoGle4fuRPPyxEd9GpVT3wCOEIdwakOMgxJZgeZbInjKmay9e5/G98fKgZkjMBWSwofyc3coql/hKAWIbFOg07/8FGuu4sv5CaAtAYeG94QbY77UT9HSSTET6NSW6mvOcqmE85vbx9K3so8JpKr1QTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747284509; c=relaxed/simple;
	bh=85+1OmQ4bJNyzAvYcapp0kMl2N9Ehyn0nCAx4/RkRos=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1KL+g5SnrGY5UQ971VMMwiratvsB9/dAHoP7mbYkDyT9Y6NA/LALzQw1wPaS6Vds7+eS9fYEcPUu4KrLFjQdPTuzGLrzEwO5Exa8hYqn8vCzMIqJyNNPkvdaAb79fN8kqpYQp+74qztMnLl3k2q9QkztkCC4XsyLnTcLhvWZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=slightlybroken.com; spf=pass smtp.mailfrom=slightlybroken.com; dkim=pass (1024-bit key) header.d=slightlybroken.com header.i=@slightlybroken.com header.b=sSOekSzH; arc=none smtp.client-ip=116.203.185.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=slightlybroken.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slightlybroken.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slightlybroken.com header.i=@slightlybroken.com header.b="sSOekSzH"
Received: by mariecurie.slightlybroken.com (Postfix) id 001C16769856
	for <git@vger.kernel.org>; Thu, 15 May 2025 06:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=slightlybroken.com;
	s=20241130; t=1747284164;
	bh=85+1OmQ4bJNyzAvYcapp0kMl2N9Ehyn0nCAx4/RkRos=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
	 Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
	 MIME-Version:Message-ID:References;
	b=sSOekSzH7jtdTKNnb1JzK54Rek8vqhxph9dn6oQqk7QPAjUUWzwaSh12SUpLVIAsG
	 N28XQcx7OZiKZTNekU5+bJnFSF2JZP3jXwx53i7vpH+gxJlGnpL7xtiCgqIuhpLUw+
	 dbPCEjsHsEw/sSZNkjZojuQdAmCKhQ3Zyz7ym2Tg=
Date: Thu, 15 May 2025 06:42:41 +0200
From: Reto <reto@slightlybroken.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
Message-ID: <5voz3jolpff7wbs5yg7jvz5dt7omcikhna7j7646veagr63quv@kkxhzxxf4uf2>
Mail-Followup-To: git@vger.kernel.org
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 02:20:27AM +0000, Elijah Newren via GitGitGadget wrote:
> Every once in a while, users report that editing the commit summaries
> in the todo list does not get reflected in the rebase operation,
> suggesting that users are (a) only using one-line commit messages, and
> (b) not understanding that the commit summaries are merely helpful
> comments to help them find the right hashes.

As with everything in git, you can learn that this is the case.
You could as well just add a explanatory comment to the footer.

> It may be difficult to correct users' poor commit messages, but we can
> at least try to make it clearer that the commit summaries are not
> directives of some sort by inserting a comment character.  Hopefully
> that leads to them looking a little further and noticing the hints at
> the bottom to use 'reword' or 'edit' directives.

For fancy things/editors that recognize comments, this will *dim* the commit
messages, to light grey or such.
This is decidedly not what I'd like to happen at least. The commit messages
there are my primary way of navigating the commit, given that I'm not learning
the commit shas by hard ;)

While I appreciate the motivation, I don't think the comment string is a
good approach here.

Cheers,
Reto
