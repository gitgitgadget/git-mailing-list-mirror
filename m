Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710761;
	b=4gYsaJaA6rGm5wpfD83IIiACCk6nwzkZFwba1HUNEUKKTWUqDs97Bm2H4ftrwVSu1JQK
	 yg15h5M6NEHKClJSLYfUzGCND2Eav8QeVKIhJNelV8fHImB7S5J9ql+hA4mTq4a+penMt
	 8cYYR96FFBxATJ4N5Ti0scSJ6m10zCYlyfX40Hd4ajPKg1PFTqLC1mmMFk8r0J3B2wQNQ
	 6cHEGgj0EY4ev9n/ayH5e+gIdtQsFzQ72ttwZIXdVnk8tDHm0uvEDvBFqAPCMx9CA1nFN
	 FlEQ+Hk+YWPn8BgZnaTEMif3CHXoVX2dGAx6uIsQIa/yqSoRETXoaYeVSVzj9nsjdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YExCX8gDC+XVCpq7M3No9fKM+sEC3TWzDwyJhZCu9B4=;
	b=Wf8VRMYIlEwFnJ20yUbsqJRQ30gjijnlcIT2zJV9WAJdbdE8ivvuG7k0nWXVWODIAaVt
	 dTFGUJR55IPzzd217ZG3r+xq0qsjJx7JSoAucQMgq/tfojOMuoi0kFogIVZ/sJu1B7SUS
	 myDwAbfUTGxmTIBhYwoI+Sk+qlyTmaTH36QJ1ZnGotjgVdCDD1RPBsXpi0oac6cjn18Ad
	 //wJmmaXH26BhDijG/AQdX9ywCwT9eigk3aHU+m9g0AEtqgbkc2HrOM31AE4f+fZHKxu7
	 OZU7xk8SnZR0Hbcnw+Bo/wNvF49o//QWq/t0C7fReeOs97EIdt4RmccBFRop5FrLREg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="erI/EGjr";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B39606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=erI/EGjr
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so3968148f8f.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710759; x=1796315559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YExCX8gDC+XVCpq7M3No9fKM+sEC3TWzDwyJhZCu9B4=;
        b=erI/EGjrjj6uOSrg+gM+6nmuv9UafRixPYR09tUYKCW5DnvyPFPLe83l1IdqFOnuYZ
         3TUnlUYmyXvteGsTMsyhf2m47ZsOqtbeqFk3gKzQi39A4LDwVVjMAf1Ekn1xGKJw6GR6
         npY7EVQOpjkPDHc36jG/ipE6i9iuhhOsqI+BVEqIEycgSY515KDqbudCktKUqB3RfcP+
         1QOLgH0pzGl1wLnVAtcKI/2S5s8zlLBClqB4XafmCbiNH8vqTVID/VAJy6LnTo6qk8ZM
         ObENhw1KUxr0zwKyljsTJBgzqH3MfCbjkCgNP3hYp3WoS0zOs+VXrwm+EzMoj3hAOz0/
         8o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710759; x=1796315559;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YExCX8gDC+XVCpq7M3No9fKM+sEC3TWzDwyJhZCu9B4=;
        b=g2SDFdC2D5jXJXrjbIDEj/HzXEOXjnKXlWOvUiTdy4/rIe/gysVKNwiSmZXtNe8ez5
         j0iSon73ZriOhorZmy0IQe+b4ErxAdE1aDaB8qFcwWVB2CgdsU3JShaCFc08QA6YA12y
         XSYdcSKKiN3I39WA4qzkdUBTSHNkKSHqSb7Us+0pqcq1t/Jd/T/2acJS94wYjuPB5xzC
         s89oy+HPvz2et0tHvd0mk3Y3ZvQDRYux6QkFHz5KtZSj7nbwFAdREzHmzYALQ20P0oyw
         P9H/1gXJeSBuz+LG1nF8vljDd36nXhxzFRouT7sfnCbJSXJVsgM1eh4vTKhKXMu8TzWd
         YJeQ==
X-Gm-Message-State: APuU4Z/tIbROLhyJhaHRIgpnwEOmUn9blh6zEE6W+xpgxvKFUkSuerB3
	MSIe7JWh94Sn9skr3QI7seSjYVyo5PxUDAJXtHnZV8SjyVV/mre54T4r
X-Gm-Gg: AZFdTZdRhuJc4toSQ5uIha0xFDMfFJ9AbGAWoVzvrK1sJURh88x1TF/0hWpnz8jRbo2
	yAuxWN7xImDtIrgVPRxs80rHVEFiSxI74jbfHizGETo8B8SkCaYsLk2W4EcD/aqDYZ6yOdJEiHU
	KXSVodVAwrY5M/L6OXeFmiQzMSNhqMbisXJ19heeTPwhD+kKEtGCAhCMGYB89T4n1D/gDipHwv4
	d2dGoHREKAADaZX1NLaUHpAxH1buJODwRgJ0emJ4ma+Vhf15aokkMjtSFkVX1//O1CP6UeUzYe/
	Qhei8VB8x6pT8+FMPb6yzBNCuf/pKKlfRRARDoxeGC0JMbbdgXg/H7ce9xL2j9hWpfZD3hk9257
	zIcmhtvswqjHBwuNgPxjDDGnC0/KACPYR125BBbYX/Yd9ElAHx95s/S+WF5EfOklMX0zXoYBwfJ
	IefZ5cmuFgvuh3knjTZEncCtmPlQ1Zrpol56lFqOtdmkS9d8qjTvXMJ9drXya1XKdjLAuSkQSGg
	Dw4Zl4ScrUFD+9nbAnWcSummAK3UOqHniKIiZ68rPQ9/M2TrSm+memdS10MjhK1xcckeUBChjnc
	THRJBKU+eXefyMq7rUrc4gtDTOW6QT2b4six/LrtyuD0FQU/lJmvVuia5U+dQp4kJM+4e4hdQIt
	j13GkWEGd462MRTANMmwVJyUQFM4P
X-Received: by 2002:a05:6000:186e:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-4abb225ebacmr42908408f8f.25.1795710758709;
        Thu, 26 Nov 2026 08:32:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm41053456f8f.32.2026.11.26.08.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:32:38 -0800 (PST)
Message-ID: <3448d665-4851-42b4-8b7f-c52b71d8eb4c@gmail.com>
Date: Thu, 26 Nov 2026 16:32:33 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] sequencer: save the null OID in abort-safety on an
 unborn branch
To: Junio C Hamano <gitster@pobox.com>,
 Wonseok Oh via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Wonseok Oh <wonseok_oh@korea.ac.kr>,
 Wonseok Oh <marinelay7@gmail.com>
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
 <pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
 <14e015ba240a661d8cf8b6bdbc4d7093bbc42ad3.1795577024.git.gitgitgadget@gmail.com>
 <xmqq4id496w5.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4id496w5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 17:07, Junio C Hamano wrote:
> "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Wonseok Oh <marinelay7@gmail.com>
>>
>> On an unborn branch, .git/sequencer/head holds the null OID, but
>> update_abort_safety_file() writes an empty .git/sequencer/abort-safety.
>> Write the null OID there as well so both state files represent an
>> unborn branch the same way, as older versions of Git expect.
> 
> Don't later versions of Git including the latest one also barf if
> get_oid_hex() is unhappy on the contents of the abort-safety file?
> 
> In sequencer.c, rollback_is_safe() reads the file like this
> 
>      if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
>              strbuf_trim(&sb);
>              if (get_oid_hex(sb.buf, &expected_head)) {
>                      strbuf_release(&sb);
>                      die(_("could not parse %s"),
>                          git_path_abort_safety_file());
>              }
>              strbuf_release(&sb);
>      }
> 
> If a multi-commit cherry-pick on an unborn branch stops without
> CHERRY_PICK_HEAD (or after "git reset --merge") and the user runs "git
> cherry-pick --skip", sequencer_skip() calls rollback_is_safe() and hits
> that die(), I think.
> 
> If there is another reroll, mentioning that rollback_is_safe() fails to
> parse an empty file would make the motivation even clearer.

I agree that would be clearer - the important thing is that we're 
changing the way we write the file to match what we expect to read. The 
implementation here and patch 1 look good to me.

Thanks

Phillip

> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 20bfe00ba3..e0bfc6305a 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -644,10 +644,9 @@ static void update_abort_safety_file(void)
>>   	if (!file_exists(git_path_seq_dir()))
>>   		return;
>>   
>> -	if (!repo_get_oid(the_repository, "HEAD", &head))
>> -		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
>> -	else
>> -		write_file(git_path_abort_safety_file(), "%s", "");
>> +	if (repo_get_oid(the_repository, "HEAD", &head))
>> +		oidclr(&head, the_repository->hash_algo);
>> +	write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
>>   }
> 
> The implementation is clean and covers all callers of
> update_abort_safety_file().  Trivially correct.
> 
>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
>> index d52fda1c54..fb1ce079f8 100755
>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -284,6 +284,17 @@ test_expect_success 'cannot abort a cherry-pick sequence started on an unborn br
>>   	test_cmp expect actual
>>   '
>>   
>> +test_expect_success 'unborn branch is saved as the null OID in the sequencer state' '
>> +	pristine_detach initial &&
>> +	git checkout --orphan new_disconnected_state &&
>> +	git reset --hard &&
>> +	test_must_fail git cherry-pick base..anotherpick 2>err &&
>> +	test_grep "could not apply .* unrelatedpick" err &&
>> +	echo $ZERO_OID >expect &&
>> +	test_cmp expect .git/sequencer/head &&
>> +	test_cmp expect .git/sequencer/abort-safety
>> +'
> 
> Here "unrelatedpick" conflicts against the empty tree, so HEAD stays
> unborn and both state files are checked directly.
> 
> We could also add a check to run "git reset --merge" followed by "git
> cherry-pick --skip" to cover rollback_is_safe() as well, though checking
> the state file directly already verifies the change.
> 
> Looking good.

