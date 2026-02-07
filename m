Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE12DC35C
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438501; cv=none; b=gasLNfwR4P/vqIyJ5a8SZWB4TgDeXU7eKJcVxbk4cTbnP+OcKjLrDqX4Mix6HLhWM2291qVFDZMC00pd/xQtybJ6iFiB5TN4fgrKncJLobWvvehVBYViwOMLT+/PsOWTSKJHmqyKxwBlX723oT9FYW48L++TbroIyju7B+GxMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438501; c=relaxed/simple;
	bh=ZnXbHTlc9Cm2Akt7tjvdE7PhjfK/wJCG0HuoXu1jw0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9air5lTMqB/seTxhhmBJCN+Aly7zxu2Ezqqs62gzoVnpGUSFiSNwcH4A48FGFHGTYPQgW3LPELG4slniFm/PfmGWtDDy3PfN9a8aurh7IHRoy4MSOq1uR1MwIcueNPMhNopDjQwtoLNQdjFekKjspOUQ8wk7vzB7RPZa5FzZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=S0F1D5RU; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="S0F1D5RU"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1voZvd-008VL6-4H
	for git@vger.kernel.org; Sat, 07 Feb 2026 05:28:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=z0z/A1AX2p0dxuONZqY/bi4sse35u9LEW2L5zSU92fI=; b=S0F1D5RUAUct2SKaUe3TUBMxw+
	nyDEfJy3kaLqhNaleq9nfPK8nGeiIZUV/KQRnOp5sLpLMUV72i938mV5JcYdk4QrWXcoxaQkvFtp5
	CzmaTo6GrtOq/fzltydnCeZ8+07cu5qqJQW9nAw5K+iQxpfm9/zpnaXisS3WqvoRovc35D0JF9QZP
	aQYGa0DX38D8TV/5zb/wi35NXTcdkS5RFj5212wmFiatp5ojlvxqfEdMlfGWzZGQf5RgdB8iGgNoN
	irsbyE06hSktKIUE9P430ooDQ2R8dmdB0T9pD0NTrfCxN9tkHAjpLfEwUbzC1AgvjrnVj4XQBqTtG
	IQXIWjbg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1voZvc-0005hX-Nu; Sat, 07 Feb 2026 05:28:16 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1voZvI-005ElL-1Z; Sat, 07 Feb 2026 05:27:56 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
Date: Fri,  6 Feb 2026 22:27:03 -0600
Message-ID: <20260207042703.1180704-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aYWaytvnR8wOdc1s@pks.im>
References: <xmqqy0l6khkd.fsf@gitster.g> <aYWaytvnR8wOdc1s@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2/6/26 01:39, Patrick Steinhardt wrote:

> On 2/5/26 15:55, Collin Funk wrote:
>> If you would prefer to keep usingubuntu:rolling, you can do something
>> like this:
>> 
>>      $ podman run --rm -itubuntu:25.10
>>      $ dirname --version
>>      dirname (uutils coreutils) 0.2.2
>>      $ apt-get upgrade -y; apt-get update -y;
>>      [...]
>>      $ apt-get install -y coreutils-from-gnu coreutils-from-uutils- \
>>          --allow-remove-essential
>>      [...]
>>      $ dirname --version | head -n 1
>>      dirname (GNU coreutils) 9.5
>
> ideally we'd do a similar workaround to the sudo.ws workaround
> we have in "ci/install-dependencies.sh" so that we only disable the
> pieces that _don't_ work.

The ubuntu:rolling image still has GNU coreutils installed, but all
the command names are prefixed with "gnu". This approach replaces
only `dirname`. Feel free to adapt or discard as you like---this
isn't my CI!

Colin

-- >8 --
Subject: [PATCH] ci: ubuntu: use GNU coreutils for dirname

The uutils version of `dirname` has output that is inconsistent
with GNU coreutils. Prefer the GNU implementation of this command.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 ci/install-dependencies.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ee8216a05..617b90cbc9 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -71,16 +71,27 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
 	# is that it does not support `--preserve-env` though, which we rely on
 	# in our CI. We thus revert back to the C implementation.
 	if test -f /etc/alternatives/sudo
 	then
 		sudo update-alternatives --set sudo /usr/bin/sudo.ws
 	fi
 
+	# on uutils v0.2.2 from rust-coreutils,
+	#     dirname "foo/."
+	# outputs "." instead of "foo" like it should.
+	# Use GNU coreutils to provide dirname instead.
+	#
+	# See <https://github.com/uutils/coreutils/issues/10508>.
+	if test -x /usr/bin/gnudirname
+	then
+		ln -sfT /usr/bin/gnudirname /usr/bin/dirname
+	fi
+
 	case "$distro" in
 	ubuntu-*)
 		mkdir --parents "$CUSTOM_PATH"
 
 		wget --quiet --directory-prefix="$CUSTOM_PATH" \
 			"$P4WHENCE/bin.linux26x86_64/p4d" \
 			"$P4WHENCE/bin.linux26x86_64/p4" &&
 		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {

base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
-- 
2.43.0

