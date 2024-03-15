Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966F1EB2C
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533059; cv=none; b=ZJ430ZzfBSdEr1E2PhhRzd9SHHfOxr4LWitrSQ32BEEw24ThJUB639dx3eiLRkdImIK0M6LkuWlQGaD6RfdAOavE2rmLo2DgmLSY0oQAN3pdTCOUl07pMHVWkxAR3Ws2S1ZtyVYUt//8i04dVTcm0r3QgS70KutqHFwnblQReKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533059; c=relaxed/simple;
	bh=bm4Q5ZWmdCZjqBa6OoRvGLjaL9dXMy0kBp9lKcFgLmA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=K6YK1vU3y4yuxI5ymYbBtyHzhA89zBn46mlZdc6NOsvmtSVBf4ldhYCdn/yIFZYsZlhPIv2c1ltLvjgBwucIazp5uRkRj74ntEVixnWiL9BM01m7rL5v98QFEeFxyMlxB93cJS2NceBofAopsnr8Bf3QmvQyuhcuY2hYNCsldDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y6u3VYfc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y6u3VYfc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710533052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNgT9U2MGIzFKBfuSMWYMexSLFbvknN9iztLS9Pciy8=;
	b=Y6u3VYfc/y71jFKZQRDeayPOfwFCMIZHJtsrTq7dxq/iNzriIKv16dLW1oJ9p5xXj4/CLg
	S5YyxSLILtykDE09a3kbby2Ut8zs8DtYvWhCnYliglomhyWEuSbvqcLnCw7liBXQJhrHX8
	5fgpCsAISTFkinfWM0HJm1XWGOOsymmhU7yLhPS+bvdAwjDcfuF/6DkAPqa8MIrFS/tVDd
	OsFyETN87tLCbj0DHpVNmvFnBpE40Eg7cTCg8VOwkHpKNr6hfDDe4hUfc3tX5lqTjtnqBU
	dra2wdUgTANCCAG8F+x3TwtLbI0RXv5/6jYJnUXuLeOBVz4Zl7YGm3hRjVtzpg==
Date: Fri, 15 Mar 2024 21:04:12 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
References: <cover.1710508691.git.dsimic@manjaro.org>
 <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
 <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
Message-ID: <eb550eebb158064f1780f610669bbda1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-03-15 20:39, Eric Sunshine wrote:
> On Fri, Mar 15, 2024 at 9:22 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Add a handful of additional automated tests, to improve the coverage 
>> of
>> configuration file entries whose values contain internal whitespace, 
>> leading
>> and/or trailing whitespace, or which contain an additional inline 
>> comment.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> Just some minor style-related comments...
> 
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> @@ -11,6 +11,96 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +cat > .git/config << EOF
>> +[section]
>> +       solid = rock
>> +       sparse = big             blue
>> +       sparseAndTail = big              blue
>> +       sparseAndTailQuoted = "big               blue "
>> +       sparseAndBiggerTail = big                blue
>> +       sparseAndBiggerTailQuoted = "big                 blue          
>>  "
>> +       sparseAndBiggerTailQuotedPlus =  "big            blue          
>>  "
>> +       headAndTail =   big blue
>> +       headAndTailQuoted = "   big blue "
>> +       headAndTailQuotedPlus =  "      big blue "
>> +       annotated = big blue    # to be discarded
>> +       annotatedQuoted = "big blue"    # to be discarded
>> +EOF
> 
> These days we try to place all test-related code inside a
> test_expect_success() context rather than having it standalone. In
> this case, since the file being created is (presumably) shared by
> multiple tests in this script, you may want to add a new test which
> performs this setup step.
> 
> Use \EOF rather than EOF to signal to readers that we don't expect any
> variable interpolation to happen within the here-doc body.
> 
> Further, use -\EOF inside test_expect_success() to allow us to indent
> the body of the heredoc to match the test indentation.
> 
> Style guideline says to omit whitespace after redirection operators
> (such as `<<` and `>`).
> 
> We have a q_to_tab() function which lets us state explicitly for
> readers the location of TAB characters in the heredoc body. You'll
> often see that used instead of literal TABs.
> 
> Taking all the above into account, perhaps:
> 
>     test_expect_success 'setup whitespace' '
>         q_to_tab >.git/config <<-\EOF
>         [section]
>         solid = rock
>         sparse = bigQblue
>         ...
>         EOF
> 
> Same comments apply to rest of patch.

Thank you for your review and all suggestions!  I'll make sure to rework
the tests in v2, in the way you described it above.

I'll come back with any questions I might have while reworking the new
tests.  I hope that's fine.
