Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA01A841C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877242; cv=none; b=F9FuoJ7/3xI2QirHDukp16qr9p7gcbI9qZsWmZaQN0Crt2+dtz9bNnggcoha0bdaqEbIcaxh2/6gH0TxlKY+RWiu82NLikO11yQuAJacWY0d3nVhrQk7RPoVn74wBPIqLGZOUth6HOZ0xtg6Rlc38ePBZaYsyb7t//JXJsKJEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877242; c=relaxed/simple;
	bh=T/UhmjVvpU9SxUn4kgp6bBweyuw+fIBj5wkUmBSGZSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLjptCeJN4J+Ko1N1FLlfpE0IlYN/2FLegwM4WVp7OYIT/als86Dr3tXuXOyT1fIYgTb6Yw9+I16l0MPqFMRqkSZW7BQohBIlIRpgpPJMX5heJMmKXuUCc+w0BLPumIIrL5LjaX96fkR/kk9Rif3sSaClCM44rst0JslWCneAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rvKkrBKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpM279Us; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rvKkrBKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpM279Us"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC6EF11401CA;
	Tue, 18 Feb 2025 06:13:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 18 Feb 2025 06:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739877238; x=1739963638; bh=4bzfrLSnZb
	CVsj5fxPdmMPazV9mbAiiSSZvXPwvPcAI=; b=rvKkrBKMLhtKUeK2S6gyFoD7Ez
	bHSe8riE/1PyRCpkRB2ERLUr2y+dFOKYMJNoZLmXJfdCgd2yVaFzMN35tFanpf4W
	WferxJ/gtg6uUTkV/Ivxdc0NCmB2Ch5DTW7sULUbS06hHvlf5ZyIO3/U16kekhXi
	tMD3UgwYmfonHURVoyftCxLLqYS/abzDKprIhKaLd4Gg1ORn6kTg1e0uf4ie5A+y
	9XMOkma75grEBE9oKI6InSzY/l/Oj/Yiu+AFT8oqRNJAePm4y7xVdh+lwG6yjYoP
	DhyPYqP1zqeklJo/D/GzeJeTxjTgq+QGiEODzdKTz0bZkXfwKTjpSzilpHyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739877238; x=1739963638; bh=4bzfrLSnZbCVsj5fxPdmMPazV9mbAiiSSZv
	XPwvPcAI=; b=SpM279UsPk4N2CNVbkv5sjWIlbAaLHJL+RmZTp2eQAi3lSv0YMY
	dKe4wr78z+Y3AfGjNMpbXbi22pksJNh7UjmcNGxj6DNhXxVjyEEIT3iNcyV/WBpZ
	jPxuNLsAtt9k8kU5gDPLgioEriCeQEDOuasSgWCl5A8HMEhhAC0v4yyQ9l6Fe8ty
	WnidyXoqjiUShKohwc0A47aKg5KCgjvGx9QnhjoSVlNEBdc0YWhus1KT+Wx7sq/N
	RJNhXoaBiD+w/drNNSssaZJZT7VhVicc9lbaawTTt4gx8QKls6eQMp/8hywEOqYA
	BhrdHxmSS8TRMk9ebXTH9ejGmHCgWDvNqqA==
X-ME-Sender: <xms:dmu0Z15ieiD-QJ15_4VOfVGt92DEl8K0PphosS9yTLmywLe9YoonjQ>
    <xme:dmu0Zy5yGkMr7eeX6hgCpaYvQrycldo4DluOMPs8kXLgEHZmP49EARA5IXJb9aZ4p
    pPAH_ZEag9nGJteog>
X-ME-Received: <xmr:dmu0Z8dJoHIY6L-eOaPhhgUS4nwj5uezQ5nu8dLcWALv3VQIih07siCdOHmZZLrb4OB25D8eQxp450T78RIgBLX4O3qWCUzTc7lU2_OYJXtJJXKq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevgffffedtjeduffejvdefjeejffehfefhieeihfef
    geeugffhvddvhffgudfgteenucffohhmrghinhepvgigrghmphhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dmu0Z-Kf36pGQ6I-NQBEBcmypmoMAFzsLbUClxVEZuVu67DcS2KITg>
    <xmx:dmu0Z5Ljd0fQAxhOQI_qM_pewny3NqQ7_jnXryXAcNhXVxWK8mq_tg>
    <xmx:dmu0Z3yt_wt7woDCmXQiIklJfe9sAd-dH1Zl6MT1o8g7EOYV083UHw>
    <xmx:dmu0Z1LXp7pOXx4RiV9u55VJI5nRHPelSlZHDHzXA1HsMNQBAIkCow>
    <xmx:dmu0ZwURsftjF3Fc54qSOwEaHePSbn7A3jDpjk62I5mgSfwSWLNSGHxI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 06:13:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7ae5473 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 11:13:54 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:13:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] meson: wire up credential helpers
Message-ID: <Z7RrbZqq9VrTg-Bz@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im>
 <CAGJzqs=+mL_GyXfR44iQ6o6L+gb=D7DWm2Bq4eW19XhuEFuHew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGJzqs=+mL_GyXfR44iQ6o6L+gb=D7DWm2Bq4eW19XhuEFuHew@mail.gmail.com>

On Tue, Feb 18, 2025 at 10:11:23AM +0000, M Hickford wrote:
> > Note that ideally, we'd also wire up t0303 to be executed with each of
> > the credential helpers to verify their functionality. Unfortunately
> > though, none of them pass the test suite right now, so this is left for
> > a future change.
> 
> Out of curiosity, which tests failed?

Basically all of them. I originally had the patch at the bottom of this
email. With that in place, we re-run t0303 for every configured
credential helper, where `GIT_TEST_CREDENTIAL_HELPER` is set to the
respective credential helper under test. We have to disable parallel
tests there because the test state directories would otherwise conflict
with one another.

Now you can for example:

    $ meson setup build -Dcredential_helpers=libsecret,netrc
    $ meson test -C build t0303-*

And that shows failures like:

    --- expect-stderr	2025-02-18 11:09:33.323668205 +0000
    +++ stderr	2025-02-18 11:09:33.347668278 +0000
    @@ -1,2 +1,4 @@
    +
    +** (process:75536): CRITICAL **: 11:09:33.339: lookup failed: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.secrets was not provided by any .service files
     askpass: Username for 'https://example.com':
     askpass: Password for 'https://askpass-username@example.com':
    error: last command exited with $?=1
    not ok 1 - helper (/home/pks/Development/git/build/contrib/credential/libsecret/git-credential-libsecret) has no existing data

I might be missing how exactly to set all of this up so that things
actually work. Maybe I have to do something specific for each of the
helpers via `GIT_TEST_CREDENTIAL_HELPER_SETUP`. But t0303 isn't wired up
via our Makefiles for any of the helpers, as far as I can see, so I'm
unable to figure out what such a setup would look like.

Any hints would be welcome.

Patrick

--- >8 ---

diff --git a/contrib/credential/libsecret/meson.build b/contrib/credential/libsecret/meson.build
index 0137660fe02..cb5f7280823 100644
--- a/contrib/credential/libsecret/meson.build
+++ b/contrib/credential/libsecret/meson.build
@@ -1,4 +1,4 @@
-executable('git-credential-libsecret',
+credential_helpers += executable('git-credential-libsecret',
   sources: 'git-credential-libsecret.c',
   dependencies: [
     dependency('glib-2.0'),
diff --git a/contrib/credential/meson.build b/contrib/credential/meson.build
index 4216296ae05..f04525b728e 100644
--- a/contrib/credential/meson.build
+++ b/contrib/credential/meson.build
@@ -1,3 +1,20 @@
+credential_helpers = []
+
 foreach helper : get_option('credential_helpers')
   subdir(helper)
 endforeach
+
+foreach helper : credential_helpers
+  helper_test_environment = test_environment
+  helper_test_environment.set('GIT_TEST_CREDENTIAL_HELPER', helper.full_path())
+
+  test('t0303-credential-external-' + fs.stem(helper.full_path()),
+    shell,
+    args: [ meson.project_source_root() / 't/t0303-credential-external.sh' ],
+    workdir: meson.project_source_root() / 't',
+    env: helper_test_environment,
+    depends: test_dependencies + bin_wrappers + helper,
+    timeout: 0,
+    is_parallel: false,
+  )
+endforeach
diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86da..110eac8f2f8 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -6,6 +6,7 @@ credential_netrc = custom_target(
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
+credential_helpers += credential_netrc
 
 credential_netrc_testenv = test_environment
 credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
diff --git a/contrib/credential/osxkeychain/meson.build b/contrib/credential/osxkeychain/meson.build
index 3c7677f736c..545a8a25b4b 100644
--- a/contrib/credential/osxkeychain/meson.build
+++ b/contrib/credential/osxkeychain/meson.build
@@ -1,4 +1,4 @@
-executable('git-credential-osxkeychain',
+credential_helpers += executable('git-credential-osxkeychain',
   sources: 'git-credential-osxkeychain.c',
   dependencies: [
     dependency('CoreFoundation'),
diff --git a/contrib/credential/wincred/meson.build b/contrib/credential/wincred/meson.build
index 6de23ca17d4..fa669f038fe 100644
--- a/contrib/credential/wincred/meson.build
+++ b/contrib/credential/wincred/meson.build
@@ -1,4 +1,4 @@
-executable('git-credential-wincred',
+credential_helpers += executable('git-credential-wincred',
   sources: 'git-credential-wincred.c',
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
