Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B013321AA
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762578; cv=none; b=oYoKJKukXKkN4JWTIV//tYspiKsPGP0QSHSt+Xyyn54InP2gWzdcwFEzLf07sg8Fa2F+eVNNjtyb7V0+EQrqy+mTa8rOWi8GDACwILaMgoIBE3nFq2fZ06Zc1boiGF71dS3w41hQhAwjGTjJ1mwz3h4b41C5DWGCaNovFiIog84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762578; c=relaxed/simple;
	bh=iSX8NqjKjfmZ2bymgLEIIOo0YpNk6oFWHuNpJ6fJ9NQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ALg+UHV3bPL64df+EuLNzKJYkB8jZSUYk5iuyMZzX8DJhExjsD3+fIb+kY+WdZEYGF567JW3t0BWC3JF7kNd+WUGgaWrA6IMnXGC0sridigD+C3AsSzyU7cIZ1Y+tH9Qk8BRnx+VSzF4sTvZCqbQv/6XlEkx4tIJ0a+ETiQEEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=AOXHdXu+; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="AOXHdXu+"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5C6133F6BA;
	Tue, 10 Feb 2026 23:29:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iP5-4VXn5nnr; Tue, 10 Feb 2026 23:29:28 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1BCB73F660;
	Tue, 10 Feb 2026 23:29:28 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DEE5B1E4A;
	Tue, 10 Feb 2026 23:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770762511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YT/BWfEvscgSY36i3d8zJuJBI9JcCmFQ5r9BtlUQ4bw=;
	b=AOXHdXu+UrTfSdSz4FE8CMAEyNqs0uzrdEExIz6e+cp7SEjmG+KMbLaKSbktgf7/jJP9AG
	j5DmNTfJhZNJpYFPq3BO/gp1PEbhaLdGd7LTy8r+bp2cPsdWBLnADEID8/xa3zahK3vLCq
	sXGfnt07NBfnAeiM0G+TUERJY03VpL3YPwYtpFUJeZmMC4v6j/468rHxqoR77dqWO4W1us
	XZLRIYjfDpceO0p9w6DNvNqaA04JHkCb3BIqfe29MO9ECHrj7yXXmRLHITxLB3MeZcTvxb
	E3b9qLntNR8fOwE+m7EpqOpWhq1uAkuDFtepTADy0zu/iS2UOe0VUHcpVcRy7Q==
Message-ID: <38bf9422-c239-4398-ba9a-ebb1e62b7e86@jontes.page>
Date: Tue, 10 Feb 2026 23:29:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonatan Holmgren <jonatan@jontes.page>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via
 subsection syntax
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, "D . Ben Knoble"
 <benknoble@gmail.com>, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
 <20260210183110.1151072-3-jonatan@jontes.page> <xmqqv7g4xtx0.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv7g4xtx0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

I broke it out into 3 commits for my version 3 of the patches and think 
I've caught all the bugs in my implementation. Thanks for the patience!

I also took the liberty of breaking
     [alias "foo"]
	bar = !date
as dotted aliases were never a feature (XKCD 1172 workflow hopefully not 
incoming) and it might be useful to be able to define more stuff under 
this new alias syntax other than "command".

Patch incoming.

Best,
Jonatan

On 2026-02-10 20:47, Junio C Hamano wrote:
> Jonatan Holmgren <jonatan@jontes.page> writes:
> 
>> Git alias names are limited to alphanumeric characters and dashes
>> because config variable names are validated by iskeychar(). This
> 
> "ASCII alphanumeric", perhaps, as accented alphabet characters are
> still alphanumeric ;-).  "because aliases are implemented as config
> variable names" is probably an explanation that talks to readers in
> terms closer to them (iskeychar() function is an implementation detail).
> 
>> prevents non-English speakers from creating aliases in their native
>> languages.
> 
> True.
> 
>> Add support for arbitrary alias names by using config subsections:
>>
>>      [alias "förgrena"]
>>          command = branch
>>
>> The subsection name is matched as-is (case-sensitive byte comparison),
>> while the existing definition without a subsection (e.g.,
>> "[alias] co = checkout") remains case-insensitive for backward
>> compatibility. This uses existing config infrastructure since
>> subsections already support arbitrary bytes, and avoids introducing
>> Unicode normalization.
>>
>> Also teach the help subsystem about the new syntax so that "git help
>> -a" properly lists subsection aliases and the autocorrect feature can
>> suggest them. Use utf8_strwidth() instead of strlen() for column
>> alignment so that non-alphanumeric alias names display correctly.
> 
> Either move the last two hunks from [1/2] to this step, or make it a
> separate patch [1.5/2] between this and the other steps, and explain
> it as a change that breaks compatibility in a way that hopefully
> would not affect anybody in practice.  The alias configuration
> parser used to be overly loose and took "alias.<subsection>.<key>"
> as defining an alias "<subsection>.<key>"; that change tightens the
> parser and alias.<subsection>.<key> are silently ignored.  This step
> then take alias.<subsection>.command to be defining a new-style
> alias that can be invoked as "<subsection>", which is case sensitive
> and is not limited to ASCII alphanumeric and dashes.
> 
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
>> ---
>>   Documentation/config/alias.adoc | 44 +++++++++++++++++++++-----
>>   alias.c                         | 45 ++++++++++++++++++++++-----
>>   help.c                          | 12 +++++--
>>   t/t0014-alias.sh                | 55 +++++++++++++++++++++++++++++++++
>>   4 files changed, 137 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
>> index 80ce17d2de..17a548cd64 100644
>> --- a/Documentation/config/alias.adoc
>> +++ b/Documentation/config/alias.adoc
>> @@ -1,12 +1,40 @@
>>   alias.*::
>> +alias.*.command::
>> +	Command aliases for the linkgit:git[1] command wrapper. Aliases
>> +	can be defined using two syntaxes:
>> ++
>> +--
>> +1. Without a subsection, e.g., `[alias] co = checkout`. The alias
>> +   name is limited to alphanumeric characters and `-` (the same
>> +   limitation as configuration variable names), and is matched
>> +   case-insensitively.
>> +2. With a subsection, e.g., `[alias "name"] command = value`. The
>> +   alias name can contain any characters including UTF-8, and is
>> +   matched case-sensitively as raw bytes.
>> +--
>> ++
>> +Examples:
>> ++
>> +----
>> +# Without subsection
>> +[alias]
>> +    co = checkout
>> +    st = status
>> +
>> +# With subsection (allows UTF-8 and special characters)
>> +[alias "hämta"]
>> +    command = fetch
>> +[alias "gömma"]
>> +    command = stash
>> +----
>> ++
>> +E.g. after defining `alias.last = cat-file commit HEAD`, the invocation
>> +`git last` is equivalent to `git cat-file commit HEAD`. To avoid
>> +confusion and troubles with script usage, aliases that
>> +hide existing Git commands are ignored except for deprecated
>> +commands.  Arguments are split by
>> +spaces, the usual shell quoting and escaping are supported.
>> +A quote pair or a backslash can be used to quote them.
>>   +
>>   Note that the first word of an alias does not necessarily have to be a
>>   command. It can be a command-line option that will be passed into the
>> diff --git a/alias.c b/alias.c
>> index c66a6095bb..cfd313ce5d 100644
>> --- a/alias.c
>> +++ b/alias.c
>> @@ -17,21 +17,50 @@ static int config_alias_cb(const char *key, const char *value,
>>   			   const struct config_context *ctx UNUSED, void *d)
>>   {
>>   	struct config_alias_data *data = d;
>> -	const char *p;
>> +	const char *subsection, *subkey;
>> +	size_t subsection_len;
>>   
>> -	if (!skip_prefix(key, "alias.", &p))
>> +	if (parse_config_key(key, "alias", &subsection, &subsection_len,
>> +			     &subkey) < 0)
>>   		return 0;
>>   
>> +	/*
>> +	 * Two config syntaxes:
>> +	 * - alias.name = value        (without subsection, case-insensitive)
>> +	 * - [alias "name"]
>> +	 *       command = value       (with subsection, case-sensitive)
>> +	 */
>> +	if (subsection) {
>> +		if (strcmp(subkey, "command"))
>> +			return 0;
> 
> This silently ignores
> 
> 	[alias "foo"]
> 		bar = !date
> 
> which may or may not be a feature.  If the variable name is "help"
> instead of "bar", it certainly is a feature to silently skip it, as
> it is not inconceivable that we would add such a variable name in
> the future, and because we won't be able to predict the future, not
> limiting us to "help" but ignoring anything we do not understand
> like this code does may probably be a good thing.  I dunno.
> 
>> +	}
>> +
>>   	if (data->alias) {
>> -		if (!strcasecmp(p, data->alias)) {
>> +		int match;
>> +
>> +		if (subsection)
>> +			match = (strlen(data->alias) == subsection_len &&
>> +				 !strncmp(data->alias, subsection,
>> +					  subsection_len));
>> +		else
>> +			match = !strcasecmp(data->alias, subkey);
>> +
>> +		if (match) {
>>   			FREE_AND_NULL(data->v);
>> -			return git_config_string(&data->v,
>> -						 key, value);
>> +			return git_config_string(&data->v, key, value);
>>   		}
>>   	} else if (data->list) {
>> -		if (value)
>> -			string_list_append(data->list, p)->util =
>> -				xstrdup(value);
>> +		struct string_list_item *item;
>> +
>> +		if (!value)
>> +			return 0;
>> +
>> +		if (subsection)
>> +			item = string_list_append_nodup(data->list,
>> +				xmemdupz(subsection, subsection_len));
>> +		else
>> +			item = string_list_append(data->list, subkey);
>> +		item->util = xstrdup(value);
> 
> This still silently ignores
> 
> 	[alias "foo"]
> 		command
> 
> which is a much more grave problem than ignoring alias.foo.bar in
> the earlier part of this function.  We would want to preserve the
> existing diagnosis on broken configuration.
> 
>> @@ -108,7 +109,7 @@ static void print_command_list(const struct cmdname_help *cmds,
>>   
>>   	for (i = 0; cmds[i].name; i++) {
>>   		if (cmds[i].category & mask) {
>> -			size_t len = strlen(cmds[i].name);
>> +			size_t len = utf8_strwidth(cmds[i].name);
>>   			printf("   %s   ", cmds[i].name);
>>   			if (longest > len)
>>   				mput_char(' ', longest - len);
>> @@ -492,7 +493,7 @@ static void list_all_cmds_help_aliases(int longest)
>>   	string_list_sort(&alias_list);
>>   
>>   	for (i = 0; i < alias_list.nr; i++) {
>> -		size_t len = strlen(alias_list.items[i].string);
>> +		size_t len = utf8_strwidth(alias_list.items[i].string);
>>   		if (longest < len)
>>   			longest = len;
>>   	}
>> @@ -590,8 +591,13 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>>   
>>   	/* Also use aliases for command lookup */
>>   	if (!parse_config_key(var, "alias", &subsection, &subsection_len, &key)) {
>> -		if (!subsection)
>> +		if (subsection) {
>> +			if (!strcmp(key, "command"))
>> +				add_cmdname(&cfg->aliases, subsection,
>> +					    subsection_len);
>> +		} else {
>>   			add_cmdname(&cfg->aliases, key, strlen(key));
>> +		}
>>   	}
> 
> OK.  Alternatively, out of
> 
> 	[alias "foo"]
> 		command = !echo foo
> 		bar = !echo bar
> 
> we _could_ list "foo" (a new style alias) and "foo.bar" (an old
> style alias that we have been accepting forever by mistake) for
> maximum backward compatibility.  I am still undecided if it is a
> good idea.
> 
> Thanks.

