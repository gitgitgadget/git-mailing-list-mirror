Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2473783B4
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861391; cv=none; b=fRNuWXwadODfk408iOPWVGJOl8bIVxiUWQ2N7O1BChUivLDQXEYVBenQqZHO/ydBnig/iuqD3DYQ4bY36ftTgGb9Gv9Et+wcret4lduhO9ZYzwwtP2rUbsE1XhGG66Um0wuavuXfLRK0CBYWKKwXspgCNbeLFzkGIQ9Py8Rm5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861391; c=relaxed/simple;
	bh=HIkJisONdVVHhrhLvsKNlVCrH/YXgoChy7dZsjoccAU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Yn9CUn0n4nyEDQ4M48973R5LMhBe7s7BhxBqZ125EUvSobVC3ihHdlGsuLJB5vb7nxje5RG8gIH6FDYWo9Tcf6+tjzZsjmGINSgy9o8iMYC/86AIqwqrZPc03e8DBvoz3KjU7uewbVmKqzY2zmJ/8BZ34zc/I8URieST4bnbYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPWDhTDu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPWDhTDu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d712281f8bso3084595ad.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787861389; x=1788466189; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cJC0ycAbKlexHsRdRcKuk7xKuhoqLGIpSmJbZDE9dmQ=;
        b=GPWDhTDu35tvHtt+IRjPfmDj9kZQmtsNmpav8gkPzyDK1rjltzXtkibU8kADJWAUlo
         9qMMfvAMuS06qnB20xu6YJYJcUrWUrxaGWEe84mTinOwGlYIpqtgs3McZEexZiAoa+KR
         JMgdd1UR69EjmG2HjinkkkpxjtO5fu1RlstxZfrTIZglgwLWSe0kKegJ2KL5eG6yQwk+
         +LYII+fOD2VlfjMsqCwZUWCkHqZeGVBwe+reH35F1n5olDSfui5vhST6H7msGYOyU6JL
         yUvbs8lvU1TCb8qM+P5T2LjhIg0HvaDy80tdSp6SN36gCgrcUjGfLdbtOj1NAP4VLc0v
         zigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787861389; x=1788466189;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJC0ycAbKlexHsRdRcKuk7xKuhoqLGIpSmJbZDE9dmQ=;
        b=hPLffHKsIqgx8utWiEImN5B7O3dOKRvYWHyZzTjaKj3AqHtsrXPV3rzzODRia3eT3m
         NKwp4DuX7PQH57aChPDd3/7BSp1/EqmyxREKcXTO5aD0Fo6lt/zvlRewcdLQ28K4Oex3
         VOgHoRWQC8AZ93h5qIBcp6Dl3Azk/eH0VZbq4mngyO5X5klHkddDI7H7QnF/1A/K8wYQ
         +HTzP66vyo67s0d+3j/crFYBwElzz19rna+YMbVIxKRjYT1RjIdWKEZgdiYHd5jh7MX8
         HLz5YJ7KtsxctT2yjawq/+NlfxjPiYmBCfCTEDrLyfjsscJuro/wzTkg6o3KNaHjHPAi
         I3qQ==
X-Gm-Message-State: AFuF++mvID3upY3CL2yNYbFb84zrl0Nr5ieatYj4tt/5qygqrnxYr8e8
	o2R22W3fz2/hvE8MtKClhCTmcEgs1BSZFMt9H/c9/pE/F9+LTsJmtB3riXno6g==
X-Gm-Gg: AR+sD13l/bQF9QipUOV1ArREFun6G+FUyZAB2HhWtZSQdWDqTxqfuffsF6rvW11PcWi
	iX5R8hD/IlqhPDJ9YYSEj1OBHXKP8jawOa2EZeAEC7YVyOq5P9KyVA6aQd4vVhRBgxnjF00hhkc
	soad7iOJLv4VIUlMpb4heZuuPIZuZUUcLJHS6R1m9GiCW17uPm8UGS/2tt1+mq/i3eJhqOqe/EF
	7toGVWzAOd2irAjs5c277DMGF/znky+Af1uXVw+8ltxTTE5aUjD4RTxjhe+SbkiRDArSUvG9og2
	SRKwfkbSYwlFPu1L+9da84Lzj3KAxOvITojHNDNUBIUBKoV2QdeCjq5j9SXYYypffehT3lWkIo6
	ZTwdIwtG1ad4gziLDuULopyTRV6nsLQ7Ugnp/UI+MBMyU6U2aSMOR+RdIr4iX5M5aNLwZiEAXjN
	WV4tCDNBWWahzvzJxLe1qPXDGKtJdExVzJUZd3NljXK+DRMnlvX6OlEPmf3g==
X-Received: by 2002:a17:903:13c7:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d74dee93abmr27515655ad.10.1787861388586;
        Thu, 27 Aug 2026 13:09:48 -0700 (PDT)
Received: from localhost ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm34552016eec.6.2026.08.27.13.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 13:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 01:39:43 +0530
Message-Id: <DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
From: "Hardik Kumar" <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
 <xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
In-Reply-To: <xmqqh5kf8hqc.fsf@gitster.g>

On Fri Aug 28, 2026 at 1:21 AM IST, Junio C Hamano wrote:

> I guess this was a bit too short, so let me explain in a bit more
> detail.
>
>>> diff --git a/builtin/blame.c b/builtin/blame.c
>>> index 48d5251c6d..dbf4b4ffc7 100644
>>> --- a/builtin/blame.c
>>> +++ b/builtin/blame.c
>>> @@ -957,7 +957,7 @@ static void build_ignorelist(struct blame_scoreboar=
d *sb,
>>>  int cmd_blame(int argc,
>>>  	      const char **argv,
>>>  	      const char *prefix,
>>> -	      struct repository *repo UNUSED)
>>> +	      struct repository *repo)
>>>  {
>>>  	struct rev_info revs;
>>>  	char *path =3D NULL;
>>> @@ -1187,7 +1187,7 @@ int cmd_blame(int argc,
>>> =20
>>>  	revs.disable_stdin =3D 1;
>>>  	setup_revisions(argc, argv, &revs, NULL);
>>> -	if (!revs.pending.nr && is_bare_repository(the_repository)) {
>>> +	if (!revs.pending.nr && is_bare_repository(repo)) {
>>>  		struct commit *head_commit;
>>>  		struct object_id head_oid;
>
> There are a handful of uses of the_repository before the execution
> reaches here.  But you left them unmodified.
>
> The original code used to consistently used the_repository.  Here
> you changed it to use "repo".  In practice, they are most likely the
> same when "repo" is not NULL, so in that sense, this may not be
> breaking anything, but you must ask yourself what the point is,
> unless you convert all uses of the_repository with "repo".  It does
> not help libification effort at all.

My main goal here was to start small with by removing the dependence
from `the_repository`. The other instances are obivous left out which
makes the patch seem inconsistent but I suppose those functions are the
ones that require execution before the flow ever checks for the value of
`repo` and so they rely on the global one instead.

> In general, builtin/foo.c::cmd_foo() are concrete programs that work
> on specific repository (i.e., the_repository), and there is not much
> reason to rewrite the use of the_repository to use "repo" given by
> the caller which is git potty.  You'd also need to deal with the
> case where "repo" is NULL (hint: "cd / && git foo -h").

Right, but would safety check be required for single instance or better
to find and work on only the specific ones which could lead to an
exception.

>
> They are quite different from other parts of the system, things
> outside builtin/, many of which are general utility/helper routines,
> many of which should be designed to work with given repository.


