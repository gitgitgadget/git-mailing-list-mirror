Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449C2BEFEF
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610445; cv=none; b=ZbNOUVXR+EYh12elB5JOv0NKkLHfewgPDmrDUDS//ctkBrXOU49MmuyqyehgDtWsBY9qVatZzZjpW4LMz55cdbBfzcF5KHYnI9dz5PU+VoYHyUpbE18ypEYPXmcrgroaq3wpZ/qcACzbZkFfNGBLe0kAqIS5AQiKHpcI2tn7itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610445; c=relaxed/simple;
	bh=5jP20+mfdgpzHqvdPNE2tLC3HXykdZUmFCeoTec8nQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xp/YFfMi/yhMkzAI8s4/IUw/NxpjhOprDsvT9h/cqxvYXHzXd4YaPEHSY/AIXBvCZFdP8ye/jRipkx/ISLfUoGrOiCEPQhli+LA+cRkWyKtoRtV82evGBFTVweklwzKoVQWjmDG4WPPPAqUh+mgs6xPYNzxcKqI4asnvB0vgYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wmv6x/br; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQOxAvs5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wmv6x/br";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQOxAvs5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0168C7A0177;
	Fri, 20 Feb 2026 13:00:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 13:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771610442; x=1771696842; bh=l5swH+36br
	erV0BAIwV5lyiMb8KqRl+H9DcbPdsK5J4=; b=Wmv6x/brKS78s6DvNJ5TdS0rZf
	ddOUKAX/J3ddIH/lkVO8TcPoxVork0SZd9NnYp/VKdpJBLxxDwuCi9NIUNBvWIBv
	oiWO9DeVcZ0I6rb8snj/SXnmw7g9+EB1RbJ7iruh+C/FJnh0/ONdoXNLeIMVfrET
	+EYHCYz+VINCF+qtXcAnfy/YB457uEn89n5svnFnO8JhgWpG034Sfwe5P1CQyYiq
	7+KobmeRcTr5XAD3usUu2sU/kM7pi9AHUMCCIfHNatNJGsQnveE1+oVIO2+/Bfa8
	6E+O8UbLG1u4gjhn3NxztcX4uCk6QvSxRGdkq0J/I2slMZ6K4Iytb7ztk5qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771610442; x=1771696842; bh=l5swH+36brerV0BAIwV5lyiMb8KqRl+H9Dc
	bPdsK5J4=; b=NQOxAvs5TyXvtc+Ylnnwtyv0DBsEs6DObVSEGVYvNhYXKscydrV
	J0clpQ8UmNdVV34z9pTPmQ2W/IsRR0/CSdcuSIdlGCs5luqHLMhOYY4T65K5kY0M
	QgOPU8BRC+o1rOuJOYr8bo/QFoXLvwAQQHboCJw3LmHhlXwW59q+8gXM7PacQ4fF
	s1zC719xcluQGMExXGtg5smRPo5mh0u7+gA4D5WEVuO4ju5Iky7L13XKPSZ5RjTH
	R10bEQ16gZDfx0AeaPPLRIDmOS/gj6LQrsrNpJgy9Qg5wXSl0JWmDsFJEhPB9d/G
	zuyBUCS/Dz7EBCTNNH7iHQFBUNj8C5G1DXg==
X-ME-Sender: <xms:SqGYaSh7vNpaCZK94beFQVP_1XRCIYARQrTu5Ut_tGIR6UNYz2bDEg>
    <xme:SqGYaaAg9RSjBeD1L0jVy3Diei6tt1ni6m79wiZI9mF-2QiCEW9WYbvdVAjc5JGcc
    63ngGH0xPrnH3IlDH7KlTgfFBHRzHx_yeghoim5_pfc6LM-ADifEQ>
X-ME-Received: <xmr:SqGYafGxGGnd27SamGkzVGTjOVNKC4m_KzSJLVocK7i5ZgyDadzXeP1EH5OR0J2fA-u52n1fTD_Z_of9lVnZ_6aau9YmyARQSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SqGYaaJXrtA_FN6bYR5r1XgC9PqcLRo6LuhKYvE1vTEAktMmiBkynQ>
    <xmx:SqGYabkRkG_Bu7mlffN5SGaT7Ldbt5o87hWyS_xzoyC3K0HrFiJ9PQ>
    <xmx:SqGYaaQPZgN5UKLfmHc0kGxYNQdFf4Fy0ZbsSjUttZcYt9LV7DWVjg>
    <xmx:SqGYaVIUnU_JLWUA2_bEUMKJquI_XT7lFtgADXj6wsHvNP7crO-uFA>
    <xmx:SqGYaWlPQqw6zuEtF_MiS8evnkCSwTJxZziwBr8PdVg-x1wz6JsoqkRi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 13:00:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v8] setup: allow cwd/.git to be a symlink to a directory
In-Reply-To: <20260220164512.216901-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sat, 21 Feb 2026 00:45:12 +0800")
References: <20260218124638.176936-1-a3205153416@gmail.com>
	<20260220164512.216901-1-a3205153416@gmail.com>
Date: Fri, 20 Feb 2026 10:00:40 -0800
Message-ID: <xmqqfr6vxpkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Currently, `setup_git_directory_gently_1()` fails to recognize a `.git`
> symlink pointing to a directory because `read_gitfile_gently()` strictly
> expects a regular file and returns `READ_GITFILE_ERR_NOT_A_FILE` for
> anything else, including valid directories.

I have to admit that I was not paying too much attention to this
part of the proposed log message.  We kept seeing the above (and the
title) for the series forever, but is it really a problem if we did
not allow you to make a symbolic link to somebody else's .git/
directory?  Besides, I do not think we have such a problem at all,
as read_gitfile_gently() uses stat() not lstat().

	Side note: In any case, we do not want to see "Currently".
        We give an observation on how the current system works in
        the present tense (so no need to say "Currently X is Y", or
        "Previously X was Y" to describe the state before your
        change; just "X is Y" is enough), and discuss what you
        perceive as a problem in it.

I just did this, and it worked just fine as expected.

    $ git clone https://git.kernel.org/pub/scm/git/git.git/ git
    $ mv git/.git git.git
    $ ln -s ../git.git git/.git
    $ git -C git log

Even if there were a problem in making such a symbolic link work,
these days we have a textual "gitdir: $there" file as an official
way to let you keep the repository data on a filesystem that is
different from the filesystem that hosts its working tree.

Anyway, I've always thought that this topic is about addressing the
two NEEDSWORK comments to allow us to give better filesystem problem
diagnoses.

> Fix this by distinguishing directories from regular files and other
> non-regular file types (like FIFOs or sockets) via newly introduced
> error_code.

So, "Fix this" written here does not resonate with my understanding
of what we have been discussing so far.  Puzzled.

> diff --git a/setup.c b/setup.c
> index c8336eb20e..2869d10669 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -897,10 +897,14 @@ int verify_repository_format(const struct repository_format *format,
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  {
>  	switch (error_code) {
> -	case READ_GITFILE_ERR_STAT_FAILED:
> -	case READ_GITFILE_ERR_NOT_A_FILE:
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +	case READ_GITFILE_ERR_IS_A_DIR:
>  		/* non-fatal; follow return path */
>  		break;
> +	case READ_GITFILE_ERR_STAT_FAILED:
> +		die(_("error reading %s"), path);
> +	case READ_GITFILE_ERR_NOT_A_FILE:
> +		die(_("not a regular file: %s"), path);
>  	case READ_GITFILE_ERR_OPEN_FAILED:
>  		die_errno(_("error opening '%s'"), path);
>  	case READ_GITFILE_ERR_TOO_LARGE:
> @@ -941,8 +945,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	static struct strbuf realpath = STRBUF_INIT;
>  
>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;
> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}
>  	if (!S_ISREG(st.st_mode)) {

All of the above are exactly what I expected to see.  Nice.

> @@ -1578,20 +1588,28 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> -		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> -						NULL : &error_code);
> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
>  		if (!gitdirenv) {
> +			switch (error_code) {
> +			case READ_GITFILE_ERR_STAT_ENOENT:
> +				/* no .git in this directory, move on */
> +				break;
> +			case READ_GITFILE_ERR_IS_A_DIR:
>  				if (is_git_directory(dir->buf)) {
>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
>  				}
> +				/* otherwise, it is an empty/unrelated directory, move on */
> +				break;

This design decision may be debatable, but not tightening everything
at once may be a prudent thing to do to avoid accidental regression.

Having said that.

If you have a directory ".git/" somewhere in your working tree, and
the directory is somehow corrupt that is_git_directory() says "nope,
that is not a valid Git directory", wouldn't you rather want to know
about it as a potential problem?  Perhaps there are valid use cases
to have such a directory (you have "empty" listed here, which may or
may not have a valid use case), but it smells like falling into the
same bucket as "Gee we have .git that is a fifo here---what is going
on???", which is ...

> +			default:
> +				if (die_on_error || error_code == READ_GITFILE_ERR_NOT_A_FILE)
> +					read_gitfile_error_die(error_code, dir->buf, NULL);
> +				else
> +					return GIT_DIR_INVALID_GITFILE;

... what we do here.


So, I dunno.

> +			}
> +		} else {
>  			gitfile = xstrdup(dir->buf);
> +		}
