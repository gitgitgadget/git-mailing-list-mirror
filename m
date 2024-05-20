Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0628E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221180; cv=none; b=ihiv229iSeQzMkwfDbSWPrlPdUj53iLw1NeM8t3vqKY6hgyOLr/D9EsryMngZynF31cJ+rhtkdK19p+xxyw17r1rguY4OLaFFmqJLcq6JDzy+YOviBHG6W3BqEKQvyaDV9+5GuBPrkol9NJMRY53uwN/1hwqrJlabfcggmXQzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221180; c=relaxed/simple;
	bh=D4Q0hSCf2+Pbi5zCP5cdlS0mdAGJst5zCzl/CBhd5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBqIkmyXJZOX5e364DTZszPzx3cDOFavpSMAJ1+i3HTsCI0vdn8XLcl5a6zq7EaGVh4mG96/sg5EJfb4AqjlobQfVKXsVeFUXtQ9T3UMYeshEssDqa6Ar2Fb5883ounVDMX8jY+MHLqmcikOjwWdJFy9anCXgriRH/PfjfOOC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=Ir/Bu0KU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="Ir/Bu0KU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716221162; x=1716825962; i=tboegi@web.de;
	bh=2Q1upCM+3AsLMkFG8G93sKPBpW/XoKWQIaKmym3VYII=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ir/Bu0KUxy1x6bO92f2nZF69nC9fvQHvx2iPru7aZz9FX6nJdIwuUB3/SY1WpJTQ
	 2BEUzkwklV3+7cMfwHdOc+Da8pC1Cez5z13xwA06l8NgRuH42HNzW6WJOi25J9tq5
	 SykGufckrBiQTSlhXjQkCd0rFNaadwrEuncjMSI8a6R4cyVg9FWYLTH/sw2crXNoP
	 Vlg76KS6h2xC5ncboQdS3fRH3Lp5ybgnO71WCguWkBuPQ2hkKrC2R/xk4IMURrynG
	 I4hcXSQMOQCbOjioUH/xPbSKMTmjibrSEMETxgkeGNxMpUiKx+rr+qBVaVegoiOCS
	 yjR0sHPCjA7xIjKorA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([213.65.201.17]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1svqP72RYV-00oMZP; Mon, 20
 May 2024 18:06:02 +0200
Date: Mon, 20 May 2024 18:06:01 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is
 NFD
Message-ID: <20240520160601.GA29154@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240509161110.12121-1-tboegi@web.de>
 <98AD4B35-ECE2-4349-AEA9-86F5CA52EA9B@kba.biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98AD4B35-ECE2-4349-AEA9-86F5CA52EA9B@kba.biglobe.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:MnNGFrVxacyaxmgGR0/CDDG+Kl5prmLFXmPaeJGpJjm5n07g/Ek
 xiVWvhNMSy8bt10YG5CokAzz952pCp7m0t+6tZjhqWXGcVzJPq+f3I99pYv4O7E3jeob2zK
 orHCeniRGcWC+js8dB2JrLeIjktc6RtkGJidYk2WPothBESk6m2sO0KBBNXBdZcWlyEltmJ
 VnHDrmpHCKBAX6uQ11pDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ySORtgeftek=;fsVdiU6niK9we2BrR0pcDyh+1/l
 C2YFKqTkZsoYn/TN/ary+VUy+nvo5oqqeoF8DD9d6lM8u4v2Oo/MaDyc2jPZA4+Zi0T7JXeYy
 cggaUSvQeVKaOsz2PDkptS9nG66xWobjAxrQ9+V4rTDVCOdxyh7KdTIfuqvJVNRJVhGoXnO8K
 ACBC+YFF9zT0e8ijVSKf1tiMRlhxqnlnM9kjgXjElwt0hgqvIkLNO4qW/D6YhbgDqCQLUD9k8
 X2wABv2oRgpEbd+HSMGhbHhV4vRu7fOQ03Z1rrq//k0ylp2Al5ywTUDDteM0BFZKu0d/gfcFB
 O8Vuyhv8H/bnML3e90VIzB3LiwQab3NaCHjMH5eH63xZ8yXAHfPfdHl1qZBbWdhP5WAwisWPx
 +iIZtAxquiUlLwS0h6EW5n8i+rT16if4UYwLgUUjAbGUGmN5YdeL/sGca6wkiBwxmQ7zRIXPH
 3H5dQkdni3X1Fk/litXdVC/7U/+Mv4wVP5QTl/oKQln2eQzq4xvuWMG/1eZ945PPvjBlSzAEa
 fMz6wbNG2fXxOshkXA4Qo2sXaA1BQchgSt1IKMcuAJGdtMG4m4UMIaJmScLO5dDkGI8mkFvLU
 kOGIY6sdh2PB/3y4JKMJb1WKy/BTiR3OwrTODSlS971+pU102ZPuJ+2CB4cceAtORUVTJcUYF
 QQ4ppbypAFnX3wM3uEc0nX+FpMlrmDLwaPPAyIXXkuO41dM50cHJs0eC4wfViG91rxTWVqWMr
 C7Tw74K5G8JBR8/kzahxm2Y32aRXc6WrkmNrYRjy7iXa0YNEtr582U8LSVVzYYqaCISQFxHyo
 M+B+P/ML4/WgBEDpaKrTQiMbsX6eiNAPKm0qNDfb2wK5A=
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 04:03:03PM +0900, Jun. T wrote:
> Sorry for not responding quickly.
>
> Thank you for the patch, but it seems the problem still remains.
>
> Although
> % git ls-files NFD
> (apparently) works,
> % git ls-files NFC
> still gives the error
> (if core.precomposeunicode is not set in global config).
>
> The following is some info I got (hope it is correct and useful),
> but I have no idea how to fix the problem.
>
> precompose_string_if_needed() works only if:
>   precomposed_unicode is already set to 1, or
>   git_config_get_bool("core.precomposeunicode") sets it to 1.
>
> But git_config_get_bool() reads the file .git/config only if:
>   the_repository->commondir is already set to ".git".
>
> Back trace when the strbuf_getcwd() is called for the
> 3rd time is (frame #4 is set_git_work_tree()):
>
>   * frame #0: git`strbuf_getcwd(sb=3D0x00007ff7bfeff0a8) at strbuf.c:588=
:20
>     frame #1: git`strbuf_realpath_1(resolved=3D0x00007ff7bfeff0a8, path=
=3D".", flags=3D2) at abspath.c:101:7
>     frame #2: git`strbuf_realpath(resolved=3D0x00007ff7bfeff0a8, path=3D=
".", die_on_error=3D1) at abspath.c:219:9
>     frame #3: git`real_pathdup(path=3D".", die_on_error=3D1) at abspath.=
c:240:6
>     frame #4: git`repo_set_worktree(repo=3D0x000000010044eb98, path=3D".=
") at repository.c:145:19
>     frame #5: git`set_git_work_tree(new_work_tree=3D".") at environment.=
c:278:2
>     frame #6: git`setup_discovered_git_dir(gitdir=3D".git", cwd=3D0x0000=
000100435238, offset=3D16, repo_fmt=3D0x00007ff7bfeff1d8, nongit_ok=3D0x00=
00000000000000) at setup.c:1119:2
>     frame #7: git`setup_git_directory_gently(nongit_ok=3D0x0000000000000=
000) at setup.c:1606:12
>     frame #8: git`setup_git_directory at setup.c:1815:9
>     frame #9: git`run_builtin(p=3D0x0000000100424d58, argc=3D2, argv=3D0=
x00007ff7bfeff6d8) at git.c:448:12
>     frame #10: git`handle_builtin(argc=3D2, argv=3D0x00007ff7bfeff6d8) a=
t git.c:729:3
>     frame #11: git`run_argv(argcp=3D0x00007ff7bfeff54c, argv=3D0x00007ff=
7bfeff540) at git.c:793:4
>     frame #12: git`cmd_main(argc=3D2, argv=3D0x00007ff7bfeff6d8) at git.=
c:928:19
>     frame #13: git`main(argc=3D3, argv=3D0x00007ff7bfeff6d0) at common-m=
ain.c:62:11
>
> At this point, precomposed_unicode is still -1 and
> the_repository->commondir is still NULL.
> This means strbuf_getcwd() retuns NFD, and                              =
        the_repository->worktree is set to NFD.
>
> Moreover, precompose_string_if_needed() calls
> git_config_get_bool("core.precomposeunicode"), and
> this function indirecly sets
> the_repository->config->hash_initialized =3D 1
>
> Later setup_git_directory_gently() (frame #7) calls
> setup_git_env() --> repo_set_gitdir() --> repo_set_commondir()
> and the_repository->commondir is now set to ".git".
>
> Then run_builtin() (frame #10) calls precompose_argv_prefix()
>  --> precompose_string_if_needed(). Here we have
>   precomposed_unicode =3D -1
>   the_repository->config->hash_initialized =3D 1
> This means git_config_check_init() does not read
> .git/config (does not call repo_read_config()) even if
> the_repository->commondir is set to ".git",
> and precomposed_unicode is not set to 1.
> So the NFD in argv is not converted to NFC,
> and
> % git ls-files NFD
> apparently works.
>

Thanks so much for the detailed analysis, that is appreciated.
To be honest, I have set core.precomposeunicode true globally,
core.quotepath=3Dfalse, together with settings for
pull.rebase and init.defaultbranch

Because of that, the new testcase passed, and the patch was in
improvement.
However, it would be nice to have the case fixed as well,
where core.precomposeunicode is not set at a global level.

I am happy to provide a patch (a new testcase is already there),
but for a change in the codebase I would need some help from an expert,
to get the config-reading right both for hash_initialized
(that is may be not about the hash-algorithn at all ?)
and precompose.





