Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBEA37E2E7
	for <git@vger.kernel.org>; Mon, 18 May 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118051; cv=none; b=ply9IByzkxw1uMXHHF78fw3zMoyWg18HDZM0q7IU2YMCkCADkLXPdr3AoCqrI3M7gExOXhqwUzvG1mSfSS/07OHuDRhFycvF5U4qbb3h4RBPa97vMR7Zkj5GLyWcfM7+RfcDskpyiJO9Rp1KG1RHhAVJA+m/G9sbNlkFTNZi8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118051; c=relaxed/simple;
	bh=oNVryqfcqsIRScLhniL0bG2ClmPWYxHnMRG7XMLllNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGaLhnrnoBs6PpJKlyYS0vOfKyNPxr/Vo3PnG8RwMgnTCejTuyNd+phRdv9ZwzmaHpaRgKWsk8UETQxYiEdz14lwjl0Nv5fL3lExyrw24chejDoyG0Lwdzc3vJ0Aq8FjIm6cfyZhHcaMM+HcHyYxX3HeNATOaF3g0zwvC233T28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvcY7kh3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvcY7kh3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so19676305e9.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118047; x=1779722847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3e1QYikQEpfU/Jq6SRqu68pANggGg2cqfl2ikNmuboo=;
        b=BvcY7kh3CcB3Y19GKXJFKIYUsnpUIH18EmZn2euW9tIL2J4yES1nTQhaI0qVMH1tfp
         fJyPJm0V3X6Epte8eZa+854snDNysshec9sJ0/WZkpvF8tXwaVqCzfGx+sUsgOtR87hD
         piQAWuYLdOcHBhaXTSI2ro6h5mFFuZYXSEAun9VZT5eurpIk+mMLIxSCvfhHgMPvpDCV
         FWF11iT0e1hw9bPYcs5P1SRITY1Ra//TOoxWmNpEaRQB6dEe8p3NHCh67O77POR1SACi
         klNKMqBXN8hdGx6KUgOZdrZdcsFF9j2d/pPNcTrHEDjQrztVK2hd1npCnMEAHjRwfSAD
         bmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118047; x=1779722847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e1QYikQEpfU/Jq6SRqu68pANggGg2cqfl2ikNmuboo=;
        b=IFCkDeeYHexpwDPmP02oKgVtmuXIEpAxvMrHzAFMLq7KJ7D8msJyCkXfrlg5EOY27I
         OU7iUw97mRTdqF1kCN2BU7+Y/feV2QhAwUePlbZ1Nme5ELyR386SOkLYnfyZj9jyQQfo
         7V9I8iD0nobb2xchMNcjAM+ckP/sIq+WYf5PbIIJVWhlm1KpV0oZqLoPCumZYoHNLmBd
         zO9ACqEvPLlNqEsPXsecG0kjhNu15WbApGtQknug1V0GCmgcHYdZC2qECewXF4cjdjt3
         fA6dLs/MsizXTu5o1o5Jgu6xWe38fSbjrunDyuuNFGMmaVkRV6pFPp+DiHqif4Qh6WLQ
         HYGw==
X-Gm-Message-State: AOJu0Yy9jq+chkYVOddSayKoqxUnDwHr+Ec0jWWOQmZNyQ9PcLg8izki
	t98tvN+Sgf9XkPH3MvHJiRJ9VQU2XI+VT0yMAd/BKwK5d1F7IHvGRlBhN2JMwg==
X-Gm-Gg: Acq92OER2C4p4Rdf7lFSJu8v10jQUVgC+vmBc2B+O1pJTXd6ZiZsfkFV8J4YwZGyHhN
	pY0nJElux97VKIZjWV3y6TfWd/qGziSIVu3eOtPfI7dWlbHMeoU+Dlu1fSL04AxxcKDmMVtMN2b
	4NOkq5YTdkKGDJc/1QXdv7xdR3fO1EU03kwtfqRIb1cvUZ6kK8ASnG/ZlPtPNivsATGTpg0UI6y
	KTQoHzctM7bDHniXu4x5c0AIdHoertDCwXm1nidyz3qrOkMyktwW5cIpaYTSmj02BBnWAv4Rur6
	Dq0lFWxILDtgw9MqFDTms3er2UCXDPUSQZrEtymPLEeFNyUQ62fS3WS+EXjZSxaDX79dcKMflX2
	FacwdUvdyT63lnuGxdQoH5evVmEXXrHRfCqnGSlt3JW8GaYOSic936wVbx7IRPM5ZbQurwL+UHu
	oVRJ//9o1oZ2zkp971Yi1SDwXojV6bgeFsPiZcxQRKCrM9OwGwXtfpEHM2UWmU/HKpcjWUfc1X5
	jXLlA==
X-Received: by 2002:a05:600c:c096:b0:48f:d1b8:9aaa with SMTP id 5b1f17b1804b1-48fe60e525bmr179452075e9.6.1779118046399;
        Mon, 18 May 2026 08:27:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7da11sm83352265e9.32.2026.05.18.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:27:25 -0700 (PDT)
Message-ID: <ac6aaaca-2b7c-4892-ba93-0dc3e3c18ff7@gmail.com>
Date: Mon, 18 May 2026 16:27:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] commit: allow -m/-F with --fixup=amend: or reword:
To: Junio C Hamano <gitster@pobox.com>, erik@cervined.in
Cc: git@vger.kernel.org, charvi077@gmail.com
References: <20260518112225.73172-2-erik@cervined.in>
 <20260518112225.73172-4-erik@cervined.in> <xmqqik8kc2nj.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqik8kc2nj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 13:39, Junio C Hamano wrote:
> erik@cervined.in writes:
> 
>> From: Erik Cervin-Edin <erik@cervined.in>
> 
> The name on this overriding in-body From: line, and the name on
> Signed-off-by: line below, must match.  Please pick a name with or
> without hyphen and stick to it.
> 
>> --fixup=amend: and --fixup=reword: require an editor to supply the
>> replacement commit message. The -m and -F flags are rejected: -m is
>> caught by a die() in prepare_to_commit(), and -F is caught by
>> die_for_incompatible_opt4() which groups -F with --fixup as mutually
>> exclusive. This makes these modes unusable in non-interactive
>> workflows -- notably AI coding agents.
> 
> "Unusable" may be stronger than reality, as you can make creatie use
> of GIT_EDITOR to achieve what you want.  "awkward" or "poorly suited"
> would be more fitting.

Indeed

>> Plain --fixup (without amend: or reword:) continues to reject -F but
>> still accepts -m (even though it's practically a no-op).
> 
> Is it "practically a no-op"?  Wouldn't
> 
>     $ git commit --fixup <commit> -m "message body"
> 
> be useful to leave a message in the resulting commit, which is later
> to be squashed into the named <commit>?  Actually squashing with "fixup!"
> may lose the message supplied here, but wouldn't people use this
> facility to more easily identify what each of the fixups are about?

Yes, I find it quite useful to make a note of what the fixup is doing if 
I know I'm not going to squash it for a while.

> For the same reason, "-F" would be just as useful as "-m" in this context,
> and it feels a bit inconsistent to allow one while rejecting the other.

Yes, looking at the way the code is structured I wonder if these options 
were made incompatible to simplify the implementation, or maybe the 
implementation merely reflects those restrictions.

>> @@ -1821,6 +1824,22 @@ int cmd_commit(int argc,
>>   	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>>   					  builtin_commit_usage,
>>   					  prefix, current_head, &s);
>> +
>> +	if (logfile && fixup_message && !strcmp(fixup_prefix, "amend")) {
>> +		if (!strcmp(logfile, "-")) {
>> +			if (isatty(0))
>> +				fprintf(stderr, _("(reading log message from standard input)\n"));
>> +			if (strbuf_read(&message, 0, 0) < 0)
>> +				die_errno(_("could not read log from standard input"));
>> +		} else {
>> +			if (strbuf_read_file(&message, logfile, 0) < 0)
>> +				die_errno(_("could not read log file '%s'"), logfile);
>> +		}
>> +		strbuf_complete_line(&message);
>> +		have_option_m = 1;
>> +		FREE_AND_NULL(logfile);
>> +	}
>> +
> 
> It is curious that for this new feature alone, but not the other
> existing code paths, "-m" and "-F" options reads from file in the
> new code here, instead of letting the existing code for "-F" to read
> (which happens inside prepare_to_commit(), I presume?).
> 
> A potential problem of the above code is if we find something wrong
> in message and complain later in the control flow, we have long lost
> where the message came from, as the point of the above code is
> exactly to pretend that "--fixup:amend/reword -F" message did *not*
> come from a file with the "-F" option, but from the command line via
> the "-m" option.

It is indeed unfortunate that we end up duplicating the code to read the 
logfile here. I wonder how hard it would be to refactor 
prepare_to_commit() so that it can accommodate "--fixup=amend:<commit> -F"

>> +test_expect_success '--fixup=amend: with -m option' '
>>   	commit_for_rebase_autosquash_setup &&
>> -	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
>> -	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
>> -	test_cmp expect actual
>> +	cat >expected <<-EOF &&
> 
> This comment is not about the added logic, but I notice that among
> 86 hits with string "expect" in this file in today's "master", only
> 14 hits are with string "expected", i.e., the prevalent name for the
> "golden copy result" that is compared with the actula result (called
> "actual") is "expect", not "expected".  Please do not make the
> situation worse.

In this case it would be better to use

	test_commit_message HEAD <<-EOF
	amend! $(git log -1 --format=%s HEAD~)

	amend commit message
	EOF

and avoid creating actual and expect all together.

Thanks

Phillip

