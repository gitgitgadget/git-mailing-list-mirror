Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19534251D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545354; cv=none; b=BK5mHBjksuEB1ItXOoEb4aQn1Sr9QgUSbnha20YFVFJcm7Dl2aDD+5kOM0CJHJO9xM5YK7hu4w1IoSW9g5HrMIJPkJckVj2mO3PWqoyuEx55GXgwXrSg4l+ZSmv3VNcw4N8PCbp1ey+ICqpei0vfQ+gdAUUfPe/dmVQCthlGkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545354; c=relaxed/simple;
	bh=LS11RgZeKfZnsfPonjjTFtVCjA+7OoUx+EaNRupUvpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAk6Y6QKNFDX6poKBEdQ8NYNErDk9XtaSFVKoNpPUgzbMPzsKUcqTogLibg+5yzL6mxjTgaHdEa21uddM+yWyYaTITd2vSv3KdY4DBOFGYqdIsrtUbvlPjoPYjD8aXBJ/4ht3WrPWIcONKCMBP+9roh9zRZMdjhv6RKWzp4WMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=W2sPGb1V; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="W2sPGb1V"
Date: Thu, 26 Mar 2026 18:15:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774545344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Tuyvc8naoMBC+CdC9hYr13mGqrEIr+FC94bg0QOnQ=;
	b=W2sPGb1VCq5jQGr3JNHWYM8GJrHL5k16Ppdbr4roIAy8x+WJgBDCH8YKqfPMm7ALGFX0dI
	U6b/q9Fp7LuuKfRRlj5GQou4RsM4UNuH2fTm8mWRj3ndu5lQfrV1TiyVA5k4gwLwv3Utqd
	tEbu1C+6+o6AeTvtBsBiNX/Q/nJVoUVid/TUPCINEEYL8oDVzYygJP8s2foyYhJjBMcpEg
	OiRYqiEBM0skNVdGQ9tPXSKzfyjeUkPnMVvOaZF+YEt26xlx90w0rscKpBj/Xj3ZH7IowE
	ArGQ7kKExx5iJEvdIjvc9OXrvFqoq1jQMpC8UeBowo8mKEXoHnNdWTXyNhC7yQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
Message-ID: <acVpNdlKESgogXe3@exploit>
References: <cover.1773959395.git.mroik@delayed.space>
 <cover.1774284699.git.mroik@delayed.space>
 <CALnO6CAmXrYxYUCg6KRKNYmw7xTW6W5ZZ85BAYL5pOt0pvMR2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAmXrYxYUCg6KRKNYmw7xTW6W5ZZ85BAYL5pOt0pvMR2w@mail.gmail.com>
X-Spamd-Bar: -

On Thu, Mar 26, 2026 at 12:34:00PM -0400, D. Ben Knoble wrote:
> On Mon, Mar 23, 2026 at 1:32 PM Mirko Faina <mroik@delayed.space> wrote:
> >
> > Not much has changed, just applied the suggestions Kristoffer made.
> > Thank you again for the review
> >
> > [1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
> > [2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
> > [3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
> > [4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
> > [5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
> > [6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
> > [7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
> > [8/8] format-patch: --commit-list-format without prefix (Mirko Faina)
> 
> I've just noticed:
> - we don't specify the default value in git-format-patch(1), so I have
> to jump from there to git-config(1) to look it up
> - we don't specify what the "modern" format means
> 
> Maybe that was all hashed out already, in which case links appreciated :)

No, you're right. It doesn't say what the default is in
--commit-list-format, it just says that it defaults to
format.commitListFormat if not given.

I will send a patch to fix the docs. I guess I should also change the
text for --cover-letter as the commit list can now be something other
than a shortlog.

Thank you for pointing out.
