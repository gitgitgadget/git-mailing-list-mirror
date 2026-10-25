Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957343;
	b=ND3JpODP7EAGGRxpCBgzFIn0ceW99zKf5Foka/aZ+S4Hg+BE7+w54MFZyXcGWnY09p4g
	 KNrMYCuTLg1rIbwCkT5Sj7ztJvsjtFz+rsWjeNi1Egvu5grtZoGe6Njfq5ue5PL0mEsJZ
	 Z75uwNW2LY6hO3kWoPmvdfYpBG+HvrO6tVcLTlm7nNGoJeqcTMy0wcVP/H4mbGnZPEXWv
	 pP+U+sUoD+VlERU352fDqeoZwptIt3yYyLFzXAl17zdq++JbNPa9ZFvRjrAjyteGxgkim
	 6hU5SElEqFtGFucqHv0VuaZCu7MbJKo/Jv8QPNSMu88UuLDOMNdx4wIL5tpmdgCPL8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IlKxYjD1qjSfPMAVxaxyxEcETsKJK3sXzx8BN6oXCB0=;
	b=SKkD7N04f7cszgC3ftvJ0uhKvEqlbonxWs7HJrSmGPpyHGU08U2tgV6wtJh9Zwlb2WRG
	 Ec8A9puAaUb94es5eye1QvwwyvrUATiQEWSocB8JZvbqJoq5WPl34J+QaD1AJlTeaQ7D8
	 FKtVaCMZ+WhV52JRQM72JqpvsG2eSqHoOFMNtZOS1rIXKsIod44q8tFvWQMMK6l8XXaAf
	 nh6LlfN0JPej05LxYHwgfCnBEF1q2QsGt7FHUCSF1zl5HFO0GrOcRrtUwsqwisD4af5bz
	 csBz2D56Cmdoln6NVV4Iqx/wFzsapb9GLKPMxKxr73SpOZaFvo7O/Ot505Ogl19J5ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0WnLrHL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CB3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0WnLrHL
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6dde81a6820so1850464eaf.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 12:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792957341; cv=none;
        d=google.com; s=arc-20260327;
        b=Vo7o0XX+R21/IrUBZiiWb+w0NSvdl/6EzHXd32laBXct7Hy/w5WpaQNoaS2YEToaVf
         uFd+IwEoSd/SCg/H/Cm5bzSmIQYSoRK0+Le+2dAMJFmYI1Om3RZ3RY1h39WufyZUi5e9
         a3ys+VBe5jsZHB+hLXDRjriZOrhvPcUp+tGDtB26+o8nI1r839mbZ/KN76IwykJzVTkJ
         5NMSwjqLwW+v6pC/ZdyKqgPYtFfRZFXgTGC4qWQ8Y8qPzskeVo31mqp5hSFlDsMzOtjq
         JgcEIgwgpVEUTSXCE5HfdfnhUAXkLqG3CbvT/wDZLdAL66w9xSd9DtzEqjoED9veTeBU
         K6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlKxYjD1qjSfPMAVxaxyxEcETsKJK3sXzx8BN6oXCB0=;
        fh=UfphQm4Hqdo6WH1l0G4BQQ7LZkyG8GWumJTbiG6/V2Y=;
        b=mMdRw9oPQ7lbO/cj6OZdCM4WKwL2ulNZcXPgkniRY4aJNgVLqePhBdYHKYdiTgd6A/
         vVg7jfBT26yNlPYBvKkqm95NvTtOJpkWLvp/+DMJT6Cs4sz3v6lgt7a2zhq1qZmtM6Kd
         c6ELRvKt8U56XRbkc7cXaJ6E8jdEXAQ2eqlkG81Lr0qQ/ES5rdABNPLPUxU+Umf6cPaa
         ozElJyP4eaHRLloFcfZapJBcLu6pC2gd4XpUp//hdXN3o69gWlXjRo/WVVjJVKiJIZ/Q
         pm7cq4UBTQ58Hz5Dwty+9siGZ8paY40AREtGrE3IpCjoUFtswqIY5/5RDs0PM9KO0jzD
         Znuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792957341; x=1793562141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IlKxYjD1qjSfPMAVxaxyxEcETsKJK3sXzx8BN6oXCB0=;
        b=l0WnLrHLvr1+ehjigYwYWhsRmGycIIfn2QpiqrJz2dWPowOFcx1SwqTGBSL8pVM2X3
         HUvWzF07rwI/+ZNC/rXttANNfgD+xE/ky1c6zw2TueduMTOIx2ENllfTbCk1BGyCYbNm
         6Cnii2wcZiG5GYyr49Zo9rul/5uS5wAaBb7Lqfpa9dh0ysYyF9lkT8FyJUZb5fgMnNUJ
         T/Hid5ynijdmQ7NHNiP39XnvTtHQQFnwEkoL78E9S246tM4p/I9bsCXgbhc/WVARUEHj
         BGyRWgUA7LV1wPTDm8xK1Kie0Fm5KLuBWuKNhSC3XXvEW8tB3axwI5VvU1eNKqrdQWk/
         EuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792957341; x=1793562141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlKxYjD1qjSfPMAVxaxyxEcETsKJK3sXzx8BN6oXCB0=;
        b=BuDqdeMKir1nVYJd0hfDrQ9z1jdz0EdHZc1pnkOKAZK+osCtAUHSsBuA+AAtcSpRkx
         ZFwsuAST0GmElVhk0jHWFyFuyXgxo86WqlXA50gc5M/dcLDK/iKxC34WHierGMPGkk1r
         LA1N8p+emuV6vGJ75Jn9rLw4eXY44XhOz3x2AKNZOmg5TdrgYrsmN147p2s6A824P4wo
         a+bxpPXyapvhqrGkX2+9aq5IGHIlRpFo2H+Ecta6dpeuors3J2c+nBfu4peZxANdgV/6
         /aGuciE9fGyEKcqls19O3rVf0gwEow9QvyG5XX43zViVedstiuSF1H+ioOkjBhWpfLjl
         dErQ==
X-Gm-Message-State: AFq9FYKDEUKwEtJ049leFn2y09erH46dn5H0+rtXuOQrB3Pdx6DCzA8H
	exKUocio5BxfUkAeils58zQwy7vEp8uVf1sDXntee6e0m6t+T7mzXSO7uXUieen5Es8YEjscnae
	rfnigN+7Hk9Fvd1CQVDU0F6OamjNqBDE=
X-Gm-Gg: AYBFou3HR+lDuGejz16vpMCe4oHf1FALtBcafH8phTa9Vi0bndVy86tQqq6/pOJVY5g
	HLnQU+iGAVRT9wXOZaNBizm43vJS5LLYPLsOM55thItQVtAnSwBMoXthSSnBGPUtYf7Is66Upl/
	x4q1y/i3uORsT+5jw8tjmEywTPlBUo+WWuze2+01tEVkDsIn2kUUJEL5db+pbYbSU2KTbBYLQkF
	+1HjPKNFyBT/sUQF1ldrWd11K9mpucyuhKRy9IeaBWc73WGpw4HNxkY8RC3W/CFxmviFeqLEQIf
	ZK55KKcvLLHGB/nRPotxvNsR8y8JwwuQLx/U7P4Jz+3trnAfmqKMm+CQ7Beomazgcv/SoHSCFu1
	zuJ8TY7tSY3pq0l233Br6IxRxhfTz8Psd7w==
X-Received: by 2002:a05:6820:2203:b0:70c:8247:fc73 with SMTP id
 006d021491bc7-70c824816f7mr1087613eaf.81.1792957341329; Sun, 25 Oct 2026
 12:42:21 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
In-Reply-To: <20260929185122.3127574-1-lightofmysoul@gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Sun, 25 Oct 2026 12:42:10 -0700
X-Gm-Features: AclHuK9wTDXhfJIfUN5bKNHYa0b9BAb5FU-dAQRZcp-TLtfizihxQrdCV7ydoFQ
Message-ID: <CA+P7+xoSd2rsHpw+n5vCrcqXRibG6zH+SKCsVXA0OW-VZN_+=g@mail.gmail.com>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:51=E2=80=AFAM Stanislav Aleksandrov
<lightofmysoul@gmail.com> wrote:
>
> A submodule URL like "../../org/lib.git" breaks when the superproject
> is forked to a different depth, e.g. into a GitLab subgroup. An
> absolute URL doesn't break, but it forces one protocol on everyone.
>
> Resolve a URL starting with "^/" against the superproject's remote,
> like "../", but from the root of the server. Protocol, user, host and
> port stay the same. For "^/org/lib.git":
>
>     https://host/me/super.git      ->  https://host/org/lib.git
>     git@host:group/sub/super.git   ->  git@host:org/lib.git
>
> Unlike "../", "^/" fails in a superproject cloned from a local path or
> without a remote, since there is no server. It also fails for
> "<transport>::<address>" remotes, whose address only the helper can
> parse.
>
> The syntax comes from svn:externals, where "^/" is the repository root.
>
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---
> RFC: the syntax is new, and it changes the meaning of local paths
> that start with "^/".
>
> - Why not "/path" or "//host/path"? "/path" is already a local
>   absolute path, "//host" is a network path on Windows, and neither
>   can express "git@host:path" or SSH host aliases.

Sure. We would need something to distinguish these.

> - Why not url.<base>.insteadOf? It has to be set up on every clone;
>   .gitmodules cannot carry it.

Could .gitmodules be extended to carry this information?

> - Compatibility: a local "^/..." path needs a "^" directory in the
>   superproject and protocol.file.allow=3Dalways, and "git submodule
>   add" refuses it.

What do you mean here by "refuses it" Is this character already
refused? I.e. "^" isn't considered a valid directory, which is why its
suitable for converting to a special meaning?

> - Known costs: "^" is special in cmd.exe, Git Bash rewrites "^/..."
>   arguments, and libgit2, JGit and forges would need to learn it.
>

Adding new special characters meaning is always problematic. I do like
that "^/" has some precedence with SVN though.

> GitLab has an open request for the same thing:
> https://gitlab.com/gitlab-org/gitlab/-/issues/393295
>

The ultimate goal would be to allow users to specify what protocol
they want to operate on. Technically they can already do this by
changing the URL of the submodule in their local config, but this does
somewhat force doing so on everyone. It also makes that change a more
involved and manual process as you have to fix every single submodule
URL rather than automatically selecting the appropriate procotol based
on how you clone the root parent project.

I guess "insteadOf" even in the .gitmodules wouldn't work because you
wouldn't want to apply that to everyone. The issue seems to be caused
because of the URLs on Gitlab changing such that relative paths don't
work anymore?

Does doing something like "../../" work to allow the subproject to
find the root from a relative path? Or does the current logic not
support multiple ".."?

>  Documentation/git-submodule.adoc       |   8 +-
>  Documentation/gitmodules.adoc          |   7 +-
>  builtin/submodule--helper.c            |  39 +++--
>  remote.c                               |  61 ++++++++
>  remote.h                               |  15 ++
>  submodule-config.c                     |   8 +-
>  submodule-config.h                     |   6 +
>  t/helper/test-submodule.c              |   7 +-
>  t/meson.build                          |   1 +
>  t/t0060-path-utils.sh                  |  43 ++++++
>  t/t7427-submodule-root-relative-url.sh | 190 +++++++++++++++++++++++++
>  t/t7450-bad-git-dotfiles.sh            |   5 +
>  12 files changed, 366 insertions(+), 24 deletions(-)
>  create mode 100755 t/t7427-submodule-root-relative-url.sh
>
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodu=
le.adoc
> index 722d827908..f512625eb8 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -40,8 +40,9 @@ subcommands are available to perform operations on the =
submodules.
>         project: the current project is termed the "superproject".
>  +
>  _<repository>_ is the URL of the new submodule's `origin` repository.
> -This may be either an absolute URL, or (if it begins with `./`
> -or `../`), the location relative to the superproject's default remote
> +This may be an absolute URL, (if it begins with `^/`) an absolute path
> +on the server of the superproject's default remote, or (if it begins wit=
h
> +`./` or `../`), the location relative to the superproject's default remo=
te
>  repository (Please note that to specify a repository `foo.git`
>  which is located right next to a superproject `bar.git`, you'll
>  have to use `../foo.git` instead of `./foo.git` - as one might expect
> @@ -53,7 +54,8 @@ of the current branch. If no such remote-tracking branc=
h exists or
>  the `HEAD` is detached, `origin` is assumed to be the default remote.
>  If the superproject doesn't have a default remote configured
>  the superproject is its own authoritative upstream and the current
> -working directory is used instead.
> +working directory is used instead. A `^/` path needs a default remote
> +with a host.
>  +
>  The optional argument _<path>_ is the relative location for the cloned
>  submodule to exist in the superproject. If _<path>_ is not given, the
> diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.ado=
c
> index fd96639806..9f6cc9a4ef 100644
> --- a/Documentation/gitmodules.adoc
> +++ b/Documentation/gitmodules.adoc
> @@ -31,9 +31,10 @@ submodule.<name>.path::
>
>  submodule.<name>.url::
>         Defines a URL from which the submodule repository can be cloned.
> -       This may be either an absolute URL ready to be passed to
> -       linkgit:git-clone[1] or (if it begins with `./` or `../`) a locat=
ion
> -       relative to the superproject's origin repository.
> +       This may be an absolute URL ready to be passed to
> +       linkgit:git-clone[1], (if it begins with `./` or `../`) a locatio=
n
> +       relative to the superproject's origin repository, or (if it begin=
s
> +       with `^/`) an absolute path on the server of that repository.
>
>  In addition, there are a number of optional keys:
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5d3bcda334..16884ca6b6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -50,7 +50,8 @@ static char *get_default_remote(void)
>         return xstrdup(repo_default_remote(the_repository));
>  }
>
> -static char *resolve_relative_url(const char *rel_url, const char *up_pa=
th, int quiet)
> +static char *resolve_relative_url_gently(const char *rel_url,
> +                                        const char *up_path, int quiet)
>  {
>         char *remoteurl, *resolved_url;
>         char *remote =3D get_default_remote();
> @@ -58,14 +59,17 @@ static char *resolve_relative_url(const char *rel_url=
, const char *up_path, int
>
>         strbuf_addf(&remotesb, "remote.%s.url", remote);
>         if (repo_config_get_string(the_repository, remotesb.buf, &remoteu=
rl)) {
> -               if (!quiet)
> +               if (!quiet && !starts_with(rel_url, "^/"))
>                         warning(_("could not look up configuration '%s'. =
"
>                                   "Assuming this repository is its own "
>                                   "authoritative upstream."),
>                                 remotesb.buf);
>                 remoteurl =3D xgetcwd();
>         }
> -       resolved_url =3D relative_url(remoteurl, rel_url, up_path);
> +       if (starts_with(rel_url, "^/"))
> +               resolved_url =3D root_relative_url(remoteurl, rel_url);
> +       else
> +               resolved_url =3D relative_url(remoteurl, rel_url, up_path=
);
>
>         free(remote);
>         free(remoteurl);
> @@ -74,6 +78,16 @@ static char *resolve_relative_url(const char *rel_url,=
 const char *up_path, int
>         return resolved_url;
>  }
>
> +static char *resolve_relative_url(const char *rel_url, const char *up_pa=
th, int quiet)
> +{
> +       char *resolved_url =3D resolve_relative_url_gently(rel_url, up_pa=
th, quiet);
> +
> +       if (!resolved_url)
> +               die(_("cannot resolve '%s' without a remote url that has =
a host"),
> +                   rel_url);
> +       return resolved_url;
> +}
> +
>  static int get_default_remote_submodule(const char *module_path, char **=
default_remote)
>  {
>         const struct submodule *sub;
> @@ -87,11 +101,10 @@ static int get_default_remote_submodule(const char *=
module_path, char **default_
>                 url =3D xstrdup(sub->url);
>
>                 /* Possibly a url relative to parent */
> -               if (starts_with_dot_dot_slash(url) ||
> -                   starts_with_dot_slash(url)) {
> +               if (submodule_url_is_relative(url)) {
>                         char *oldurl =3D url;
>
> -                       url =3D resolve_relative_url(oldurl, NULL, 1);
> +                       url =3D resolve_relative_url_gently(oldurl, NULL,=
 1);
>                         free(oldurl);
>                 }
>         }
> @@ -618,8 +631,7 @@ static void init_submodule(const char *path, const ch=
ar *prefix,
>                 url =3D xstrdup(sub->url);
>
>                 /* Possibly a url relative to parent */
> -               if (starts_with_dot_dot_slash(url) ||
> -                   starts_with_dot_slash(url)) {
> +               if (submodule_url_is_relative(url)) {
>                         char *oldurl =3D url;
>
>                         url =3D resolve_relative_url(oldurl, NULL, 0);
> @@ -1450,8 +1462,7 @@ static void sync_submodule(const char *path, const =
char *prefix,
>         sub =3D submodule_from_path(the_repository, null_oid(the_hash_alg=
o), path);
>
>         if (sub && sub->url) {
> -               if (starts_with_dot_dot_slash(sub->url) ||
> -                   starts_with_dot_slash(sub->url)) {
> +               if (submodule_url_is_relative(sub->url)) {
>                         char *up_path =3D get_up_path(path);
>
>                         sub_origin_url =3D resolve_relative_url(sub->url,=
 up_path, 1);
> @@ -2314,8 +2325,7 @@ static int prepare_to_clone_next_submodule(const st=
ruct cache_entry *ce,
>         strbuf_reset(&sb);
>         strbuf_addf(&sb, "submodule.%s.url", sub->name);
>         if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
> -               if (sub->url && (starts_with_dot_slash(sub->url) ||
> -                                starts_with_dot_dot_slash(sub->url))) {
> +               if (sub->url && submodule_url_is_relative(sub->url)) {
>                         url =3D resolve_relative_url(sub->url, NULL, 0);
>                         need_free_url =3D 1;
>                 } else
> @@ -3710,8 +3720,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix,
>                 free(sm_path);
>         }
>
> -       if (starts_with_dot_dot_slash(add_data.repo) ||
> -           starts_with_dot_slash(add_data.repo)) {
> +       if (submodule_url_is_relative(add_data.repo)) {
>                 if (prefix)
>                         die(_("Relative path can only be used from the to=
plevel "
>                               "of the working tree"));
> @@ -3722,7 +3731,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix,
>         } else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, =
':')) {
>                 add_data.realrepo =3D add_data.repo;
>         } else {
> -               die(_("repo URL: '%s' must be absolute or begin with ./|.=
./"),
> +               die(_("repo URL: '%s' must be absolute or begin with ./|.=
./|^/"),
>                     add_data.repo);
>         }
>
> diff --git a/remote.c b/remote.c
> index fe62068463..05ef35e3ab 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -3095,6 +3095,67 @@ char *relative_url(const char *remote_url, const c=
har *url,
>         return strbuf_detach(&sb, NULL);
>  }
>
> +static const char *skip_bracketed_host(const char *host)
> +{
> +       const char *start =3D strstr(host, "@[");
> +       const char *end;
> +
> +       start =3D start ? start + 1 : host;
> +       if (*start !=3D '[')
> +               return host;
> +       end =3D strchr(start + 1, ']');
> +       return end ? end : host;
> +}
> +
> +static int has_host(const char *start, const char *end)
> +{
> +       const char *p;
> +
> +       for (p =3D start; p < end; p++)
> +               if (*p =3D=3D '@')
> +                       start =3D p + 1;
> +       return start < end && *start !=3D ':' && !starts_with(start, "[]"=
);
> +}
> +
> +char *root_relative_url(const char *remote_url, const char *url)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char *path, *host, *end;
> +       int scp;
> +
> +       if (!skip_prefix(url, "^/", &path))
> +               BUG("not a root-relative url: '%s'", url);
> +       if (*path =3D=3D '/' || *path =3D=3D ':')
> +               die(_("root-relative url '%s' must not start with '^//' o=
r '^/:'"),
> +                   url);
> +
> +       for (end =3D remote_url; is_urlschemechar(end =3D=3D remote_url, =
*end); end++)
> +               ;
> +       if (starts_with(end, "::") || starts_with(remote_url, "file://") =
||
> +           url_is_local_not_ssh(remote_url))
> +               return NULL;
> +
> +       scp =3D !is_url(remote_url);
> +       if (scp) {
> +               host =3D remote_url;
> +               end =3D strchr(skip_bracketed_host(remote_url), ':');
> +       } else {
> +               host =3D strstr(remote_url, "://") + 3;
> +               end =3D strchrnul(host, '/');
> +       }
> +       if (!end || !has_host(host, end))
> +               return NULL;
> +
> +       strbuf_add(&sb, remote_url, end - remote_url);
> +       strbuf_addch(&sb, scp ? ':' : '/');
> +       if (scp && end[1] =3D=3D '/')
> +               strbuf_addch(&sb, '/');
> +       strbuf_addstr(&sb, path);
> +       if (ends_with(path, "/"))
> +               strbuf_setlen(&sb, sb.len - 1);
> +       return strbuf_detach(&sb, NULL);
> +}
> +
>  int valid_remote_name(const char *name)
>  {
>         int result;
> diff --git a/remote.h b/remote.h
> index cca02033b9..8a759ae20d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -478,6 +478,21 @@ void apply_push_cas(struct push_cas_option *, struct=
 remote *, struct ref *);
>  char *relative_url(const char *remote_url, const char *url,
>                    const char *up_path);
>
> +/*
> + * The `url` argument starts with "^/" and names a repository relative t=
o
> + * the root of the server that `remote_url` points to: the path of
> + * `remote_url` is replaced with the rest of `url`, keeping its scheme, =
user,
> + * host and port. Returns NULL if `remote_url` has no host, and dies if
> + * `url` continues with '/' or ':', which could change the kind of URL.
> + *
> + * remote_url                 url            outcome
> + * https://a.com/b/c          ^/d/e          https://a.com/d/e
> + * ssh://u@a.com:22/b/c       ^/d/e          ssh://u@a.com:22/d/e
> + * u@a.com:b/c                ^/d/e          u@a.com:d/e
> + * u@a.com:/b/c               ^/d/e          u@a.com:/d/e
> + */
> +char *root_relative_url(const char *remote_url, const char *url);
> +
>  int valid_remote_name(const char *name);
>
>  #endif
> diff --git a/submodule-config.c b/submodule-config.c
> index 37c3be377b..dfa819112c 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -237,9 +237,10 @@ int check_submodule_name(const char *name)
>         return 0;
>  }
>
> -static int submodule_url_is_relative(const char *url)
> +int submodule_url_is_relative(const char *url)
>  {
> -       return starts_with_dot_slash(url) || starts_with_dot_dot_slash(ur=
l);
> +       return starts_with_dot_slash(url) || starts_with_dot_dot_slash(ur=
l) ||
> +              starts_with(url, "^/");
>  }
>
>  /*
> @@ -342,6 +343,9 @@ int check_submodule_url(const char *url)
>                 if (count_leading_dotdots(url, &next) > 0 &&
>                     (*next =3D=3D ':' || *next =3D=3D '/'))
>                         return -1;
> +               if (skip_prefix(url, "^/", &next) &&
> +                   (*next =3D=3D ':' || *next =3D=3D '/'))
> +                       return -1;
>         }
>
>         else if (url_to_curl_url(url, &curl_url)) {
> diff --git a/submodule-config.h b/submodule-config.h
> index 755570d5d1..3e947291d5 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -94,6 +94,12 @@ int check_submodule_name(const char *name);
>  /* Returns 0 if the URL valid per RFC3986 and -1 otherwise. */
>  int check_submodule_url(const char *url);
>
> +/*
> + * Returns 1 if the URL is resolved against the superproject's remote,
> + * i.e. starts with "./", "../" or "^/", and 0 otherwise.
> + */
> +int submodule_url_is_relative(const char *url);
> +
>  /*
>   * Note: these helper functions exist solely to maintain backward
>   * compatibility with 'fetch' and 'update_clone' storing configuration i=
n
> diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
> index ea9bef0904..f28daf52fe 100644
> --- a/t/helper/test-submodule.c
> +++ b/t/helper/test-submodule.c
> @@ -123,7 +123,12 @@ static int cmd__submodule_resolve_relative_url(int a=
rgc, const char **argv)
>         if (!strcmp(up_path, "(null)"))
>                 up_path =3D NULL;
>
> -       res =3D relative_url(remoteurl, url, up_path);
> +       if (starts_with(url, "^/"))
> +               res =3D root_relative_url(remoteurl, url);
> +       else
> +               res =3D relative_url(remoteurl, url, up_path);
> +       if (!res)
> +               die("cannot resolve '%s' against '%s'", url, remoteurl);
>         puts(res);
>         free(res);
>         free(remoteurl);
> diff --git a/t/meson.build b/t/meson.build
> index 3ca7b27104..9d3ac94aae 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -918,6 +918,7 @@ integration_tests =3D [
>    't7424-submodule-mixed-ref-formats.sh',
>    't7425-submodule-gitdir-path-extension.sh',
>    't7426-submodule-get-default-remote.sh',
> +  't7427-submodule-root-relative-url.sh',
>    't7450-bad-git-dotfiles.sh',
>    't7500-commit-template-squash-signoff.sh',
>    't7501-commit-basic-functionality.sh',
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 56faf5fe73..c8618e8a30 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -7,6 +7,11 @@ test_description=3D'Test various path utilities'
>
>  . ./test-lib.sh
>
> +# Keep MSYS2 from turning "^/..." arguments into Windows paths. The valu=
e
> +# must not look like a path itself, or MSYS2 rewrites it for child proce=
sses.
> +MSYS2_ARG_CONV_EXCL=3D'^'
> +export MSYS2_ARG_CONV_EXCL
> +
>  norm_path() {
>         expected=3D$(test-tool path-utils print_path "$2")
>         test_expect_success $3 "normalize path: $1 =3D> $2" "
> @@ -435,6 +440,44 @@ test_submodule_relative_url "(null)" "user@host:path=
/to/repo" "../subrepo" "user
>  test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "user=
@host:subrepo"
>  test_submodule_relative_url "(null)" "user@host:repo" "../../subrepo" ".=
:subrepo"
>
> +test_submodule_relative_url "(null)" "https://example.com/me/super.git" =
"^/org/lib.git" "https://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "https://example.com/a/b/c/super.gi=
t" "^/org/lib.git" "https://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "https://example.com" "^/org/lib.gi=
t" "https://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "https://user@example.com:8443/me/s=
uper.git" "^/org/lib.git" "https://user@example.com:8443/org/lib.git"
> +test_submodule_relative_url "(null)" "https://example.com/me/super.git" =
"^/org/lib/" "https://example.com/org/lib"
> +test_submodule_relative_url "../" "https://example.com/me/super.git" "^/=
org/lib.git" "https://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "helper://example.com/me/super.git"=
 "^/org/lib.git" "helper://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "ssh://git@example.com:2222/a/b/sup=
er.git" "^/org/lib.git" "ssh://git@example.com:2222/org/lib.git"
> +test_submodule_relative_url "(null)" "ssh://git@[::1]:2222/me/super.git"=
 "^/org/lib.git" "ssh://git@[::1]:2222/org/lib.git"
> +test_submodule_relative_url "(null)" "ssh://example.com/~user/super.git"=
 "^/org/lib.git" "ssh://example.com/org/lib.git"
> +test_submodule_relative_url "(null)" "git@example.com:me/super.git" "^/o=
rg/lib.git" "git@example.com:org/lib.git"
> +test_submodule_relative_url "(null)" "git@example.com:a/b/super.git" "^/=
org/lib.git" "git@example.com:org/lib.git"
> +test_submodule_relative_url "(null)" "git@example.com:/srv/git/super.git=
" "^/org/lib.git" "git@example.com:/org/lib.git"
> +test_submodule_relative_url "(null)" "example.com:~user/super.git" "^/or=
g/lib.git" "example.com:org/lib.git"
> +test_submodule_relative_url "(null)" "git@[::1]:me/super.git" "^/org/lib=
.git" "git@[::1]:org/lib.git"
> +test_submodule_relative_url "(null)" "[::1]:me/super.git" "^/org/lib.git=
" "[::1]:org/lib.git"
> +
> +test_expect_success 'root-relative submodule url needs a remote with a h=
ost' '
> +       for remote in /srv/git/super.git ../super.git file:///srv/git/sup=
er.git \
> +               helper::https://example.com/super.git "[::1]" \
> +               https:///srv/git/super.git https://user@/super.git \
> +               ssh://:22/super.git :super.git git@:super.git "[]:super.g=
it"
> +       do
> +               test_must_fail test-tool submodule resolve-relative-url \
> +                       "(null)" "$remote" "^/org/lib.git" 2>err &&
> +               test_grep "cannot resolve" err || return 1
> +       done
> +'
> +
> +test_expect_success 'root-relative submodule url cannot change the kind =
of url' '
> +       for url in "^//evil.example.com/x.git" "^/:evil"
> +       do
> +               test_must_fail test-tool submodule resolve-relative-url \
> +                       "(null)" host:/srv/super.git "$url" 2>err &&
> +               test_grep "must not start with" err || return 1
> +       done
> +'
> +
>  test_expect_success 'match .gitmodules' '
>         test-tool path-utils is_dotgitmodules \
>                 .gitmodules \
> diff --git a/t/t7427-submodule-root-relative-url.sh b/t/t7427-submodule-r=
oot-relative-url.sh
> new file mode 100755
> index 0000000000..526dfec8d2
> --- /dev/null
> +++ b/t/t7427-submodule-root-relative-url.sh
> @@ -0,0 +1,190 @@
> +#!/bin/sh
> +
> +test_description=3D'submodule urls relative to the server root (^/)'
> +
> +. ./test-lib.sh
> +
> +# Keep MSYS2 from turning "^/..." arguments into Windows paths. The valu=
e
> +# must not look like a path itself, or MSYS2 rewrites it for child proce=
sses.
> +MSYS2_ARG_CONV_EXCL=3D'^'
> +export MSYS2_ARG_CONV_EXCL
> +
> +test_expect_success 'setup' '
> +       git config --global protocol.file.allow always &&
> +       git config --global url."$(pwd)/server/".insteadOf https://exampl=
e.com/ &&
> +       git config --global --add url."$(pwd)/server/".insteadOf git@exam=
ple.com: &&
> +
> +       git init --bare server/org/dep.git &&
> +       git init --bare server/org/lib.git &&
> +       git init --bare server/org/team/super.git &&
> +
> +       git clone https://example.com/org/dep.git dep &&
> +       test_commit -C dep dep &&
> +       git -C dep push origin HEAD &&
> +
> +       git clone https://example.com/org/lib.git lib &&
> +       test_commit -C lib lib &&
> +       git -C lib submodule add ^/org/dep.git dep &&
> +       git -C lib commit -m "add dep" &&
> +       git -C lib push origin HEAD &&
> +
> +       git clone https://example.com/org/team/super.git super &&
> +       test_commit -C super super &&
> +       git -C super submodule add ^/org/lib.git lib &&
> +       git -C super commit -m "add lib" &&
> +       git -C super push origin HEAD &&
> +
> +       git clone --bare server/org/team/super.git server/me/super.git
> +'
> +
> +test_expect_success 'add records the url as given' '
> +       test_cmp_config -C super "^/org/lib.git" -f .gitmodules submodule=
.lib.url &&
> +       test_cmp_config -C super https://example.com/org/lib.git submodul=
e.lib.url
> +'
> +
> +test_expect_success 'clone of the upstream in a subgroup' '
> +       git clone --recurse-submodules https://example.com/org/team/super=
.git upstream &&
> +       test_cmp_config -C upstream https://example.com/org/lib.git submo=
dule.lib.url &&
> +       test_path_is_file upstream/lib/lib.t &&
> +       test_path_is_file upstream/lib/dep/dep.t
> +'
> +
> +test_expect_success 'clone of a fork at a different depth' '
> +       git clone --recurse-submodules https://example.com/me/super.git f=
ork &&
> +       test_cmp_config -C fork https://example.com/org/lib.git submodule=
.lib.url &&
> +       test_cmp_config -C fork/lib https://example.com/org/dep.git submo=
dule.dep.url &&
> +       test_path_is_file fork/lib/dep/dep.t
> +'
> +
> +test_expect_success 'clone over scp-like ssh uses ssh for submodules' '
> +       git clone --recurse-submodules git@example.com:me/super.git fork-=
ssh &&
> +       test_cmp_config -C fork-ssh git@example.com:org/lib.git submodule=
.lib.url &&
> +       test_cmp_config -C fork-ssh/lib git@example.com:org/dep.git submo=
dule.dep.url &&
> +       test_path_is_file fork-ssh/lib/dep/dep.t
> +'
> +
> +test_expect_success 'sync follows a changed superproject remote' '
> +       git -C fork remote set-url origin ssh://git@example.com:2222/me/s=
uper.git &&
> +       git -C fork submodule sync &&
> +       test_cmp_config -C fork ssh://git@example.com:2222/org/lib.git su=
bmodule.lib.url &&
> +       test_cmp_config -C fork/lib ssh://git@example.com:2222/org/lib.gi=
t remote.origin.url
> +'
> +
> +test_expect_success 'get-default-remote finds the submodule remote by it=
s ^/ url' '
> +       git -C fork/lib remote rename origin upstream &&
> +       git -C fork/lib remote add other https://example.com/org/dep.git =
&&
> +       echo upstream >expect &&
> +       git -C fork submodule--helper get-default-remote lib >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'init fails when the remote has no host' '
> +       git clone server/me/super.git local &&
> +       test_must_fail git -C local submodule init 2>err &&
> +       test_grep "cannot resolve .* without a remote url that has a host=
" err
> +'
> +
> +test_expect_success 'init without a remote does not suggest the cwd fall=
back' '
> +       git init noremote &&
> +       git -C noremote config -f .gitmodules submodule.lib.path lib &&
> +       git -C noremote config -f .gitmodules submodule.lib.url "^/org/li=
b.git" &&
> +       git -C noremote update-index --add --cacheinfo \
> +               160000,$(git -C lib rev-parse HEAD),lib &&
> +       test_must_fail git -C noremote submodule init 2>err &&
> +       test_grep "cannot resolve" err &&
> +       test_grep ! "authoritative upstream" err
> +'
> +
> +test_expect_success 'update fails when the remote has no host' '
> +       git -C noremote config submodule.lib.active true &&
> +       test_must_fail git -C noremote submodule update 2>err &&
> +       test_grep "cannot resolve .* without a remote url that has a host=
" err
> +'
> +
> +test_expect_success 'update --init fails even if the submodule is not up=
dated' '
> +       test_must_fail git -C noremote -c submodule.lib.update=3Dnone \
> +               submodule update --init 2>err &&
> +       test_grep "cannot resolve" err
> +'
> +
> +test_expect_success 'sync fails when the remote has no host' '
> +       git -C local config submodule.lib.active true &&
> +       test_must_fail git -C local submodule sync 2>err &&
> +       test_grep "cannot resolve .* without a remote url that has a host=
" err
> +'
> +
> +test_expect_success 'add fails when the remote has no host' '
> +       test_must_fail git -C local submodule add "^/org/dep.git" dep 2>e=
rr &&
> +       test_grep "cannot resolve .* without a remote url that has a host=
" err &&
> +       test_path_is_missing local/dep
> +'
> +
> +test_expect_success 'clone --recurse-submodules stops when the remote ha=
s no host' '
> +       git init --bare server/org/mixed.git &&
> +       git init mixed &&
> +       git -C mixed config -f .gitmodules submodule.lib.path lib &&
> +       git -C mixed config -f .gitmodules submodule.lib.url "^/org/lib.g=
it" &&
> +       git -C mixed config -f .gitmodules submodule.zz.path zz &&
> +       git -C mixed config -f .gitmodules submodule.zz.url ../dep.git &&
> +       git -C mixed update-index --add \
> +               --cacheinfo 160000,$(git -C lib rev-parse HEAD),lib \
> +               --cacheinfo 160000,$(git -C dep rev-parse HEAD),zz &&
> +       git -C mixed add .gitmodules &&
> +       git -C mixed commit -m mixed &&
> +       git -C mixed push "$(pwd)/server/org/mixed.git" HEAD &&
> +
> +       test_must_fail git clone --recurse-submodules server/org/mixed.gi=
t \
> +               mixed-clone 2>err &&
> +       test_grep "cannot resolve .* without a remote url that has a host=
" err &&
> +       test_path_is_missing mixed-clone/zz/dep.t
> +'
> +
> +test_expect_success 'nested ^/ fails when the submodule remote has no ho=
st' '
> +       git init --bare server/org/rel.git &&
> +       git init rel &&
> +       git -C rel config -f .gitmodules submodule.lib.path lib &&
> +       git -C rel config -f .gitmodules submodule.lib.url ../lib.git &&
> +       git -C rel update-index --add --cacheinfo \
> +               160000,$(git -C lib rev-parse HEAD),lib &&
> +       git -C rel add .gitmodules &&
> +       git -C rel commit -m rel &&
> +       git -C rel push "$(pwd)/server/org/rel.git" HEAD &&
> +
> +       test_must_fail git clone --recurse-submodules server/org/rel.git =
\
> +               rel-clone 2>err &&
> +       test_grep "cannot resolve .*dep.git. without a remote url that ha=
s a host" err
> +'
> +
> +test_expect_success 'explicit url overrides a root-relative one' '
> +       git -C local config submodule.lib.url "$(pwd)/server/org/lib.git"=
 &&
> +       git -C local submodule update --init &&
> +       test_path_is_file local/lib/lib.t &&
> +       git -C local submodule update --remote &&
> +       test_path_is_file local/lib/lib.t
> +'
> +
> +test_expect_success '^/ means the server root even if a local ^ director=
y exists' '
> +       git init literal &&
> +       mkdir -p "literal/^/org" &&
> +       git clone --bare server/org/lib.git "literal/^/org/lib.git" &&
> +       git -C literal config -f .gitmodules submodule.lib.path lib &&
> +       git -C literal config -f .gitmodules submodule.lib.url "^/org/lib=
.git" &&
> +       git -C literal update-index --add --cacheinfo \
> +               160000,$(git -C lib rev-parse HEAD),lib &&
> +
> +       git -C literal remote add origin https://example.com/me/super.git=
 &&
> +       git -C literal submodule init &&
> +       test_cmp_config -C literal https://example.com/org/lib.git submod=
ule.lib.url &&
> +
> +       git -C literal config --unset submodule.lib.url &&
> +       git -C literal remote set-url origin "$(pwd)/server/me/super.git"=
 &&
> +       test_must_fail git -C literal submodule init
> +'
> +
> +test_expect_success 'add from a subdirectory is refused' '
> +       mkdir super/sub &&
> +       test_must_fail git -C super/sub submodule add ^/org/dep.git dep 2=
>err &&
> +       test_grep "Relative path can only be used from the toplevel" err
> +'
> +
> +test_done
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 72c7f6f73b..0df7cb4a92 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -49,12 +49,17 @@ test_expect_success 'check urls' '
>         ./bar/baz/foo.git
>         https://example.com/foo.git
>         http://example.com:80/deeper/foo.git
> +       ^/org/foo.git
>         EOF
>
>         test-tool submodule check-url >actual <<-\EOF &&
>         ./bar/baz/foo.git
>         https://example.com/foo.git
>         http://example.com:80/deeper/foo.git
> +       ^/org/foo.git
> +       ^/%0ahost=3Dexample.com/foo.git
> +       ^//evil.example.com/foo.git
> +       ^/:foo.git
>         -a./foo
>         ../../..//test/foo.git
>         ../../../../../:localhost:8080/foo.git
> --
> 2.55.0
>
