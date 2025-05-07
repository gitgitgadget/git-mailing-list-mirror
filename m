Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83492101B3
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601605; cv=none; b=a9f2vWw7YrxAagbaQnZeJNUk6DwUFM1Su02h7TYpOdBkUhn3Xamo+xtv8sXsEv5NjjiAkHS/5GjpJctpSfk7uPYPfbbqAhH7YM9XuLSj6OiqqMvLavuwxjmlRjk0IIBRZa95rsSx5pku2F7L1wbhRhqRkoB8wIWq9DBsMMwLGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601605; c=relaxed/simple;
	bh=3d8dIb07LmGDWqsaPiYS65HFG82ugsrG0m4SG+lA63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn1zQVBfmFo1UaqcnidtKxfwGkPY6670/YFjAOVjWKiUhnPFTgGz9FcrRlXDOJPk5UQTefaGIG9Ikn2GxeiEalN6PFuL70uQWmAWD9QTUK0byhDrAlRffpEa0mWvMXA6LD0LeQ8FJqaKXtT7D84KnSZIG2O/pDkLAXUKJ2W/F6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eGxxuyre; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRp519gp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eGxxuyre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRp519gp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E23E825400F3;
	Wed,  7 May 2025 03:06:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 03:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746601602;
	 x=1746688002; bh=DFuPC/kX2wa1FMlYcbAJx3/P4zan9Njb6VZFUongqhs=; b=
	eGxxuyreIuhzw9uQaKVOOJOfAHjsYGOWcSF6WPGb1wTk1w/MF4P50XiA72egqPvS
	+U0iSNckXTwwnBYiSO2jQ6mZ+M0GVS5HN2Jdy4VgZaa5ZHKJE3TdexulFedli/+c
	8VqwuqOMExagJLH3EKljj8XnCvgGoMVX4vwh7YjB9nCDAyUHrgnXH/3fFZH4F+Hs
	NxUikf2m0mRmOvuQhImxHik9Z1+yTm3/cJJKOCc1LCy38R9iENbm0SArI+i4Xw8/
	sCyzkfMoW0igND2AIHyRcJIzwZwi7zLNDTUX8IT/Iyj6aOBnDSwci9mATokUMFc1
	zoF2v6kOeAUpsNt9CD2DMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746601602; x=
	1746688002; bh=DFuPC/kX2wa1FMlYcbAJx3/P4zan9Njb6VZFUongqhs=; b=P
	Rp519gppp53cNFbJUikZdA6+eu3KyRA9243nDSrPJZJxSiOBdDmuXYq/830ZRsbx
	1Cqqc0Mtg8dH74WifYnoYMnisw8o0Go4rng9PYvvlMWYcuEcdg+nr5QJIXwTVmK2
	B7vWoSRue/n0ORXfu7vCpaglVrW5NwuoiaLniHpvYHQwjBx1ajGzghPztlB1F1pL
	7L00ZVJppYlnR00YCRlaTU5nlvw0EiRzeeg3pWOo1Vi4H1BfBu2FkP68IaO0ol1d
	D9Izy1N2+nfUdtJzKPF94nsWyV9qTgHiCEv5zkKRQ4oE5AaArKbs7Dlfe9q9fJ7U
	l9XUbxnj9i49pZkLMmz4w==
X-ME-Sender: <xms:ggYbaAewyinU6kgWEJk7spdk_u2idaRn58_v63Mp_SU9xSiAQtRFjw>
    <xme:ggYbaCNZ3YWWDxureY1PUf85_QhVkg74ZSefef1IcC_NtmvhfofYpK2yguapP0b4x
    M2tYo7H9q9Q2fcyxg>
X-ME-Received: <xmr:ggYbaBi--FoT5FlMZqLkUCwQ94WMwuqdG4fFPiSx9mkuVKpJMreiTwFjaYTY4-QYUxKTJfa1zj0U4oNnFGp59UN4IoNapZxkR4K5ExhwCysBkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgteelhedvkeelvdeukefgtdffhefhheehvedt
    vedugefhvedtveelheejfeeuveenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:ggYbaF_stYlPe8HlpwEn-jJR8d7UrbMS4Zu1I2dBfv12OJdriNcqCQ>
    <xmx:ggYbaMvCqpqUmU-I3BoVfXe_PdJ-uXxdW0JkvwkLMkwj3DFEHKwgPg>
    <xmx:ggYbaMHuwWMjocOMvyWvswmn_LZn3QPt7c7iLr5_JgOWLHkPPshTpQ>
    <xmx:ggYbaLOfnaAYHZeyFpCGU7QUtaJw6qQniTnCinF-onEe4nsoLJTDIw>
    <xmx:ggYbaGQRgxOCBcxcaIU5ADPeh1iuITDnSI-rO2XE6wM3O4h5xp6j4K3Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:06:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1dd29f22 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:06:38 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] worktree: expose function to retrieve worktree
 names
Message-ID: <aBsGgNsNmy-t5CGK@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
 <20250502-pks-maintenance-missing-tasks-v3-4-13e130d36640@pks.im>
 <CAPig+cSDDbhGrym8j=PFKBCUxBQhZPzAHXGvKy-Z6POA4Ju3sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSDDbhGrym8j=PFKBCUxBQhZPzAHXGvKy-Z6POA4Ju3sw@mail.gmail.com>

On Mon, May 05, 2025 at 04:42:40AM -0400, Eric Sunshine wrote:
> On Fri, May 2, 2025 at 4:44 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Introduce a function that retrieves worktree names as present in
> > ".git/worktrees". This function will be used in a subsequent commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> I'm not convinced that this patch or the get_worktree_names() function
> which it adds to worktree.[hc] adds value. Aside from the mere act of
> consulting the directory at repo_git_path(r, "worktrees"), there is
> nothing about the function at all related to worktrees. It doesn't
> make any guarantees, such as only returning entries which at least
> superficially look like worktree-metadata directories, or perform any
> sort of validation. I don't see how this is any better than the caller
> just implementing its own bog-standard opendir() / readdir()-loop /
> closedir() over repo_git_path(r, "worktrees"). Or, if you don't want
> the caller to implement its own readdir()-loop, I wouldn't be
> surprised if we already have a function which does exactly this for a
> provided path, though I haven't checked. If there isn't such a generic
> function, perhaps it makes more sense to add one and call it with
> repo_git_path(r, "worktrees") as its input?

I think this is fair criticism indeed, and open-coding this isn't even
any more complex, either, as shown by the below patch. I'll drop this
patch.

Patrick

diff --git a/builtin/gc.c b/builtin/gc.c
index 82f0fac81a4..eb4469b7858 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -351,11 +351,11 @@ static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNU
 
 static int worktree_prune_condition(struct gc_config *cfg)
 {
-	struct strvec worktrees = STRVEC_INIT;
-	struct strbuf reason = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int should_prune = 0, limit = 1;
 	timestamp_t expiry_date;
-	int should_prune = 0;
-	int limit = 1;
+	struct dirent *d;
+	DIR *dir = NULL;
 
 	git_config_get_int("maintenance.worktree-prune.auto", &limit);
 	if (limit <= 0) {
@@ -363,15 +363,18 @@ static int worktree_prune_condition(struct gc_config *cfg)
 		goto out;
 	}
 
-	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
-	    get_worktree_names(the_repository, &worktrees) < 0)
+	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date))
+		goto out;
+
+	dir = opendir(repo_git_path_replace(the_repository, &buf, "worktrees"));
+	if (!dir)
 		goto out;
 
-	for (size_t i = 0; i < worktrees.nr; i++) {
+	while ((d = readdir_skip_dot_and_dotdot(dir))) {
 		char *wtpath;
 
-		strbuf_reset(&reason);
-		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
+		strbuf_reset(&buf);
+		if (should_prune_worktree(d->d_name, &buf, &wtpath, expiry_date)) {
 			limit--;
 
 			if (!limit) {
@@ -384,8 +387,9 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	}
 
 out:
-	strvec_clear(&worktrees);
-	strbuf_release(&reason);
+	if (dir)
+		closedir(dir);
+	strbuf_release(&buf);
 	return should_prune;
 }
