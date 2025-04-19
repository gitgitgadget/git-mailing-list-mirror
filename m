Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D41DDA1B
	for <git@vger.kernel.org>; Sat, 19 Apr 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745099684; cv=none; b=QvwdnpC5vIAHkP/Ss8sEB9fFNd8FWHueW6WcH70Z3fwau0pUDFTRNvMe9x8XHgKLaZMybvpcErW1Ytyw9kg0cVR6/HdR5Y7NullVc9AzpbIB0f//wUJs/erZv+t9Mmnm+gEKZlAP1tr9qwEgCIUz5Cehx1BV9YGCu5TdOoOK0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745099684; c=relaxed/simple;
	bh=D0cAN2EsBsan5d7n09Me/mz6C1xOGIyLuKEsdlYMP30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mfhn7ECB4oZAHedP+HYztqrUk1m75YM7wSQY431UdYoqIXygsDDeo66DMrn9Jdn7+jJfJngeDQeWTCqO0BJTEgqL0Y54lmvHdtwb1/lUBCDvXqmwqeMWujxN8purvb/gO2kBXZ5iK1gSnNw0WcZa8JJT6YVbxHcA13Cuh6Nhdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZUDW+ge+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efs40a9L; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZUDW+ge+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efs40a9L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 157081140173;
	Sat, 19 Apr 2025 17:54:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 19 Apr 2025 17:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745099679; x=1745186079; bh=bMJV0qTCTh
	OtratbcSnXgyy0bKB2cOXW+sKDaEZBH/0=; b=ZUDW+ge+ld9xJqxhpx+iEkoOlg
	WlYg33jZ3IJdr4VS9BuQWLMhDAPyt+hLkWmNLHNUNpQotLq0keXx+uoGLvkJ6Oa5
	2bJFjgfW8fnzl/5nYh5saLLJSlkq6XkeWkuTb7CqLgh/v+A4+xjl2/PxxLaximwS
	05V2I+9S4sr+cJkvCQJW3QCqHWbLinbBvC4v10uFgVwXVzvWKsRxlbtiqn7dm3HS
	PBN+rvZ9hw767P+cjfuHjiWHA7c96oomnPl9O+vT7czpEN00BRNHU0Ugwdeh4ZtO
	tXFyVLLHRQtERDco5lF7yEi1diEg7B2O7YWhxxeGdmDVGccjTDZkvzvaYCtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745099679; x=1745186079; bh=bMJV0qTCThOtratbcSnXgyy0bKB2cOXW+sK
	DaEZBH/0=; b=efs40a9LrTZWeFhAW3w8/+gbmT2KSL1cmUUkIAba76dU/DQk5AY
	5+ZcbQ6Oj01jw7BeRw1P+bu+6ivTCgZ1W6HNoVCnP/99BPCncM2hv65Zrqk0IMbK
	aWbNij2m3KAjeaex75+K0RNVR4mJze2BMV2Db2R+STx46MqUt1x2q+k1iGw9Pcd1
	7bIhx8Zn4DmBpQS7EhCdU/L7KTa/v9LpJOC4/hyLm+sESI9Tm3Pi94Rbi5FMOW0c
	+f2YAu/Ji8k7nSd0gq6FPpgv9h+OI7x9B188CvsDbdrIER8KyLuQxn9z0ZI+dTtY
	vW+pDlGAdyoBbTwNbdt8w8hYC97Hk2bjkhQ==
X-ME-Sender: <xms:nxsEaPxcnOMkO8GZu1jaesHOvKYjL0sMMJaGZvjpgwFWBeVL8_heLw>
    <xme:nxsEaHQbZO36AuM2LUoCiFDFaWWhx5PCesPrnInqiN5zf8CFNzHOUUfnBmA-yeZQC
    jhrG8Mbx5EZKAsSTQ>
X-ME-Received: <xmr:nxsEaJVAmuJr8zvbBLueGXnHcLJqf-4IO0JU8_W6Ajgl8zOC2xWlme1a2UQ7dDUl-KgT_8nIhc8_W14uCA4AYetf4CYjEojNbnZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsohhfthifrghrvgeslhhftghouggvrdgtrgdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nxsEaJjJ8hUa7KlQeGk3GOsUN1Ol-Wlv9ytxNQmbFn8nm71D4P-EOA>
    <xmx:nxsEaBAq4l1o0HZnk5s2OO6qmwSD5n3aE5oLje1RgHGu0ZmcUO00Wg>
    <xmx:nxsEaCLlvFJAkrSSwNwIIEocLOMJDz0BzWNvGd-EgWh_uFR2DN3DyQ>
    <xmx:nxsEaACtPxqYyqhP2znd1gyCK2ag7R0ReoStBrRW_Gs8pHxb3McNsQ>
    <xmx:nxsEaJFl1L9cGlUEtesEiJzcNPz0xLQthaoIiG81lTFJS8euYPR6hMXW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Apr 2025 17:54:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "jade via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  jade <software@lfcode.ca>
Subject: Re: [PATCH] builtin/blame: ignore nonexistent ignore files
In-Reply-To: <pull.1947.git.git.1745088194384.gitgitgadget@gmail.com> (jade
	via GitGitGadget's message of "Sat, 19 Apr 2025 18:43:14 +0000")
References: <pull.1947.git.git.1745088194384.gitgitgadget@gmail.com>
Date: Sat, 19 Apr 2025 14:54:37 -0700
Message-ID: <xmqqo6wr95r6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"jade via GitGitGadget" <gitgitgadget@gmail.com> writes:

> It's currently a problem to put blame.ignoreRevsFile in a global
> gitconfig, for example, to use the GitHub (and other) supported filename
> of .git-blame-ignore-revs by default if present in a repo, since the
> current implementation exits the process if it fails to open the file.

Well, that is how it is designed to be used.  If the file you
specify does not exist, it is likely you made a typo, which you
would want to be told about.

I however am somewhat sympathetic to the cause.  If the user had a
way to tell Git that they know what they are doing, it would make
sense in certain situations to allow the paths they specify, either
from the command line or in the configuration files, to be optional,
without triggering "no, there is no such file, perhaps you have a
typo there?" error.

Having said all that, I am not interested in the design and
implementaion presented in this patch at all, for many reasons.

 - The code essentially duplicates the loop that goes over the
   specified files.

 - Unconditionally robbing the typo protection from existing users
   who expect the command would refuse to start when they
   misconfigure is not absolute no-no.  We would have some way for
   the user to say "I am giving this path to be used, but this is
   optional. Instead of failing, just pretend I didn't specify it if
   it does not exist".

 - Singling out the ignorefile configuration and treating it
   differently from the command line option makes things
   inconsistent.  Perhaps people may want to do

    [alias] fooblame = blame --ignore-revs-file="foo"
    [alias] barblame = blame --ignore-revs-file="bar"

   instead of using a single configuration variable, and somehow
   want to mark them to be "optional".

 - The situation where users want to specify a pathname for a file
   that is optional is not limited to blame.ignoreRevsFile.  Any
   codepath that takes user-specified/specifiable pathname (or blob
   object name) should benefit if we had a single consistent way to
   tell Git that the path is optional.

An alternative design that goes along the following lines may be
more palatable:

 - The way to spell for the users to specify a path that is
   optional, either as the value of a command line option or a
   configuration variable, is to prefix it with ":(optional)".  E.g.

    [blame]
	ignoreRevsFile = ":(optional).git-blame-ignore"

    $ git blame --ignore-revs-file=":(optional).git-blame-ignore"

 - For command line options, all commands that use parse-options API
   would automatically benefit by updating parse-options.c and tweak
   its handling of OPTION_FILENAME; when the specified string begins
   with ":(optional)", you strip the prefix and see if the remainder
   or the string names an existing file.  If it does, you use the
   filename as the value of that command line option; otherwise you
   pretend that the option didn't even exist on the command line.

 - For configuration variables, you update git_config_pathname() to
   do the same.

Thanks.
