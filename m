Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8D23A6
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399635; cv=none; b=Ii121gIeUZlHgM5nZzC18l+dKEY5V4iLa342fHWx0iacNEAZ7irJzQLCMnlWLyoOdvwDqRN6bbyGLwyWObKMir5aYp3KVQ/FJce2tNgrTGrc9tMVYh7Sp/d/cgOuic72EBMtRKvpWujCLfcIs0IJ8fgA49Y1R7VH9+Dj8D7NJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399635; c=relaxed/simple;
	bh=Hnbl28Orer5MlxIyTJx7hnz+CIL0aZvwVI1lPlUwETU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYRzc0Zhbi01aG7VTHtAY0Qh3106Cj49QN5G22MdihxrLNGPrGlVNccPmJUDR7nNCwoOQ36BoXJuisuMU+uVSMjo1GaKrBUBjniyEemm/6+ZkFMFF/JkkDNrpiPqZ98PyjNZRrabcVGdKejzn5wvicHru+H4WiarrD63/xmDZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S14vuQBj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S14vuQBj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 657811E144D;
	Sat,  2 Mar 2024 12:13:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hnbl28Orer5MlxIyTJx7hnz+CIL0aZvwVI1lPl
	UwETU=; b=S14vuQBj83IQOlTINl6Z0GcJwGru/7uRwvFf9PIOUH9FedGIKWXJ+s
	aM7w9UWj79jN1B6ADDDfQSAR3xO6zK3K9EJNFnsxtljCCutgoXPbILYjoPKX104c
	CZyQp1xtsOnsMxtc/ge5XF8hvrke0TAlKgkUWKIP1DneWL5fovcbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DA371E144C;
	Sat,  2 Mar 2024 12:13:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEA881E144B;
	Sat,  2 Mar 2024 12:13:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Sergius Nyah <sergiusnyah@gmail.com>,  git@vger.kernel.org,  pk@pks.im,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC][PATCH] userdiff: Add JavaScript function patterns
In-Reply-To: <CAP8UFD1sAYORc_q20t4Y28mSjNa0BZ69XQ-hGFsNTzbThsG1KQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 2 Mar 2024 11:28:48 +0100")
References: <xmqqttlsjvsi.fsf@gitster.g>
	<20240301074048.188835-1-sergiusnyah@gmail.com>
	<CAP8UFD1sAYORc_q20t4Y28mSjNa0BZ69XQ-hGFsNTzbThsG1KQ@mail.gmail.com>
Date: Sat, 02 Mar 2024 09:13:51 -0800
Message-ID: <xmqq5xy4zhdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E6D599C-D8B8-11EE-8087-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> +       # check results
>> +       test_i18ngrep "function myFunction() { return true; }" output &&
>> +       test_i18ngrep "function myFunction() { return false; }" output &&
>> +       test_i18ngrep "var myVar = function() { return false; }" output &&
>> +       test_i18ngrep "var myVar = function() { return true; }" output
>
> I think we try to use just test_grep instead of test_i18ngrep these days.

Thanks for reminding.  I am tempted to suggest doing this.

------ >8 ----------- >8 ----------- >8 ----------- >8 ------
Subject: test_i18ngrep: hard deprecate and forbid its use

Since v2.44.0-rc0~109 (Merge branch 'sp/test-i18ngrep', 2023-12-27)
none of the tests we have, either in 'master' or in flight and
collected in 'seen', use test_i18ngrep.

Perhaps it is good time to update test_i18ngrep to BUG to avoid
people adding new calls to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git c/t/test-lib-functions.sh w/t/test-lib-functions.sh
index b5eaf7fdc1..6eaf116346 100644
--- c/t/test-lib-functions.sh
+++ w/t/test-lib-functions.sh
@@ -1263,9 +1263,8 @@ test_cmp_bin () {
 	cmp "$@"
 }
 
-# Deprecated - do not use this in new code
 test_i18ngrep () {
-	test_grep "$@"
+	BUG "do not use test_i18ngrep---use test_grep instead"
 }
 
 test_grep () {
