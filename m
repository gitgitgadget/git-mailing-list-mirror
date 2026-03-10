Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A872E0412
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153245; cv=none; b=X+xyph1zW3SpNkL35HCtExzgOU7dSsC4xI7z2/YZAh42Hv578mUj3BdcU8ZGiaNUm/cZQLN0G6Z85KIsmpJOBIAU4Hzm8GVMxoZ4XP6s3E6kZ/xd37bL1Y6BB7+A2M8Yfssp/QY+2oTnior2jUIrLGG+6+NOo0fxglJ01qJIBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153245; c=relaxed/simple;
	bh=gl13LgnBcnzNQDUzNlODJGp3FVDBjq6Cu0+H5wNe+NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCFj+URZYklLFp+5RkVbbdcGbkIU7qFhys79v3GEfdpAsf27uYKn7NH1FqPuOlslbGcJKGjFG5scEV9d5jnBJ1kDuvA4bZddrRJ8tlTLbnAedxO4kI6qH1LK+mat5CYXQ5fjV5+HLtuPUV8hlWR1jxVtGHmwnFjRcjEB5mXJVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYOhtfiV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYOhtfiV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b972641eb96so14044766b.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153242; x=1773758042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aWWArm4be37LasAqQkbNXJbO0o6QyG4ypuCllG3yEcU=;
        b=jYOhtfiVIS5zxUrEi9D5X6Q8HLeQJIR7Y0NnM1WYvvvjGj7IPclO70/Wyb1JxbNmby
         UOuVMRhgy4ncJtBswy5CkiHgnNO6f7Hs8kBTA8lz0x3B7RuY+9LLEh9xF6rD4HSaz6kF
         IOouV1km9W3Pm9bn3mAsd+91dTgf2Zu8/wZKitmrZR85BxoxdJDBh73EcdX9EbNoXIX1
         0pC/wQxH/6zsDHd7ScQevhX/YVvln86HPtcQhwWF4d1D/6LUtTFUz/hZC+SXEQKhLzof
         1yoON7h5R7TzmlaWB25KgVnr1p1nJ6JSfKC3iyVKJ9duPJmuil2/uoJaZPouyPdAVxXi
         7gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153242; x=1773758042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWWArm4be37LasAqQkbNXJbO0o6QyG4ypuCllG3yEcU=;
        b=TQWri2YT9eoHWZlxuanUpWcicfxsa4JIT4JYkqN4+OvDBXRjqFDFaHf7M9ooMh+2RX
         cKbwIi7qIeU1zeFyO4kxqi/Qb4dhC3JnYSI1RsqZD12+5tsKq5xTmU+BIdfNXPA4XNiZ
         KKmFyldhC449p4EEeHBSSZavjwhQGj8cRC2npM73FPd3fowGaUQI/ycdoTVtJs25ssGc
         wxIhy9b7CiluPTt19E3g5mvXVmYvkuiXmMqookUhx0O6x8/NkKY9Iry5jQccYQ6UyMEA
         XIJ3q9oMUwI7+6UUbwr1ft0UWEZ0M7nhQ1tU+FJzWv9xNQ915NK8LR9XIGWqN9myzUER
         5cWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXglzXdM+bWgZaqg0qHp2p60U+4b110aOAxmwah8zR8pAkqpxVj2PDTE0ajMHGYOwVMvAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEH54prFLv6fvJnGgKwL1/h5kqGloiNhp0vfYmGRdzCAzL7TAC
	BRydTiNarYWr3UgpaluzoFYodRdUktcNMU5Qu60rXi0OVxvhZAmiUlH/bsHOWA==
X-Gm-Gg: ATEYQzyJ+inm89lzNPvCRXLSW14nlQUB2OPXepBltIfC/HyGOdCQt2gasH628RDCdU2
	oM3lxL3i2yc4uGEngA30TkAaLfd20tc8V+azYTQcsLi+vEV0v5QmfYiEptnrd5VXEXsNQo1D4Cs
	/iIwcLEu83EhECd0uE+FWHdMTVZQJ/JjBuep1l8pQggV4mV14sOw6NmvxS3cXA0jmf3fqFBWsW+
	05opaFyjSkHUc5DDw+L+95SFYyhly7LBU8jDEsrnbUXmLcMIQvRPzUnw/ma9w1p/k+kJaGkhhDV
	QdhV3e6ZOx1ba5yftEmwiX7PGd+MI76CqjhBAzcVKQehQRGdXKUGBmWpUpVBsnFiH14BnvOLfp6
	0JMLs7aFfsHyPJuiHD0rHz1nQzkpJIzua2TVgt3wKiapthaDE8nEnMcyrBq+Icy85Lldf6FnDmt
	k29Q+k/HmEQStab7lxSVPSh5ZKgCGfWLRHhoxVujoAjPCY5pdTNAgAMjcnpmCKB8fMh8We08GHZ
	U8ruw==
X-Received: by 2002:a17:907:e117:b0:b96:f7c7:6233 with SMTP id a640c23a62f3a-b96f7c76586mr262374566b.19.1773153242211;
        Tue, 10 Mar 2026 07:34:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b943cca3c0asm439877466b.34.2026.03.10.07.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:34:01 -0700 (PDT)
Message-ID: <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
Date: Tue, 10 Mar 2026 14:34:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 23:34, Mirko Faina wrote:
> Using "--cover-letter" we can tell format-patch to generate a cover
> letter, in this cover letter there's a list of commits included in the
> patch series and the format is specified by the "--cover-letter-format"
> option. Would be useful if this format could be configured from the
> config file instead of always needing to pass it from the command line.
> 
> Teach format-patch how to read the format spec for the cover letter from
> the config files. The variable it should look for is called
> format.commitListFormat.
> 
> Possible values:
>    - commitListFormat is set but no string is passed: it will default to
>      "[%(count)/%(total)] %s"

It is unusual for an empty config value to mean something different from 
it not being set. The reason for this is that it allows

     git -c config.key some-command

to act as though config.key was not set.

Perhaps we should use the value "default" to generate a default format. 
It would be nice to support a default format on the commandline as well.

>    - if a string is passed: will use it as a format spec. Note that this
>      is either "shortlog" or a format spec prefixed by "log:"
>      e.g."log:%s (%an)"

Having the config value behave like --cover-letter-format=<value> is 
sensible

>    - if commitListFormat is not set: it will default to the shortlog
>      format.

makes sense

Thanks

Phillip

> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>   builtin/log.c           | 21 ++++++++++++++++
>   t/t4014-format-patch.sh | 53 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 95e5d9755f..5fec0ddaf9 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -886,6 +886,7 @@ struct format_config {
>   	char *signature;
>   	char *signature_file;
>   	enum cover_setting config_cover_letter;
> +	char *fmt_cover_letter_commit_list;
>   	char *config_output_directory;
>   	enum cover_from_description cover_from_description_mode;
>   	int show_notes;
> @@ -930,6 +931,7 @@ static void format_config_release(struct format_config *cfg)
>   	string_list_clear(&cfg->extra_cc, 0);
>   	strbuf_release(&cfg->sprefix);
>   	free(cfg->fmt_patch_suffix);
> +	free(cfg->fmt_cover_letter_commit_list);
>   }
>   
>   static enum cover_from_description parse_cover_from_description(const char *arg)
> @@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
>   		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>   		return 0;
>   	}
> +	if (!strcmp(var, "format.commitlistformat")) {
> +		struct strbuf tmp = STRBUF_INIT;
> +		strbuf_init(&tmp, 0);
> +		if (value)
> +			strbuf_addstr(&tmp, value);
> +		else
> +			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
> +
> +		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
> +		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);



> +		strbuf_release(&tmp);
> +		return 0;
> +	}
>   	if (!strcmp(var, "format.outputdirectory")) {
>   		FREE_AND_NULL(cfg->config_output_directory);
>   		return git_config_string(&cfg->config_output_directory, var, value);
> @@ -2329,6 +2344,12 @@ int cmd_format_patch(int argc,
>   		goto done;
>   	total = list.nr;
>   
> +	if (!cover_letter_fmt) {
> +		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
> +		if (!cover_letter_fmt)
> +			cover_letter_fmt = "shortlog";
> +	}
> +
>   	if (cover_letter == -1) {
>   		if (cfg.config_cover_letter == COVER_AUTO)
>   			cover_letter = (total > 1);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 458da80721..4891389a53 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -428,6 +428,59 @@ test_expect_success 'cover letter no format' '
>   	test_line_count = 1 result
>   '
>   
> +test_expect_success 'cover letter config with count, subject and author' '
> +	test_when_finished "rm -rf patches result" &&
> +	test_when_finished "git config unset format.coverletter" &&
> +	test_when_finished "git config unset format.commitlistformat" &&
> +	git config set format.coverletter true &&
> +	git config set format.commitlistformat "log:[%(count)/%(total)] %s (%an)" &&
> +	git format-patch -o patches HEAD~2 &&
> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .* \(A U Thor\)" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 2 result
> +'
> +
> +test_expect_success 'cover letter config with count and author' '
> +	test_when_finished "rm -rf patches result" &&
> +	test_when_finished "git config unset format.coverletter" &&
> +	test_when_finished "git config unset format.commitlistformat" &&
> +	git config set format.coverletter true &&
> +	git config set format.commitlistformat "log:[%(count)/%(total)] (%an)" &&
> +	git format-patch -o patches HEAD~2 &&
> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] \(A U Thor\)" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 2 result
> +'
> +
> +test_expect_success 'cover letter config commitlistformat set but no format' '
> +	test_when_finished "rm -rf patches result" &&
> +	test_when_finished "git config unset format.coverletter" &&
> +	test_when_finished "git config unset format.commitlistformat" &&
> +	git config set format.coverletter true &&
> +	printf "\tcommitlistformat" >> .git/config &&
> +	git format-patch -o patches HEAD~2 &&
> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 2 result
> +'
> +
> +test_expect_success 'cover letter config commitlistformat set to shortlog' '
> +	test_when_finished "rm -rf patches result" &&
> +	test_when_finished "git config unset format.coverletter" &&
> +	test_when_finished "git config unset format.commitlistformat" &&
> +	git config set format.coverletter true &&
> +	git config set format.commitlistformat shortlog &&
> +	git format-patch -o patches HEAD~2 &&
> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 1 result
> +'
> +
> +test_expect_success 'cover letter config commitlistformat not set' '
> +	test_when_finished "rm -rf patches result" &&
> +	test_when_finished "git config unset format.coverletter" &&
> +	git config set format.coverletter true &&
> +	git format-patch -o patches HEAD~2 &&
> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 1 result
> +'
> +
>   test_expect_success 'reroll count' '
>   	rm -fr patches &&
>   	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&

