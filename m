Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42B32ABCD
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809499; cv=pass; b=KY67uQ+h4rD7sqJ/pKKy6fs3/98+iIoflQJ+zpfZkoGHVrfJhbFDAAnGNv80mGVHOXNMQkpvj4l7tt3M2MuPD+hzzZc8kMl7h8VlYSfVobxxXOPqHKjBPrZG5HWhjc3wK3l0PnkxIBqWZv+0DZ6yjAlvJPUSU3GuBCuy03eE9PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809499; c=relaxed/simple;
	bh=pC25rfqwWG6ejs/U2QLP/cjGezVVe9OSKpavhTcRNfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tIvmJMYxiM0EiIjkUj4giGfYaJx/i/Xv+l/dEDDo+kwYqRyH6mhrupRTQMi407+uNyF1f3d1BqYqcBGvNbQBcdgfEIHifV85O8O1ClTuwtQAV7c0kK+W0WhQZfvau5SaRw1A9qK9fR99MiB5EvbfiGypp6kMry5ApWgg4gDJFU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=H8OSBJnT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="H8OSBJnT"
ARC-Seal: i=1; a=rsa-sha256; t=1767809487; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BKG7FScLWJ8cx8JLG8f8QSuYU9wZLzglT7zrvWTC20gKaH8gQw9itJIPyyabz5LqmDWGc3lgatVmrbC/G+yZOdM5osGRZyc+8pb7k6jVuJgfeilLKoI+HLSdATv0BsaISe8781DtE4yVOLPjjcyDwDl1gkihiutIdCKzDKYgj+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767809487; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pX/jTkTGvH6JpFnz5GRKIdd0j0RFI+V4xOZbZk4xooI=; 
	b=mUOHL5g0Hp6/Vx0r8YvbUvbMoHigHw1Lkn9JecYbR72y4a/oWvRqJRqenrkzmx8DppHAcZ2U7R9ElZFtjyNzZqGRR6yOfdLt9TA5OurfrVFqDpJaeqNRxTQ1bKziy19mQ7425kQRML7RWVeRDUqTZr8L+RvAXkQ9+c7gr03M99A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767809487;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=pX/jTkTGvH6JpFnz5GRKIdd0j0RFI+V4xOZbZk4xooI=;
	b=H8OSBJnTeLOJiOU6e4+iFIp0cdM0mXbIQHJnutiPDDUnVvBv4JUal1hyoCC/aQxW
	Se9P7QG6CN/G9PCxt1Lc82EFs+b1Qyn6HGyeioEMXCVKNqo4cngudLyk2xPOTZKebBJ
	QL/4h+z1zx4k51ZMHwxaUpYekJTcurRtpbWAKP6g=
Received: by mx.zohomail.com with SMTPS id 1767809484479761.3103358380359;
	Wed, 7 Jan 2026 10:11:24 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
In-Reply-To: <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
 <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
Date: Wed, 07 Jan 2026 20:11:19 +0200
Message-ID: <87y0m9guns.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 07 Jan 2026, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 07.01.26 um 02:30 schrieb Adrian Ratiu:
>> This adds a new check to detect HT in the middle of sentences that
>> should have been a SP, as suggested by Junio in
>> https://public-inbox.org/git/xmqqy0mwsedz.fsf@gitster.g/
>
> Generally, please review the commit message to follow the project's
> style: Use imperative mood in sentences the describe the changes ("Add a
> new check to...", "Supoort highlighting for tools like...", "Enable the
> new chaeck for...", etc.)

Ack, will fix.

>> The check is a bit complex because we want to detect places where
>> a SP was intended (HT can expand to more than one display column),
>> so we need to count both the display columns (col) and the string
>> character columns (i) to determine if a HT looks identical to a SP
>> or can cause confusion.
>> 
>> Highlighting support for tools like git diff/show/log is added, as
>> well as git apply --whitespace=fix capability.
>> 
>> The middle section of the line used to be assumed non-highlighted,
>> which is obviously not true anymore, so we split its logic into a
>> separate function named emit_middle_section().
>> 
>> The new check is enabled for Documentation/**/*.adoc, where these
>> kinds of mistakes were seen in practice. It can also be enabled in
>> other locations where it can be useful, by adding to the relevant
>> attributes file.
>> 
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 3c8eb02e4f..f5b6ceeed9 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -2440,4 +2440,147 @@ test_expect_success 'combine --ignore-blank-lines with --function-context 2' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
>> +	git config core.whitespace "-tab-between-non-ws" &&
>
> It might be worthwhile using test_config here, because this setting does
> not need to persist for the remaining tests.

Ack, will do.

>> +
>> +	printf "1234567\tb" >x &&
>
> What if you made the test cases into
>
> 	# only the TAB in the middle must be diagnosed
> 	printf "\t1234567\t12\t90\n" >x &&
>
> to test that only the second of the three TABs is diagnosed?

Yes we can do it this way.

>> +	git add x &&
>> +	git diff --cached --check &&
>> +
>> +	git diff --cached --color >raw &&
>> +	test_decode_color <raw >actual &&
>> +	! test_grep "<GREEN>1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
>
> This must be
>
> 	test_grep ! "...
>
> Furthermore, a negative test with a very tight pattern is often not
> desired: The test could fail if any single character does not occur
> (which could easily happen if the test text is changed, but not this
> pattern). In this case, it would be sufficient to test only that "BLUE"
> does not occur.

Thanks, I'm still a bit of a noob wrt the git codebase. Will do.

>> +	test_grep "<GREEN>1234567	b<RESET>" actual &&
>> +
>> +	# should apply without error because tab-between-non-ws is off
>> +	git diff --cached >patch.diff &&
>> +	git checkout HEAD -- x &&
>> +	git apply --whitespace=error patch.diff
>> +'
>
> There is t/t4124-apply-ws-rule.sh. Wouldn't the `git apply` tests be
> better located there?

I think so, yes, thanks for pointing it out.

>
> Please consider all comments on this test case repeated (and suitably
> adusted) for all other test cases added by this patch.

Will do.

>> +
>> +test_expect_success 'check tab between non-whitespace at tab stop (tab-between-non-ws: on)' '
>> +	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
>
> I am curious why you set tabwidth=8 here even though 8 is the default.

Just to make it explicit because I also set tabwidth=4 in the following
tests, however I can drop it.

>> +test_expect_success 'check tab between non-whitespace not at tab stop (tab-between-non-ws: on)' '
>
> With my suggested text above, this case does not need a separate test, I
> think.

Yes, it likely is redundant. I'll double check the tabwidth=8 test as
well because that might also be redundant and can be dropped entirely.

>
>> diff --git a/ws.c b/ws.c
>> index 6cc2466c0c..633bc69418 100644
>> --- a/ws.c
>> +++ b/ws.c
>> @@ -26,6 +26,7 @@ static struct whitespace_rule {
>>  	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>>  	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>>  	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
>> +	{ "tab-between-non-ws", WS_TAB_BETWEEN_NON_WS, 0 },
>
> How about "tab-is-1-space"? The documentation can clarify that not any
> TAB expanding to width 1 is diagnosed, but only those that are between
> non-space characters.

I like this suggestion as well.

Many thanks for the review,
Adrian
