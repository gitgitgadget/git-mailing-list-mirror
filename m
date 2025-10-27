Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D7233155
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595354; cv=none; b=VDAa4dxGTRB33lYMWQLXwQ/VJLTkHQXJKOIXbRXmr3yjBhmBnXzxzvsqewWbZZk7DlomeGilLFExxM129UhqwmCpZts043ocIndKQiTDyllJAkxNqBYiC0eu/AnoUp6Ohy8f/VQfoGKwmD1YEdtBbTvxDHxkXayhJvYIenNMX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595354; c=relaxed/simple;
	bh=pN3OD2/7IM+wPFcgRJE9Q9WrFNqbYZEGxlNa9sBIVeE=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=t2MjeYzECv7rkQTiguBrIFqAKf/ICJ+0nTljWTQs/Fv5ed90MkYe2ulahx5MbWRwuXjLtC1nSPDA2IO1CFCU4eROLi6epS4SbM2ikzJLRXL8sFvctzo/wWTuX/DevHy8M5aoCAD1lYSlqMoxmwreBU6zN/dtYgZ0jgRJWVHAKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34728)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDSUr-002lxe-M8; Mon, 27 Oct 2025 13:03:13 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:42180 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDSUq-003k73-LZ; Mon, 27 Oct 2025 13:03:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
In-Reply-To: <xmqqqzuoi6sg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 Oct 2025 10:38:39 -0700")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
	<xmqqqzuoi6sg.fsf@gitster.g>
Date: Mon, 27 Oct 2025 14:03:09 -0500
Message-ID: <875xc02mmq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vDSUq-003k73-LZ;;;mid=<875xc02mmq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19llrfM0ASu/wQG47exdcEA+09Q53itNIE=
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4990]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 510 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.47 (0.3%),
	 extract_message_metadata: 23 (4.5%), get_uri_detail_list: 2.5 (0.5%),
	tests_pri_-2000: 25 (4.9%), tests_pri_-1000: 3.7 (0.7%),
	tests_pri_-950: 1.71 (0.3%), tests_pri_-900: 1.32 (0.3%),
	tests_pri_-90: 127 (25.0%), check_bayes: 120 (23.4%), b_tokenize: 11
	(2.2%), b_tok_get_all: 9 (1.7%), b_comp_prob: 3.8 (0.7%),
	b_tok_touch_all: 92 (17.9%), b_finish: 0.96 (0.2%), tests_pri_0: 301
	(59.0%), check_dkim_signature: 0.79 (0.2%), check_dkim_adsp: 3.1
	(0.6%), poll_dns_idle: 0.58 (0.1%), tests_pri_10: 2.1 (0.4%),
	tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: sandals@crustytoothpaste.net, five231003@gmail.com, git@vger.kernel.org, tmz@pobox.com, gitster@pobox.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> The only possible source of flakiness in the tests I can see is the
>> possibility of t/t1016/gpg not getting called (which uses a fixed
>> timestamp).  It appears you just fixed that problem in commit
>> 516bf45749bb ("t1016: make sure to use specified GPG").
>
> I think that one also is in 'seen', and yet we saw t1016 flaky X-<.
>
> Let me isolate the relevant topics and test them again, i.e.
>
>     $ git checkout --detach v2.51.0
>     $ git merge --no-ff jc/t1016-setup-fix ;# 516bf45749
>     $ git merge --no-ff tz/test-prepare-gnupghome~1 ;# 6cd8369ef3
>     $ git log --no-merges --oneline v2.51.0..
>     516bf45749 (jc/t1016-setup-fix) t1016: make sure to use specified GPG
>     6cd8369ef3 t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
>     a35952b493 t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
>     $ make
>     $ cd t && ./t1016-*.sh --stress
>     FAIL 10.1
>     FAIL  5.1
>     FAIL 34.1
>     ...
>     ++ eval 'diff -u' '"$@"'
>     +++ diff -u signedcommit3_sha1 signedcommit3_sha1_expected
>     --- signedcommit3_sha1	2025-10-27 17:34:58.237496945 +0000
>     +++ signedcommit3_sha1_expected	2025-10-27 17:34:58.145497051 +0000
>     @@ -1 +1 @@
>     -de9cabc2419f97eb665452c198ed93e890a7ef87
>     +c87cd5157461a81b60ef6d3c47562c12b328ef54
>     error: last command exited with $?=1
>     not ok 163 - Verify commit signedcommit3's sha1 oid
>     #	
>     #			git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha1 &&
>     #			test_cmp ${name}_sha1 ${name}_sha1_expected
>     #		
>     1..163

Interesting.  With --stress I can reproduce the flakiness locally as
well.

I am starting to dig any but I haven't found any smoking guns yet.  So
far manually running the commands that resulted in the failure are
giving me the same output, but I have several more to run.

>> With that commit reverted I can reproduce the flakiness locally
>> by just running the test manually a few times.
>
> The above is with all three patches mentioned.
> FWIW, "gpg --version | head -2" says
>
>     gpg (GnuPG) 2.4.8
>     libgcrypt 1.11.2
>
> Hmmmm.....

I have gpg 2.4.7 but otherwise things are identical.

Eric
