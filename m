Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FBCA68
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAVUa+6P"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C703DE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 07:11:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f61322fso35437085e9.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698675071; x=1699279871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gkDx7UJoguKT13EhzhAkzNPgn4VJaontkP238pMFUeE=;
        b=dAVUa+6P7QWhWROyHF3X2UviSEHuu0aI+Xwd7wSQoWciNddYXl2AxApV19eev733uV
         cCxVXZBYqycwPMFRY4F+ad4VP0CqUVqjH7hwWf2g3IcCF/cA3S/TtvQelRNFUz6Pi7W/
         u59dyD5js0E6EIxSOkIBF/AtXYyxBpvyJ/NMleCjFR2yQL9MB4ALfSCzPWrCHuOfOgi+
         Y0hcJ1xhlU/WaGcy0ntdoPrDy0UWsvblaFfBh0DhSf6MtsApTpP/1KULwWZ7O6A6e0YH
         0YXwnIvRDpzRmc5yg/TUiHqZAWaoU4dpP9sY9zXw4QCummxIMY9+aw3P/rqufa/oa48k
         y2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698675071; x=1699279871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkDx7UJoguKT13EhzhAkzNPgn4VJaontkP238pMFUeE=;
        b=Ce/ViUxXrnRc3VNhYmUJ6sVnaTIPgXqm5NVsa0I+NuMPvvd3VOFJcwxO7XQyG3Iyiu
         6U4x5bjKdBwE7Dne9PTXgMOUiM+l05hHRPfMJw5V17iDNl2/etJ9T/0QSsE3NzbtEKZw
         tYnK5XcNB2KHHmC1RDhm4UdC7kCfhMCh6TXWych5BmKl85u/ZVIch1EAbOzMDklRJysN
         4jxezqYAgPI2b19RshoPVsjyRmhBYaIy7sC4XRrbCrSYxi4F8zd5ZgUg8GdGiA+D4x0v
         n7nyxcUmVjNv7Ic2XUBYQau85crLCnOdZlYKUtd46ZdUtYiVKlmpXQjTWAKHPXNrcHxO
         jklg==
X-Gm-Message-State: AOJu0YwGzJuNAj2fK+qXlEIYvCLPY73l2VzzSpddmqUsp5M7ogtl9gkB
	13aCQwPY9UE43mkSMc0qQAFPDdDZ1NY=
X-Google-Smtp-Source: AGHT+IG6q8d8tY7SaXp0B7DJ4izyPbGsBZsRWypfv0L1lc/w6pW/w1TCXxrlY+ChgxW1GhgSHJmsww==
X-Received: by 2002:a05:600c:1c15:b0:406:f832:6513 with SMTP id j21-20020a05600c1c1500b00406f8326513mr8136982wms.3.1698675071124;
        Mon, 30 Oct 2023 07:11:11 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b00401e32b25adsm9398502wms.4.2023.10.30.07.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:11:10 -0700 (PDT)
Message-ID: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
Date: Mon, 30 Oct 2023 14:11:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] bugreport: reject positional arguments
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, emilyshaffer@google.com,
 git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
 Sheik <sahibzone@gmail.com>, Dragan Simic <dsimic@manjaro.org>
References: <20231026005542.872301-1-nasamuffin@google.com>
 <20231026155459.2234929-1-nasamuffin@google.com>
 <CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
 <3e15f266-c790-4b71-84b6-1328339425c1@gmail.com> <xmqqv8apez0o.fsf@gitster.g>
 <xmqqpm0xeyp9.fsf@gitster.g> <xmqqcywwg9am.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqcywwg9am.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2023 01:59, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> It is rather unfortunate that test_i18ngrep was deprecated without
>>>> providing an alternative that offers the same debugging
>>>> experience.
>>> ...
>>> We could rename test_i18ngrep to test_grep (and make test_i18ngrep
>>> into a thin wrapper with warnings).
>>>
>>> 	test_grep -e must-exist file &&
>>> 	test_grep ! -e must-not-exist file
>>
>> ... as the only remaining part in test_18ngrep has no hack to work
>> around the tainted localization tests, so "was deprecated without"
>> is a bit too strong.  There is nothing we have lost yet.
> 
> Having said all that, when re-reading the test_i18ngrep with a fresh
> pair of eyes, I somehow doubt there was much upside in "debugging
> experience" with test_i18ngrep in the first place, and I doubt if
> retaining it with a new name test_grep has much value.
> 
> Given that test_i18ngrep (hence test_grep) requires you to have the
> haystack in a file, between
> 
>      test_i18ngrep must-exist file &&
>      test_i18ngrep ! must-not-exist file
> 
> and
> 
>      grep must-exist file &&
>      ! grep must-not-exist file
> 
> I do not see any difference in "debugging experience" when you run
> the test with "-i [-v] -d".   The two cases you care about are
> 
>   (1) the test expects the string "must-exist" in the file "file" but
>       the string is not there.
> 
>   (2) the test expects the string "must-not-exist" missing from the
>       file "file", but the string is there.
> 
> The latter can clearly be seen in output from "-i -v -d" (the "grep"
> outputs a line with "must-not-exist" on it).  The former will show
> silence but since you are debugging with "-d", and your haystack is
> in a file, after such a step fails, the test stops, and without
> removing the "file" even if the test piece had test_when_finished
> to remove it (i.e. running tests in debugging mode "-d" and
> immediately stopping upon failure "-i" behaves this way exactly to
> help you debugging), so you can go there to the TRASH_DIRECTORY
> yourself and inspect "file" to see what is going on anyway.
>
> So, I dunno.  Surely with a long &&-chain of steps, where a grep
> that expects lack of something is in the middle, it is hard to see
> if the lack of hit is because an earlier step failed (and the
> control did not reach "grep must-exist file") or because the
> haystack lacked the "must-exist" needle, so from that point of view,
> it may be nicer that "did not find an expected match" is explicitly
> stated.

It is this latter point that I had in mind. I find it much easier to 
debug a test that says "This command failed" rather than looking at the 
output to try and figure out which was the last successful command. I 
take your point above that one can go and inspect the file when the test 
is run with "-i -d" but it is determining that grep failed in the first 
place that I find annoying. I've also found the output from 
test_i18ngrep is helpful when debugging CI test failures.

Best Wishes

Phillip
