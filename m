Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF3149DE2
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318500; cv=none; b=M8fuHcmL5s41+HWTwol5rUrml87qilKeouk0ChDTfQsN1k7jImRuJfZpYIhpSLpQW4ZRFW0koJf4h7ZhFIY64fVjO+2rsBNqrKOmV6mCl+P3d4YLRv/O/5yBvcJIUtxeFAZ5D0x9/H6VhWcVL0DZHJZeZloIbXwA5r8AuAOBZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318500; c=relaxed/simple;
	bh=dSEyZXebjWxE5t7D6j/uE7eTJ0NS5vEFGzGvNjW/pr0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl7defYhXZTLI/FoIJdEJ7qqoktuuJ5gvBWW4uXQ6xjW0OueqmlzTPZiSOE6pq2YCDITAgnb1bRX4HnziFR1fDP4yvHDHcyQwFIeShtVim85Da5OEpVUMnF4929c2/BhNqPznDeoeOEuEKRjXInCiWZyWPQPzeDzTgliFeb/P/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqnDrSb5; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqnDrSb5"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2598f517a33so2861911fac.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318498; x=1719923298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRlnsWzyKDGMO3T14UZpwNuEGHrEwAS/KCZfcgTcV4=;
        b=TqnDrSb52lt2OxeyFWp9CM8h7AJ9orC8FA77yWtgldwvnjEgDEWtGmOelDx7UPu526
         JM0nHXVj9qQHZOs5vTq8J1OksZoYlC834XmIxpIGBGqXiPYsAKwIoBUzJLNJhQ7rzUDq
         qylp6H34sE3ZkFsQDOo9n3jAGp0IUOLqnQMm9B0V12qK39uRAc16EKe49mav3Ylh5y5R
         sTizR8SpHt9g/XfbjbB4KndQbEdJjCxrfk02aBejY1fKLbSBWLvEhHXJIxcU2hoPHoZa
         ZZE7K0JQOLxy9wyX8Lsebj1gWSYOqkWrLoCJxx1Y0sTMXh0FN0Rrla8s+2Ge9WxQ+aJE
         PUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318498; x=1719923298;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRlnsWzyKDGMO3T14UZpwNuEGHrEwAS/KCZfcgTcV4=;
        b=EbpoaClGXSccL7pPO53AyTHtMuSrKKEwFsxTimRNeydGCyEYjSPuekz4Qn6mdBbBAB
         LijasKlimBB0m8bGldZgmMZky6akHE4IzbwnflDfs6ZijEM7mPo7O7rYGYOiDG9UbWhX
         jHJm766mKLZPfIfh12b3LvhWJy3tRvzsxYnM8ZpksTUSKRpLA6Vo0rtux4mbw0BC72Fu
         AFu1QOUP7uxz/LoWCfwMsByeKmpgvuirzwsmDnqrtC6oEBgJ3xYtHbf84B6PH77vszb7
         N5M0mxuH8UiMGT9q+R3j6uAZf9DxeI0qQAdnyq+RApi4oQdKEaK9fGpKdddoYiQOgf06
         pocQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7f7k5IusIOvtbmoI0Z7GY7AAnzIsWeNossdSL6k39jApeGtWQ+stNmpfGtmFQpuUIYupmqcghZWyZgHWlLGVAzT0F
X-Gm-Message-State: AOJu0YzuW3KvuQZqVlIq9x64/RSpY4kM758uYbkGwXUnaIM5NjVNnZfA
	3rxoevvvQrgZH1cSKJCMjEF5uqTOZ1W+DoqrOwfBKKBljcjY8YK4IsG9FKPgUVZXAGdBaEzHepA
	UdwUp5pPXCsO2Vakg3CdSiW2Atug=
X-Google-Smtp-Source: AGHT+IHnl7PFdN+NPFkUf4JRPJETiWLhLheZjnqp9vIC8ubzDZ0/d1URpJWQHvBRCp4LhNFuKww6xBrTc+SNF+FMcnA=
X-Received: by 2002:a05:6870:548c:b0:254:a588:ba9b with SMTP id
 586e51a60fabf-25d017b039fmr8813033fac.36.1719318498090; Tue, 25 Jun 2024
 05:28:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 07:28:16 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com> <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 07:28:16 -0500
Message-ID: <CAOLa=ZQEhT02TXgymD20J49HwAAkTeTqDBruuebwjkMzj1kjmQ@mail.gmail.com>
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: phillip.wood@dunelm.org.uk, Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000055bd5d061bb6086f"

--00000000000055bd5d061bb6086f
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Abhijeet and Karthik
>
> On 24/06/2024 11:56, Karthik Nayak wrote:
>> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>>
>>> When describe is run with 'dirty' flag, we refresh the index
>>> to make sure it is in sync with the filesystem before
>>> determining if the working tree is dirty.  However, this is
>>> not done for the codepath where the 'broken' flag is used.
>>>
>>> This causes `git describe --broken --dirty` to false
>>> positively report the worktree being dirty.  Refreshing the
>>> index before running diff-index fixes the problem.
>
> This is a good description of the problem the patch fixes.
>
>>> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
>>> Reported-by: Paul Millar <paul.millar@desy.de>
>>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>   builtin/describe.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/builtin/describe.c b/builtin/describe.c
>>> index e5287eddf2..2b443c155e 100644
>>> --- a/builtin/describe.c
>>> +++ b/builtin/describe.c
>>> @@ -645,6 +645,20 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>>>   	if (argc == 0) {
>>>   		if (broken) {
>>>   			struct child_process cp = CHILD_PROCESS_INIT;
>>> +			struct lock_file index_lock = LOCK_INIT;
>>> +			int fd;
>>> +
>>> +			setup_work_tree();
>>> +			prepare_repo_settings(the_repository);
>>> +			repo_read_index(the_repository);
>>> +			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
>>> +				      NULL, NULL, NULL);
>>> +			fd = repo_hold_locked_index(the_repository,
>>> +						    &index_lock, 0);
>>> +			if (0 <= fd)
>>> +				repo_update_index_if_able(the_repository, &index_lock);
>>> +
>
> As we're dealing with a repository that might be broken I suspect we'd
> be better to run "git update-index --unmerged -q --refresh" as a
> subprocess in the same way that we run "git diff-index" so that "git
> describe --broken" does not die if the index cannot be refreshed.
>
>> I'm wondering why this needs to be done, as I can see, when we use the
>> '--broken' flag, we create a child process to run `git diff-index
>> --quiet HEAD`. As such, we shouldn't have to refresh the index here.
>
> "git diff-index" and "git diff-files" do not refresh the index. This is
> by design so that a script can refresh the index once and run "git
> diff-index" several times without wasting time updating the index each time.
>

I see. Thanks for correcting me!

>> Also apart from that, we should add a test to capture the changes.
>
> That would be nice
>
> Best Wishes
>
> Phillip
>
>
>>>   			cp.git_cmd = 1;
>>>   			cp.no_stdin = 1;
>>> --
>>> 2.45.GIT

--00000000000055bd5d061bb6086f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1dfcae68009d6e12_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNnQ5OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFpxQy8wVkt4SWp6bVE1L1RoVE15S0RpSW94NGdaSwpjdVZmZnZ2bFR4
bkp1bjVEbVZGQ2lJUmhVeDhhUlFRdUpycFZxRG9kanhBNzRWbVQ1NHFScWsvd1ZjZWU0azdnCmpm
VytqYUVWRzM1MlZWam1WdzZSRzJmZWhNK003N29nQkYwUHh6bVRxUC83U2Y0MkF1ZzlJeEg3eTdZ
QU1mMXIKNzU5QXRKYTVmbCtkeUtoMVNOUW9vZVdCQVgzZWE5QVJmYkJYV2tPZ1BPeHNpaVhLdml3
bGM4S2IvZlQ4OHozZwpGcUpobThpdGx4SzBRb2NHS0NKQXFjcy8xdTN0bDVabEU5a3lxUHlGZzJx
Wkh1K1FqWmZGM2Znb2dkTGNMcDhDCmJnT0FhOUo2YzY2Rm9SUVNPS09YQUZmcW5nZFRKNmZmTzNs
ci9yU1BUK0VBRHFKSkVRMkYvZDVvS3VDRmwwVlMKY1A3bHhkUW9oajdNcW5XczRLS1B5WDR6N0R3
OEN0NGZWcWx5aXZnR1NndkNxaDlTWW1UV1BzUWpuRFJ6eVpGbQpVaEFENnRUekZlQUNBNE8xcTR1
RXIzM1JURzVBUDV0bkZEek5MRUpHVmZnZ0Y0SWloNFd6YlBURzVjTVZUQy9CCmFaR3hQNEtUNjBt
NlVJL0w3R3paaEhSM1JndzVmZ2Yrc244S214OD0KPVNCcnAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000055bd5d061bb6086f--
