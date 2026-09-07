Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35174854F5
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783021; cv=none; b=UpP0MVn1n9HZdW6pkQbMs7zEQBPdkM7N8lW15w2aqE6LemY8eLpG8tTDjnhFvMHOOxDv2yP2nnNcAJUeHasoycRS5E/J49aenKNZpH6umHDUGCIV7ZBbk3YpGxgZmGxNqTImfuCjGl17BOTxpYYVSyfOO789ST7uAT25RnHYvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783021; c=relaxed/simple;
	bh=mUuMr1SYlmrPjdlF7nkU+GpGek3Hs3ccyLmUXe6Za34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUknzoYl4SXWtt8OM5hsFuQ1Y7r8nfKMixdGEmQB/TSiUb5Tm+6bF0yiOSR94S4FbkeYcMg97dIeGabLgXY4IH5ZwgWALN+1dIpOLuOAP+I2QEE+b5PS7wo8o95KPjA/Mg6DADXoxl6tdtiRC287gprzEzNCbUpJoK4uGQpulhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oxTSfZAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vGn9xZ/X; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oxTSfZAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGn9xZ/X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 899627A00C1;
	Mon,  7 Sep 2026 08:10:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 07 Sep 2026 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788783017; x=1788869417; bh=zSwvjn+Hmg
	spPsfdn7k1rRyj8IlVQXekCjn3GTYHsCU=; b=oxTSfZAL50u0OW5r0fIYVm6mc6
	0yyX6ZQFOhFmY3i3m1PBks/LuXGa2M9fRraBkVTSafrMaLxs/MDHxUQ/DpzHhZuO
	NkWFZm7W0kfzl8TXAcgzad8rx0lZDphvQAH0nrtfw0vm8EgDLqW4n95BI63WzQI/
	DayZz1Z8Bg6LynxnnamUHB/ejtLL6TIh7bIrix1n+duRAezPja9urt6pwX2Judpb
	0aR/FfjZG3idJyLOKrle2vBVUu5lWMG2ZxWGx6cEYc7ctJHQ9coKiEExLyAVnXpI
	E8+byr7lBMhwrYmdRDU/tGHcuUsAJCHMYGQ36MuSVTgAspHEUTmKssOi4vFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788783017; x=1788869417; bh=zSwvjn+HmgspPsfdn7k1rRyj8IlVQXekCjn
	3GTYHsCU=; b=vGn9xZ/XJnXNWISpQxv4sgD32sAcapIwIasjOE1h2EYxzBOlm6w
	kiVyKpth9C/iUwkApZ64UFCoj4/9qR+JasRspdaMD86Sx03ntQzmfE2u6qTFyNh6
	xAor1gEbTJYj7RqtO5Hzk16oRAweqWf8vDs2AptDKseC+TTTmFP3tTMNxU+J+RSC
	RrQIRWuaOepVFG4fcVRwgHtpMI+C9Bb1kL/7ydDNPW8USvVVBUHYUdCH77VhqnR4
	BuMvNr/pyosR1dLAC9LWxG1Sz7MVKlIj/ssY3CxQQpcSvKz8yREfAZKYBilu7Atl
	BmX/MWCQbj/cbTDBFx7XZhUQ/bPNGPZSAoA==
X-ME-Sender: <xms:qameaq-K5x4BhstXjwAFG6AeEZjjw1hgEkL5VLRjr8HRLhge0l7hPA>
    <xme:qameagvmFqMi-GFdlcrQnD0wl4CFuFfzcjHa0vQP8-iG7C89GKXJhG66c1Gu2VzDt
    BXwaGnLTgEs_Z56zvJ7jknb67dw22FgZ8QsDYKMQWj-NLZcpOMTz-8>
X-ME-Received: <xmr:qameatrK2tNA2AFH9fUj2pUcNjjK7SZnN4axgJ_Kvhx1va1nKnWIlg>
X-ME-Proxy-Cause: dmFkZTE9XBAShMtvXZ3iuBbHJLow7t8+lBDrr2MjeCjIp7/v7I+rRxUcovODSVeBfb8YUP
    NFbTcr9u23aq9qRrjXlHJ1I8RBbBVHIXoxhPhZqQ1b1XG93cQrnStQ/wcmNR4DlG9CoxQe
    9rgUZWgTCK7EOZem8W0p51XMkap/q28SMGXO0zwUYsJkeyRPBQK/OAMpu5/kaMHf3eSWpN
    pFOg4SV9QWgZU3MSBAMFZpNTvKidPPRw0xdRGQY6vAd2KB6KRlENpU2dWhb4O1vcXVrgtV
    GlzWq+nMS93T724eJ9HkpP7xs0+GTmHElwAuQyW2RgiJEyqLSKg5wKItG5LzwvG70boAAF
    PN2si3wlC3mRYwmoynT0s5LWku6QLfWyuWJefD7WobijHOpFsb4Sje1VL3eftB9htsmxSn
    TyQ1DdsgohYKzFgfQ4nx9Tf/YsNUDey51eLTi503+LEnPAQfQDvIIpzC3hY6Otmeno2lOI
    FrahtfRriO6byzLm5aLwKI0IMobwlA1Z5lGEFRlkePDWOm1WFHZBixiu0eXDR0wMXp1odd
    +g37uYEx6FQSRmPqt6VgpyiGW97cE7b2Br6sQaxShzu92ej3tYuWIqm93ZkJ15NTsadpeE
    E5QvUjFDTlFCtRUa+9HitobwpG2KuEIjCTqkC0BS4VMb/QPPjlEPGkZlOxUA
X-ME-Proxy: <xmx:qameatmDOvvbfgX-tWQC2vkkoIeC567imzLGu5F81Y2RjMcs2rAr8g>
    <xmx:qameahyXMS55_CgfJ9ew62HImnEhkPRfhBaAcnyXYeorDOq0QYtuTQ>
    <xmx:qameallqSGzv60Q9HydxwBNYzVvTI0KrMPrWdDROFMqwjW-WWaGm3Q>
    <xmx:qameaqfwAT769vXmk6gl2waQgg8yEKY88_AnAoOPmct5gi2ezBZP5w>
    <xmx:qameamWc2sm2tDUxVz928rgvmAarlF-6M9K9E-x2ppLYMuihhCQrGPyS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 08:10:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id deeedee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 12:10:15 +0000 (UTC)
Date: Mon, 7 Sep 2026 14:10:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: markchucarroll@fastmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] Update shell tests to use semantic functions
Message-ID: <ap6ppBwdg0Tpb8TM@pks.im>
References: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
 <20260904-file-tests-use-shell-functions-v1-1-b66f9cb4adbe@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-file-tests-use-shell-functions-v1-1-b66f9cb4adbe@fastmail.com>

On Fri, Sep 04, 2026 at 04:35:52PM -0400, Mark C. Chu-Carroll via B4 Relay wrote:
> From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
> 
> This updates an initial bash of shell tests to replace uses
> of "test -f" and "! test -f" with "test_path_is_file" and
> "test_path_is_missing".

The commit message doesn't quite match our conventions:

  - We typically write the messages in imperative style, as if telling
    the code to change.

  - The subject should typically start with the subsystem that you're
    changing, followed by a lower-case letter. So in your case, "t:"
    would be a good prefix.

  - The message should also briefly explain what the benefit of this
    conversion is.

  - You're missing the Signed-off-by line.

>  t/t0031-lockfile-pid.sh            |  2 +-
>  t/t0200-gettext-basic.sh           |  2 +-
>  t/t1007-hash-object.sh             |  6 +++---
>  t/t2030-unresolve-info.sh          |  8 ++++----
>  t/t2201-add-update-typechange.sh   |  2 +-
>  t/t3300-funny-names.sh             |  2 +-
>  t/t3306-notes-prune.sh             |  2 +-
>  t/t3311-notes-merge-fanout.sh      |  2 +-
>  t/t4014-format-patch.sh            |  6 +++---
>  t/t4032-diff-inter-hunk-context.sh |  4 ++--
>  t/t4102-apply-rename.sh            |  2 +-
>  t/t4131-apply-fake-ancestor.sh     |  2 +-
>  t/t4132-apply-removal.sh           |  4 ++--
>  t/t5300-pack-object.sh             | 10 +++++-----
>  t/t5301-sliding-window.sh          |  4 ++--
>  t/t5302-pack-index.sh              |  8 ++++----
>  t/t5502-quickfetch.sh              |  2 +-
>  t/t5510-fetch.sh                   |  8 ++++----
>  t/t5516-fetch-push.sh              |  2 +-
>  t/t5534-push-signed.sh             |  6 +++---
>  t/t5550-http-fetch-dumb.sh         |  2 +-
>  t/t5604-clone-reference.sh         |  2 +-
>  t/t6500-gc.sh                      |  2 +-
>  t/t7012-skip-worktree-writing.sh   |  2 +-
>  t/t7102-reset.sh                   |  2 +-
>  t/t7104-reset-hard.sh              |  2 +-
>  t/t7113-post-index-change-hook.sh  | 12 ++++++------
>  t/t7201-co.sh                      |  6 +++---
>  t/t7400-submodule-basic.sh         | 10 +++++-----
>  t/t7407-submodule-foreach.sh       |  6 +++---
>  t/t7412-submodule-absorbgitdirs.sh |  8 ++++----
>  t/t7602-merge-octopus-many.sh      |  2 +-
>  t/t9001-send-email.sh              |  6 +++---
>  t/t9400-git-cvsserver-server.sh    |  6 +++---
>  34 files changed, 76 insertions(+), 76 deletions(-)

I'd recommend significantly shrinking the number of files you convert to
at most a handful in this series. The conversion to use the
`test_path_*()` helpers is something that we mostly hand out to
newcomers as the usefulness of it is really rather in the educational
part rather than it bringing a lot of value to the Git project.

> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 463b38f990..e6d1fe3e13 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -271,7 +271,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
>  
>  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
>  		'files over 4GB hash correctly via --stdin' '
> -	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> +	{ test_path_is_file big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
>  	test_oid large5GB >expect &&
>  	git hash-object --stdin <big >actual &&
>  	test_cmp expect actual

This is wrong. The intent is that we only generate the file if we didn't
already do it beforehand, so it's a form of lazy creation. So it is
expected that the file may not exist, but with `test_path_is_file` we'd
now generate an error message if so.

Likewise for the subsequent changes in this fiel.

> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index 7d443968e3..cc213c04a1 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -28,7 +28,7 @@ t() {
>  	file=f$1
>  	expected=expected.$file.$3.$hunks
>  
> -	if ! test -f $file
> +	if test_path_is_missing $file
>  	then
>  		f A $1 B >$file
>  		git add $file
> @@ -40,7 +40,7 @@ t() {
>  		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
>  	"
>  
> -	if test -f $expected
> +	if test_path_is_file $expected
>  	then
>  		test_expect_success "$label: check output" "
>  			git $cmd $file | grep -v '^index ' >actual &&

Likewise, these here are expected cases where the file may be missing.
We shouldn't print an error message in such cases. There's also a couple
more such cases.

Thanks!

Patrick
