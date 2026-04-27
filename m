Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F13C062A
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294868; cv=pass; b=U1+YMF3j5YYOIrib6Xr5VGqiqpKSK9cRZvXEVxdK9VPedpqerrIlL6aM/ac6ctjeiqTPq2qkXt2Ozp25Dy2ZU8u9Q9+YpCTLDhOI8w91pSgcuxJrKJgMVT2wuBx5SFdAqTCW955DK/ep3JD/Hcf9duWoUfe4vrovJ6Bg7jWRhU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294868; c=relaxed/simple;
	bh=BiovnEH9vKB9KmPuhgLz//YSKbstBGpVUZ4M9x8TusY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTBU3h9GrBD7wZECjRhQSA6XgtAkFlFOPvJhKBT5jty1STpuGAizh8La8OdofVP9vbp/pa1XvY+4w1fUy05vpQw52t4tuovDmEhU6Klb4cnFTIKWETUNIMWycNj22VIk+9XQ9R3fZ9WqE1kT0uotwus9xcRlYwyZvM92TG3NuW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clqPGEc+; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clqPGEc+"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso104218c88.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 06:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777294864; cv=none;
        d=google.com; s=arc-20240605;
        b=MbqJJzzFWxiVXLpVA8rDa1u3rfoQnqqpBqm0yrIMFIF4iZCHdzNb4jdvZchCyGn5Iy
         KaL6MVoyMHAjZO7EQHLRtRfEmyymBauRMy5POa0OZGAPHIFqSUllE21ydUzrOoAcBdL7
         11R/8H6PUm/xoJ1RnPsRE+hNDIjjpRWBsboE9/LDbW4xctkCAySnJkjm3xGgdxMI5ipw
         aF6PZ02oaVk9yDe4wBfud0WBBGauVxU5f8d4aeCQ1TbyiCPmYP3FnzRnyffhhD93S0c8
         AY7W+RGZlHlrPSaigDfHYT8T55ZVCiKtmf2Ny9uIdb90bKXu25iWTtkTe8nVSzimdPyc
         k1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogmdQ95csy4zrd7dvCAz/DFTCVrN0e92pipHHHiIcB4=;
        fh=Rb/YAh07E3PzT9T6I10R8ADK1sCDP+M59F1b1erOs5A=;
        b=Ea6LY3YjLzq1+XFB898uazTrqLkulfWxz7m5bReRWvrccrdt/n7OSAILfWfig+j0XC
         X7XUGdOQeV3L3+ZLPLsRce56TmmQSmbwm0STyKjiPB9B1hs5v+QJLtHB2uEDWYtzN+f4
         ODZ9OHlq6TvfgooG/ppRcUAhJeLgzkgIVJ8j/PLlbQD3z8Ay5dbD24Z6U6uIFF+T6ORm
         k+zm6x7RtVLytQa3LQzhakEBc3HEFeeYY8qpxshAsCFTNv/ozLKECSBq8LSoa74JnObx
         +mgFmjvwH/SnVFPBeepFZ6bQ97Z1l3lyj4KJRGaqc1etSp0MyUTz8f0UPqSrdvOjTMZv
         5BdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294864; x=1777899664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogmdQ95csy4zrd7dvCAz/DFTCVrN0e92pipHHHiIcB4=;
        b=clqPGEc+76fd4ii5ZzQKrHe7qHl99dLomcWOhEjugbbkixQBQAsLGim2VJxUstkmOY
         Gab92HxzI+MGizXVOeDxf2eY9QZllMZp73ydIYX2YEe7prnfAi+EIdMCrHu1kJb6vaZ9
         fO/yyBIxNPk6HIwW7y3IyPYts9IPxes/5RqVhWLy0kRcMcoO+BbPEPKs6zzWNQtdBmKa
         lUdipG+LiwPqJRaXq4Pm5XZjFBrvKF6Twmx4bSdVa8x03DuRCMdxWPwmILbwnNXMiurR
         8O14qlxCyVPw+w5MfKy/BqzVa+CHrlc/2v8HYvPZ/QIDDfvT0Nz1m8bvUbQLd5hKQkml
         bviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294864; x=1777899664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogmdQ95csy4zrd7dvCAz/DFTCVrN0e92pipHHHiIcB4=;
        b=csDCXJLOgHYFxPOA8Rjksop1//N/kjj2LeJ/TF7hoU9sWz2DgMa8zjr1S7XQG87o+y
         Xffh7wxwRFW0JSaX3xALrIT1yM9HXTHVW7kSwyap/BkkijUSEcYGsVCZ9OOAVvkFY/kw
         kV1OaL4zbevRXnDwpeWod+cd5qbHrwdDpuR8yS2L5mETQyui54c0plokSG15BpLrDx2S
         cy3n2vUA+g/RpP9pfIn7tMtDQFYXlYQ7I8XsoUKiS0OWiPmrmrqATLhNntfC9210Z/27
         68JPVZOpAUhVZ2EH7KIwzBU7dcMN+jYeTH2OdeT3SvCzxy0uv1vJtBAk5NH3l8fozQ5s
         mmRg==
X-Gm-Message-State: AOJu0Yxgqu04YqgZCP5VcJD8j3T67MjOu175SQetp/q4il1XnB9zNOSG
	xOCPM3e7WPhWpc8t7M1TWSAdwABNuAwsuS5JTpjatOB8h+YwqOjRlKBQvgUrgZW8CpvY1yHlRNa
	OwLk+ShaP90623RM2aeJW4Iqr/XGBiDd/zPwy
X-Gm-Gg: AeBDieurwL+7NFvxOfLYg0CSAg69dw2b1Biv2IXP9XlzSjVj7vKTpFh51Uk/pqXgSdX
	9Y/kWf+oIf9pW/B0oEThPZ3djbFxWs+aw1nRfInnxiQGFOiKmsI16GURVOSqy/Y4ezlT6axg8Es
	mhNr5bLGEDVJbkJHuTCrej/uuQsP0UnTQthOxdGoB9ih0zLw4KPAmo5cXEYwm6ZzsuCEid7SzZ9
	3NYdpRPjJ2VuqK8WEF+YF/8RnuTfNzuJPtpV5TMM2FQZ9519WIsE8K2MjoWU6r0HrCCV9baY9HZ
	e//ub7ADJ50tsUTWWbziipmv8E07Wiq2G4LUy4ENU6FyahuEbiOplF8EqYJYyMdnQEGOPIm3qkl
	iggg=
X-Received: by 2002:a05:7022:388a:b0:12d:ba50:4baf with SMTP id
 a92af1059eb24-12dba50508dmr13031299c88.33.1777294861405; Mon, 27 Apr 2026
 06:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com> <20260427124108.3524129-1-christian.couder@gmail.com>
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 15:00:49 +0200
X-Gm-Features: AVHnY4JWdExPOfiYBM2OkPaNn7drRAuIHcyT7dijZ9vOBxdX0ESfkE2XvUKuaaw
Message-ID: <CAP8UFD2b+AHD0rfR9PxBcANAGg823LRk0S6zWCJWKMVWEGHYjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Auto-configure advertised remotes via URL allowlist
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, it looks like I sent this series in reply to:

https://lore.kernel.org/git/20251223111113.47473-1-christian.couder@gmail.c=
om/

instead of:

https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.=
com/

I will try to do better next time.

Also I forgot to say that this series is based on a merge of 'master'
@ v2.54.0 and 'cc/promisor-auto-config-url' (which is in 'next' but is
marked with "Will merge to master" in the last "What's cooking..."
email).

On Mon, Apr 27, 2026 at 2:41=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Currently, the "promisor-remote" protocol capability allows a server
> to advertise promisor remotes (and their tokens/filters), but the
> client's `promisor.acceptFromServer` mechanism requires these remotes
> to already exist in the config.
>
> This is a significant burden for users and administrators who have to
> pre-configure remotes.
>
> This patch series improves on this by introducing a new
> `promisor.acceptFromServerUrl` config option, which provides an
> additive, URL-based security allowlist.
>
> Multiple `promisor.acceptFromServerUrl` config options can be provided
> in different config files. Each one should contain a URL glob pattern
> which can optionally be prefixed with a remote name in the
> "[<name>=3D]<pattern>" format.
>
> The goal is for something like a simple:
>
>   git config set --global promisor.acceptFromServerUrl "https://my-org.co=
m/*"
>
> to be all that is needed for internal work in many organizations.
>
> With this new config option:
>
>  - The server can update fields (like tokens) for known remotes,
>    provided their URL matches the allowlist, even if
>    `acceptFromServer` is set to `None`.
>
>  - Unknown remotes advertised by the server can be automatically
>    configured on the client if their URL matches the allowlist.
>
>  - If there is no `<name>` prefix before the glob pattern matched, the
>    auto-configured remote is named using the
>    "promisor-auto-<sanitized-url>" format. So the same auto-configured
>    remote config entry will be reused for the same URL.
>
>  - If a `<name>` prefix is provided, it will be used for the
>    auto-configured remote config entry.
>
>  - If the chosen name (auto-generated or prefixed) already exists but
>    points to a different URL, overwriting the existing config is
>    prevented by appending a numeric suffix (e.g., -1, -2) to the name
>    and auto-configuring using that name.
>
>  - The server's originally advertised name is always saved in the
>    `remote.<name>.advertisedAs` config variable of the auto-configured
>    remote for tracing and debugging.
>
> Security considerations:
>
>  - Advertised URLs and glob patterns are routed through
>    url_normalize() / url_normalize_pattern() before matching, to
>    prevent percent-encoding, case variation, or path-traversal (..)
>    bypasses.
>
>  - URL matching is done component by component: scheme and port
>    must match exactly (no wildcards), the host is matched with
>    WM_PATHNAME so a '*' cannot cross the '/' boundary into the
>    path, and the path is matched without WM_PATHNAME so '*' can
>    still span multi-level paths.
>
>  - Auto-generated remote names are sanitized (non-alphanumeric
>    characters are replaced with '-', runs of '-' are collapsed)
>    and prefixed with 'promisor-auto-'. User-supplied names (from
>    the 'name=3D<pattern>' syntax) are validated with
>    valid_remote_name(). Together, these prevent a server from
>    maliciously overwriting standard remotes (like 'origin').
>
>  - If the auto-generated or user-supplied name collides with an
>    existing remote configured to a different URL, a numeric
>    suffix ('-1', '-2', ...) is appended, up to a bounded limit,
>    so a server cannot hijack an existing remote by name.
>
>  - Known remotes are still subject to URL consistency checks:
>    even if an advertised URL matches the allowlist, it is only
>    accepted for a known remote if it matches the URL already
>    configured locally for that remote.
>
>  - The documentation explains in detail how to write secure glob
>    patterns in `promisor.acceptFromServerUrl`, and highlights the
>    risks of overly broad patterns on shared hosting platforms.
>
> High level description of the patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  - Patch 1/8 is new. It is a very small preparatory patch that
>    simplifies some tests a bit.
>
>  - Patches 2/8 and 3/8 expose and adapt a url_normalize_pattern()
>    helper function in the urlmatch API.
>
>  - Patch 4/8 adapts `struct promisor_info` by adding a new
>    `local_name` member to it to prepare for the next patches.
>
>  - Patches 5/8 to 7/8 implement the core feature. They introduce the
>    parsing machinery, add the additive allowlist for known remotes
>    (with url_normalize() security), and finally implement the
>    auto-creation and collision resolution for unknown remotes.
>
>  - Patch 8/8 cleans up and modernizes the existing
>    `promisor.acceptFromServer` documentation.
>
> Changes compared to v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks to Patrick and Junio for reviewing the previous versions of
> this series and of the preparatory series.
>
>  - A lot of preparatory patches have been moved to a preparatory series
>    that has already been merged. See:
>
>    https://lore.kernel.org/git/20260407115243.358642-1-christian.couder@g=
mail.com/
>
>    This is why this v2 contains only 8 patches compared to 16 patches
>    in v1.
>
>  - Everywhere in this series "whitelist" as been replaced with
>    "allowlist".
>
>  - In the tests added in this series, the new $TRASH_DIRECTORY_URL and
>    $ENCODED_TRASH_DIRECTORY_URL introduced by the preparatory series
>    are used instead of the previous $PWD_URL and $ENCODED_PWD_URL.
>
>  - Patch 1/8 ("t5710: simplify 'mkdir X' followed by 'git -C X init'")
>    is new.
>
>  - Patch 3/8 ("urlmatch: add url_normalize_pattern() helper") replaces
>    patch 3/16 ("urlmatch: add url_is_valid_pattern() helper") because
>    in subsequent patches we now normalize patterns to validate them
>    and match them component by component against URLs.
>
>  - In patch 5/8, previously 13/16, ("promisor-remote: introduce
>    promisor.acceptFromServerUrl"):
>
>    - We add a `struct url_info pattern_info;` to `struct allowed_url`,
>      so we can validate patterns using url_normalize_pattern() and, in
>      a subsequent patch, match URLs component by component. This
>      requires a new allowed_url_free() function that is passed to
>      string_list_clear_func() to clear the `struct allowed_url`
>      instances.
>
>    - We don't use a `static struct string_list` to store the URL
>      patterns we accept. Instead we load them from the config into a
>      `struct string_list` passed as argument. The function doing this
>      is renamed accordingly from accept_from_server_url() to
>      load_accept_from_server_url().
>
>    - A "clone with invalid promisor.acceptFromServerUrl" test is moved
>      from patch 15/16 to this patch as it's more relevant in this
>      patch (where we validate the content of the
>      `promisor.acceptFromServerUrl` environment variable).
>
>  - In patch 6/8, previously 14/16, ("promisor-remote: trust known
>    remotes matching acceptFromServerUrl"):
>
>    - In the commit message, an example, which shows how the new
>      "acceptFromServerUrl" config option can be useful, is added.
>
>    - The matching of URLs advertised by the server to URLs patterns
>      from the config, is now performed component by component. This is
>      reflected in the commit message, the documentation and the
>      code. This ensures a `*` in the host pattern cannot cross into
>      the path.
>
>    - In the code, we add a new match_one_url() function to perform the
>      matching.
>
>  - In patch 7/8, previously 15/16 ("promisor-remote: auto-configure
>    unknown remotes"):
>
>    - In the doc, the unclear "considered trusted by the client" is
>      clarified using "a client is allowed to act on" and subsequent
>      explanations. In general the doc is also improved a bit.
>
>    - In the tests, parsing the "remote.<name>.advertisedAs" config
>      option is now more careful about the possibility that more than
>      one such options exist.
>
>    - The test that was moved to patch 5/8 is still enhanced a bit in
>      this commit by checking that no "remote.<name>.advertisedAs"
>      config option has been added.
>
> CI tests
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> They all pass, see:
>
> https://github.com/chriscool/git/actions/runs/24992478331
>
> Range diff since v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  1:  b2894eb33a <  -:  ---------- promisor-remote: try accepted remotes b=
efore others in get_direct()
>  -:  ---------- >  1:  44e9a16455 t5710: simplify 'mkdir X' followed by '=
git -C X init'
>  2:  a3206a6ae9 =3D  2:  42f174910c urlmatch: change 'allow_globs' arg to=
 bool
>  3:  51bbf65c52 <  -:  ---------- urlmatch: add url_is_valid_pattern() he=
lper
>  4:  f367beef72 <  -:  ---------- promisor-remote: clarify that a remote =
is ignored
>  5:  1faf74cb3f <  -:  ---------- promisor-remote: refactor has_control_c=
har()
>  6:  40cf0af639 <  -:  ---------- promisor-remote: refactor accept_from_s=
erver()
>  7:  b75dca8037 <  -:  ---------- promisor-remote: keep accepted promisor=
_info structs alive
>  8:  f5e55dc407 <  -:  ---------- promisor-remote: remove the 'accepted' =
strvec
>  -:  ---------- >  3:  8088374458 urlmatch: add url_normalize_pattern() h=
elper
>  9:  63c1db30de !  4:  6bfda89a79 promisor-remote: add 'local_name' to 's=
truct promisor_info'
>     @@ Commit message
>          In a following commit, we will store promisor remote information=
 under
>          a remote name different than the one the server advertised.
>
>     -    To prepare for this change, let's add a new 'char* local_name' m=
ember
>     +    To prepare for this change, let's add a new 'char *local_name' m=
ember
>          to 'struct promisor_info', and let's update the related function=
s.
>
>          While at it, let's also add a small promisor_info_internal_name(=
)
>     @@ Commit message
>
>       ## promisor-remote.c ##
>      @@ promisor-remote.c: static struct string_list *fields_stored(void)
>     -
>     - /*
>        * Struct for promisor remotes involved in the "promisor-remote"
>     -- * protocol capability.
>     -+ * protocol capability:
>     +  * protocol capability.
>        *
>      - * Except for "name", each <member> in this struct and its <value>
>      - * should correspond (either on the client side or on the server si=
de)
>      - * to a "remote.<name>.<member>" config variable set to <value> whe=
re
>      - * "<name>" is a promisor remote name.
>     -+ * - "name" is the name the server advertised.
>     -+ * - "local_name" is the name we use locally (may be auto-generated=
).
>     -+ *
>      + * Except for "name" and "local_name", each <member> in this struct
>      + * and its <value> should correspond (either on the client side or =
on
>      + * the server side) to a "remote.<name>.<member>" config variable s=
et
>      + * to <value> where "<name>" is a promisor remote name.
>        */
>       struct promisor_info {
>     -   const char *name;
>     -+  const char *local_name;
>     +-  const char *name;
>     ++  const char *name;       /* name the server advertised */
>     ++  const char *local_name; /* name used locally (may be auto-generat=
ed) */
>         const char *url;
>         const char *filter;
>         const char *token;
> 10:  e9b8a64ab8 <  -:  ---------- promisor-remote: pass config entry to a=
ll_fields_match() directly
> 11:  2e1260190a <  -:  ---------- promisor-remote: refactor should_accept=
_remote() control flow
> 12:  b33f06173a <  -:  ---------- t5710: use proper file:// URIs for abso=
lute paths
> 13:  681b03e248 !  5:  fefa17e6dd promisor-remote: introduce promisor.acc=
eptFromServerUrl
>     @@ promisor-remote.c: static bool has_control_char(const char *s)
>      +struct allowed_url {
>      +  char *remote_name;
>      +  char *url_pattern;
>     ++  struct url_info pattern_info;
>      +};
>      +
>     ++static void allowed_url_free(void *util, const char *str UNUSED)
>     ++{
>     ++  struct allowed_url *allowed =3D util;
>     ++
>     ++  if (!allowed)
>     ++          return;
>     ++
>     ++  /* Depending on prefix, free either remote_name or url_pattern */
>     ++  free(allowed->remote_name ? allowed->remote_name : allowed->url_p=
attern);
>     ++  free(allowed->pattern_info.url);
>     ++  free(allowed);
>     ++}
>     ++
>      +static struct allowed_url *valid_accept_url(const char *url)
>      +{
>      +  char *dup, *p;
>     @@ promisor-remote.c: static bool has_control_char(const char *s)
>      +          p =3D dup;
>      +  }
>      +
>     -+  if (has_control_char(p) || !url_is_valid_pattern(p)) {
>     ++  if (has_control_char(p)) {
>      +          warning(_("invalid url pattern '%s' "
>      +                    "in '%s' from promisor.acceptFromServerUrl conf=
ig"), p, url);
>      +          free(dup);
>     @@ promisor-remote.c: static bool has_control_char(const char *s)
>      +  allowed =3D xmalloc(sizeof(*allowed));
>      +  allowed->remote_name =3D (p =3D=3D dup) ? NULL : dup;
>      +  allowed->url_pattern =3D p;
>     ++  allowed->pattern_info.url =3D url_normalize_pattern(p, &allowed->=
pattern_info);
>     ++  if (!allowed->pattern_info.url) {
>     ++          warning(_("invalid url pattern '%s' "
>     ++                    "in '%s' from promisor.acceptFromServerUrl conf=
ig"), p, url);
>     ++          free(dup);
>     ++          free(allowed);
>     ++          return NULL;
>     ++  }
>      +
>      +  return allowed;
>      +}
>      +
>     -+static struct string_list *accept_from_server_url(struct repository=
 *repo)
>     ++static void load_accept_from_server_url(struct repository *repo,
>     ++                                  struct string_list *accept_urls)
>      +{
>     -+  static struct string_list accept_urls =3D STRING_LIST_INIT_DUP;
>     -+  static int initialized;
>      +  const struct string_list *config_urls;
>      +
>     -+  if (initialized)
>     -+          return &accept_urls;
>     -+
>     -+  initialized =3D 1;
>     -+
>      +  if (!repo_config_get_string_multi(repo, "promisor.acceptfromserve=
rurl", &config_urls)) {
>      +          struct string_list_item *item;
>      +
>     @@ promisor-remote.c: static bool has_control_char(const char *s)
>      +                  struct allowed_url *allowed =3D valid_accept_url(=
item->string);
>      +                  if (allowed) {
>      +                          struct string_list_item *new;
>     -+                          new =3D string_list_append(&accept_urls, =
item->string);
>     ++                          new =3D string_list_append(accept_urls, i=
tem->string);
>      +                          new->util =3D allowed;
>      +                  }
>      +          }
>      +  }
>     -+
>     -+  return &accept_urls;
>      +}
>      +
>       static int should_accept_remote(enum accept_promisor accept,
>     @@ promisor-remote.c: static void filter_promisor_remote(struct repos=
itory *repo,
>         struct string_list_item *item;
>         bool reload_config =3D false;
>         enum accept_promisor accept =3D accept_from_server(repo);
>     -+  /* Pre-load and validate the acceptFromServerUrl config */
>     -+  (void)accept_from_server_url(repo);
>     ++  struct string_list accept_urls =3D STRING_LIST_INIT_DUP;
>     ++
>     ++  /* Load and validate the acceptFromServerUrl config */
>     ++  load_accept_from_server_url(repo, &accept_urls);
>
>         if (accept =3D=3D ACCEPT_NONE)
>                 return;
>     +@@ promisor-remote.c: static void filter_promisor_remote(struct repo=
sitory *repo,
>     +           }
>     +   }
>     +
>     ++  string_list_clear_func(&accept_urls, allowed_url_free);
>     +   promisor_info_list_clear(&config_info);
>     +   string_list_clear(&remote_info, 0);
>     +   store_info_free(store_info);
>     +
>     + ## t/t5710-promisor-remote-capability.sh ##
>     +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone=
 with 'KnownUrl' and empty url, so not advertised" '
>     +   check_missing_objects server 1 "$oid"
>     + '
>     +
>     ++test_expect_success "clone with invalid promisor.acceptFromServerUr=
l" '
>     ++  git -C server config promisor.advertise true &&
>     ++  test_when_finished "rm -rf client" &&
>     ++
>     ++  # As "bad name" contains a space, which is not a valid remote nam=
e,
>     ++  # the pattern should be rejected with a warning and no remote cre=
ated.
>     ++  GIT_NO_LAZY_FETCH=3D0 git clone \
>     ++          -c promisor.acceptfromserver=3DNone \
>     ++          -c "promisor.acceptFromServerUrl=3Dbad name=3Dhttps://exa=
mple.com/*" \
>     ++          --no-local --filter=3D"blob:limit=3D5k" server client 2>e=
rr &&
>     ++
>     ++  # Check that a warning was emitted
>     ++  test_grep "invalid remote name '\''bad name'\''" err &&
>     ++
>     ++  # Check that the largest object is not missing on the server
>     ++  check_missing_objects server 0 "" &&
>     ++
>     ++  # Reinitialize server so that the largest object is missing again
>     ++  initialize_server 1 "$oid"
>     ++'
>     ++
>     + test_expect_success "clone with promisor.sendFields" '
>     +   git -C server config promisor.advertise true &&
>     +   test_when_finished "rm -rf client" &&
> 14:  8c04e48d66 !  6:  2f238d0a7a promisor-remote: trust known remotes ma=
tching acceptFromServerUrl
>     @@ Commit message
>
>          To enable such targeted updates for trusted URLs, let's use the =
URL
>          patterns from `promisor.acceptFromServerUrl` as an additional UR=
L
>     -    based whitelist.
>     +    based allowlist.
>
>          Concretely, let's check the advertised URLs against the URL glob
>          patterns by introducing a new small helper function called
>          url_matches_accept_list(), which iterates over the glob patterns=
 and
>          returns the first matching allowed_url entry (or NULL).
>
>     -    (Before matching, the advertised URL is passed through url_norma=
lize()
>     -    so that case variations in the scheme/host, percent-encoding tri=
cks,
>     -    and ".." path segments cannot bypass the whitelist.)
>     +    The URL matching is done component by component: scheme and port=
 are
>     +    compared exactly, the host is matched with wildmatch() using the
>     +    WM_PATHNAME flag (so '*' cannot cross the '/' boundary into the =
path),
>     +    and the path is matched with wildmatch() without WM_PATHNAME (so=
 '*'
>     +    can still match multi-level paths). Before matching, the adverti=
sed
>     +    URL is passed through url_normalize() so that case variations in=
 the
>     +    scheme/host, percent-encoding tricks, and ".." path segments can=
not
>     +    bypass the allowlist.
>
>          Let's then use this helper at the tail of should_accept_remote()=
 so
>          that, when `accept =3D=3D ACCEPT_NONE`, a known remote whose URL=
 matches
>     -    the whitelist is still accepted.
>     +    the allowlist is still accepted.
>
>          To prepare for this new logic, let's also:
>
>     @@ Commit message
>             and relax its early return so that the function is entered wh=
en
>             `accept_urls` has entries even if `accept =3D=3D ACCEPT_NONE`=
.
>
>     +    With this, many organizations may only need something like:
>     +
>     +      git config set --global \
>     +              promisor.acceptFromServerUrl "https://my-org.com/*"
>     +
>     +    to accept only their own remotes. And if they need to accept add=
itional
>     +    remotes in some specific repos, they can also set:
>     +
>     +      git config set promisor.acceptFromServer knownUrl
>     +
>     +    and configure the additional remote manually only in the repos w=
here
>     +    they are needed.
>     +
>          Let's then properly document `promisor.acceptFromServerUrl` in
>     -    "promisor.adoc" as an additive security whitelist for known remo=
tes,
>     -    including the URL normalization behavior, and let's mention it i=
n
>     -    "gitprotocol-v2.adoc".
>     +    "promisor.adoc" as an additive security allowlist for known remo=
tes,
>     +    including the URL normalization behavior and the component-wise
>     +    matching, and let's mention it in "gitprotocol-v2.adoc".
>
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
>     @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
>         comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
>
>      +promisor.acceptFromServerUrl::
>     -+  A glob pattern to specify which URLs advertised by a server
>     -+  are considered trusted by the client. This option acts as an
>     -+  additive security whitelist that works in conjunction with
>     -+  `promisor.acceptFromServer`.
>     ++  A glob pattern to specify which server-advertised URLs a
>     ++  client is allowed to act on. When a URL matches, the client
>     ++  will accept the advertised remote as a promisor remote and may
>     ++  automatically accept field updates (such as authentication
>     ++  tokens) from the server, even if `promisor.acceptFromServer`
>     ++  is set to `none` (the default).
>      ++
>      +This option can appear multiple times in config files. An advertise=
d
>      +URL will be accepted if it matches _ANY_ glob pattern specified by
>      +this option in _ANY_ config file read by Git.
>      ++
>     -+Be _VERY_ careful with these glob patterns, as it can be a big
>     -+security hole to allow any advertised remote to be auto-configured!
>     ++Be _VERY_ careful with these patterns: `*` matches any sequence of
>     ++characters within the 'host' and 'path' parts of a URL (but cannot
>     ++cross part boundaries). An overly broad pattern is a major security
>     ++risk, as a matching URL allows a server to update fields (such as
>     ++authentication tokens) on known remotes without further confirmatio=
n.
>      +To minimize security risks, follow these guidelines:
>      ++
>      +1. Start with a secure protocol scheme, like `https://` or `ssh://`=
.
>     @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
>      +   your specific organization or namespace (e.g.,
>      +   `https://gitlab.com/your-org/*`).
>      ++
>     -+3. Don't use globs (`*`) in the domain name. For example
>     -+   `https://cdn.example.com/*` is much safer than
>     -+   `https://*.example.com/*`, because the latter matches
>     -+   `https://evil-hacker.net/fake.example.com/repo`.
>     ++3. Never use globs at the end of domain names. For example,
>     ++   `https://cdn.your-org.com/*` might be safe, but
>     ++   `https://cdn.your-org.com*/*` is a major security risk because
>     ++   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
>      ++
>     -+4. Make sure to have a `/` at the end of the domain name (or the en=
d
>     -+   of specific directories). For example `https://cdn.example.com/*=
`
>     -+   is much safer than `https://cdn.example.com*`, because the latte=
r
>     -+   matches `https://cdn.example.com.hacker.net/repo`.
>     ++4. Be careful using globs at the beginning of domain names. While t=
he
>     ++   code ensures a `*` in the host cannot cross into the path, a
>     ++   pattern like `https://*.example.com/*` will still match any
>     ++   subdomain. This is extremely dangerous on shared hosting platfor=
ms
>     ++   (e.g., `https://*.github.io/*` trusts every user's site on the
>     ++   entire platform).
>      ++
>     -+Before matching, the advertised URL is normalized: the scheme and
>     -+host are lowercased, percent-encoded characters are decoded where
>     -+possible, and path segments like `..` are resolved.  Glob patterns
>     -+are matched against this normalized URL as-is, so patterns should
>     -+be written in normalized form (e.g., lowercase scheme and host).
>     ++Before matching, both the advertised URL and the pattern are
>     ++normalized: the scheme and host are lowercased, percent-encoded
>     ++characters are decoded where possible, and path segments like `..`
>     ++are resolved. The port must also match exactly (e.g.,
>     ++`https://example.com:8080/*` will not match a URL advertised on
>     ++port 9999).
>      ++
>     -+Even if `promisor.acceptFromServer` is set to `None` (the default),
>     -+Git will still accept field updates (like tokens) for known remotes=
,
>     -+provided their URLs match a pattern in
>     -+`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
>     -+details on the protocol.
>     ++For the security implications of accepting a promisor remote, see t=
he
>     ++documentation of `promisor.acceptFromServer`. For details on the
>     ++protocol, see linkgit:gitprotocol-v2[5].
>      +
>       promisor.checkFields::
>         A comma or space separated list of additional remote related
>     @@ promisor-remote.c
>
>       struct promisor_remote_config {
>         struct promisor_remote *promisors;
>     -@@ promisor-remote.c: static struct string_list *accept_from_server_=
url(struct repository *repo)
>     -   return &accept_urls;
>     +@@ promisor-remote.c: static void load_accept_from_server_url(struct=
 repository *repo,
>     +   }
>       }
>
>     ++static bool match_one_url(const struct url_info *pi, const struct u=
rl_info *ui)
>     ++{
>     ++  const char *pat =3D pi->url;
>     ++  const char *url =3D ui->url;
>     ++  char *p_str, *u_str;
>     ++  bool res;
>     ++
>     ++  /*
>     ++   * Schemes must match exactly. They are case-folded by
>     ++   * url_normalize(), so strncmp() suffices.
>     ++   */
>     ++  if (pi->scheme_len !=3D ui->scheme_len || strncmp(pat, url, pi->s=
cheme_len))
>     ++          return false;
>     ++
>     ++  /*
>     ++   * Ports must match exactly. url_normalize() strips default
>     ++   * ports (like 443 for https), so length and content
>     ++   * comparisons are sufficient.
>     ++   */
>     ++  if (pi->port_len !=3D ui->port_len ||
>     ++      strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len)=
)
>     ++          return false;
>     ++
>     ++  /*
>     ++   * Match host and path separately to prevent a '*' in the host
>     ++   * portion of the pattern from matching across the '/'
>     ++   * boundary into the path. Use WM_PATHNAME for the host so '*'
>     ++   * cannot cross '/' there, and 0 for the path so '*' can still
>     ++   * match multi-level paths.
>     ++   */
>     ++
>     ++  p_str =3D xstrndup(pat + pi->host_off, pi->host_len);
>     ++  u_str =3D xstrndup(url + ui->host_off, ui->host_len);
>     ++  res =3D !wildmatch(p_str, u_str, WM_PATHNAME);
>     ++  free(p_str);
>     ++  free(u_str);
>     ++
>     ++  if (!res)
>     ++          return false;
>     ++
>     ++  p_str =3D xstrndup(pat + pi->path_off, pi->path_len);
>     ++  u_str =3D xstrndup(url + ui->path_off, ui->path_len);
>     ++  res =3D !wildmatch(p_str, u_str, 0);
>     ++  free(p_str);
>     ++  free(u_str);
>     ++
>     ++  return res;
>     ++}
>     ++
>      +static struct allowed_url *url_matches_accept_list(
>      +          struct string_list *accept_urls, const char *url)
>      +{
>      +  struct string_list_item *item;
>     -+  char *normalized =3D url_normalize(url, NULL);
>     ++  struct url_info url_info;
>     ++
>     ++  url_info.url =3D url_normalize(url, &url_info);
>      +
>     -+  if (!normalized)
>     ++  if (!url_info.url)
>      +          return NULL;
>      +
>      +  for_each_string_list_item(item, accept_urls) {
>      +          struct allowed_url *allowed =3D item->util;
>      +
>     -+          if (!wildmatch(allowed->url_pattern, normalized, 0)) {
>     -+                  free(normalized);
>     ++          if (match_one_url(&allowed->pattern_info, &url_info)) {
>     ++                  free(url_info.url);
>      +                  return allowed;
>      +          }
>      +  }
>      +
>     -+  free(normalized);
>     ++  free(url_info.url);
>      +  return NULL;
>      +}
>      +
>     @@ promisor-remote.c: static int should_accept_remote(enum accept_pro=
misor accept,
>      +  /*
>      +   * Even if accept =3D=3D ACCEPT_NONE, we MUST trust this known
>      +   * remote to update its token or other such fields if its URL
>     -+   * matches the acceptFromServerUrl whitelist!
>     ++   * matches the acceptFromServerUrl allowlist!
>      +   */
>      +  if (url_matches_accept_list(accept_urls, remote_url))
>      +          return all_fields_match(advertised, config_info, p);
>     @@ promisor-remote.c: static int should_accept_remote(enum accept_pro=
misor accept,
>
>       static int skip_field_name_prefix(const char *elem, const char *fie=
ld_name, const char **value)
>      @@ promisor-remote.c: static void filter_promisor_remote(struct repo=
sitory *repo,
>     -   struct string_list_item *item;
>     -   bool reload_config =3D false;
>     -   enum accept_promisor accept =3D accept_from_server(repo);
>     --  /* Pre-load and validate the acceptFromServerUrl config */
>     --  (void)accept_from_server_url(repo);
>     -+  struct string_list *accept_urls =3D accept_from_server_url(repo);
>     +   /* Load and validate the acceptFromServerUrl config */
>     +   load_accept_from_server_url(repo, &accept_urls);
>
>      -  if (accept =3D=3D ACCEPT_NONE)
>     -+  if (accept =3D=3D ACCEPT_NONE && !accept_urls->nr)
>     ++  if (accept =3D=3D ACCEPT_NONE && !accept_urls.nr)
>                 return;
>
>         /* Parse remote info received */
>     @@ promisor-remote.c: static void filter_promisor_remote(struct repos=
itory *repo,
>                 }
>
>      -          if (should_accept_remote(accept, advertised, &config_info=
)) {
>     -+          if (should_accept_remote(accept, advertised, accept_urls,=
 &config_info)) {
>     ++          if (should_accept_remote(accept, advertised, &accept_urls=
, &config_info)) {
>                         if (!store_info)
>                                 store_info =3D store_info_new(repo);
>                         if (promisor_store_advertised_fields(advertised, =
store_info))
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'KnownUrl
>         check_missing_objects server 1 "$oid"
>       '
>
>     -+test_expect_success "clone with 'None' but URL whitelisted" '
>     ++test_expect_success "clone with 'None' but URL allowlisted" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
>      +          -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>     -+          -c remote.lop.url=3D"$PWD_URL/lop" \
>     ++          -c remote.lop.url=3D"$TRASH_DIRECTORY_URL/lop" \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"$ENCODED_PWD_URL/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that the largest object is still missing on the server
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with 'None' but URL not in whitelist" '
>     ++test_expect_success "clone with 'None' but URL not in allowlist" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
>      +          -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>     -+          -c remote.lop.url=3D"$PWD_URL/lop" \
>     ++          -c remote.lop.url=3D"$TRASH_DIRECTORY_URL/lop" \
>      +          -c promisor.acceptfromserver=3DNone \
>      +          -c promisor.acceptFromServerUrl=3D"https://example.com/*"=
 \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'KnownUrl
>      +  initialize_server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with 'None' but URL whitelisted in one p=
attern out of two" '
>     ++test_expect_success "clone with 'None' but URL allowlisted in one p=
attern out of two" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
>      +          -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>     -+          -c remote.lop.url=3D"$PWD_URL/lop" \
>     ++          -c remote.lop.url=3D"$TRASH_DIRECTORY_URL/lop" \
>      +          -c promisor.acceptfromserver=3DNone \
>      +          -c promisor.acceptFromServerUrl=3D"https://example.com/*"=
 \
>     -+          -c promisor.acceptFromServerUrl=3D"$ENCODED_PWD_URL/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that the largest object is still missing on the server
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with 'None', URL whitelisted, but client=
 has different URL" '
>     ++test_expect_success "clone with 'None', URL allowlisted, but client=
 has different URL" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  # The client configures "lop" with a different URL (serverTwo) th=
an
>      +  # what the server advertises (lop). Even though the advertised UR=
L
>     -+  # matches the whitelist, the remote is rejected because the
>     ++  # matches the allowlist, the remote is rejected because the
>      +  # configured URL does not match the advertised one.
>      +  GIT_NO_LAZY_FETCH=3D0 git clone -c remote.lop.promisor=3Dtrue \
>      +          -c remote.lop.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>     -+          -c remote.lop.url=3D"$PWD_URL/serverTwo" \
>     ++          -c remote.lop.url=3D"$TRASH_DIRECTORY_URL/serverTwo" \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"$ENCODED_PWD_URL/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that the largest object is not missing on the server
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'KnownUrl
>      +  initialize_server 1 "$oid"
>      +'
>      +
>     - test_expect_success "clone with promisor.sendFields" '
>     + test_expect_success "clone with invalid promisor.acceptFromServerUr=
l" '
>         git -C server config promisor.advertise true &&
>         test_when_finished "rm -rf client" &&
>     -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "subse=
quent fetch from a client when promisor.advertise is f
>     -   check_missing_objects server 1 "$oid"
>     - '
>     -
>     -+
>     -+
>     - test_done
> 15:  314150a860 !  7:  a077f33df4 promisor-remote: auto-configure unknown=
 remotes
>     @@ Commit message
>          promisor-remote: auto-configure unknown remotes
>
>          Previous commits have introduced the `promisor.acceptFromServerU=
rl`
>     -    config variable to whitelist some URLs advertised by a server th=
rough
>     +    config variable to allowlist some URLs advertised by a server th=
rough
>          the "promisor-remote" protocol capability.
>
>          However the new `promisor.acceptFromServerUrl` mechanism, like t=
he old
>     @@ Commit message
>
>       ## Documentation/config/promisor.adoc ##
>      @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
>     -
>       promisor.acceptFromServerUrl::
>     -   A glob pattern to specify which URLs advertised by a server
>     --  are considered trusted by the client. This option acts as an
>     --  additive security whitelist that works in conjunction with
>     --  `promisor.acceptFromServer`.
>     -+  are allowed to be auto-configured (created and persisted) on
>     -+  the client side. Unlike `promisor.acceptFromServer`, which
>     -+  only accepts already configured remotes, a match against this
>     -+  option instructs Git to write a new `[remote "<name>"]`
>     -+  section to the client's configuration.
>     +   A glob pattern to specify which server-advertised URLs a
>     +   client is allowed to act on. When a URL matches, the client
>     +-  will accept the advertised remote as a promisor remote and may
>     ++  will accept the advertised remote as a promisor remote, may
>     ++  automatically create a new remote configuration for it and may
>     +   automatically accept field updates (such as authentication
>     +   tokens) from the server, even if `promisor.acceptFromServer`
>     +   is set to `none` (the default).
>     +@@ Documentation/config/promisor.adoc: this option in _ANY_ config f=
ile read by Git.
>     + Be _VERY_ careful with these patterns: `*` matches any sequence of
>     + characters within the 'host' and 'path' parts of a URL (but cannot
>     + cross part boundaries). An overly broad pattern is a major security
>     +-risk, as a matching URL allows a server to update fields (such as
>     +-authentication tokens) on known remotes without further confirmatio=
n.
>     +-To minimize security risks, follow these guidelines:
>     ++risk, as a matching URL allows a server to auto-configure new remot=
es
>     ++and to update fields (such as authentication tokens) on known remot=
es
>     ++without further confirmation. To minimize security risks, follow th=
ese
>     ++guidelines:
>     + +
>     + 1. Start with a secure protocol scheme, like `https://` or `ssh://`=
.
>       +
>     - This option can appear multiple times in config files. An advertise=
d
>     - URL will be accepted if it matches _ANY_ glob pattern specified by
>     -@@ Documentation/config/promisor.adoc: possible, and path segments l=
ike `..` are resolved.  Glob patterns
>     - are matched against this normalized URL as-is, so patterns should
>     - be written in normalized form (e.g., lowercase scheme and host).
>     +@@ Documentation/config/promisor.adoc: are resolved. The port must a=
lso match exactly (e.g.,
>     + `https://example.com:8080/*` will not match a URL advertised on
>     + port 9999).
>       +
>     --Even if `promisor.acceptFromServer` is set to `None` (the default),
>     --Git will still accept field updates (like tokens) for known remotes=
,
>     --provided their URLs match a pattern in
>     --`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
>     --details on the protocol.
>      +The glob pattern can optionally be prefixed with a remote name and =
an
>      +equals sign (e.g., `cdn=3Dhttps://cdn.example.com/*`). If such a pr=
efix
>      +is provided, accepted remotes will be saved under that name. If no
>      +such prefix is provided, a safe remote name will be automatically
>      +generated by sanitizing the URL and prefixing it with
>     -+`promisor-auto-`. If a remote with the chosen name already exists b=
ut
>     -+points to a different URL, Git will append a numeric suffix (e.g.,
>     -+`-1`, `-2`) to the name to prevent overwriting existing
>     -+configurations. You should make sure that this doesn't happen often
>     -+though, as remotes will be rejected if the numeric suffix increases
>     -+too much. In all cases, the original name advertised by the server =
is
>     -+recorded in the `remote.<name>.advertisedAs` configuration variable
>     -+for tracing and debugging purposes.
>     ++`promisor-auto-`.
>      ++
>     -+Note that this option acts as an additive security whitelist. It wo=
rks
>     -+in conjunction with `promisor.acceptFromServer` (see the documentat=
ion
>     -+of that option for the implications of accepting a promisor
>     -+remote). Even if `promisor.acceptFromServer` is set to `None` (the
>     -+default), Git will still automatically configure new remotes, and
>     -+accept field updates (like tokens) for known remotes, provided thei=
r
>     -+URLs match a pattern in `promisor.acceptFromServerUrl`. See
>     -+linkgit:gitprotocol-v2[5] for details on the protocol.
>     -
>     - promisor.checkFields::
>     -   A comma or space separated list of additional remote related
>     ++If a remote with the chosen name already exists but points to a
>     ++different URL, Git will append a numeric suffix (e.g., `-1`, `-2`) =
to
>     ++the name to prevent overwriting existing configurations. You should
>     ++make sure that this doesn't happen often though, as remotes will be
>     ++rejected if the numeric suffix increases too much. In all cases, th=
e
>     ++original name advertised by the server is recorded in the
>     ++`remote.<name>.advertisedAs` configuration variable for tracing and
>     ++debugging purposes.
>     +++
>     + For the security implications of accepting a promisor remote, see t=
he
>     + documentation of `promisor.acceptFromServer`. For details on the
>     + protocol, see linkgit:gitprotocol-v2[5].
>
>       ## Documentation/config/remote.adoc ##
>      @@ Documentation/config/remote.adoc: remote.<name>.promisor::
>     @@ promisor-remote.c: static void filter_promisor_remote(struct repos=
itory *repo,
>                         string_list_sort(&config_info);
>                 }
>
>     --          if (should_accept_remote(accept, advertised, accept_urls,=
 &config_info)) {
>     -+          if (should_accept_remote(repo, accept, advertised, accept=
_urls,
>     +-          if (should_accept_remote(accept, advertised, &accept_urls=
, &config_info)) {
>     ++          if (should_accept_remote(repo, accept, advertised, &accep=
t_urls,
>      +                                   &config_info, &reload_config)) {
>                         if (!store_info)
>                                 store_info =3D store_info_new(repo);
>                         if (promisor_store_advertised_fields(advertised, =
store_info))
>
>       ## t/t5710-promisor-remote-capability.sh ##
>     -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone=
 with 'None', URL whitelisted, but client has differen
>     +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone=
 with 'None', URL allowlisted, but client has differen
>         initialize_server 1 "$oid"
>       '
>
>     -+test_expect_success "clone with URL whitelisted and no remote alrea=
dy configured" '
>     ++test_expect_success "clone with URL allowlisted and no remote alrea=
dy configured" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>     ++  test_when_finished "rm -f full_names" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"$ENCODED_PWD_URL/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"$ENCODED_TRASH_DIRECTO=
RY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>     -+  # Check that a remote has been auto-created with the right fields=
.
>     -+  # The remote is identified by "remote.<name>.advertisedAs" =3D=3D=
 "lop".
>     -+  FULL_NAME=3D$(git -C client config --name-only --get-regexp "remo=
te\..*\.advertisedas" "^lop$") &&
>     -+  REMOTE_NAME=3D$(echo "$FULL_NAME" | sed "s/remote\.\(.*\)\.advert=
isedas/\1/") &&
>     ++  # Check that exactly one remote has been auto-created, identified
>     ++  # by "remote.<name>.advertisedAs" =3D=3D "lop".
>     ++  git -C client config get --all --show-names --regexp \
>     ++          "remote\..*\.advertisedas" >full_names &&
>     ++  test_line_count =3D 1 full_names &&
>     ++  REMOTE_NAME=3D$(sed "s/^remote\.\(.*\)\.advertisedas .*$/\1/" ful=
l_names) &&
>      +
>      +  # Check ".url" and ".promisor" values
>     -+  printf "%s\n" "$PWD_URL/lop" "true" >expect &&
>     ++  printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" >expect &&
>      +  git -C client config "remote.$REMOTE_NAME.url" >actual &&
>      +  git -C client config "remote.$REMOTE_NAME.promisor" >>actual &&
>      +  test_cmp expect actual &&
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'None', U
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with named URL whitelisted and no pre-co=
nfigured remote" '
>     ++test_expect_success "clone with named URL allowlisted and no pre-co=
nfigured remote" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_PWD_URL=
/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_TRASH_D=
IRECTORY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that a remote has been auto-created with the right "cdn" =
name and fields.
>     -+  printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
>     ++  printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
>      +  git -C client config "remote.cdn.url" >actual &&
>      +  git -C client config "remote.cdn.promisor" >>actual &&
>      +  git -C client config "remote.cdn.advertisedAs" >>actual &&
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'None', U
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with URL whitelisted but colliding name"=
 '
>     ++test_expect_success "clone with URL allowlisted but colliding name"=
 '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'None', U
>      +          -c remote.cdn.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>      +          -c remote.cdn.url=3D"https://example.com/cdn" \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_PWD_URL=
/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_TRASH_D=
IRECTORY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that a remote has been auto-created with the right "cdn-1=
" name and fields.
>     -+  printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
>     ++  printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
>      +  git -C client config "remote.cdn-1.url" >actual &&
>      +  git -C client config "remote.cdn-1.promisor" >>actual &&
>      +  git -C client config "remote.cdn-1.advertisedAs" >>actual &&
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'None', U
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with URL whitelisted and reusable remote=
" '
>     ++test_expect_success "clone with URL allowlisted and reusable remote=
" '
>      +  git -C server config promisor.advertise true &&
>      +  test_when_finished "rm -rf client" &&
>      +
>      +  GIT_NO_LAZY_FETCH=3D0 git clone \
>      +          -c remote.cdn.fetch=3D"+refs/heads/*:refs/remotes/lop/*" =
\
>     -+          -c remote.cdn.url=3D"$PWD_URL/lop" \
>     ++          -c remote.cdn.url=3D"$TRASH_DIRECTORY_URL/lop" \
>      +          -c promisor.acceptfromserver=3DNone \
>     -+          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_PWD_URL=
/*" \
>     ++          -c promisor.acceptFromServerUrl=3D"cdn=3D$ENCODED_TRASH_D=
IRECTORY_URL/*" \
>      +          --no-local --filter=3D"blob:limit=3D5k" server client &&
>      +
>      +  # Check that the existing "cdn" remote has been properly updated.
>     -+  printf "%s\n" "$PWD_URL/lop" "true" "lop" "+refs/heads/*:refs/rem=
otes/lop/*" >expect &&
>     ++  printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" "+refs/head=
s/*:refs/remotes/lop/*" >expect &&
>      +  git -C client config "remote.cdn.url" >actual &&
>      +  git -C client config "remote.cdn.promisor" >>actual &&
>      +  git -C client config "remote.cdn.advertisedAs" >>actual &&
>     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone =
with 'None', U
>      +  check_missing_objects server 1 "$oid"
>      +'
>      +
>     -+test_expect_success "clone with invalid promisor.acceptFromServerUr=
l" '
>     -+  git -C server config promisor.advertise true &&
>     -+  test_when_finished "rm -rf client" &&
>     -+
>     -+  # As "bad name" contains a space, which is not a valid remote nam=
e,
>     -+  # the pattern should be rejected with a warning and no remote cre=
ated.
>     -+  GIT_NO_LAZY_FETCH=3D0 git clone \
>     -+          -c promisor.acceptfromserver=3DNone \
>     -+          -c "promisor.acceptFromServerUrl=3Dbad name=3Dhttps://exa=
mple.com/*" \
>     -+          --no-local --filter=3D"blob:limit=3D5k" server client 2>e=
rr &&
>     -+
>     -+  # Check that a warning was emitted
>     -+  test_grep "invalid remote name '\''bad name'\''" err &&
>     -+
>     -+  # Check that no remote was auto-created
>     -+  test_must_fail git -C client config --get-regexp "remote\..*\.adv=
ertisedas" &&
>     -+
>     -+  # Check that the largest object is not missing on the server
>     -+  check_missing_objects server 0 "" &&
>     -+
>     -+  # Reinitialize server so that the largest object is missing again
>     -+  initialize_server 1 "$oid"
>     -+'
>     -+
>     - test_expect_success "clone with promisor.sendFields" '
>     + test_expect_success "clone with invalid promisor.acceptFromServerUr=
l" '
>         git -C server config promisor.advertise true &&
>         test_when_finished "rm -rf client" &&
>     +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone=
 with invalid promisor.acceptFromServerUrl" '
>     +   # Check that a warning was emitted
>     +   test_grep "invalid remote name '\''bad name'\''" err &&
>     +
>     ++  # Check that no remote was auto-created
>     ++  test_must_fail git -C client config get --regexp "remote\..*\.adv=
ertisedas" &&
>     ++
>     +   # Check that the largest object is not missing on the server
>     +   check_missing_objects server 0 "" &&
>     +
> 16:  20f70b52bb !  8:  b68b9497aa doc: promisor: improve acceptFromServer=
 entry
>     @@ Documentation/config/promisor.adoc: variable is set to "true", and=
 the "name" an
>      +for protocol details.
>
>       promisor.acceptFromServerUrl::
>     -   A glob pattern to specify which URLs advertised by a server
>     +   A glob pattern to specify which server-advertised URLs a
>
>
> Christian Couder (8):
>   t5710: simplify 'mkdir X' followed by 'git -C X init'
>   urlmatch: change 'allow_globs' arg to bool
>   urlmatch: add url_normalize_pattern() helper
>   promisor-remote: add 'local_name' to 'struct promisor_info'
>   promisor-remote: introduce promisor.acceptFromServerUrl
>   promisor-remote: trust known remotes matching acceptFromServerUrl
>   promisor-remote: auto-configure unknown remotes
>   doc: promisor: improve acceptFromServer entry
>
>  Documentation/config/promisor.adoc    | 123 ++++++--
>  Documentation/config/remote.adoc      |   9 +
>  Documentation/gitprotocol-v2.adoc     |   9 +-
>  promisor-remote.c                     | 410 ++++++++++++++++++++++++--
>  t/t5710-promisor-remote-capability.sh | 202 ++++++++++++-
>  urlmatch.c                            |  11 +-
>  urlmatch.h                            |  12 +
>  7 files changed, 730 insertions(+), 46 deletions(-)
>
> --
> 2.54.0.19.gb68b9497aa
>
