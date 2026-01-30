Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A423D7FC
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804134; cv=none; b=Uwsj1y5MFI3UVto08CEFX2rPIYsVuQyvNnK4c9NvM1LUyHuAOY4woRXiYACQ6H/fd+uACpsqKAyZbsgQjQcg4+ACLjumdg+IwrhdOzgcOFw7YusPH367VvUKSv54JFcCzHsB0IQcvjqnhTO0NVaX2ri4sVkO3nNWnCkxq0PM62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804134; c=relaxed/simple;
	bh=TyEllZoX5R1tei5d2n+UlYJdc8pIFOerfpoVVlKbn04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHvGgJeyytyYHsJ/quCTATPuMf1knj9qE9hDSaV/w1INZz1Jgi7+aUn4rLBLYyOqfPHlRBCgHDc+42wohjSNNkR+HmUkSe7ZRocMtoqXGyoMhSkpZKc/czwA5XV5pnjkVp+hGS2ct9W/HSLerJItEs3X69UrUE5OfgyGzPfZB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZ2exPBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbW7vz2A; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZ2exPBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbW7vz2A"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C78DC7A012A;
	Fri, 30 Jan 2026 15:15:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 15:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769804130; x=1769890530; bh=Ty3ayrfFGn
	WpDI0PwjYoA+4s/E10cZ8wHRPQGqc9zlM=; b=WZ2exPBXuX7kbh8W0uzPEEDoHT
	pGZEGuF27/HLLXjgVTxjb7ZJDCDoIWnLvpNzE9vzBp/w8CemhIN74AuY5czrhxr/
	iYfKNh40jcAy7da3Xi/QU6AtrpKdxXNJNha6oSV97EauLRBFRpsmcdKN3zVth9LM
	u/NPm6Yt7KEi0C9uZfBuZoYv7MgqJAOUKAW1jtvWYLzInvoPFIRlr2V7mi2TMZ7D
	DxUj4+Ub26RBKu6qetwVA0LJlYLmAXa3zCqJCuf4r2RdcjCfptgjMlvPteg9TDZm
	svsaJL7sLsBqKoAAhueh5ykE/qi9M97MAT8A5NcXZhb0eB/jhrojShxQdxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769804130; x=1769890530; bh=Ty3ayrfFGnWpDI0PwjYoA+4s/E10cZ8wHRP
	QGqc9zlM=; b=YbW7vz2AY9XyRxFzXyQMfyUZnRuwCGC1z2PKcFN4qHD50LGG6/+
	zcSShJIfgZGJDMKeLuchsKQttN+tzdK441AfmQ/zyqJmM0edoSFrE9ZzbnH9cmQE
	vY2F6DhZWMZ1X9D/fqHBF7x5rrYCtYm0t1/74jVlUKngwOHL8DERReGVIk87Pl1U
	gtwlKVuqeg/Wwfkt7c+E/BDfoYn5CywK1O1Mco+EgSRAbsXEj3TOiKRZ0T8fS9De
	lDPu7rchQBhqd/fyy0eEbKl7VMvRqz35X+LGBvLgol09b4BOB1bQiCKahByd/F0k
	9MBI1FgBnjalYZx2P0TEGxZ31bdr9iaD9hw==
X-ME-Sender: <xms:YhF9abdoMztMu29s3GWiDmvgxPV5LYUYmdAM6nbKuZdrtBfDHUdr0Q>
    <xme:YhF9adzmdxdnBOCKlowcusRE0iJccOCR0ILsSATTywY7bz59_YPBrwhL2Y3v9Jw7J
    KmNQtkGPU97ffeSDL-zS2mHASCiRpHxGDoLDtnUAm7EfnW0QJPT-A>
X-ME-Received: <xmr:YhF9aY8s7cXoQBneOKN5xuI8Kuc25uRA9Z7FIZ1fISf50bydokcA-P-KlFmAH8CqLowS_E_vGiaFupTfZUnre5pqBHifKeKTjQ_CCOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtiedvheejfeehgfdtkeevueefue
    ehhfffudejtdffjeeggedvueekfeekueehvdenucffohhmrghinheprghtthhrrdgtfidp
    vghnvhhirhhonhhmvghnthdrtgifpdhrvghpohhsihhtohhrhidrtgifnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegsvghlkhhiugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YhF9aTx0TaJ-BUk7C1jsVpRZ7GZgZrldQuT-bEqev8VHhJ_5K-s9jQ>
    <xmx:YhF9aYo91jwpUOMFp5WxAug7gEcrtabsfRhCW8RsQ33LDvEXCzYfuQ>
    <xmx:YhF9aUqnvKIof-dU1Kbz9KMgSfYUAdvVm6R6ANUrxTLUjaHdm031oQ>
    <xmx:YhF9aYAfmMD-YD5HHGWh8iL3mzvEu2HsaO0AYfQC1nM0MpBOmB-jbw>
    <xmx:YhF9aVcQnV4m_N2guUiUJsSzQFJMTBa3pubd5DBiEH7N63qjSnRmRUHw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 15:15:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v5 3/3] environment: move
 "branch.autoSetupMerge" into `struct repo_config_values`
In-Reply-To: <xmqqikcj842o.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	30 Jan 2026 08:20:47 -0800")
References: <cover.1769256839.git.belkid98@gmail.com>
	<e7f37bac87aac74ca13f85ae7e393a38d2079b9c.1769256839.git.belkid98@gmail.com>
	<xmqqms1wb6zg.fsf@gitster.g> <xmqqikcj842o.fsf@gitster.g>
Date: Fri, 30 Jan 2026 12:15:28 -0800
Message-ID: <xmqq5x8i7t7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So, we need to take it as a given that repo_config_values_init()
> needs to exist.  Under that condition, I wonder if we can somehow
> have a cheap way to assert the following two things:
>
>  * Before a repository instance is used, repo_config_values_init()
>    has been called on it, as using an instance without initializing
>    is a no-no.
>
>  * repo_config_values_init() is never called twice on a repository
>    instance, as the second call will wipe what the first call and
>    subsequent reading of the configuration files have done.

Something like this squashed into your [1/3] would give us these two
assertions, but I am not sure if it is a good idea or if I am overly
paranoid.

The main ideas are:

 * "struct repository" now knows if it has been initialized via its
   "bool initialized" member.

 * "initialize_repository()" detects double initialization of the
   repository struct itself.

 * "repo_config_values" member in "struct repository" has been
   renamed to make it clear it is "private", and there is an
   accessor function of the same name.  It barfs if you ask the
   address of repo_config_values in a repository instance that
   hasn't been initialized.

 * Any code outside what implement the above are supposed to call
   repo_config_values() on the repository they are working in, to
   request the address of the repo_config_values instance to use.

It didn't barf when I ran all the tests, which means there isn't
anybody who calls initialize_repository() twice in the current code.

I am not sure if this is being overly paranoid, or exercising a
reasonable caution, but anyway,...


 attr.c        |  3 ++-
 environment.c |  2 +-
 environment.h |  3 +++
 repository.c  | 13 ++++++++++++-
 repository.h  |  5 ++++-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git c/attr.c w/attr.c
index b8b70e6dce..cd39e6d2bf 100644
--- c/attr.c
+++ w/attr.c
@@ -881,7 +881,8 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	struct repo_config_values *cfg = &the_repository->config_values;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!cfg->attributes_file)
 		cfg->attributes_file = xdg_config_home("attributes");
 
diff --git c/environment.c w/environment.c
index c876589b05..208a52ce11 100644
--- c/environment.c
+++ w/environment.c
@@ -302,7 +302,7 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 int git_default_core_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
-	struct repo_config_values *cfg = &the_repository->config_values;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
diff --git c/environment.h w/environment.h
index 2b861a61de..254fec6b7c 100644
--- c/environment.h
+++ w/environment.h
@@ -84,11 +84,14 @@ extern const char * const local_repo_env[];
 
 struct strvec;
 
+struct repository;
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 };
 
+struct repo_config_values *repo_config_values(struct repository *);
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
diff --git c/repository.c w/repository.c
index d308cd78bf..4cb487b5b2 100644
--- c/repository.c
+++ w/repository.c
@@ -50,14 +50,25 @@ static void set_default_hash_algo(struct repository *repo)
 	repo_set_hash_algo(repo, algo);
 }
 
+struct repo_config_values *repo_config_values(struct repository *repo)
+{
+	if (!repo->initialized)
+		BUG("config values from uninitialied repository?");
+	return &repo->config_values_private_;
+}
+
 void initialize_repository(struct repository *repo)
 {
+	if (repo->initialized)
+		BUG("repository initialized already!");
+	repo->initialized = true;
+
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
-	repo_config_values_init(&repo->config_values);
+	repo_config_values_init(repo_config_values(repo));
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git c/repository.h w/repository.h
index 638a142577..9717e45000 100644
--- c/repository.h
+++ w/repository.h
@@ -150,7 +150,7 @@ struct repository {
 	const struct git_hash_algo *compat_hash_algo;
 
 	/* Repository's config values parsed by git_default_config() */
-	struct repo_config_values config_values;
+	struct repo_config_values config_values_private_;
 
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
@@ -175,6 +175,9 @@ struct repository {
 
 	/* Should repo_config() check for deprecated settings */
 	bool check_deprecated_config;
+
+	/* Has this repository instance been initialized? */
+	bool initialized;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
