Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA6329E4B
	for <git@vger.kernel.org>; Sat,  9 May 2026 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778364892; cv=none; b=dv3EVLvJNnZdHAqkjzuCkUO1Ji5Os3t6tas1+GNjkO2cJDoxMMS2KsrFL/1wICGi/RvGUFAWPc6S5/6izEynB6J1oqc6TqRNSZmnzzMFT7zQRgr1tS7XOifX9mCtNG/kGnpmAWVuSvSgNICIPEMZ/nR+meuiE+eEqGaFZcSoeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778364892; c=relaxed/simple;
	bh=GZnvxJrFGzbSmGDveJH5Hk4cv0J9+0zxr/9M4vJkzrk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bm3L+qhkl/Z/lLOA9qypMMj9Eseg0pZEcyY3GjFKMJq1f4RRPCxkmm6r/8pFOlakFhjOqApnLZr6x1x/oYudr1hzIUI5GD97Jd08Op2Hpd3auRSQEFSaTFzAMb5WHtfqoCFGWa5pciIHlAHZLeIHtoTXKJBfUzTNLQuTQa4vR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Lqos8tST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nAkhSEE6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Lqos8tST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nAkhSEE6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 773C07A004D;
	Sat,  9 May 2026 18:14:48 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Sat, 09 May 2026 18:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778364888;
	 x=1778451288; bh=Imc4MaVdcVshUfL5rGaNFqnmMP05/G1g9jlx/YtGj3I=; b=
	Lqos8tSTsadbqU3Dmqbw7B1qqCh4y7cx4+hh1u9q3g1zOj7JepET0VmfJ1uL+ZaC
	K4YOkcD7jA0wml71QWCxHPoiR5jkLh4rlqUkglmAIaA/WgNe7mUe+krxdJTZj9te
	pYSL8v2Bnw8FWbi59gY8bWQ/UCTP5XWjYzD20N3mgIje10evZAZAzYYUmD68UHUV
	JWDPuNELdP/d9jF1Nb3MtqwcFBwB+kem4+6I3MUOGo/vAekFJNsuseH8/X3MWwn1
	B0TyEaDPb96qN15kBGywYE6sdLA7x4N5KTJ1GleOpEX8oDcpMRC/G9sTMA9ptjaK
	gmW10F95L43Ufc9BWh1Z0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778364888; x=1778451288; bh=I
	mc4MaVdcVshUfL5rGaNFqnmMP05/G1g9jlx/YtGj3I=; b=nAkhSEE6y+lPyU3EH
	SaJnspAVu0IqYA7kLjYvjW7duz323I6RG6plUkBNuaATDlNvJjtRTGShRppRCMY1
	uLLHkpjUqlN7wjFJBD3f26X6/bev0t2i0kkgp8Y+EXSx9NXBLBEVcGz/32JYE/U2
	Ey8DrXXxN9DQ2b+RxHNgzsgC75RFt0YKeBiAkUXR/KW7oajlih9j/LhjSEeSCEf/
	G143fqyjDOwwl3Arhwf2ne4OB3+eWOU7R8GVDZUBGfR+EABI0BtUFesgi275y49I
	POK0WAOcIEfWxeEYt2nX9OD6Dv2abK5iV6lD+YnfwR+/dSRmrR9QTU4lCBN6oCuO
	iSR6Q==
X-ME-Sender: <xms:2LH_aczDBptIX9MTRhW2V796-z6ot_ZhmVp0Dp2_j9GoOHDqZfVtcNE>
    <xme:2LH_abF5aVmQa5Pf8xBFyrla0_l1x8M-JZLZDhMs9wxQ6joZ8y3GxWOo4pupCirl8
    Lm5rUoEEbUMDpfA2CZr6z34aO9kTCWU_7-bNhd_LuulT-Qk5ScKZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    hgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2LH_afe1-Z1DUHfaYbIBOaBw2g9yHgmbmT-v_j3HFqNK4DjcAqnpSw>
    <xmx:2LH_aTKtXLaGoUs4C2qRLFeYLeZ00_7YPPq_ktmH-qheUStqW4jZHw>
    <xmx:2LH_aQEo79gANaL0ZFhOaJmpwkUNe3jrhwqcaUs_jHVuFr1EOeeHkA>
    <xmx:2LH_adrZSJgoBfQnvzjodGl6quMSp3emFZapKMkxQELAAiw-tg-l-g>
    <xmx:2LH_aT3h5HLYPYi78pdG27y7NzARurx2RADcZkfXqE2p8fa0nug9DjlS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0775EC4006E; Sat,  9 May 2026 18:14:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Acu3FUFCGCiJ
Date: Sun, 10 May 2026 00:14:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <b8d57be0-b03c-461c-94e4-02340b5af77b@app.fastmail.com>
In-Reply-To: <20260506101631.18127-1-algonell@gmail.com>
References: <20260506101631.18127-1-algonell@gmail.com>
Subject: Re: [PATCH] doc: fix typos via codespell
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026, at 12:15, Andrew Kreimer wrote:
> There are some typos in the documentation, comments, etc.
> Fix them via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>[snip]
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submittin=
gPatches
> index d570184ec8..35b4952c8a 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -92,7 +92,7 @@ input and avoids unnecessary churn from many rapid i=
[INFO ] 2026-05-06 12:13:18.452 [restartedMain] [userId:] c.n.a.Database=
Migrator - Created measure package with name =E2=80=9CScoring MP w/ cont=
ent package feedback (NIUP-470)=E2=80=9D and key =E2=80=9Cnorse-mp-12=E2=
=80=9D
[INFO ] 2026-05-06 12:13:18.620 [restartedMain] [userId:] c.n.a.Database=
Migrator - Created measure package with name =E2=80=9CScoring MP w/ char=
ts (NIUP-470)=E2=80=9D and key =E2=80=9Cnorse-mp-13=E2=80=9Dterations.
>    topic are appropriate, so such an incremental updates are limited to
>    small corrections and polishing.  After a topic cooks for some time
>    (like 7 calendar days) in 'next' without needing further tweaks on
> -  top, it gets merged to the 'master' branch and wait to become part
> +  top, it gets merged to the 'master' branch and waits to become part

=E2=80=9CIt ... waits=E2=80=9D (verb agreement). Okay.

>    of the next major release.
>
>  In the following sections, many techniques and conventions are listed
> diff --git a/Documentation/git-sparse-checkout.adoc
> b/Documentation/git-sparse-checkout.adoc
> index 0d1618f161..e286584c67 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -134,7 +134,7 @@ the `clean.requireForce` config option is set to
> `false`.
>  +
>  The `--dry-run` option will list the directories that would be removed
>  without deleting them. Running in this mode can be helpful to predict=
 the
> -behavior of the clean comand or to determine which kinds of files are=
 left
> +behavior of the clean command or to determine which kinds of files ar=
e left

=E2=80=9Ccommand=E2=80=9D typo.

>  in the sparse directories.
>  +
>  The `--verbose` option will list every file within the directories th=
at
> diff --git a/Documentation/technical/build-systems.adoc
> b/Documentation/technical/build-systems.adoc
> index 3c5237b9fd..ca5b5d96f1 100644
> --- a/Documentation/technical/build-systems.adoc
> +++ b/Documentation/technical/build-systems.adoc
> @@ -47,7 +47,7 @@ Auto-detection of the following items is considered
> to be important:
>
>    - Check for the existence of headers.
>    - Check for the existence of libraries.
> -  - Check for the existence of exectuables.
> +  - Check for the existence of executables.

=E2=80=9Cexecutables=E2=80=9D typo.

>    - Check for the runtime behavior of specific functions.
>    - Check for specific link order requirements when multiple librarie=
s are
>      involved.
> @@ -106,7 +106,7 @@ by the build system:
>
>    - C: the primary compiled language used by Git, must be supported.
> Relevant
>      toolchains are GCC, Clang and MSVC.
> -  - Rust: candidate as a second compiled lanugage, should be
> supported. Relevant
> +  - Rust: candidate as a second compiled language, should be

=E2=80=9Clanguage=E2=80=9D typo.

> supported. Relevant
>      toolchains is the LLVM-based rustc.
>
>  Built-in support for the respective languages is preferred over suppo=
rt that
> @@ -142,7 +142,7 @@ The following list of build systems are considered:
>
>  =3D=3D=3D GNU Make
>
> -- Platform support: ubitquitous on all platforms, but not well-integr=
ated into Windows.
> +- Platform support: ubiquitous on all platforms, but not well-integra=
ted into Windows.

=E2=80=9Cubiquitous=E2=80=9D typo. (that=E2=80=99s a difficult word for =
me)

>  - Auto-detection: no built-in support for auto-detection of features.
>  - Ease of use: easy to use, but discovering available options is hard.
> Makefile
>    rules can quickly get out of hand once reaching a certain scope.
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index dd2480a73d..806068907e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1341,7 +1341,7 @@ static void write_pack_file(void)
>  			 * length of them as buffer length.
>  			 *
>  			 * Note that we need to subtract one though to
> -			 * accomodate for the sideband byte.
> +			 * accommodate for the sideband byte.

=E2=80=9Caccommodate=E2=80=9D typo.

>  			 */
>  			struct hashfd_options opts =3D {
>  				.progress =3D progress_state,
> diff --git a/commit-graph.h b/commit-graph.h
> index f6a5433641..13ca4ff010 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -18,7 +18,7 @@
>   * This method is only used to enhance coverage of the commit-graph
>   * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
>   * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
> - * call this method oustide of a builtin, and only if you know what
> + * call this method outside of a builtin, and only if you know what

=E2=80=9Coutside=E2=80=9D typo.

>   * you are doing!
>   */
>  void git_test_write_commit_graph_or_die(struct odb_source *source);
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 43b3be0114..6e709bd138 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -85,7 +85,7 @@ const char *precompose_string_if_needed(const char
> *in)
>  		out =3D reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
>  		if (out) {
>  			if (outlen =3D=3D inlen && !memcmp(in, out, outlen))
> -				free(out); /* no need to return indentical */
> +				free(out); /* no need to return identical */

=E2=80=9Cidentical=E2=80=9D typo.

>  			else
>  				in =3D out;
>  		}
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..40e95bccb4 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
>  	if {[file pathtype $p] ne {absolute}} {
>  		continue
>  	}
> -	# Keep only the first occurence of any duplicates.
> +	# Keep only the first occurrence of any duplicates.

=E2=80=9Coccurrence=E2=80=9D typo.

>  	set norm_p [file normalize $p]
>  	dict set _path_seen $norm_p 1
>  }
> diff --git a/git-gui/lib/choose_repository.tcl
> b/git-gui/lib/choose_repository.tcl
> index 7e1462a20c..a4703af028 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -15,7 +15,7 @@ field w_recentlist ; # Listbox containing recent
> repositories
>  field w_localpath  ; # Entry widget bound to local_path
>
>  field done              0 ; # Finished picking the repository?
> -field clone_ok      false ; # clone succeeeded
> +field clone_ok      false ; # clone succeeded

=E2=80=9Csucceeded=E2=80=9D typo.

>  field local_path       {} ; # Where this repository is locally
>  field origin_url       {} ; # Where we are cloning from
>  field origin_name  origin ; # What we shall call 'origin'
> diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
> index c18e201d85..f4cffeac66 100644
> --- a/git-gui/lib/themed.tcl
> +++ b/git-gui/lib/themed.tcl
> @@ -4,7 +4,7 @@
>
>  namespace eval color {
>  	# Variable colors
> -	# Preffered way to set widget colors is using add_option.
> +	# Preferred way to set widget colors is using add_option.

=E2=80=9CPreferred=E2=80=9D typo.

>  	# In some cases, like with tags in_diff/in_sel, we use these colors.
>  	variable select_bg				lightgray
>  	variable select_fg				black
> diff --git a/hook.h b/hook.h
> index 5c5628dd1f..5f0c3f19bb 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -116,7 +116,7 @@ struct run_hooks_opt {
>  	 * While the callback allows piecemeal writing, it can also be
>  	 * used for smaller inputs, where it gets called only once.
>  	 *
> -	 * Add hook callback initalization context to `feed_pipe_ctx`.
> +	 * Add hook callback initialization context to `feed_pipe_ctx`.

=E2=80=9Cinitialization=E2=80=9D typo.

>  	 * Add hook callback internal state to `feed_pipe_cb_data`.
>  	 *
>  	 */
> diff --git a/meson_options.txt b/meson_options.txt
> index 659cbb218f..1ed228d42a 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -106,7 +106,7 @@ option('highlight_bin', type: 'string', value: 'hi=
ghlight')
>
>  # Documentation.
>  option('docs', type: 'array', choices: ['man', 'html'], value: [],
> -  description: 'Which documenattion formats to build and install.')
> +  description: 'Which documentation formats to build and install.')

=E2=80=9Cdocumentation=E2=80=9D typo. Took me five seconds to stop.

>  option('default_help_format', type: 'combo', choices: ['man', 'html',
> 'platform'], value: 'platform',
>    description: 'Default format used when executing git-help(1).')
>  option('docs_backend', type: 'combo', choices: ['asciidoc',
> 'asciidoctor', 'auto'], value: 'auto',
> diff --git a/midx-write.c b/midx-write.c
> index a25cab75ab..6d6d29c6cd 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct
> multi_pack_index *midx, struct write_midx_c
>
>  	/*
>  	 * Ensure that we have a valid checksum before consulting the
> -	 * exisiting MIDX in order to determine if we can avoid an
> +	 * existing MIDX in order to determine if we can avoid an

=E2=80=9Cexisting=E2=80=9D typo.

>  	 * update.
>  	 *
>  	 * This is necessary because the given MIDX is loaded directly
> @@ -1438,7 +1438,7 @@ static int write_midx_internal(struct
> write_midx_opts *opts)
>
>  		/*
>  		 * Attempt opening the pack index to populate num_objects.
> -		 * Ignore failiures as they can be expected and are not
> +		 * Ignore failures as they can be expected and are not

=E2=80=9Cfailures=E2=80=9D typo.

>  		 * fatal during this selection time.
>  		 */
>  		open_pack_index(oldest);
> diff --git a/odb/source.h b/odb/source.h
> index f706e0608a..4958a503cf 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -338,7 +338,7 @@ static inline int
> odb_source_read_object_stream(struct odb_read_stream **out,
>   * are only iterated over once.
>   *
>   * The optional `request` structure serves as a template for
> retrieving the
> - * object info for each indvidual iterated object and will be populat=
ed as if
> + * object info for each individual iterated object and will be popula=
ted as if

=E2=80=9Cindividual=E2=80=9D typo.

>   * `odb_source_read_object_info()` was called on the object. It will
> not be
>   * modified, the callback will instead be invoked with a separate
> `struct
>   * object_info` for every object. Object info will not be read when
> passing a
> diff --git a/packfile.h b/packfile.h
> index 9b647da7dd..6dea707ba4 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -124,7 +124,7 @@ struct packfile_store {
>  	 * that packs that contain a lot of accessed objects will be located
>  	 * towards the front.
>  	 *
> -	 * This is usually desireable, but there are exceptions. One excepti=
on
> +	 * This is usually desirable, but there are exceptions. One exception

=E2=80=9Cdesirable=E2=80=9D typo.

>  	 * is when the looking up multiple objects in a loop for each
> packfile.
>  	 * In that case, we may easily end up with an infinite loop as the
>  	 * packfiles get reordered to the front repeatedly.
> diff --git a/path.h b/path.h
> index 0434ba5e07..4c2958a903 100644
> --- a/path.h
> +++ b/path.h
> @@ -217,7 +217,7 @@ void safe_create_dir(struct repository *repo, const
> char *dir, int share);
>   *
>   *   - It always adjusts shared permissions.
>   *
> - * Returns a negative erorr code on error, 0 on success.
> + * Returns a negative error code on error, 0 on success.

=E2=80=9Cerror=E2=80=9D typo.

>   */
>  int safe_create_dir_in_gitdir(struct repository *repo, const char
> *path);
>

These next ones are for translations:

> diff --git a/po/el.po b/po/el.po
> index 703f46d0c7..c45560c996 100644
> --- a/po/el.po
> +++ b/po/el.po
> @@ -2748,7 +2748,7 @@ msgid "Low-level Commands / Interrogators"
>  msgstr "=CE=95=CE=BD=CF=84=CE=BF=CE=BB=CE=AD=CF=82 =CE=A7=CE=B1=CE=BC=
=CE=B7=CE=BB=CE=BF=CF=8D =CE=95=CF=80=CE=B9=CF=80=CE=AD=CE=B4=CE=BF=CF=85=
 / =CE=95=CF=81=CF=89=CF=84=CE=B7=CE=BC=CE=AC=CF=84=CF=89=CE=BD"
>
>  #: help.c:37
> -msgid "Low-level Commands / Synching Repositories"
> +msgid "Low-level Commands / Syncing Repositories"
>  msgstr "=CE=95=CE=BD=CF=84=CE=BF=CE=BB=CE=AD=CF=82 =CE=A7=CE=B1=CE=BC=
=CE=B7=CE=BB=CE=BF=CF=8D =CE=95=CF=80=CE=B9=CF=80=CE=AD=CE=B4=CE=BF=CF=85=
 / =CE=A3=CF=85=CE=B3=CF=87=CF=81=CE=BF=CE=BD=CE=B9=CF=83=CE=BC=CE=BF=CF=
=8D =CE=91=CF=80=CE=BF=CE=B8=CE=B5=CF=84=CE=B7=CF=81=CE=AF=CF=89=CE=BD"
>
>  #: help.c:38
> diff --git a/po/ko.po b/po/ko.po
> index 7a6847f023..6bc20a43e3 100644
> --- a/po/ko.po
> +++ b/po/ko.po
> @@ -2062,7 +2062,7 @@ msgid "Low-level Commands / Interrogators"
>  msgstr "=EB=B3=B4=EC=A1=B0 =EB=AA=85=EB=A0=B9 / =EC=A0=95=EB=B3=B4 =ED=
=9A=8D=EB=93=9D =EA=B8=B0=EB=8A=A5"
>
>  #: help.c:37
> -msgid "Low-level Commands / Synching Repositories"
> +msgid "Low-level Commands / Syncing Repositories"
>  msgstr "=EB=B3=B4=EC=A1=B0 =EB=AA=85=EB=A0=B9 / =EC=A0=80=EC=9E=A5=EC=
=86=8C =EB=8F=99=EA=B8=B0=ED=99=94 =EA=B8=B0=EB=8A=A5"

Translation msgids for locales `el` and `ko` are wrong. Should these be
dealt with here or separately? Translations (/po) is its own subsystem.

>
>  #: help.c:38
> diff --git a/reftable/system.h b/reftable/system.h
> index c0e2cbe0ff..628232a46f 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -84,7 +84,7 @@ struct reftable_flock {
>   * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is
> negative
>   * we block indefinitely.
>   *
> - * Retrun 0 on success, a reftable error code on error. Specifically,
> + * Return 0 on success, a reftable error code on error. Specifically,

=E2=80=9CReturn=E2=80=9D. Took me four seconds to spot.

>   * `REFTABLE_LOCK_ERROR` should be returned in case the target path is
> already
>   * locked.
>   */
> diff --git a/t/README b/t/README
> index adbbd9acf4..085921be4b 100644
> --- a/t/README
> +++ b/t/README
> @@ -972,7 +972,7 @@ see test-lib-functions.sh for the full list and
> their options.
>   - test_lazy_prereq <prereq> <script>
>
>     Declare the way to determine if a test prerequisite <prereq> is
> -   satisified or not, but delay the actual determination until the
> +   satisfied or not, but delay the actual determination until the

=E2=80=9Csatisfied=E2=80=9D typo.

>     prerequisite is actually used by "test_have_prereq" or the
>     three-arg form of the test_expect_* functions.  For example, this
>     is how the SYMLINKS prerequisite is declared to see if the platform
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index f0598e3934..2d07a99700 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -35,7 +35,7 @@
>  #
>  # In other languages, `1+2` would typically be scanned as three tokens
>  # (`1`, `+`, and `2`), but in shell it is a single token. However, th=
e similar
> -# `1 + 2`, which embeds whitepace, is scanned as three token in shell=
, as well.
> +# `1 + 2`, which embeds whitespace, is scanned as three token in shel=
l, as well.

=E2=80=9Cwhitespace=E2=80=9D typo.

>  # In shell, several characters with special meaning lose that meaning
> when not
>  # surrounded by whitespace. For instance, the negation operator `!` is
> special
>  # when standing alone surrounded by whitespace; whereas in `foo!uucp`
> it is
> diff --git a/t/chainlint/chain-break-false.expect
> b/t/chainlint/chain-break-false.expect
> index f6a0a301e9..db6f8b12a4 100644
> --- a/t/chainlint/chain-break-false.expect
> +++ b/t/chainlint/chain-break-false.expect
> @@ -1,4 +1,4 @@
> -2 if condition not satisified
> +2 if condition not satisfied
>  3 then
>  4 	echo it did not work...
>  5 	echo failed!
> diff --git a/t/chainlint/chain-break-false.test
> b/t/chainlint/chain-break-false.test
> index f78ad911fc..924c9627c0 100644
> --- a/t/chainlint/chain-break-false.test
> +++ b/t/chainlint/chain-break-false.test
> @@ -1,6 +1,6 @@
>  test_expect_success 'chain-break-false' '
>  # LINT: broken &&-chain okay if explicit "false" signals failure
> -if condition not satisified
> +if condition not satisfied

=E2=80=9Csatisfied=E2=80=9D typo. The =E2=80=9Csatisified=E2=80=9D with =
the extra =E2=80=9Ci=E2=80=9D seems easy to
make.

>  then
>  	echo it did not work...
>  	echo failed!
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index ac4a5b2734..869fb4a14e 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base
> index' '
>  		git checkout main &&
>  		git update-index --split-index &&
>  		test_commit more &&
> -		# must not write a new shareindex, or we wont catch the problem
> +		# must not write a new shareindex, or we won't catch the problem

Lack of contraction typo.

>  		git -c splitIndex.maxPercentChange=3D100 merge --no-edit side-branch
> 2>err &&
>  		# i.e. do not expect warnings like
>  		# could not freshen shared index .../shareindex.00000...
> diff --git a/t/t3909-stash-pathspec-file.sh
> b/t/t3909-stash-pathspec-file.sh
> index 73f2dbdeb0..3afa6bff3d 100755
> --- a/t/t3909-stash-pathspec-file.sh
> +++ b/t/t3909-stash-pathspec-file.sh
> @@ -29,7 +29,7 @@ verify_expect () {
>  test_expect_success 'simplest' '
>  	restore_checkpoint &&
>
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Ditto.

>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -47,7 +47,7 @@ test_expect_success 'simplest' '
>  test_expect_success '--pathspec-file-nul' '
>  	restore_checkpoint &&
>
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Again.

>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
>  test_expect_success 'only touches what was listed' '
>  	restore_checkpoint &&
>
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Again.

>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 7c749062e2..df4999b326 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -420,7 +420,7 @@ test_expect_success 'merge --stat respects COLUMNS
> with long name' '
>  # enough terminal display width, will contain the following line:
>  #     "<RED>|<RESET>  ${FILENAME} | 0"
>  # where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
> -# To calculate the minimium terminal display width MIN_TERM_WIDTH so =
that the
> +# To calculate the minimum terminal display width MIN_TERM_WIDTH so t=
hat the

=E2=80=9Cminimum=E2=80=9D typo.

>  # FILENAME in the diffstat will not be shortened, we take the FILENAME
> length
>  # and add 9 to it.
>  # To check if the diffstat width, when the line_prefix (the
> "<RED>|<RESET>" of
> diff --git a/t/t4067-diff-partial-clone.sh
> b/t/t4067-diff-partial-clone.sh
> index 30813109ac..a9dec84c30 100755
> --- a/t/t4067-diff-partial-clone.sh
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -159,7 +159,7 @@ test_expect_success 'diff succeeds even if prefetch
> triggered by break-rewrites'
>  	# We need baz to trigger break-rewrites detection.
>  	git -C client reset --hard HEAD &&
>
> -	# break-rewrites detction in reset.
> +	# break-rewrites detection in reset.

=E2=80=9Cdetection=E2=80=9D typo.

>  	git -C client reset HEAD~1
>  '
>
> diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
> index 42f70dbec7..6a8ac81b11 100644
> --- a/t/t9150/svk-merge.dump
> +++ b/t/t9150/svk-merge.dump
> @@ -77,7 +77,7 @@ Content-length: 2411
>  PROPS-END
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

=E2=80=9Chappening=E2=80=9D. This took me a minute to spot.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -206,7 +206,7 @@ Content-length: 2465
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -310,7 +310,7 @@ Content-length: 2521
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -417,7 +417,7 @@ Content-length: 2593
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -534,7 +534,7 @@ Content-length: 2713
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
> index 47cafcf528..d5e1695637 100644
> --- a/t/t9151/svn-mergeinfo.dump
> +++ b/t/t9151/svn-mergeinfo.dump
> @@ -87,7 +87,7 @@ Content-length: 2411
>  PROPS-END
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -260,7 +260,7 @@ Content-length: 2465
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -365,7 +365,7 @@ Content-length: 2521
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -473,7 +473,7 @@ Content-length: 2529
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -578,7 +578,7 @@ Content-length: 2593
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -767,7 +767,7 @@ Content-length: 2593
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -948,7 +948,7 @@ Content-length: 2713
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -1172,7 +1172,7 @@ Content-length: 2713
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> @@ -1414,7 +1414,7 @@ Content-length: 2713
>
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not giv=
e you
> -# enough guarantees about no collisions between objects ever hapennin=
g.
> +# enough guarantees about no collisions between objects ever happenin=
g.

Same.

>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and cti=
mes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and i=
t will
> diff --git a/t/unit-tests/clar/README.md b/t/unit-tests/clar/README.md
> index 41595989ca..a45b9c8e5d 100644
> --- a/t/unit-tests/clar/README.md
> +++ b/t/unit-tests/clar/README.md
> @@ -138,7 +138,7 @@ raise errors during test execution.
>  __Caution:__ If you use assertions inside of `test_suitename__initial=
ize`,
>  make sure that you do not rely on `__initialize` being completely run
>  inside your `test_suitename__cleanup` function. Otherwise you might
> -encounter ressource cleanup twice.
> +encounter resource cleanup twice.

=E2=80=9Cresource=E2=80=9D typo.

>
>  ## How does Clar work?
>
> --
> 2.54.0
