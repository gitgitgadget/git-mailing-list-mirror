Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE45233722
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877964; cv=none; b=kCvM8xi93+0+y6tgGLUWuPjDeASunar/fBq9X2hNsUUFlgFsTHZIOnW79ec0MO2fvo3RMJJ+bFdp/E+NncXDCLdSmiUnWxbgPYGxUsifKcgPMBl3vTcrjR5+IhJYPFbulaBGHjAs305ZciwgTwyYb/P7jx7Ext7AELdBsZYqaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877964; c=relaxed/simple;
	bh=e6rNPcY+jvT8TnIHwv86Ek0MDqA2lAei/+dZJ5tDe0g=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=ATjXS6yJ7B9UHZUZ/ogJB6nScsZfyjfg6LvigkmFcovTKw8WX/dKg68ClQQwKabRgXkYoNdOuVpxmIt8JDFGws02UiJjoWRa2oZbcqIUg1PoqOBXN3tA0HggZ1YYj3rvEtKmMzTdfQG2TKIh4ysU9oLxt6nOjt5OQOEIDZ2q5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=ON2fBLqz; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="ON2fBLqz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=g.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Sffx6ctsaK75lYvYhvLb2Qc5tlArL2MPzbeJOPATcLI=; b=ON2fBLqz49mZ
	tfOjQMDkxgG7gC0PvlT2K2DSwCB/a+C2dUXRdP6CaQoXmoOyTwxctplEvq40eZhlYB8hqW9W2PVSz
	kqBEVqekPOcmIIahWniZQZ5Br53T4D1xkQ4iVfCmSKCxyCCpV/0iXzknLKA1tj0fiCy4F+NiquC3u
	8VJH3z1u5uBB99Ny9mSN+L44CMKzlhqy6j33DqWr+t7DH8L5Oo3prMdLduiuBhUOMjV6aJF3AcBHf
	3MSQFZKBRoVRsBtR7oFFWKHi8RTEEBoXn9Xthhm/czbEy9eYMgdT8Qw3SJVdkDkb6NMyKnofrPJpZ
	bh8HY6yqKe2tdEfeN2E3DA==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wFb7o-000705-DP; Wed, 22 Apr 2026 18:12:32 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27113.384.389621.34039@chiark.greenend.org.uk>
Date: Wed, 22 Apr 2026 18:12:32 +0100
To: Avery Pennarun <apenwarr@gmail.com>
Cc: Colin Stagner <ask+git@howdoi.land>,
    git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>
Subject: git-subtree rewrite
In-Reply-To: <27109.63619.90318.366157@chiark.greenend.org.uk>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
	<27109.13129.424068.382997@chiark.greenend.org.uk>
	<27109.63619.90318.366157@chiark.greenend.org.uk>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/c1/c1ddf06a6f81ef753bdb3a544fda03f3.pem

Hi, Avery.

tl;dr:
  Do you object if I use the name git-subtree for my rewrite?

  I intend it to be forward compatible with existing git-subtree
  histories and existing command line invocations.


I've been looking into your git-subtree program.  Thanks for it;
it is definitely solving a very real problem reasonably well. [1]
However, I think the existing implementation (in shell) and data model
need some work.

I have done some experiments, with enough success that I have more or
less decided to try to rewrite git-subtree.

I am intending to make my rewrite able to work with existing histories
(ie, projects which have done git-subtree add and git-subtree merge).
I intend to support the existing command line interface, although I
may improve that later.

I am also hoping to be able to define the data model more formally.

The git maintainers and others on the git mailing list seem reasonably
enthusiastic about all this.  My nascent rewrite is a a standalone
Rust package, and the plan would be for it to obsolete the shell
script in git.git/contrib, but live outside the git project itself.

I would like to call my new program "git-subtree" and have it use
(and extend) the exisitng `git-subtree-...:` metadata that
`git-subtree add` puts into its generated commits.

Obviously there are compatibility, packaging, and deployment
considerations, which I'm keeping in mind.  I don't want to break
anyone downstream.  So I will proceed reasonably cautiously.

I hope this is all OK with you.  If not, or if you have questions,
please let me know, using reply-all to this email (so the mailing list
gets a copy).

If I don't hear from you I will go ahead.  The actual programming work
is going to take a while so watch this space but not too closely :-).

Regards,
Ian.

[1] See also my blog post
   Never use git submodules
   https://diziet.dreamwidth.org/14666.html

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
