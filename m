Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DB1E0B86
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439125; cv=none; b=huwaO58U198EfJkUJcOe+RNbhYIclN+s6p9YC3it4bRhCjHmOEIz2Zym/r61HnvECtDDB1/j8Yc1p2+XACjJGVoO1pguRlkQrsYy74DuJRSpHoMaB4B3xJ5Hd9QU6d+8FOoV/ctg+AMP3eqRdtmYLHjaxGQE+YznUl69B0RMFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439125; c=relaxed/simple;
	bh=2BdPSVYEyU5vJENSeOKTGGtHkfbLJbz5FPjL/60g2dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYgS/Dk77hNevGV9Izwd7SYulL0/C0BCSSJBEXXOhdOuadBme0lyNO16xzs4EunOv6eIvQfv2CJSa+2sZoWbFMpKcX+8cNZLuf4V441AcJ/8MLUVqjArtiozPYSRQ3cqspWDN2URt/ESUPUuAJYDF71QOoaaRdXdkaSdDk//F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1/JU6fx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFDUPi2B; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1/JU6fx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFDUPi2B"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 919FF1D00031;
	Wed, 18 Feb 2026 13:25:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Feb 2026 13:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771439123; x=1771525523; bh=PjjDALFGLk
	58psn7UrCj/8lEuSknP6UfNoZCs0C1csM=; b=R1/JU6fxw+gv0JznOQ2zlwwLOY
	Zvi/1Vb8CdsVjg8BAUE3P9A1FFcSUwhWp7OfjO22XgdcAvgyu3T8Uj75HVT3SQ2h
	/V2wiLx0gIRHAjOJUCANH/ouXxVCXLEOD/cYqT6T2PtTz1FYUb70JpxUJyzesVn6
	qSyh3yaRT76+vuYCaqanDBEMppfFB/WG8gwSP1iRMHkeUzLYZY+sK4nRoRe+TUlk
	0A/jt27N9C/YqvjdtGDHcaLjp7pWuA/bHdEtkSYpjuDl6WVFFJb6VDG7O6ALeTK+
	v/2EDcZuZ1PMZN2tOaNUQF7oYXQnocIWtCnrJeR47YUsnW1z2R79qNQJIqRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771439123; x=1771525523; bh=PjjDALFGLk58psn7UrCj/8lEuSknP6UfNoZ
	Cs0C1csM=; b=hFDUPi2BZ8b35FSk7LS0QpNspkYP0wcysspIWONdVAjW2u41av4
	DIwbD9uu6iWrhjRjEMuBspbjyNNP+90m5LOcM6o/9JtGtigOGAvXr8JI7SKcmHwN
	N2PGu9L6BNexPQkjf3G3aymg3BbHujMVmXFAzkBkf5YuTey1x9JhhpiG4UyZKq8d
	Q2VsFz4KFlIkPM76nJJU16I1UT7N2Ro/mv8dbo8uFUQqWe8pROOhF+jOlNZcpjMR
	UclPC0HHD8MMF9+Gv8o+9EMIjazlHDKNrkBjRIhb2RqV1ZHIhz+NCKnqtpS+xRnb
	Jq5cFgTiF0g5gzXZKhJzH32bPydw1SYxZCw==
X-ME-Sender: <xms:EwSWaf_2_5B-wcN5e7ZnFn8Pz5gLepRrr2suB9P24j4X9tBbwJ3q6A>
    <xme:EwSWaSsFKO34xpb_VNcW5DQgoPBJN8bVJD1_QlyoQklXMbwFfm7ZHbpFfp9e_e9-c
    xunm1AbueqSGRsqGgOull5x7KNisy-9lbm4ce_rs3p_2q_F4DtU>
X-ME-Received: <xmr:EwSWaSDjPGp4GQupSHzlMvNr6yOEHZV8-F72yTju69heI0vITtHKPEk2CjVpOySnBww5nDoJ-4mW2Santg2UM3_q5ow83lmL_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EwSWaaWCm-qpHo5UOxprpg_F3HryLNPyAELqKVbYrVo3FYsX0uR1xg>
    <xmx:EwSWaQAU9M6YDeAn1OdJ9s-LBzenM3erxTNHkdAwNBslpjDzKNghnw>
    <xmx:EwSWad_ReiagolKZ7O_LjEwD0O4d4YP6_4rQg1NLAyvQMsgAy2dUvg>
    <xmx:EwSWaXHJWB4nezLVp3uaDs0ZbJVRdSctpmjLcwrkIV4-sAgij8Jltg>
    <xmx:EwSWaVgxjwWz_vE9MBLu3_c1kOrofYxBV0muU7wC2ga2zgZKqF9ctEZe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 13:25:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v5 2/2] setup: allow cwd/.git to be a symlink to a
 directory
In-Reply-To: <20260218051850.164972-3-a3205153416@gmail.com> (Tian Yuchen's
	message of "Wed, 18 Feb 2026 13:18:50 +0800")
References: <20260217084124.150366-1-a3205153416@gmail.com>
	<20260218051850.164972-1-a3205153416@gmail.com>
	<20260218051850.164972-3-a3205153416@gmail.com>
Date: Wed, 18 Feb 2026 10:25:21 -0800
Message-ID: <xmqqtsvd7vu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Strictly enforcing 'lstat()' prevents valid '.git' symlinks.

But nobody sane would propose running one more lstat() anyway, so
how is that relevant?

>  		if (!gitdirenv) {
> -			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> -				/* NEEDSWORK: fail if .git is not file nor dir */
> -				if (is_git_directory(dir->buf)) {
> -					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> -					gitdir_path = xstrdup(dir->buf);
> -				}
> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
> -				return GIT_DIR_INVALID_GITFILE;

The _intent_ of the original code was to

    * do is_git_directory() thing to deal with a plain vanilla
      ".git" directory when read_gitfile_gently thing said "we found
      a directory" (NOT_A_FILE is overly coarse, which is what we
      are correcting in this topic, but the _intent_ was to do the
      is_git_directory() thing when we know it is a directory).

    * return INVALID_GITFILE on any error, but do not return when
      the reason why read_gitfile_gently thing failed was because
      there is no ".git" there (again, STAT_FAILED is overly coarse,
      which is what we are correcting in this topic, but the
      _intent_ was to return INVALID thing when we not the failure
      is not due to ENOENT).  Note that returning INVALID_GITFILE is
      done when die_on_error is not set.

> -		} else
> +			if (error_code)
> +				read_gitfile_error_die(error_code, dir->buf, NULL);

Should this be unconditional?  If our caller did not ask us to die
upon an error with die_on_error, what happens?  The original I think
returned INVALID_GITFILE for the caller to deal with.

> +			if (is_git_directory(dir->buf)) {

Should this be unconditional?  If the thing is a directory, the
original would have given us NOT_A_FILE but now it would give us
IS_A_DIR.  And that is the only case original wanted to call
is_git_directory() no?

> +				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +				gitdir_path = xstrdup(dir->buf);
> +			}
> +		} else {
>  			gitfile = xstrdup(dir->buf);
> +		}
>  		/*
>  		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>  		 * to check that directory for a repository.
