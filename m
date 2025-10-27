Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451830F92F
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583969; cv=none; b=sMfDWk2ez4V3/YSGdmFNVdkcvKJp1NCcDIgeXXuzeoLJh+tDf6MBGUrxxAjHvKoybvLemwf2RseSfYVbTv2UDnbbrBLZb6gY8IHwgArlAtj1tTBQAhMjnl+Bd1DnuOAqY34OB5PG8piKYe+fxrpFNjL9+8UwWbHS05+vnUR5J68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583969; c=relaxed/simple;
	bh=Z6lXrgh0szIy9vbeqOXkFH+S9uxmDHYfOXTc9ixj6kw=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ppHq/e3zi0O+4uFenG4VM4yJMChtSp+J2aL2qN2p3OXtlf0Fypqx8w5Bxv1qFSadZVjWmXsEqm9khDwaAFcYPLbwkw1IA4hBCaBlEmOJaeks/2UjcRQcQazeMPeGG3J++kFjG26qFw1Mpp7HiYcQsnDwZbinDX+v7Zf1ZB0QbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:51416)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDPtq-00G3tS-QA; Mon, 27 Oct 2025 10:16:50 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:42556 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDPtp-00422J-NR; Mon, 27 Oct 2025 10:16:50 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
In-Reply-To: <xmqqbjlump3m.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	25 Oct 2025 18:25:01 -0700")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 27 Oct 2025 11:16:45 -0500
Message-ID: <87zf9c8glu.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vDPtp-00422J-NR;;;mid=<87zf9c8glu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/p0FtHpaGEZLnQyMqY0pWj5OsisLrv74A=
X-Spam-Level: ***
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.5 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.2160]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XMLngstWrd_01 words over 55 charachters don't exist
	*  0.2 XMLngstWrd_00 words over 45 charachters don't exist
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 603 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.6 (0.4%), parse: 0.76
	(0.1%), extract_message_metadata: 15 (2.4%), get_uri_detail_list: 3.0
	(0.5%), tests_pri_-2000: 9 (1.5%), tests_pri_-1000: 1.85 (0.3%),
	tests_pri_-950: 0.94 (0.2%), tests_pri_-900: 0.77 (0.1%),
	tests_pri_-90: 128 (21.2%), check_bayes: 125 (20.6%), b_tokenize: 8
	(1.4%), b_tok_get_all: 9 (1.6%), b_comp_prob: 2.4 (0.4%),
	b_tok_touch_all: 101 (16.7%), b_finish: 0.81 (0.1%), tests_pri_0: 433
	(71.7%), check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 2.7
	(0.5%), poll_dns_idle: 1.33 (0.2%), tests_pri_10: 1.79 (0.3%),
	tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: sandals@crustytoothpaste.net, five231003@gmail.com, git@vger.kernel.org, tmz@pobox.com, gitster@pobox.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Junio C Hamano <gitster@pobox.com> writes:

> Todd Zullinger <tmz@pobox.com> writes:
>
>> I've intended to dig into it further over the past few
>> months but have not managed to spend enough time to work out
>> the root of the problem.
>>
>> I hope that someone more familiar with these tests (or
>> perhaps someone with fresh eyes) will spot the problem.
>>> 
>>> A number of these fail, e.g.:
>>> 
>>> https://github.com/tmzullinger/git/actions/runs/9780387020/job/27001952643#step:4:1871
>>> 
>>>     Error: failed: t1016.173 Verify commit signedcommit4's sha1 oid
>>>     failure: t1016.173 Verify commit signedcommit4's sha1 oid 
>>> 	    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
>>> 	    test_cmp ${name}_sha1 ${name}_sha1_expected
>>>       
>>>       + git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 5d70155cc40e4c16515c89ad0b11d8c691436fc4a4d3ca246669a4c21f07e454
>>>       + test_cmp signedcommit4_sha1 signedcommit4_sha1_expected
>>>       + test 2 -ne 2
>>>       + eval diff -u "$@"
>>>       + diff -u signedcommit4_sha1 signedcommit4_sha1_expected
>>>       --- signedcommit4_sha1	2024-07-03 15:11:05.597537579 +0000
>>>       +++ signedcommit4_sha1_expected	2024-07-03 15:11:05.553537766 +0000
>>>       @@ -1 +1 @@
>>>       -9179ccc5b15588bc3a45c5cc75bdec380f8ccb86
>>>       +c6c46f92bc2cfda57ad6bf7981fa654825376b24
>>>       error: last command exited with $?=1
>>>       not ok 173 - Verify commit signedcommit4's sha1 oid
>>>       #	
>>>       #		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
>>>       #		test_cmp ${name}_sha1 ${name}_sha1_expected
>>>       #	
>>> 
>>> This seems like it's just exposing a pre-existing failure,
>>> as I can't imagine how creating GNUPGHOME would cause the
>>> actual and expected SHA's to differ. :)

Hmm. Let me see.

The test goes through and creates 2 repositories, one sha1 and the other
sha256.

In those repositories a gpg signed commit is created.
That gpg signed commit should contain both the signed sha1
and the signed sha256 gpg signatures.  As both object-format
and compat-object-format are set in the config.

Then the commit is extracted and one of the signatures removed.

Then the oid of the signed commit with only a single signed gpg
signature is computed.

In the sha256 repository the sha256 oid is given to get the sha1 oid.

That sha1 oid is of the signed gpg commit is compared with the
previously computed sha1 oid.

So I think a messed up GNUPGHOME could result in the wrong signing
key being used.  Though how that signing key could be inconsistent
from one part of the test to the other I don't know.

Not seeing t/t1016/gpg as the gpg program does look like a more
likely cause of the error there.

>>> 
>>> Perhaps the intended gpg wrapper script which sets
>>> `--faked-system-time` isn't being used?
>>> 
>>> I'm not sure why that would differ in the Github actions
>>> from my local builds, but I don't know what else differs in
>>> the Ubuntu images and/or environment used by the actions.
>>
>> I have run a good number of builds with the patches applied
>> and t1016-compatObjectFormat regularly fails for all of the
>> tests which use the GPG2 prereq.  A recent Github CI run is
>> here:
>>
>>     https://github.com/tmzullinger/git/actions/runs/13570544425
>>
>> I think this test flakiness should be fixed so that we can
>> apply the patch to fix the GPG2 prereq.  As it is, we're
>> skipping _all_ of the tests which require GPG2.
>
> Any progress or responses?  All of these tests, that nobody seemed
> to have caught breakage of because they weren't being run anyway,
> seem to be flakey with the new GNUPGHOME set-up.
>
> I am tempted to do this in the meantime, but I'd really prefer not
> to have to do so, assuming that these tests, when fixed, would be
> materially contributing to the health of our codebase.

I just dug into this a little and hopefully I have paged enough
state back to understand this.

In my testing a missing GNUPGHOME appears enough to prevent the
prerequisite from succeeding. So let's fix that. Todd Zullinger's sent
some nice patches to do that (up-thread), or you can take use my minimal
version.

The only possible source of flakiness in the tests I can see is the
possibility of t/t1016/gpg not getting called (which uses a fixed
timestamp).  It appears you just fixed that problem in commit
516bf45749bb ("t1016: make sure to use specified GPG").

With that commit reverted I can reproduce the flakiness locally
by just running the test manually a few times.

I believe I used the GPG2 prereq because I don't have the older version
of GPG to test with.  So I don't know if t1016 would work on the older
version of GPG or not.


diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 937b876bd052..c4bbedfe081e 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -62,6 +62,8 @@ test_lazy_prereq GPG2 '
 		exit 1
 		;;
 	*)
+		mkdir "$GNUPGHOME" &&
+		chmod 0700 "$GNUPGHOME" &&
 		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&


Eric
