Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB333ADA3
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762966; cv=none; b=eKZgnPTFgcEaaSy6D+cUCIDQ9KK6FTJrAnWu4lZydCxZt6SVhatjd7tsIXR9xxz6juz6EhQP0MR74OlUIIrzt5I2KS9ET+blHqgl+yo2haP8fKKpsV1k5iaKOBpMGYHwKQnkje0LjovBfpMztjajumMWdql14rMy/GZ2AH4ITtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762966; c=relaxed/simple;
	bh=s0dvdEx3c/LvxuvX9jeJQmubvHChCH6CzCQfqkihS+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IkTJ7Ee+Q1WQvwIvAwEyE5h1g1CEeFzU8FXJgIxdiqRqicnIZoZ0+lK4ucm7CC01eOBv7ovBrWuUQVN8DaCjDlVmZzTsDNfQsd31IIYC96AmBOJu5EgZXG6tI9cV0zYtbpy9bs8uot/zQxwEB5ivTho8nWpkF4SeH8rR0QZfCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ai+oP2V7; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ai+oP2V7"
Date: Fri, 6 Mar 2026 03:09:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772762956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=s0dvdEx3c/LvxuvX9jeJQmubvHChCH6CzCQfqkihS+s=;
	b=ai+oP2V7Y3nYvDFSAprcdt9Fy9rilxkWA0DhbdgyWh+rWL/wxhcD8pkff/Zh/dePVTAh3y
	t5m4Jh2DI5r4tWz6QqoAbImic0IKGIt2mxt7zHEoYiTLHIos25m9AsXizmF346/NxFWn0Y
	QxCx0ERguDVfNnTq6cIiHkadlpXoqhuXg6zqg40RKMvChOigCnwLfGbpQwzmE+aLUfz2V3
	g3ss9cy0yOjfu+rN1UaRoZ8cZ4pvoloMXcchNDI+G3aJnR69SDSdRaEXaPuA207i4Ek0rU
	s5N/z5vpVdfeax82p/psltaNp3fi0QQ9PtY+8EJbWd11tdCM+SN6w/hBjGKNag==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Aron Sigfridsson <aron.sigfridsson@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git reference git stash
Message-ID: <aao1hFwJYpJymY3o@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=356; i=mroik@delayed.space;
 h=from:subject:message-id; bh=s0dvdEx3c/LvxuvX9jeJQmubvHChCH6CzCQfqkihS+s=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpqjc9pLAIN2bb7wm3VcK/1Pp4cDo6eYuGtmNJw
 HjYmX6Av8OJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaao3PQAKCRBIeX6hnBm+
 0cujD/sFRU8SD9uCIA/ZGSdGNYNaeSYlXQNsJk5S/ka8BOj1WeDwvfFrNpUIynMD61ummYnMceM
 QNW3dTz9Z3sG8Sv12zJEZTiwSXiEJHzfoD+KPU+QARgZEoKyv9QS94pSYylgeyzC/a8FnjpjvCc
 /MOtuD2N001IIegjHEV/1dv0jgfTfbrgjr1lp+VchpkQcc/R2pk/0XG+cTuk0qNO23YY6j4qTib
 0icVW3wLaMc8v0hsQrEw49zeI8TrP8aVryAfInzV6gKfvxjqZWLtmZs8SbpovNjEKv3GSYMouM/
 xWIzdKDsdP0UD3KFkJvOebFjRiwCNE44JP2TuIa0XBAWn16RnA0hifTE7BNEMuXGGV609aZ12sS
 RQBXkckyE216qAFwspwZ0NZru8dZpUktS936QWz7ylBykeecziD+EWD24DxHx4B+BVqTZG0YWYA
 1DSDQIJcBzbvLFf4lzSE5dUSpEMvgijavjNGxvD0gzTUyxZIekxdTGw8NA6vZ2qt1knhOmUcLJ3
 3sxkG8jnMfnltcRe3JSF+NQsvfvPcUKUY3kp/6QZ3u2RwdszhL1iA0i1j3eGoTSa/7VluB0c0Tl
 X6Zdr5BV+dEN+Q4tnRwshUD2pvM7UcyIC3gmCqnloLpL3nz3bUYsyfkb9i3KgZA7U0L5aGgZHg3
 xgYM5bjmEWCtVGw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0c_PjtTs8dWJCoUnQfCUM_YOaK3e3FcZfCgWjTOLcNWj-6nA@mail.gmail.com>
X-Spamd-Bar: --

It doesn't seem to be specified at all, but from a quick test you can
see for yourself that "git stash push <pathspec>" uses relative paths
from the current directory and not the toplevel one.

To be sure on what's the relative path to use you can check the output
from "git status".

Maybe it should be added to the documentation for "git stash".
