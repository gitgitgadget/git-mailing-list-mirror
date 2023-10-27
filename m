Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC51773E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i65ZiYZF"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F07D4D
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:41:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso1388727f8f.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698417705; x=1699022505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrnwOYKCEzwLegm0bJYf8NVClI7iIFbzkRmM71oP/6A=;
        b=i65ZiYZFt1HoDId6dGIga2iyZEARaW3Pa51g8rwgQHTFujcmkNseIi94YeQ6B/lrMG
         806hXfTbHCyBQMVHOAZtDqo/ucyaRLdtN6b3GBx54yOps6lFhr8v2vCKXAGBtlUHjFy4
         E7OWIttCHqntHm6646klDsMYUVfITvQog1ONkZHG6Eqo5vjS5/j+CuxcpYkWymUXYLAy
         ccHIaEa+xaU+jNzosQXdA83n0/qDF16pN8uECr5nM24ydxGZLi3hFliAR/z11eyIjyNR
         yYXoh17arZvD2nqbQ2qghdp0JJMNX+qun7eQebC8QPWTbYrWboIjVhKRi/w1Omd3wAfC
         B7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417705; x=1699022505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrnwOYKCEzwLegm0bJYf8NVClI7iIFbzkRmM71oP/6A=;
        b=rOZ/9cxbLHncu5LU35NCmNeWSbNrv4wfSmKdyPpkD0dcMUpdeMGLqTVgB9r/EPqwnu
         zRaYvUBgo/rLLS9pq8YYsU4ZpN7GyWdwQw+F+wbglrkK0hwBTe2BcXmveRodfCuGU7L2
         WJ2gJmQKiO2l2+Ik4gRyV35Ytv72xOotrMHTukXaUk87S8p74PpnZgo/IhBOjieo5CTk
         biunUFYGNfqfFAH2qqOez82dmEaaOIA/kbTlIzM4/Z8Kn8VkQ1p/q4InrBKPZlCSwlRA
         X3tebaowsKWH+N7FfWN6vNJX0DGOrNjaTMt9CqKbecMJtvU7IV2o2RTSO5kBLWQogJkM
         4qQg==
X-Gm-Message-State: AOJu0Ywhrcxs5BBKKnsRLfRxtOhgwNjrjmyV64LdYB1dqVfdZt/l3yOv
	7Sn23/hMjs2U0NxKegGf1dBIiTRFzsc=
X-Google-Smtp-Source: AGHT+IGhqT0gN0Euu2NDb5Xv/j3d3MZP4OSTuMFHOiw2tC7FZpP4ce8JUUIYVGdk3YetYe0P2O6X8Q==
X-Received: by 2002:a05:6000:401f:b0:32d:9718:b32a with SMTP id cp31-20020a056000401f00b0032d9718b32amr2495829wrb.0.1698417705171;
        Fri, 27 Oct 2023 07:41:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d16-20020adfef90000000b0032326908972sm1894350wro.17.2023.10.27.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:41:45 -0700 (PDT)
Message-ID: <3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
Date: Fri, 27 Oct 2023 15:41:44 +0100
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
To: Eric Sunshine <sunshine@sunshineco.com>, emilyshaffer@google.com
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
 Sheik <sahibzone@gmail.com>, Dragan Simic <dsimic@manjaro.org>
References: <20231026005542.872301-1-nasamuffin@google.com>
 <20231026155459.2234929-1-nasamuffin@google.com>
 <CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/10/2023 18:18, Eric Sunshine wrote:
> On Thu, Oct 26, 2023 at 11:55 AM <emilyshaffer@google.com> wrote:
>> git-bugreport already rejected unrecognized flag arguments, like
>> `--diaggnose`, but this doesn't help if the user's mistake was to forget
>> the `--` in front of the argument. This can result in a user's intended
>> argument not being parsed with no indication to the user that something
>> went wrong. Since git-bugreport presently doesn't take any positionals
>> at all, let's reject all positionals and give the user a usage hint.
>>
>> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
>> ---
>> Per Eric's and Dragan's comments, dropped the null checking for argv[0].
>> No point in being too paranoid, I suppose :)
>>
>> Note that after this morning it's not likely that I'll be able to find
>> time to update this again so quickly, so if there are other nits,
>> reviewers can feel free to send their own rerolls rather than waiting
>> for me to see it and turn the patch around.
> 
> Thanks. This version looks good enough to me. Just one minor comment below...
> 
>> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
>> @@ -69,6 +69,13 @@ test_expect_success 'incorrect arguments abort with usage' '
>> +test_expect_success 'incorrect positional arguments abort with usage and hint' '
>> +       test_must_fail git bugreport false 2>output &&
>> +       test_i18ngrep usage output &&
>> +       test_i18ngrep false output &&
>> +       test_path_is_missing git-bugreport-*
>> +'
> 
> I didn't really pay attention to the test in earlier rounds so didn't
> notice this, but these days we just use 'grep' rather than
> 'test_i18ngrep'. (Indeed, the existing tests in this script use
> 'grep'.)

It is rather unfortunate that test_i18ngrep was deprecated without 
providing an alternative that offers the same debugging experience. When 
test_i18ngrep fails it prints a message with the pattern and text that 
failed to match so it is easy to see where the test failed. If grep 
fails there is no output and so unless the test is run with "-x" it can 
be hard to see which command caused the test to fail.

Best Wishes

Phillip

