Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC0748F
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596257; cv=none; b=iezm6gwdlC9YyjErWColwaxaE5OAvY0gMczJGpM6LbyfmrBhqTDqxhGsvuzKIYWqYkSwBY49RfxrVwIIL07FowRpCJsNNnIP5s6jh8jIo/mzTx++ZQ2SoODTUxrateSx41LHzuGGPAFIeemMDy7fO/bOHLkp0/iqXDhWedavG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596257; c=relaxed/simple;
	bh=6lFWz3PQWLh5oqc3G964ySbKutcm6CO6kQDqvuN2puM=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=uASPY6rzFxtFGtrXI4jQv9VMyFPtdwyeEcuv2KVjyg6BUZ1f88cbD+rt4w3Jp1xAyPqxfFvQPyla0onmtdjk9jibLL9qjoTHDr5xvDTlHSr5B0/eNT1/cHlKwmEKFwyxekRPu1LF0xQFFDfHxcPfKlk+ezBQbji6Th9wUNDnVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:44966)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDSxB-006KLS-9b; Mon, 27 Oct 2025 13:32:29 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:41906 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vDSxA-004PeB-2u; Mon, 27 Oct 2025 13:32:28 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
In-Reply-To: <875xc02mmq.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 27 Oct 2025 14:03:09 -0500")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
	<xmqqqzuoi6sg.fsf@gitster.g>
	<875xc02mmq.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Oct 2025 14:32:24 -0500
Message-ID: <87o6ps16pj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vDSxA-004PeB-2u;;;mid=<87o6ps16pj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19vv5SgoY1QygobgMUwg2W58HAIfiOMeNQ=
X-Spam-Level: ****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4991]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.2 XMLngstWrd_00 words over 45 charachters don't exist
	*  0.2 XMLngstWrd_01 words over 55 charachters don't exist
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 722 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.00 (0.1%),
	 extract_message_metadata: 24 (3.4%), get_uri_detail_list: 7 (1.0%),
	tests_pri_-2000: 22 (3.0%), tests_pri_-1000: 3.2 (0.4%),
	tests_pri_-950: 1.79 (0.2%), tests_pri_-900: 1.33 (0.2%),
	tests_pri_-90: 208 (28.8%), check_bayes: 206 (28.5%), b_tokenize: 20
	(2.8%), b_tok_get_all: 109 (15.1%), b_comp_prob: 5.0 (0.7%),
	b_tok_touch_all: 67 (9.3%), b_finish: 1.38 (0.2%), tests_pri_0: 429
	(59.5%), check_dkim_signature: 0.72 (0.1%), check_dkim_adsp: 2.5
	(0.4%), poll_dns_idle: 0.61 (0.1%), tests_pri_10: 2.2 (0.3%),
	tests_pri_500: 14 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: sandals@crustytoothpaste.net, five231003@gmail.com, git@vger.kernel.org, tmz@pobox.com, gitster@pobox.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>
>>> The only possible source of flakiness in the tests I can see is the
>>> possibility of t/t1016/gpg not getting called (which uses a fixed
>>> timestamp).  It appears you just fixed that problem in commit
>>> 516bf45749bb ("t1016: make sure to use specified GPG").
>>
>> I think that one also is in 'seen', and yet we saw t1016 flaky X-<.
>>
>> Let me isolate the relevant topics and test them again, i.e.
>>
>>     $ git checkout --detach v2.51.0
>>     $ git merge --no-ff jc/t1016-setup-fix ;# 516bf45749
>>     $ git merge --no-ff tz/test-prepare-gnupghome~1 ;# 6cd8369ef3
>>     $ git log --no-merges --oneline v2.51.0..
>>     516bf45749 (jc/t1016-setup-fix) t1016: make sure to use specified GPG
>>     6cd8369ef3 t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
>>     a35952b493 t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
>>     $ make
>>     $ cd t && ./t1016-*.sh --stress
>>     FAIL 10.1
>>     FAIL  5.1
>>     FAIL 34.1
>>     ...
>>     ++ eval 'diff -u' '"$@"'
>>     +++ diff -u signedcommit3_sha1 signedcommit3_sha1_expected
>>     --- signedcommit3_sha1	2025-10-27 17:34:58.237496945 +0000
>>     +++ signedcommit3_sha1_expected	2025-10-27 17:34:58.145497051 +0000
>>     @@ -1 +1 @@
>>     -de9cabc2419f97eb665452c198ed93e890a7ef87
>>     +c87cd5157461a81b60ef6d3c47562c12b328ef54
>>     error: last command exited with $?=1
>>     not ok 163 - Verify commit signedcommit3's sha1 oid
>>     #	
>>     #			git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha1 &&
>>     #			test_cmp ${name}_sha1 ${name}_sha1_expected
>>     #		
>>     1..163
>
> Interesting.  With --stress I can reproduce the flakiness locally as
> well.
>
> I am starting to dig any but I haven't found any smoking guns yet.  So
> far manually running the commands that resulted in the failure are
> giving me the same output, but I have several more to run.

So far in the two should be identical sha1 and sha256 repositories
I can confirm the failure is because the repositories are out of sync.

The sha256 gpg signatures match
The sha1 gpg signatures do not match

Which is very weird.  If they both didn't match it would be easy to
explain.

This is starting to look like this is a case of the test doing it's job
and finding a problem, rather than a problem in the test infrastructure.

I will keep digging.

git/t/trash directory.t1016-compatObjectFormat.stress-failed$ ../../git --git-dir=repo-sha256/.git cat-file tag signedtag34
object 94ee57ed028bc464ec9f9dc1d9c4b8c09fd89ac00e34b2bae3105803a995a6cd
type commit
tag signedtag34
tagger C O Mitter <committer@example.com> 1112354055 +0200
gpgsig -----BEGIN PGP SIGNATURE-----
 
 iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCZQhxPBYcY29tbWl0dGVy
 QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN3wIAoLYbVnmMIQnKqAfCDEtLGKDgH+M4
 AKDNi19wI7o7yWzThiujYZ422iMRGA==
 =lsWm
 -----END PGP SIGNATURE-----
 
This is an additional signed tag
-----BEGIN PGP SIGNATURE-----
 
iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCZQhxPBYcY29tbWl0dGVy
QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN21sAn2RYjMjcngN6AqBeo9RmIUn7NnWY
AJ97WUStWCcHXMkxU+HVPeuA/CvPYw==
=7Jpz
-----END PGP SIGNATURE-----
git/t/trash directory.t1016-compatObjectFormat.stress-failed$ ../../git --git-dir=repo-sha1/.git cat-file tag signedtag34
object 9ea30d18399b9957ce40766318510dab211d747b
type commit
tag signedtag34
tagger C O Mitter <committer@example.com> 1112354055 +0200
gpgsig-sha256 -----BEGIN PGP SIGNATURE-----
 
 iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCZQhxPBYcY29tbWl0dGVy
 QGV4YW1wbGUuY29tAAoJEBO29R7N3kMN21sAn2RYjMjcngN6AqBeo9RmIUn7NnWY
 AJ97WUStWCcHXMkxU+HVPeuA/CvPYw==
 =7Jpz
 -----END PGP SIGNATURE-----
 
This is an additional signed tag
-----BEGIN PGP SIGNATURE-----
 
iHQEABECADQWIQRz11h0S+chaY7FTocTtvUezd5DDQUCZQhxPRYcY29tbWl0dGVy
QGV4YW1wbGUuY29tAAoJEBO29R7N3kMNvn4AmwRHkPsmDmKgUB6r1XP4dSzXWw+G
AKCEzEgk2bHuKv6d2L/M0bzseGlOfA==
=G+Gp
-----END PGP SIGNATURE-----

Eric
