Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794670069;
	b=XRLv1RNAbJA4Q1KxfZmjS7CMfZkS3uvuD7LoYzasGxi/cW18omKNF4ttKVX2XYIhPIZq
	 bgd2/ndIXQ5an+IIHqXDQyiV8YGuteYtFd2BrvL3EpbGjPnnS6ZN6tyVRUKikELuqPyCk
	 QgFyKviDaxvdjGhKOwLvh0qGmJZmvi9xdxd9qKV23OU3BWtt0WLkuUuVOmfVGiPyJ1kIY
	 hEkG62xmSLSZxhlHTTdzxUDE7sS11rhhDOo3dUhhdy4Oc7Ia+Ic1uVvU4okIGYBc4Sxm7
	 HLgOHEfx54duOmsF5R0DvYiKVW/CtqmGw6aE+syLCe8SHfT20cAOMRrPP/BbBmooQBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ojNPIhk/oi4yw9Da0jEFs3AQ2MHzxahvy0U+xDdqsgk=;
	b=vr9ykNLxKOCGWUHwK+hjNwfq0R+Jwzg/OqzgmOe/3KWEnluGvbD5EojGbAcM09bD1TzN
	 NlDcEBfgMu6n7SZUOFtS3vt+DlKE0HzhNLVSxazv0rsQFmaZoKQsJJ/zKxziwPkF5/81f
	 5cQiWVR39BQYNK4aobJkkNA4EfYNsz33YJZRhyNoBL+qVRXMh/nlu61VescYmFAG6XF+L
	 vgXlfvdffpIFOlp/bp0KAusZXXtx9cQBGEr6ig+Lp8isMSrOulDiJB6LMT8BRcP5nuu3u
	 6tiT7oWbcTHkoYaaevnHU/vEqE4mazdTOIoKVbOdEmG5ttz7KirdqOoDTmxMe6IRK5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwmMvraA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD9606A32D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCD9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwmMvraA
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e8938fd01so32122886d6.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:27:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794670067; cv=none;
        d=google.com; s=arc-20260327;
        b=IamiKdJSs0btbb9JXuJ++0BpL95EqbVu2oPxhRiU2tqf2zp0scQJmwE03sgd2cuJrX
         vRyc/RErd4TM8y92uSBlJ3+D+aOutcxNEkdn/NFuxzy8xZS/xvsMBqVNMut60cv7B7D/
         BTJ26kpJ1cVUGrOQyHxfpxDoyPL9oBkA03lAzMQqaqiMFAbAW92Uci9j8+ZVPVNWZ2IO
         BCZkxxBpWMTtRftfSYO/BhghjTnTG0Y6aQ0Hayj/Mr02iE9u0ZFBVT0CSD+aC8L5DZ60
         W0msHK8hYZGcvGdEEsFttg2N3pYxpbXQxga3f1rICOD/nVwqOA9fzEeO4SwNQ+EuPGIp
         iKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojNPIhk/oi4yw9Da0jEFs3AQ2MHzxahvy0U+xDdqsgk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=X1IraR9O/+CwULSK6nlf03ftSRu6UQtU+dVq78XRKY52y/Ayr1pnQ6pKfpp6WDFOvI
         vXMYSDyvvJpi6hTcWu1yaGWi0sBKNuiQD7TbGb3EwlAr1Jwdsg2FsyArsYGs4OHdOw1Z
         DLi8s9kZ5mhlWMJtwKkXFkZM9ml+Us/n8Db6cRsl4CWH0/zTQcCl9SiXw5Urb15xm9nM
         qJavuSfT9Sfr30o/6pW0rj7ZzrzA0lJgiPW4orj5bBpWjOOyq86P25Rojlo/FhVJxgaT
         HDRdWtkkNRE2Bvr6vLn8oin8gekxw/vs5bR5uofxV4sLzoU1s3bXw+0BcrKbBA8/eG9S
         TSZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794670067; x=1795274867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ojNPIhk/oi4yw9Da0jEFs3AQ2MHzxahvy0U+xDdqsgk=;
        b=lwmMvraAvms6mjisa9145w4bhtAq4DEIpDnl2PX/M9UtUX+q021hVpscXMucxPMOt/
         YNgMhBUFqL2x6qk0o6//ozlY1LkkPYBX+KNf+cqFXCe155CJRwYvRPa9F5xLugnPUnq5
         Xdgeepb3cWCiNScbQs8E8fXS2KiW5HexvbQpc/Tplmnf4l6GR6PWG84rNi+OG9lDnFe5
         Y8tvx5HPvcOvzmaa73eEKQq+O9G3nPn+A6ilO+UjyeytGyciRhZBYQvvouWAznxKnEu6
         rv3WRErG5VuaejHTtroEdINT/6VAa97bO1oewQRVq8+m3XokoX9E2XPT6bnDHb8ls/cT
         EwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794670067; x=1795274867;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ojNPIhk/oi4yw9Da0jEFs3AQ2MHzxahvy0U+xDdqsgk=;
        b=c54ElPO7ImGGpAi87dueEq4Sy+whZQUQ+ADQDkHPIa8KgWpdN5M70uvq7XIo3Wj/B6
         SsFV0FrZ/3lzz/UbqCqwB2zXAGxAY/mxBMhgNCmQCnms2fHwE3ALLqkZ6zLdVpBrOlQD
         GYK9zwogiwO435OXeW3JYf6o7mq0HFJ3bluOKaMx9dk8IYKW5IZCNHsTmt1pvOD/Uuap
         +v4Zl46nIZ36iI7lxe1iBboOLM2V4YOmEtGrw/u8U/V5HvCqCUptABbbU+lM9A9ok78o
         0kWElU6yQH0pzRNUZeETzeIGjomro+goW+AlTlxRg3tgUclkStre8cSh1KogZlj+BxFM
         WElA==
X-Gm-Message-State: APuU4Z++V9P66TM2Mk3MHV/QDlIBOTgoj6O5acp0S1MDr1nORFHTcGyL
	JMRJmzM9XYi0LV29NnQKgsRr2DlJ7mv2G1LGnbx/8h4nceCjszwWzxeu7fg6itrBUmmqDH4n+jj
	cCZEEyXl0PW+GQ0dgm+JM4G2Qw/F+cdtrF6uC
X-Gm-Gg: AYBFou15bVwYKzHrnxyvbXEem/nJIYhRAuLlxEOH44o6fypbwXtCPtApkZNO1KE52LE
	508axQqblc4uwjJuPZMu9KzKxkUZx8gn2ieGhQ5EfK4kH45HzJAwHlqH8vpIJI8FrXSSg1DX3tr
	zw4QKWgqKtVF5zkb7H9BBNs3P4tOJQji/O4TiXIj5L6SoHLC5qbdsR6WTmsknJfsKd8ypsFCysF
	FSxpKb9n/CFRdMKGAX4qiDuSmMZpp9bghJJDxQF9JFrAi3WDx36ZGb2TlHUYa+/hpyDNYM2ZrEZ
	ARisSZx/Z52OTh2rGH84vQ0FOyK845RC2yNmq7eWvreF16iOxB6Xwf6Cim1Uf5VxBFHYNekyAyV
	CHLorv/EXWHGm1hLvAjiOLWZP9S/e3xslIXplaAuMHWYBAZmtczouKOJoEwLrbMvj5i1ngG+Rr9
	yZw9hjAOQgDfPXXOs2
X-Received: by 2002:a05:6214:f04:b0:91e:a586:8b7c with SMTP id
 6a1803df08f44-91f2418ba84mr88357126d6.14.1794670067215; Sat, 14 Nov 2026
 07:27:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com> <f9adc6c85c4b098a0df8cf18783d1969a68fc048.1794484985.git.gitgitgadget@gmail.com>
In-Reply-To: <f9adc6c85c4b098a0df8cf18783d1969a68fc048.1794484985.git.gitgitgadget@gmail.com>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Sun, 15 Nov 2026 00:27:36 +0900
X-Gm-Features: AclHuK95YFK1nn44fPy6j5lxCqjOUelpsTp_GzrUQzoEDC41UpJxmxTYJG5cf94
Message-ID: <CAF5D8-sJkCzL85boqNDnuU+wWthMSB37h5SJOny4hDUfe8y1rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule: make submodule.<name>.gitdir relative for worktrees
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:03=E2=80=AFPM Yoichi NAKAYAMA via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> For a linked worktree, always keep `submodule.<name>.gitdir` relative
> to ensure it continues to work when the worktree is moved along with
> the main worktree. (This benefit also requires
> worktree.useRelativePaths to be set to true.)
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>  builtin/submodule--helper.c                | 68 +++++++++++++---------
>  t/t7425-submodule-gitdir-path-extension.sh | 19 ++++++
>  2 files changed, 61 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 461b682d0d..56d7720e93 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -37,6 +37,7 @@
>  #include "wildmatch.h"
>  #include "strbuf.h"
>  #include "url.h"
> +#include "worktree.h"
>
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -507,50 +508,60 @@ static int validate_and_set_submodule_gitdir(struct=
 strbuf *gitdir_path,
>
>  static void create_default_gitdir_config(const char *submodule_name)
>  {
> +       struct worktree *wt =3D get_current_worktree(the_repository);
> +       const char *modules_dir;
> +       struct strbuf tmp =3D STRBUF_INIT;
>         struct strbuf gitdir_path =3D STRBUF_INIT;
>         struct git_hash_ctx ctx;
>         char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
>         unsigned char raw_name_hash[GIT_MAX_RAWSZ];
>         int header_len;
>
> -       /* Case 1: try the plain module name */
> -       repo_git_path_append(the_repository, &gitdir_path, "modules/%s", =
submodule_name);
> -       if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_na=
me)) {
> -               strbuf_release(&gitdir_path);
> -               return;
> +       modules_dir =3D worktree_git_path(wt, "modules/");
> +       if (is_absolute_path(modules_dir)) {
> +               modules_dir =3D relative_path(modules_dir, wt->path, &tmp=
);
>         }

I noticed that worktree_git_path() returns a pointer to a static buffer man=
aged
by get_pathname(). I'll copy the result into tmp immediately, before callin=
g
other functions that might overwrite the buffer:

    modules_dir =3D worktree_git_path(wt, "modules/");
    if (is_absolute_path(modules_dir))
        relative_path(modules_dir, wt->path, &tmp);
    else
        strbuf_addstr(&tmp, modules_dir);
    modules_dir =3D tmp.buf;

Thanks,
--=20
Yoichi NAKAYAMA
