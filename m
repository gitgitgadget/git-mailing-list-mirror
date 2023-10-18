Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2638DD4
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pddXEY+L"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17ABFA
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:35:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A7772267F;
	Wed, 18 Oct 2023 19:35:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	NlmYft0eZuJhJ+CmkzHz/HrBUUhCdMnLOtKcmaTf3Y=; b=pddXEY+LT9kmOnFys
	tXJt3ESWndGVfWZo7onWhtQN6qQ556l07urq0O1cjCv7/2tmVtc/JluNjCDt/eRN
	b3cLOOo7ryH3hIzYUFZsZyOyaYI65aVNpvSs7IR9peOdlsWVNK1uJYQ3ULg1Hcdn
	kjgUyhaPA9WL9/bKV5qoe5DK44=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 63E4F2267E;
	Wed, 18 Oct 2023 19:35:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D84842267D;
	Wed, 18 Oct 2023 19:35:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] am: align placeholder for --whitespace option with apply
Date: Wed, 18 Oct 2023 16:35:06 -0700
Message-ID: <xmqqwmvjzeqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8DE7B04-6E0E-11EE-A40E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

`git am` passes the value given to its `--whitespace` option through
to the underlying `git apply`, and the value is called <action> over
there.  Fix the documentation for the command that calls the value
<option> to say <action> instead.

Note that the option help given by `git am -h` already calls the
value <action>, so there is no need to make a matching change there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/Documentation/git-am.txt w/Documentation/git-am.txt
index 0c1dfb3c98..de3d5dde99 100644
--- i/Documentation/git-am.txt
+++ w/Documentation/git-am.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
-	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
+	 [--whitespace=<action>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
@@ -116,7 +116,7 @@ include::rerere-options.txt[]
 
 --ignore-space-change::
 --ignore-whitespace::
---whitespace=<option>::
+--whitespace=<action>::
 -C<n>::
 -p<n>::
 --directory=<dir>::
