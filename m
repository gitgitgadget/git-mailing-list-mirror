Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF74CA281
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343012; cv=pass; b=sh2lrF1FTMafmFJHAi3nx3Xyok8Kx2ck59kY6rUN3inMOQTbaF2HhqGe7ACVUUCLQnZ7TqqneKbCoJWk3kfrG7kkrA7X1TswSB+6LLfhlyeCXfTXC7goHvkfOefG2A+8YXarBEGizJgYIdZKOraSaQQ+BjnyixqoApKvGVohmi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343012; c=relaxed/simple;
	bh=7Dm23h+7mi2fkm/ovxcuxRsT/+XGpEIq+6k/B7PzkWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo2ltP7ox5NsZSOJ2eATV3oYe9Jk5hWQtFIuSfcfropdxcl5tKiD5ERPGtfs4wrQxASXIwrjbsmDuonedSXlQmyFualo7TYg7ua3KVeM5AzaTOlYDrjqHA84Q/9SSolvdmcqKrIDfuSBfbO5TROcc3YiVTXqr637AR1zSp3dj6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy6X/9ua; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy6X/9ua"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so1116843e87.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785343009; cv=none;
        d=google.com; s=arc-20260327;
        b=gnD5vVf2w2jNMHrq+TwR36zr399GQo6AW4OoNTCffE5WKoWfLYjc421yiMTJdhGFQy
         zXLLqGupnOV+zojEdf14M8R+f+ZxpadU47jaBKf5eAdOtjCo6sJf6BHOfz3BYgWJwOYM
         rPQXPpfYEshAKbR7H4cFbBd4vwde+ia4B7EMk/gKtgEJivNMIAjIp0tMX8RxuDlQu3sC
         yeoNfPcfgT4oWvGBQcvkpW3/cGlQpY1smnRevpLblhVe1thd+6oUHYHIURAkxr1B8GKX
         m0HP+DwjhSISRmA2KnS9syozdH1T9sQ5xm3YZ7MX6PHD7w/TygYgkYW8EB6MQurDbg05
         9Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yxmTIbjjBVz5XML6+xZjIhWRizvn+ypOEPmFfpkFpK4=;
        fh=vkiZgVKs1etwuuYV9bgAty6Z0EleQnBCEcCN9WGL8Ds=;
        b=DIc6d2b9taqXHlwhDkhn5zW30QPp6t4dHYWHSWP1zyuIyUyoZ+lKtUf6XswzhV9Ysd
         gW4m1S+gKlHbGG1PZzZ8J7BxkXIV0lTbKpNXU0qMdrgMWXPELr1OBt/DgT8dOb3uLvYs
         YehWUey98ts1OVjaGbjPipTJsQx6sl+53DBGVZ8I64T+A0EhHTilJWh0ftzG8s4Elct5
         6KEKoomRagYu/95HI8WhWcvKBsl6R+cjHjLS8QIxZPaSw83UjbSx8vDdBzJLPe7FJ/SZ
         d+bVybHp24s2iMw4oCCD/IddiGOo7M3q92ZhORD0ntZ1RoD1s+NpaqIecJa4yKeSYldq
         Dd9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785343009; x=1785947809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxmTIbjjBVz5XML6+xZjIhWRizvn+ypOEPmFfpkFpK4=;
        b=Yy6X/9ua6ZfIbZiFmhmHpZ+XT/ASco+AXiCD18h6SSfiCVt0QhcycGdQ6SWsLWNSk/
         rTQ0dWtQ1Jv47geCeMBn5yhb9hmPwY4/wZy+bUfSZOimb6L1YEzCmYvG7dHVJseR6LEl
         uJy9jKf5SyAt7GnnFDg/X/4tqLtWDoly6ZYiCwi8Q7IsFrF9Qaa9SoIdK/+UbvxD0dp7
         MamFeqxOWNW9IwZKYzLULWs0ebOyVZOMu6roBXjgbExn38hA1pBV7mPbK5Z0uu6PHnXc
         pUojANucw5uBkptk659zE81RaeTh1Ij549a2f4HMSlDgBoEiSRIgcFjmmQumxwkeHnXT
         S8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343009; x=1785947809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxmTIbjjBVz5XML6+xZjIhWRizvn+ypOEPmFfpkFpK4=;
        b=dEYphr2BRKsmbZb2adrUgKyG9QkX4VK/ML4s5BSpne3gXQblxWpi6BvEpJ1HyBbxRp
         2zlNTKqbVR+tBcADTx0N7dGYpMtnDEh2W5TS/RpSvy3bpEp7hFKo0Y/q35ZkM2Ll/mQ5
         qV9VCLLfG0YTkUCni4iJjp2esaEYGh3Gx1cB+aUg4xSGkQyNTStiKfmbNn5SXuDEM4Es
         NWkQ1j06z8uy+cSx91NKReLNIvNdkNRivAUy9DxQgs+I2ACkbsLijOenvStTGCIiX0+p
         5PdVwgMIiAyBwOb1hdSjJ0OzFhIoZKFKVfsJLQRub0jgUfLWMYgMwFuCRh79YhuhQ2MH
         tPSA==
X-Gm-Message-State: AOJu0Yw+JISrghSmAsJ8kfkWa/fOrWtTe3fS8OZuMfO9pqlBRH0O/gRC
	LHeNEPIKRSUO5PSEtxzcRRbOfd8MKROkijl9NBu9HfrRhflqWmfbz2ZWZoITSR+rbsISR5aAxWR
	W0X2XRpLL0r+0Ck0Yk2cUl9INoGArYkfkhfPJ
X-Gm-Gg: AR+sD11auo+gYhLGIVqCuCzVzceqyrnBrmP+QgriUKAob+AD7+uh9atzhaF+i0Tg2A/
	u+NZ7B/XziQiWKSupAuk421u2I7PqBLHRd8e50HKGY7QPjkTgjfghmD9LrZqSPcaILZdI66+Hqn
	dsdUHSBOvxrKmBUHaZZ0u5ftCdoczR9VjdD/YWKfcw9gQh7vlIP4EiLBlWVS2/ATJPGDO0XJoJz
	0SMJIebAy4p5UBSWvAi/LmsjYoqy+vZa1/i5KpoBn/eJQ/EQdof7J9H2981lXceO2dpVFZwSXxJ
	HHF6DOBIHwzTad3bLdrZoco04c2s73/E/+pcSQRVD8kyizhdgrfypXuAhWPog3krDkyurDWmJVx
	0Sz2PX8wtozP01b8k7rJxza2SDakByIG1GE5B/bpSHtxDnySuA0jpTJ+Q8EuuqxZwY56dk63tJg
	==
X-Received: by 2002:a05:6512:3d8c:b0:5ae:c454:3740 with SMTP id
 2adb3069b0e04-5b2d027b666mr1594192e87.60.1785343008219; Wed, 29 Jul 2026
 09:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com> <amjUPEgenletgbp5@denethor>
In-Reply-To: <amjUPEgenletgbp5@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 29 Jul 2026 22:06:36 +0530
X-Gm-Features: AUfX_mwsbCVl3Yeq5iG_LsCP0U-GQJ1_Acpm7vzlwiOh8GCigSsyZ7_Gl_i6Q0g
Message-ID: <CA+rGoLfJ5Kc_HV7YfJ-y5SpMjb7t7f5ifUKcd=39eTjqzzQF5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] repo: add path.toplevel with absolute and relative
 suffix formatting
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Justin,

Thanks for the detailed review.

On Tue, Jul 28, 2026 at 10:06=E2=80=AFPM Justin Tobler <jltobler@gmail.com>=
 wrote:
>
> On 26/07/26 04:13PM, K Jayatheerth wrote:
> > Scripts frequently need to find the root directory of a repository's
> > working tree. Currently, this requires using `git rev-parse --show-topl=
evel`
> > or inferring it from other path components.
> >
> > Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
> > to `git repo info`. This allows scripts to retrieve the top-level
> > working tree path in a predictable, strictly formatted manner without
> > relying on `rev-parse`.
>
> Ok, this seems like suitable information to also look up under
> git-repo-info.
>
> > If requested in a bare repository where no working tree exists, the
> > command returns an empty string.
>
> This matches the existing behavior in git-rev-parse(1). Makes sense.
>


Yes, that is correct.


> >
> > +static int get_path_toplevel_absolute(struct repository *repo, struct =
strbuf *buf)
> > +{
> > +     const char *work_tree =3D repo_get_work_tree(repo);
> > +
> > +     if (!work_tree) {
> > +             strbuf_addstr(buf, "");
>
> The strbuf here is already NULL-terminated when its initialized. I don't
> think this should be necessary.
>


Very nice point indeed
I will change that everywhere I have added that.


> > +     if (!work_tree) {
> > +             strbuf_addstr(buf, "");
>
> Same here.
>

> > +test_expect_success 'path.toplevel returns empty in a bare repository'=
 '
> > +     test_when_finished "rm -rf bare.git" &&
> > +     git init --bare bare.git &&
> > +     (
> > +             cd bare.git &&
> > +             echo "path.toplevel.absolute=3D" >expect &&
> > +             git repo info path.toplevel.absolute >actual &&
> > +             test_cmp expect actual
>
> In this test we are only checking the absolute path. It probably
> wouldn't hurt to also check the relative path too.
>


Good catch. I'll add relative-path tests in both places.


> > Introduce `path.superproject-working-tree.absolute` and
> > `path.superproject-working-tree.relative` keys to `git repo info`.
> > This exposes the core submodule context via a scriptable config-like ke=
y
> > using standard format rules.
>
> Ok, this also seems like a good fit to include as a key in
> git-repo-info, but "superproject-working-tree" is a bit of a mouthful
> IMO. An alternative could potentially be "superproject-root"? Maybe its
> best to just be consistent with the option name in git-rev-parse(1) and
> keep it the same though.


show-superproject-working-tree is what git rev parse uses.
I am a bit unclear about this.
Since it is meant to be a scripting command, I don't know if it being
a long name matters much.
At the same time, I don't think we can keep the exact
"show-superproject-working-tree" as the key's name.
As the "show" is indirectly covered by "path." so the "show" is just
redundant if you ask me (I might be wrong here).
That is actually why I kept the rest of the name similar and omitted
the prefix from the flag name.

In other words, I am fine with the name being either one.
That said, I am more inclined with the "superproject-root".
I think the name explains exactly what it does.
Whereas "superproject-working-tree" was not that clear to me when I
first read it (Might be subjective to me).


> > +static int get_path_superproject_absolute(struct repository *repo UNUS=
ED, struct strbuf *buf)
> > +{
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(&superproject)) {
> > +             strbuf_release(&superproject);
> > +             strbuf_addstr(buf, "");
>
> Same comment here as in the previous patch...
>
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(&superproject)) {
> > +             strbuf_release(&superproject);
> > +             strbuf_addstr(buf, "");
>
> ...and here as well...
>
> > +             return 0;
> > +     }
> > +
> > +     format_path(buf, superproject.buf, startup_info->prefix, PATH_FOR=
MAT_RELATIVE);
> > +     strbuf_release(&superproject);
> > +     return 0;
> > +}
> > +
> > +test_expect_success 'path.superproject-working-tree returns empty when=
 not in a submodule' '
> > +     test_when_finished "rm -rf repo" &&
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +             echo "path.superproject-working-tree.absolute=3D" >expect=
 &&
> > +             git repo info path.superproject-working-tree.absolute >ac=
tual &&
> > +             test_cmp expect actual
>
> ... and here as well. :)
>


Good catch. I'll add a relative-path test there as well.


> > Tools and deployment hooks frequently query the location of the object
> > database directory. Currently, this relies on legacy parsing methods or
> > manually inspecting `git rev-parse --git-path objects`.
>
> "Tools and deployment hooks" seems a bit overly specific. Maybe instead
> we could just say "Scripts operating on a repository may need to query
> the location of the object database directory"?
>


I think your version is consistent with other patches as well.
I wanted to ask if it is not a good practice to write commit messages
which are very specific.
I also wanted to know what constitutes being overly specific so that I
can avoid doing it again.


> Also, I'm not entirely sure what is meant by "legacy parsing methods"
> here.
>


Something scripts have historically done: parse git rev-parse
--git-dir (or read .git/config by hand)
and manually append /objects, rather than asking for the object
directory directly
which breaks if GIT_OBJECT_DIRECTORY is set.
I'll reword the commit message to just say that explicitly instead of
the vague "legacy parsing methods" phrase.


> > Introduce `path.objects.absolute` and `path.objects.relative` keys to
> > `git repo info`. This allows tools to discover the object database
> > location safely while natively adhering to active `GIT_OBJECT_DIRECTORY=
`
> > environment variable overrides.
>
> In the context of pluggable ODBs, this proposed key is a little more
> interesting because a non-"files" ODB source in the future may not even
> have a filesystem path to an objects directory. When this becomes more
> relevant, we could just adapt these keys to return an empty string in
> such cases, but it does also make me question whether it is information
> that we should further expose in the first place if it does eventually
> becomes an internal detail of a specific ODB source.
>
> It probably doesn't matter too much, but I've CC'd Patrick for his
> thoughts too.
>


Thanks for looping in Patrick!

That's a fair concern.
My thinking is that the "files" backend is going to be the reality for
the vast majority of
repositories for a long time yet, and scripts asking for path.objects
today are almost certainly
assuming a filesystem-backed ODB anyway (that's the whole reason
they'd want the path).
So I don't think we're locking ourselves into a bad abstraction by
adding it now.

If/when a non-filesystem ODB source becomes real,
we'd have two reasonable options:
return an empty string for that key (same pattern we already use for
path.toplevel/superproject-working-tree when the concept doesn't
apply),
or deprecate the key outright if it turns out to be meaningless in that wor=
ld.
Either way it doesn't block adding it now, worst case we're removing
or narrowing a key later, not stuck with something actively wrong.



> > +static int get_path_objects_absolute(struct repository *repo, struct s=
trbuf *buf)
> > +{
> > +     const char *obj_dir =3D repo_get_object_directory(repo);
> > +
> > +     if (!obj_dir)
> > +             return error(_("unable to get object directory"));
> > +
> > +     format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_CANON=
ICAL);
>
> For the absolute path, do we actually need to provide the prefix? It
> might make it more clear that its the aboslute path if we just pass ""
> instead?
>


This point was raised in the foundational patch as well.
It won't change the output for sure, so I will pass "" instead.


On Wed, Jul 29, 2026 at 12:30=E2=80=AFAM Justin Tobler <jltobler@gmail.com>=
 wrote:
>
> On 26/07/26 04:13PM, K Jayatheerth wrote:
> > External tool integrations and validation systems need a stable way to
> > identify where the repository hooks are stored. Currently, this involve=
s
> > relying on `git rev-parse --git-path hooks` or querying `core.hooksPath=
`
> > manually.
>
> Similar to the comment in the previous patch, "External tool
> intergations and validation systems" seems overly specific IMO. Also,
> "need" is a bit strongly worded as I'm sure its not a requirement for
> every external script/tool.
>


Got it, I will try it to be not overly specific as well.
Maybe something like:
Scripts operating on a repository may want a stable way to identify
where the repository hooks are stored. Currently, this involves
relying on `git rev-parse --git-path hooks` or querying
`core.hooksPath` manually.

Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
`git repo info`. This allows scripts to discover the active hooks
location, ensuring proper resolution regardless of whether Git is
using the standard `.git/hooks` structure or a custom
`core.hooksPath` setup.


> > Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
> > `git repo info`. This allows tools to discover the active hooks locatio=
n
> > natively, ensuring proper resolution regardless of whether Git is using
> > the standard `.git/hooks` structure or a custom `core.hooksPath` setup.
>
> Per hooks path documentation:
>
>   The path can be either absolute or relative. A relative path is taken
>   as relative to the directory where the hooks are run.
>
>   ...
>
>   You  can also disable all hooks entirely by setting core.hooksPath to
>   /dev/null.
>
> Should we handle this /dev/null case specially? It looks like:
>
>   $ git -c core.hooksPath=3D/dev/null rev-parse --git-path hooks
>
> just prints '/dev/null'. I do wonder if this makes much sense though in
> context of the relative path version of this key. From some quick
> testing, it appears the git-rev-parse(1) version of this option always
> prints the absolute path if that is what is configured (it appears to
> ignore --path-format). Maybe we should just special case /dev/null and
> return an empty string? I'm not entirely sure what the best route is
> here though.
>


After thinking about it
I would lean towards not special-casing it. A few reasons:

/dev/null is just a valid (if unusual) value of core.hooksPath as far
as Git is concerned, the field is documented to reflect
whatever core.hooksPath resolves to, and rev-parse --git-path hooks
already treats it as an ordinary path.
If we special-case it to an empty string, we'd be the only place in
Git that treats /dev/null as meaningfully different from any other
hooksPath value.

Empty string is already used by other keys in this series
to mean "this concept doesn't apply here" (no working tree, not a submodule=
).
Using empty string for "hooks are disabled" would overload that
meaning with something different, "the path exists but you shouldn't
use it"
and a script can't tell the two apart without also knowing the
hooksPath convention, which defeats the purpose of adding a structured
key in the first place.

Any script that's checking for /dev/null already has to know that
convention when
using the existing rev-parse interface, so we're not creating new
surprises, just carrying forward a pre-existing quirk of
core.hooksPath semantics.

For the relative version:
I'll let format_path/relative_path do whatever it already does for a
path that isn't under the prefix
(I'd guess it falls back to printing the absolute path, similar to how
rev-parse seems to ignore --path-format for this case).
That keeps behavior consistent with the existing tool rather than
introducing new special-casing for path.hooks.relative specifically.

I'll add a test covering core.hooksPath=3D/dev/null to lock in whichever
behavior we land on,
and I can add a doc note under path.hooks.absolute/path.hooks.relative
mentioning that /dev/null is passed through unchanged if that's the
value in use,
similar to how the existing hooksPath docs describe it.
Let me know if you still think empty-string is preferable despite the
above,  happy to go either way once we agree on the reasoning.

Thanks again for the detailed review!

Regards,
- K Jayatheerth
