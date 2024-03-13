Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F11BE7F
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342388; cv=none; b=JpwMteTHBor+sPo8rvbeZd7O+E4V4Mjadtzf8XY6bnF/hQOttsxNhTv2KVLxgDOABZ/cIqW+alUU19jS8ROKUHXFNg/lQmxL0BTiY3zV+8bM4+la8tE/+0nGWWXUoRQzuctREuMs/07oFWrHVpIKDhg3R81C5WWqhJO7KObZnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342388; c=relaxed/simple;
	bh=oFOXoMnh0C+Xsljno1ykIiPu3epSNxu4UU6H6khokH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buZQY0gQoBUvF0gcARWq9nRmTLCLD7HrthqB/ph/FD8y7Weda8VwZTbp9C3zHv26iYQIUtmGVThc5TqVQjZAh/pK6X6zn+2Du73bRXqsUGJuDQKkfff+x/tSWWt2S2Chws+Kk7kxkfIAEJA6n1FR7GTsqZcKQaEOouBMKcuS4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoUCCVc1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoUCCVc1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690de619293so7742166d6.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342385; x=1710947185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUcPeyYX9usqrjqqaGQJ+kMzU4nd5X3RtgT8NUvnDFQ=;
        b=WoUCCVc1eK7znxQml6wpSDxcpxd1fLYvFRP3UIYpI9zvI2aTaI/6kyFVde/TcRHc2W
         u9bWoEXrb3DcQGJgo/CgHM8EraxtoHHMkJGou5nY6T5+Bq8yxCMsxonuk5rqCGKyjUx6
         drWQ0K4ODiBsjgIg8+5vnU03YToavytmb03mf20hbsi/dOurPgpmAkpnFgv43lujMPLQ
         P9EWc9Vre6+6tM3NW+Q+v9CqeMQnVNnnRYSAIYC/N6f8jICbsefObDwU4JVRy9/vVkUp
         yLgUV6Tb/PiR0FBS2pS4l5yzYw5fopqkR6cKV+Ih8DWBayuUmNJbqMsCWweAwu6ITox5
         F3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342385; x=1710947185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUcPeyYX9usqrjqqaGQJ+kMzU4nd5X3RtgT8NUvnDFQ=;
        b=VzW3ohWLSTYLCOxxvC9fQbg+5/39meC/YL0fMQQL0ZXBPGp+NmjHHbc95bTNYUIkxx
         d7hCEC7gdyqo31rt83x6HMc12aZvMd0BOXtxpWVnLkwya2swQ7xsN3JBvlfEglLO80EP
         ldBotdlACXILIWS7J+KAJ/kUsnf0v6/wUsNzOPvOiCJmwT4nCDxKvCdkubmJWFVxAutn
         b4gqJRC3PQODBsDo8tJ8gGdV//O4m57AnzAZBou4iomuXmcXRmH9Z+jh9T0uv9K6Sbqa
         wn6xsGMa3wGtwlpYtPSug4wJ4q/mx/VjmKhk16Bo6Xg/tsffqYTfDUxK3dz2BNfGerld
         akvA==
X-Gm-Message-State: AOJu0YyQJln6jQWRK5RrIrbxs6T1loTLX1ewQM5ml4/EFTPbu2GPEPKP
	PbTVLnQtIMNBDdTKfHBh2laT3wWTOFW87vffx9tal3FoFoM5/w9QlgKUS7/M
X-Google-Smtp-Source: AGHT+IH1+TQBLv11YVNqMmiO5l+fp4uJmpz54/C/YTo6rqe0Du3cJx84KAobdWWKBQYGdhPlDqW8pQ==
X-Received: by 2002:ad4:538c:0:b0:690:f1e3:ca7c with SMTP id i12-20020ad4538c000000b00690f1e3ca7cmr105924qvv.16.1710342385301;
        Wed, 13 Mar 2024 08:06:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id ek19-20020ad45993000000b006907e34d029sm4821559qvb.2.2024.03.13.08.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:06:25 -0700 (PDT)
Message-ID: <d15eb4b0-2ea9-44d7-af5a-2ea1162294f4@gmail.com>
Date: Wed, 13 Mar 2024 15:06:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>,
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 David Heidelberg <david@ixit.cz>
References: <20240312231559.GA116605@quokka>
 <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fac4fec23597bff0f4594112d2a9976d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/03/2024 02:15, Dragan Simic wrote:
> Hello Peter,
> 
> On 2024-03-13 00:15, Peter Hutterer wrote:
>> Allow the default prefixes "a/" and "b/" to be tweaked by the
>> diff.srcprefix and diff.dstprefix configuration variables.
> 
> The only thing that's left is to update the patch description
> to use camel case. :)

If that's the only change that's required I don't think we should be 
asking for a re-roll. We do place a high value on good commit messages 
in this project but I don't think it is reasonable to require a re-roll 
for a purely aesthetic change.

Best Wishes

Phillip

>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> ---
>> Changes to v2;
>> - doc: change to camelcase diff.srcPrefix/diff.dstPrefix for
>>   consistency with diff.mnemonicPrefix and most other options
>> - git diff --default-prefix forces a/ and b/ regardless of configured
>>   prefix, see the 'diff_opt_default_prefix' hunk in the patch below.
>>
>> The latter may be slightly controversial but: there are scripts out
>> there that rely on the a/ and b/ prefix (came across one last night).
>> With a custom prefix those scripts will break, having an option that
>> forces the a/ and b/ prefix helps. Plus the man page explicitly says:
>>   Use the default source and destination prefixes ("a/" and "b/").
>> So let's stick with that behaviour then.
>>
>>  Documentation/config/diff.txt |  6 ++++++
>>  diff.c                        | 14 ++++++++++++--
>>  t/t4013-diff-various.sh       | 35 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config/diff.txt 
>> b/Documentation/config/diff.txt
>> index 6c7e09a1ef5e..afc23d7723b6 100644
>> --- a/Documentation/config/diff.txt
>> +++ b/Documentation/config/diff.txt
>> @@ -111,6 +111,12 @@ diff.mnemonicPrefix::
>>  diff.noprefix::
>>      If set, 'git diff' does not show any source or destination prefix.
>>
>> +diff.srcPrefix::
>> +    If set, 'git diff' uses this source prefix. Defaults to 'a/'.
>> +
>> +diff.dstPrefix::
>> +    If set, 'git diff' uses this destination prefix. Defaults to 'b/'.
>> +
>>  diff.relative::
>>      If set to 'true', 'git diff' does not show changes outside of the 
>> directory
>>      and show pathnames relative to the current directory.
>> diff --git a/diff.c b/diff.c
>> index e50def45383e..108c1875775d 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
>>  int diff_auto_refresh_index = 1;
>>  static int diff_mnemonic_prefix;
>>  static int diff_no_prefix;
>> +static const char *diff_src_prefix = "a/";
>> +static const char *diff_dst_prefix = "b/";
>>  static int diff_relative;
>>  static int diff_stat_name_width;
>>  static int diff_stat_graph_width;
>> @@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const 
>> char *value,
>>          diff_no_prefix = git_config_bool(var, value);
>>          return 0;
>>      }
>> +    if (!strcmp(var, "diff.srcprefix")) {
>> +        return git_config_string(&diff_src_prefix, var, value);
>> +    }
>> +    if (!strcmp(var, "diff.dstprefix")) {
>> +        return git_config_string(&diff_dst_prefix, var, value);
>> +    }
>>      if (!strcmp(var, "diff.relative")) {
>>          diff_relative = git_config_bool(var, value);
>>          return 0;
>> @@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options 
>> *options)
>>
>>  void diff_set_default_prefix(struct diff_options *options)
>>  {
>> -    options->a_prefix = "a/";
>> -    options->b_prefix = "b/";
>> +    options->a_prefix = diff_src_prefix;
>> +    options->b_prefix = diff_dst_prefix;
>>  }
>>
>>  struct userdiff_driver *get_textconv(struct repository *r,
>> @@ -5362,6 +5370,8 @@ static int diff_opt_default_prefix(const struct
>> option *opt,
>>
>>      BUG_ON_OPT_NEG(unset);
>>      BUG_ON_OPT_ARG(optarg);
>> +    diff_src_prefix = "a/";
>> +    diff_dst_prefix = "b/";
>>      diff_set_default_prefix(options);
>>      return 0;
>>  }
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 1e3b2dbea484..e75f9f7d4cb2 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -663,6 +663,41 @@ test_expect_success 'diff --default-prefix
>> overrides diff.mnemonicprefix' '
>>      check_prefix actual a/file0 b/file0
>>  '
>>
>> +test_expect_success 'diff respects diff.srcprefix' '
>> +    git -c diff.srcprefix=x/ diff >actual &&
>> +    check_prefix actual x/file0 b/file0
>> +'
>> +
>> +test_expect_success 'diff respects diff.dstprefix' '
>> +    git -c diff.dstprefix=y/ diff >actual &&
>> +    check_prefix actual a/file0 y/file0
>> +'
>> +
>> +test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
>> +    git -c diff.srcprefix=z/ diff --src-prefix=z/ >actual &&
>> +    check_prefix actual z/file0 b/file0
>> +'
>> +
>> +test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
>> +    git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
>> +    check_prefix actual a/file0 z/file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with diff.noprefix' '
>> +    git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix 
>> diff >actual &&
>> +    check_prefix actual file0 file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with 
>> diff.mnemonicprefix' '
>> +    git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix
>> diff >actual &&
>> +    check_prefix actual i/file0 w/file0
>> +'
>> +
>> +test_expect_success 'diff src/dstprefix ignored with --default-prefix' '
>> +    git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff 
>> --default-prefix >actual &&
>> +    check_prefix actual a/file0 b/file0
>> +'
>> +
>>  test_expect_success 'diff --no-renames cannot be abbreviated' '
>>      test_expect_code 129 git diff --no-rename >actual 2>error &&
>>      test_must_be_empty actual &&
> 
