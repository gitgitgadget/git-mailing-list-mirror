Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9115539A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080513; cv=none; b=XdQo6rkyLz2mcpwbUsG7kBwYLIsurS+jEdkXYhQ3TTxiccxrC6hnxxNtczqOcNgbvczr9SZffnqhf5bCkjg5aNz4peFB6yCpuY+EC8RWUpxPf63sbgjxJJu+OlimEso0DQlJ2Vrj2xp0qjCUAztP01U6YhdiWKhEZWkmUAEjXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080513; c=relaxed/simple;
	bh=LYDjb9XuVmFnX+ISuK3fyvTQAvreUjKjzTdhZK53m+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmQ3y5+FEISo2EdbLLduZ8dnARIfGuhwuRhW5Z1yC2tx7HVkzi3ADiUwByr6b/Z3iR9E97+5Lptdg13cQqGGAvbsU0x3dzML2gsMYBTi7OyZE3qdxpQXHTCsNFxihJDBa5sDBzLcnimsBB6jTOy/SMtUjAEnvTT4BYkDleASINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=iR5h3+HC; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="iR5h3+HC"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 56FA083501B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:27:46 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:cb06:114:e600:28d2:9042:8b81:c43a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1CE7AB0053D;
	Fri,  1 Aug 2025 22:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754080059;
	bh=LYDjb9XuVmFnX+ISuK3fyvTQAvreUjKjzTdhZK53m+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iR5h3+HCHKbORgesWE0pF5cCventLPAsTbp1BxEHNp+0D7fkf7LsX8EbQNqYaB+uU
	 DksQcMizSAO37yi0OJ/J+rEVVwoCouPEAYHMu+tYVSdM4IgEhDi3mY69ucYYcc6Puq
	 EFYC5L034uOQnp9WXZO69jrtPHmshGM5sDXHwDmpir6MxMmPKtLJxXuy644f5w4Mie
	 ZmDup9JT99DLjOdpSC96aGOF49+QcA+b121vDmDTwuDp12gPTauWdxxXfSF/EplkU1
	 LcpY8FZTeAh3XkCO/KoVPhPyu05JKfRWj/9cjoIIHxjrTaCLtQ7JAJku0gQ6McFWeY
	 tBzP5tEvA2wyg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
 jltobler@gmail.com, sunshine@sunshineco.com,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [GSoC PATCH v7 5/5] repo: add the --format flag
Date: Fri, 01 Aug 2025 22:27:27 +0200
Message-ID: <12714201.O9o76ZdvQC@cayenne>
In-Reply-To: <20250801131111.8115-6-lucasseikioshiro@gmail.com>
References:
 <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 1 August 2025 15:11:10 CEST Lucas Seiki Oshiro wrote:
> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
> 
> Given that this command can be used for generating input for other
> applications and for being read by end users, it requires at least two
> formats: one for being read by humans and other for being read by
> machines. Some other Git commands also have two output formats, notably
> git-config which was the inspiration for the two formats that were
> chosen here:
> 
> - keyvalue, where the retrieved data is printed one per line, using =
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - nul, where the retrieved data is separated by null characters, using
>   the newline character for delimiting the key and the value. This
>   format is targeted for being read by machines.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc | 31 +++++++++++++++++++-
>  builtin/repo.c              | 58 +++++++++++++++++++++++++++++++------
>  t/t1900-repo.sh             | 21 ++++++++++++--
>  3 files changed, 97 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 140ee3a0aa..b735cf4737 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -18,12 +18,23 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> 
>  COMMANDS
>  --------
> -`info [<key>...]`::
> +`info [--format=<keyvalue|nul>] [<key>...]`::

According to the source code, I understand that this line should read:

`info [--format=(keyvalue|nul)] [<key>...]`::

With parentheses, which is that `keyvalue` and `nul` are keywords describing 
the type of format.

>  	Retrieve metadata-related information about the current 
repository. Only
>  	the requested data will be returned based on their keys (see "INFO 
KEYS"
>  	section below).
>  +
>  The returned data is lexicographically sorted by the keys.
> ++
> +The output format can be chosen through the flag `--format`. Two formats are
> +supported:
> ++
> +* `keyvalue`: output key-value pairs one per line using the `=` character 
as
> +the delimiter between the key and the value. This is the default.
> +
> +* `nul`: similar to `keyvalue`, but using a newline character as the 
delimiter
> +between the key and the value and using a null character after each value.
> +This format is better suited for being parsed by another applications than
> +`keyvalue`.
> 
>  INFO KEYS
>  ---------
> @@ -43,6 +54,24 @@ The reference storage format. The valid values are:
>  +
>  include::ref-storage-format.adoc[]
> 
> +
> +Examples
> +--------
> +
> +* Retrieves the reference format of the current repository:
> ++
> +------------
> +git repo info references.format
> +------------
> ++
> +
> +* Retrieves whether the current repository is bare and whether it is 
shallow
> +using the `nul` format:
> ++
> +------------
> +git repo info --format=nul layout.bare layout.shallow
> +------------
> +
>  SEE ALSO
>  --------
>  linkgit:git-rev-parse[1]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 56c3a4027f..4015cf88b7 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -9,12 +9,17 @@
>  #include "shallow.h"
> 
>  static const char *const repo_usage[] = {
> -	"git repo info [<key>...]",
> +	"git repo info [--format=<keyvalue|nul>] [<key>...]",
>  	NULL
>  };
> 
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
> 
> +enum output_format {
> +	FORMAT_KEYVALUE,
> +	FORMAT_NUL_TERMINATED,
> +};
> +
>  struct field {
>  	const char *key;
>  	get_value_fn *get_value;
> @@ -74,18 +79,33 @@ static int qsort_strcmp(const void *va, const void *vb)
>  	return strcmp(a, b);
>  }
> 
> -static int print_fields(int argc, const char **argv, struct repository 
*repo)
> +static int print_fields(int argc, const char **argv,
> +			struct repository *repo,
> +			enum output_format format)
>  {
>  	int ret = 0;
>  	const char *last = "";
>  	struct strbuf sb = STRBUF_INIT;
> 
> +	char kv_sep;
> +	char field_sep;
> +
> +	switch (format) {
> +	case FORMAT_KEYVALUE:
> +		kv_sep = '=';
> +		field_sep = '\n';
> +		break;
> +	case FORMAT_NUL_TERMINATED:
> +		kv_sep = '\n';
> +		field_sep = '\0';
> +		break;
> +	}
> +
>  	QSORT(argv, argc, qsort_strcmp);
> 
>  	for (int i = 0; i < argc; i++) {
>  		get_value_fn *get_value;
>  		const char *key = argv[i];
> -		char *value;
> 
>  		if (!strcmp(key, last))
>  			continue;
> @@ -100,11 +120,14 @@ static int print_fields(int argc, const char **argv, 
struct
> repository *repo) strbuf_reset(&sb);
>  		get_value(repo, &sb);
> 
> -		value = strbuf_detach(&sb, NULL);
> -		quote_c_style(value, &sb, NULL, 0);
> -		free(value);
> +		if (format == FORMAT_KEYVALUE) {
> +			char *value;
> +			value = strbuf_detach(&sb, NULL);
> +			quote_c_style(value, &sb, NULL, 0);
> +			free(value);
> +		}
> 
> -		printf("%s=%s\n", key, sb.buf);
> +		printf("%s%c%s%c", key, kv_sep, sb.buf, field_sep);
>  		last = key;
>  	}
> 
> @@ -112,10 +135,27 @@ static int print_fields(int argc, const char **argv, 
struct
> repository *repo) return ret;
>  }
> 
> -static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
> +static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
> -	return print_fields(argc - 1, argv + 1, repo);
> +	const char *format_str = "keyvalue";
> +	enum output_format format;
> +	struct option options[] = {
> +		OPT_STRING(0, "format", &format_str, N_("format"),
> +			   N_("output format")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +
> +	if (!strcmp(format_str, "keyvalue"))
> +		format = FORMAT_KEYVALUE;
> +	else if (!strcmp(format_str, "nul"))
> +		format = FORMAT_NUL_TERMINATED;
> +	else
> +		die(_("invalid format '%s'"), format_str);
> +
> +	return print_fields(argc, argv, repo, format);
>  }
> 
>  int cmd_repo(int argc, const char **argv, const char *prefix,
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 6706cb4c44..463ec3af92 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -21,10 +21,17 @@ test_repo_info () {
>  	key=$4
>  	expected_value=$5
> 
> -	test_expect_success "$label" '
> -		eval "$init_command $repo_name" &&
> +	test_expect_success "keyvalue: $label" '
> +		eval "$init_command keyvalue-$repo_name" &&
>  		echo "$key=$expected_value" >expected &&
> -		git -C $repo_name repo info "$key" >actual &&
> +		git -C keyvalue-$repo_name repo info "$key" >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "nul: $label" '
> +		eval "$init_command nul-$repo_name" &&
> +		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
> +		git -C nul-$repo_name repo info --format=nul "$key" 
>actual &&
>  		test_cmp expected actual
>  	'
>  }
> @@ -45,6 +52,7 @@ test_repo_info 'shallow repository = false is retrieved
> correctly' ' git init' 'nonshallow' 'layout.shallow' 'false'
> 
>  test_repo_info 'shallow repository = true is retrieved correctly' '
> +	test_when_finished "rm -rf remote" &&
>  	git init remote &&
>  	echo x >remote/x &&
>  	git -C remote add x &&
> @@ -79,4 +87,11 @@ test_expect_success 'output is returned correctly when 
two keys
> are requested' ' git -C two-keys repo info layout.bare references.format
>  '
> 
> +test_expect_success 'git-repo-info aborts when requesting an invalid 
format' '
> +	test_when_finished "rm -f err expected" &&
> +	echo "fatal: invalid format '\'foo\''" >expected &&
> +	test_must_fail git repo info --format=foo 2>err &&
> +	test_cmp expected err
> +'
> +
>  test_done




