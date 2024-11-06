Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38229335B5
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899924; cv=none; b=HZVIGu7bccmYK168uhoTLklAASb3LPNTlRX4XBec2z2jiixF50OCTuH5mdsDKYSog2vP4kX7ymRv4gBzWcHi5w7JHAkjj7FZ//b73XmEID/8XW8YLcDbRzALxjdc/mCVMt14d8lhOVB5/xjawItgV3ZOafpWujDNWmyhj1E98h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899924; c=relaxed/simple;
	bh=1h2a9afMPURuPbuot7+YsSYIxRVcUHVqY1BjRg9Ay1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYZZNtvFdzYpCw/WnqySvLolwLl/HLn5hjfrR7ZTWBCggLzwMxoJxRf+xZ2izR1XuXC4TyAO4z5Wx1rI6ucC3o1TLpQDENsggx5APK3qQzHzfbsENxS4M5/aspKfkWhrxreTlUOC3O2i97vMbhC72bXYXgpM0o20Nzwv/mUuyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me; spf=pass smtp.mailfrom=kmatsui.me; dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b=MaX5rXMC; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b="MaX5rXMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kmatsui.me;
	s=protonmail2; t=1730899912; x=1731159112;
	bh=1h2a9afMPURuPbuot7+YsSYIxRVcUHVqY1BjRg9Ay1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=MaX5rXMCNT19eRgcCwkmOkohLe7Q8rquPsZBHmNRt6mk8vVBTQbaWe5/M61rBUQbt
	 O1Ek+JoyYTOWc9jVEtcLlzFEseubDN5tV+i0QjdRFTQhOr9aR4A2sypZ10IeYRa8Ji
	 3CzW4wZUxJbrbiuR0bIwODho74BWADeZ1SZMFnkojTdlVkmc5C/qKjsgvBJqm/WIVZ
	 +/qE1Ldg0nWlHEA/JLR6GpFUSem1vQohKRTueFiicl6kuRZJNblummtTA+80436+1J
	 puMMJi0R8ZQ6Vbnyz6A0P5RGCkwO8SP815VsXUgK7vidmvev5FBz82c/LbnYVODkwD
	 T2JOQ+xQH12jA==
Date: Wed, 06 Nov 2024 13:30:46 +0000
To: Ken Matsui <ken@kmatsui.me>
From: Ken Matsui <ken@kmatsui.me>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, Matheus Tavares <matheus.tavb@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, Glen Choo <glencbz@gmail.com>, Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] config: support remote name in includeIf.hasconfig condition
Message-ID: <xFZco4IaItgwJDpEyko_Jb0z3REcs1FQsDeBdFXYHXfNAbipV9G87Otnv5SMK4J1eT4iT0E7OlVPvtSjs-ZiPZzHgcguaXLvBCs_iahqdbM=@kmatsui.me>
In-Reply-To: <20241020173216.40852-2-ken@kmatsui.me>
References: <20241020160143.92382-2-ken@kmatsui.me> <20241020173216.40852-2-ken@kmatsui.me>
Feedback-ID: 103884984:user:proton
X-Pm-Message-ID: a8216ebeb897bbada9b4e5c19db2274e943f2284
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping.

P.S. Some users have been attempting to use
hasconfig:remote.origin.url, so I believe this patch is a logical
improvement.

https://github.com/search?q=3D%22hasconfig%3Aremote.origin.url%22&type=3Dco=
de

On Sunday, October 20th, 2024 at 1:32 PM, Ken Matsui <ken@kmatsui.me> wrote=
:

>
>
> Changes in v3:
>
> * Updated the description based on Ramsay's review.
> * Added more tests.
>
> Changes in v2:
>
> * Updated the description based on Kristoffer's review.
>
> -- >8 --
>
>
> includeIf.hasconfig only accepts remote..url, making it difficult to
> apply configuration based on a specific remote, especially in projects
> with multiple remotes (e.g., GitHub and non-GitHub hosting). This often
> leads to undesired application of multiple config files.
>
> For example, the following configuration:
>
> [remote "origin"]
> url =3D https://git.kernel.org/pub/scm/git/git.git
> [remote "github"]
> url =3D https://github.com/myfork/git.git
>
> [includeIf "hasconfig:remote..url:https://github.com/"]
> path =3D github.inc
> [includeIf "hasconfig:remote.*.url:https://git.kernel.org/"]
> path =3D git.inc
>
> would apply both github.inc and git.inc, even when only one config is
> intended for the repository.
>
> Introduce support for specifying a remote name (e.g., origin) to enable
> more precise configuration management:
>
> [includeIf "hasconfig:remote.origin.url:https://github.com/"]
> path =3D github.inc
> [includeIf "hasconfig:remote.origin.url:https://git.kernel.org/"]
> path =3D git.inc
>
> This ensures that only git.inc is included in this configuration while
> other repositories that use github.com for origin can only include
> github.inc.
>
> Signed-off-by: Ken Matsui ken@kmatsui.me
>
> ---
> Documentation/config.txt | 13 +++-
> config.c | 141 ++++++++++++++++++++++++++++++++++-----
> t/t1300-config.sh | 84 +++++++++++++++++++++++
> 3 files changed, 219 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8c0b3ed807..22b50d523d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -161,14 +161,17 @@ all branches that begin with `foo/`. This is useful=
 if your branches are
> organized hierarchically and you would like to apply a configuration to
> all the branches in that hierarchy.
>
> -`hasconfig:remote.*.url:`::
> +`hasconfig:remote.(<name>|*).url:`::
>
> The data that follows this keyword is taken to
> be a pattern with standard globbing wildcards and two
> additional ones, `**/` and `/**`, that can match multiple
> components. The first time this keyword is seen, the rest of
> the config files will be scanned for remote URLs (without
> applying any values). If there exists at least one remote URL
> - that matches this pattern, the include condition is met.
> + that matches this pattern, the include condition is met. `<name>`
>
> + is the name of the remote, and `*` matches any remote name. Note
> + that `<name>` is not globbed, so it must be an exact match (e.g.,
>
> + `dev-*` will not match `dev-foo`).
> +
> Files included by this option (directly or indirectly) are not allowed
> to contain remote URLs.
> @@ -263,6 +266,12 @@ Example
> path =3D foo.inc
> [remote "origin"]
> url =3D https://example.com/git
> +
> +; include only if the given remote with the given URL exist.
> +[includeIf "hasconfig:remote.origin.url:https://example.com/**"]
> + path =3D foo.inc
> +[remote "origin"]
> + url =3D https://example.com/git
> ----
>
> Values
> diff --git a/config.c b/config.c
> index a11bb85da3..9de58eec7a 100644
> --- a/config.c
> +++ b/config.c
> @@ -123,6 +123,37 @@ static long config_buf_ftell(struct config_source *c=
onf)
> return conf->u.buf.pos;
>
> }
>
> +struct remote_urls_entry {
> + struct hashmap_entry ent;
> + char *name;
> + struct string_list urls;
> +};
> +
> +static struct remote_urls_entry *remote_urls_find_entry(struct hashmap *=
remote_urls,
> + char *name)
> +{
> + struct remote_urls_entry k;
> + struct remote_urls_entry *found_entry;
> +
> + hashmap_entry_init(&k.ent, strhash(name));
> + k.name =3D name;
> + found_entry =3D hashmap_get_entry(remote_urls, &k, ent, NULL);
> + return found_entry;
> +}
> +
> +static int remote_urls_entry_cmp(const void *cmp_data UNUSED,
> + const struct hashmap_entry *eptr,
> + const struct hashmap_entry *entry_or_key,
> + const void *keydata UNUSED)
> +{
> + const struct remote_urls_entry *e1, *e2;
> +
> + e1 =3D container_of(eptr, const struct remote_urls_entry, ent);
> + e2 =3D container_of(entry_or_key, const struct remote_urls_entry, ent);
> +
> + return strcmp(e1->name, e2->name);
>
> +}
> +
> struct config_include_data {
> int depth;
> config_fn_t fn;
> @@ -132,9 +163,10 @@ struct config_include_data {
> struct repository repo;
>
> /
> - * All remote URLs discovered when reading all config files.
> + * All remote names & URLs discovered when reading all config files.
> */
> - struct string_list *remote_urls;
> + struct hashmap remote_urls;
> + int remote_urls_initialized;
> };
> #define CONFIG_INCLUDE_INIT { 0 }
>
> @@ -328,16 +360,36 @@ static int include_by_branch(struct config_include_=
data *data,
> static int add_remote_url(const char *var, const char *value,
> const struct config_context *ctx UNUSED, void *data)
> {
> - struct string_list *remote_urls =3D data;
> - const char *remote_name;
> + struct hashmap *remote_urls =3D data;
> + const char *remote_section;
> size_t remote_name_len;
> const char *key;
>
> - if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
> + if (!parse_config_key(var, "remote", &remote_section, &remote_name_len,
> &key) &&
> - remote_name &&
> - !strcmp(key, "url"))
> - string_list_append(remote_urls, value);
> + remote_section &&
> + !strcmp(key, "url")) {
> + const char *dot;
> + char *remote_name;
> + struct remote_urls_entry *e;
> +
> + dot =3D strchr(remote_section, '.');
> + if (!dot)
> + return 0;
> +
> + remote_name =3D xstrndup(remote_section, dot - remote_section);
> + e =3D remote_urls_find_entry(remote_urls, remote_name);
> + if (!e) {
> + e =3D xmalloc(sizeof(*e));
> + hashmap_entry_init(&e->ent, strhash(remote_name));
>
> + e->name =3D remote_name;
>
> + string_list_init_dup(&e->urls);
>
> + string_list_append(&e->urls, value);
>
> + hashmap_add(remote_urls, &e->ent);
>
> + } else {
> + string_list_append(&e->urls, value);
>
> + }
> + }
> return 0;
> }
>
> @@ -348,9 +400,9 @@ static void populate_remote_urls(struct config_includ=
e_data *inc)
> opts =3D *inc->opts;
>
> opts.unconditional_remote_url =3D 1;
>
> - inc->remote_urls =3D xmalloc(sizeof(*inc->remote_urls));
>
> - string_list_init_dup(inc->remote_urls);
>
> - config_with_options(add_remote_url, inc->remote_urls,
>
> + hashmap_init(&inc->remote_urls, remote_urls_entry_cmp, NULL, 0);
>
> + inc->remote_urls_initialized =3D 1;
>
> + config_with_options(add_remote_url, &inc->remote_urls,
>
> inc->config_source, inc->repo, &opts);
>
> }
>
> @@ -391,12 +443,35 @@ static int at_least_one_url_matches_glob(const char=
 *glob, int glob_len,
> static int include_by_remote_url(struct config_include_data *inc,
> const char *cond, size_t cond_len)
> {
> + struct hashmap_iter iter;
> + struct remote_urls_entry *remote;
> +
> + if (inc->opts->unconditional_remote_url)
>
> + return 1;
> + if (!inc->remote_urls_initialized)
>
> + populate_remote_urls(inc);
> +
> + hashmap_for_each_entry(&inc->remote_urls, &iter, remote, ent)
>
> + if (at_least_one_url_matches_glob(cond, cond_len, &remote->urls))
>
> + return 1;
> + return 0;
> +}
> +
> +static int include_by_remote_name_and_url(struct config_include_data *in=
c,
> + const char *cond, size_t cond_len,
> + char *remote_name)
> +{
> + struct remote_urls_entry *e;
> +
> if (inc->opts->unconditional_remote_url)
>
> return 1;
> - if (!inc->remote_urls)
>
> + if (!inc->remote_urls_initialized)
>
> populate_remote_urls(inc);
> - return at_least_one_url_matches_glob(cond, cond_len,
> - inc->remote_urls);
>
> +
> + e =3D remote_urls_find_entry(&inc->remote_urls, remote_name);
>
> + if (!e)
> + return 0;
> + return at_least_one_url_matches_glob(cond, cond_len, &e->urls);
>
> }
>
> static int include_condition_is_true(const struct key_value_info *kvi,
> @@ -414,6 +489,32 @@ static int include_condition_is_true(const struct ke=
y_value_info kvi,
> else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote..url:", &cond,
> &cond_len))
> return include_by_remote_url(inc, cond, cond_len);
> + else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.", &cond,
> + &cond_len)) {
> + const char *dot;
> + char *remote_name;
> + char cond_prefix;
> + int ret;
> +
> + dot =3D strchr(cond, '.');
> + if (!dot)
> + return 0;
> +
> + remote_name =3D xstrndup(cond, dot - cond);
> + cond_prefix =3D xstrfmt("%s.url:", remote_name);
> + if (!skip_prefix_mem(cond, cond_len, cond_prefix, &cond,
> + &cond_len)) {
> + free(cond_prefix);
> + free(remote_name);
> + return 0;
> + }
> + free(cond_prefix);
> +
> + ret =3D include_by_remote_name_and_url(inc, cond, cond_len,
> + remote_name);
> + free(remote_name);
> + return ret;
> + }
>
> / unknown conditionals are always false */
> return 0;
> @@ -2151,9 +2252,15 @@ int config_with_options(config_fn_t fn, void *data=
,
> ret =3D do_git_config_sequence(opts, repo, fn, data);
> }
>
> - if (inc.remote_urls) {
> - string_list_clear(inc.remote_urls, 0);
> - FREE_AND_NULL(inc.remote_urls);
> + if (inc.remote_urls_initialized) {
> + struct hashmap_iter iter;
> + struct remote_urls_entry *remote;
> + hashmap_for_each_entry(&inc.remote_urls, &iter, remote, ent) {
> + string_list_clear(&remote->urls, 0);
>
> + free(remote->name);
>
> + }
> + hashmap_clear_and_free(&inc.remote_urls, struct remote_urls_entry, ent)=
;
> + inc.remote_urls_initialized =3D 0;
> }
> return ret;
> }
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index f13277c8f3..81f149a712 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2831,6 +2831,90 @@ test_expect_success 'includeIf.hasconfig:remote..u=
rl forbids remote url in such
> grep "fatal: remote URLs cannot be configured in file directly or indirec=
tly included by includeIf.hasconfig:remote..url" err
> '
>
> +test_expect_success 'includeIf.hasconfig:remote.<name>.url with differen=
t remote names and the same URL' '
>
> + git init hasremoteurlTest &&
> + test_when_finished "rm -rf hasremoteurlTest" &&
> +
> + cat >include-this <<-\EOF &&
>
> + [user]
> + this =3D this-is-included
> + EOF
> + cat >dont-include-that <<-\EOF &&
>
> + [user]
> + that =3D that-is-not-included
> + EOF
> + cat >>hasremoteurlTest/.git/config <<-EOF &&
>
> + [includeIf "hasconfig:remote.foo.url:sameurl"]
> + path =3D "$(pwd)/include-this"
> + [includeIf "hasconfig:remote.bar.url:sameurl"]
> + path =3D "$(pwd)/dont-include-that"
> + [remote "foo"]
> + url =3D sameurl
> + EOF
> +
> + echo this-is-included >expect-this &&
>
> + git -C hasremoteurlTest config --get user.this >actual-this &&
>
> + test_cmp expect-this actual-this &&
> +
> + test_must_fail git -C hasremoteurlTest config --get user.that
> +'
> +
> +test_expect_success 'includeIf.hasconfig:remote.<name>.url with the same=
 remote name and different URLs' '
>
> + git init hasremoteurlTest &&
> + test_when_finished "rm -rf hasremoteurlTest" &&
> +
> + cat >include-this <<-\EOF &&
>
> + [user]
> + this =3D this-is-included
> + EOF
> + cat >dont-include-that <<-\EOF &&
>
> + [user]
> + that =3D that-is-not-included
> + EOF
> + cat >>hasremoteurlTest/.git/config <<-EOF &&
>
> + [includeIf "hasconfig:remote.foo.url:foourl"]
> + path =3D "$(pwd)/include-this"
> + [includeIf "hasconfig:remote.foo.url:barurl"]
> + path =3D "$(pwd)/dont-include-that"
> + [remote "foo"]
> + url =3D foourl
> + EOF
> +
> + echo this-is-included >expect-this &&
>
> + git -C hasremoteurlTest config --get user.this >actual-this &&
>
> + test_cmp expect-this actual-this &&
> +
> + test_must_fail git -C hasremoteurlTest config --get user.that
> +'
> +
> +test_expect_success 'includeIf.hasconfig:remote.<name>.url with differen=
t remote names and URLs' '
>
> + git init hasremoteurlTest &&
> + test_when_finished "rm -rf hasremoteurlTest" &&
> +
> + cat >include-this <<-\EOF &&
>
> + [user]
> + this =3D this-is-included
> + EOF
> + cat >dont-include-that <<-\EOF &&
>
> + [user]
> + that =3D that-is-not-included
> + EOF
> + cat >>hasremoteurlTest/.git/config <<-EOF &&
>
> + [includeIf "hasconfig:remote.foo.url:foourl"]
> + path =3D "$(pwd)/include-this"
> + [includeIf "hasconfig:remote.bar.url:barurl"]
> + path =3D "$(pwd)/dont-include-that"
> + [remote "foo"]
> + url =3D foourl
> + EOF
> +
> + echo this-is-included >expect-this &&
>
> + git -C hasremoteurlTest config --get user.this >actual-this &&
>
> + test_cmp expect-this actual-this &&
> +
> + test_must_fail git -C hasremoteurlTest config --get user.that
> +'
> +
> test_expect_success 'negated mode causes failure' '
> test_must_fail git config --no-get 2>err &&
>
> grep "unknown option \`no-get${SQ}" err
> --
> 2.47.0
