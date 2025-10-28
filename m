Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067E343D62
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667313; cv=none; b=AOI65O2vCukPAExsQlo2B51TSG9Hr8yjL5ZubvWZ244Q0JQgONgSUeTklZWiX+5vn5zJ4N5lTq5Jb1nvDwo4lpTFWmzw5ws2I2/puUfYtFROEtZ8A/VGF7CG8gOp/X/cCOXhIJRvI+jzVq7DgBrZkf+c6waTQisSXRLLUK4FqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667313; c=relaxed/simple;
	bh=/m6sQpILV0dLhDMED4BgHiHJSGwu4Os6qiVAB405iWY=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=nKQxyZ0yw0jDDPZ23MFkjiK3+AU4yhzpJEJMFYrrHhgsJamkk87RfzY6RerBO+hOsBwJd7CRu4W5zPYpnSGY6MMJw6EhmSJ6B55mn83lDQV1Ox4cnSWfznoGd/NwhJqIrApY4pplImfmSslphRpIQ+ZHphkbYUjHqd6EdKXTd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:33626)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDm8s-007jlw-NC; Tue, 28 Oct 2025 10:01:50 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:40452 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDm8r-005Gjk-PZ; Tue, 28 Oct 2025 10:01:50 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
In-Reply-To: <xmqqms5chyr8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 Oct 2025 13:32:11 -0700")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
	<xmqqqzuoi6sg.fsf@gitster.g>
	<875xc02mmq.fsf@email.froward.int.ebiederm.org>
	<87o6ps16pj.fsf@email.froward.int.ebiederm.org>
	<xmqqms5chyr8.fsf@gitster.g>
Date: Tue, 28 Oct 2025 11:01:45 -0500
Message-ID: <87frb310d2.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vDm8r-005Gjk-PZ;;;mid=<87frb310d2.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18AiA2QIhKM2quCqWxrnrQDvlJsM1UoG4M=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4795]
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 12 (2.7%), b_tie_ro: 10 (2.4%), parse: 1.44
	(0.3%), extract_message_metadata: 22 (5.0%), get_uri_detail_list: 3.6
	(0.8%), tests_pri_-2000: 19 (4.3%), tests_pri_-1000: 2.9 (0.6%),
	tests_pri_-950: 1.45 (0.3%), tests_pri_-900: 1.26 (0.3%),
	tests_pri_-90: 86 (19.5%), check_bayes: 84 (19.0%), b_tokenize: 8
	(1.9%), b_tok_get_all: 8 (1.7%), b_comp_prob: 2.6 (0.6%),
	b_tok_touch_all: 61 (13.9%), b_finish: 0.86 (0.2%), tests_pri_0: 280
	(63.6%), check_dkim_signature: 0.54 (0.1%), check_dkim_adsp: 2.2
	(0.5%), poll_dns_idle: 0.17 (0.0%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] t1016-compatObjectFormat: Really freeze time for
 reproduciblity
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: sandals@crustytoothpaste.net, five231003@gmail.com, git@vger.kernel.org, tmz@pobox.com, gitster@pobox.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false


The strategy in t1016-compatObjectFormat is to build two trees with
identical commits, one tree encoded in sha1 the other tree encoded
in sha256 and to use the compatibility code to test and see if
the two trees are identical.

GPG signatures include the current time as part of the signature.

To make gpg deterministic I forced the use of gpg --faked-system-time.
Unfortunately I did not look closely enough.

By default gpg still allows time to move forward with --faked-system-time.
So in those rare instances when the system is heavily loaded an gpg runs
slower than other times, signatures over the exact same data differ
due to timestamps with a minuscule difference.

Reading through the gpg documentation with a close eye, time can be
frozen by including an exclamation point at the end of the argument to
--faked-system-time.

Add the exclamation point so gpg really runs with a fixed notion of time,
resulting in the exact same data having identical gpg signatures.

That is enough that I can run "t1016-compatObjectFormat.sh --stress"
and I don't see any failures.

It is possible a future change to gpg will make replay protection more
robust and not provide a way to allow two separate runs of gpg to
produce exactly the same signature for exactly the same data.  If that
happens a deeper comparison of the two repositories will need to be
performed.  A comparison that simply verifies the signatures and
compares the data for equality.  For now that is a lot of work
for no gain so I am just documenting the possibility.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 t/t1016-compatObjectFormat.sh | 6 ++++++
 t/t1016/gpg                   | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index a9af8b239626..0efce53f3aad 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -21,6 +21,12 @@ test_description='Test how well compatObjectFormat works'
 # different hash functions result in the same content in the commits.
 # This means that when the commit is translated between hash functions
 # the commit is identical to the commit in the other repository.
+#
+# Similarly this test relies on:
+#	gpg --faked-system-time '20230918T154812!
+# freezing the system time from gpg perspective so that two different
+# runs of gpg applied to the same data result in identical signatures.
+#
 
 compat_hash () {
 	case "$1" in
diff --git a/t/t1016/gpg b/t/t1016/gpg
index 2601cb18a5b3..34d6e055fc9e 100755
--- a/t/t1016/gpg
+++ b/t/t1016/gpg
@@ -1,2 +1,2 @@
 #!/bin/sh
-exec gpg --faked-system-time "20230918T154812" "$@"
+exec gpg --faked-system-time '20230918T154812!' "$@"
-- 
2.41.0

