Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792508944;
	b=fAsW8DIvPCUaEKD3350nZneLH0YpwbrqcYrJgcCbvvnd7u7z+yPG4QsfD9LubnWziv1Y
	 FUbu1s/+q7tIie9osBHixpU5rr5U1OZRYWPyRSd3w7s0ov3jo+YDtnmpLerg3SF6PoRcL
	 3VtgERn2WyuuhQrgy8+I+J7sPToXPK1EMhN8xcPP8TQLQ2MFFpd4xoG6HFfz7WblXRoAp
	 6yPlMG+Hbjtlq81uPDUgcZomiKA/yaZVj59n4qUBgI7+tIsnvINc0ZcI5iSWSs3f2zJgK
	 Xrd4OQZvIe1W2y/w3eLCc4IBnZ64GDrrMOk4c2n0f9MVQ0A3uS8Aeg8BjUxtqBZGEFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5XAdaylaVtZxLnOLnbf29eVFghnIc7Gz4uWxReNl69M=;
	b=gpMoi0ro1YYPzmjhmpaBfc2DyrMI0z7DqSyQmN8gBUFo+8+vLoZRBVhQLIlmR5pP7Cet
	 UEUgpI0HYInw+UoNUZ+aRooxDYt00io9ysX7P9TyPcZvB2uQVkGg+e3YDDHe88q3xyTyh
	 0mzTe8pjq9ZwvK1XO41zzGaaQVgoqhSzTqjz2C5r6ggqO+NhX5WHo64eLq2vXzv0Mjqrj
	 u0vjvNR5ZFk7eOwQ9ndgmyy5nLbSDt++W2JuIsHgOl5pXZ/Vlh1arxezpkcqcoh8T7pa2
	 Hg7QSE9n7qCVKxF+wrDhXlJjHjz+rY9HxrNtAM9voBveEPhnTkuopFShmi8SWrHyB5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+6FgKVn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80233606A325
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80233606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+6FgKVn
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e56efa2e9so51551985a.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792508943; cv=none;
        d=google.com; s=arc-20260327;
        b=Qdnf074sVL3qQSvQwhDf0jIu2VfTouEWBdZOdR9x2u6FW6O7CVlef/TpjPoAQ/ACtV
         Q+O3EsVBZX3t6kdNPz2gDGVaTqR8ATSv0kHRQCa6/hgKKfV8IJ3efzbEamBV+lG4+3nB
         dYwmk1JjiYtthAOh7Hj06OEbqXCsxzXfNYIb5W8c8BJZCXgTzGtJBUVf6deotjQmhTdp
         UBgCHcCSArw+jCEULFetEg7VXfbOIqNa4FyEAf4Sc14oGht6PPIbG48OTbBwANIa0Wll
         riBlmzcw6JPeI42E+Ubv4iAvTmQabPtH93tOEY2b4gp5duFvEloX6i0vaW9GXg7LP6Gj
         3arA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5XAdaylaVtZxLnOLnbf29eVFghnIc7Gz4uWxReNl69M=;
        fh=o5l0Eu0aYVhYLNaknXG9Bd9QW+Oip/V1pdMxWtUugbA=;
        b=hrpIKD8YhVblkeoQeKaf1PIcJppy8iE9wuhJzvP7zLsaUgZldqQuNiiQ25ixJ4wpL5
         7hFLkJPxcYaymlGfnrnttsIOetwVjUtONC52ZOcjE6cv0G4HSDUIS5vk8DcvAH3zafPt
         oTeEhv4xYAiox9nl0Pl72IttqxNjFuQIyP4Sju64KF1GJ+1xDH1zhjFnlkSytej1qDPg
         rhig9FVLkWqnUA+JWJMUeg2IJXVRW9uLpu/WGJZs++wAaj/ZAWH+PdSjhJ5HgBKqjb+w
         BH5kPJPYbFmUKmMcjWxlONaa7jtiU7DuCFl1dW/C3Hro5xUHt7a6/1nXT+GP0UFp4ey9
         COOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508943; x=1793113743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5XAdaylaVtZxLnOLnbf29eVFghnIc7Gz4uWxReNl69M=;
        b=Y+6FgKVn+u+xY7xeZpkTdxhiGouffT0v/TcoZj4y9iDxYkMt0NW2nyAYkLeEa/3KQ4
         oPVh79nCQXDHeGQx/fGRmPdVIDby4nyULjPGNgbK754YfkUzfN+SNDkSyD8RARjdd07v
         veoLE6qMztoyvMeE+lsHdXytQH1mNAnUiaXhRpbDig1J3lKd/EXDUmQHIcCfuQ19AfLd
         nVvQ5KFk6a9tHF0LhutPvkCXYnTmznEMGN0lUGgEN4YavkRZFTZ85CEvxVCHfr3hOqIi
         1qnp+PnF3DzMlTdss2gxwXR+9vccBgpUfeHh6acskR/w84R2wAmrg5hzFKcSvQwhWkoo
         OeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508943; x=1793113743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5XAdaylaVtZxLnOLnbf29eVFghnIc7Gz4uWxReNl69M=;
        b=dsPumU16hwM7FVADv+D/SeOL/VUxERFeYyIEc4jUnDF3CYTU47/JSEvOFe/Cgk07Xq
         4u2hqC4HUKEanGzeKy1m6kASmil+KxTnYfPU+/IElesHNsGNI8Xhf4npFHwYxOrVM7dD
         1Wm58uvTlKvDgpk4IY//vOo71VNLl83n8IJ+0zbb99WSN2HTBbPp/7MLQ2M9Ux1JRECI
         geEeELRg94jd9+r+LhtJYngJYJqbEXpPUAxuXlJl4MB0J4DbJ+8IBt+fbnx87q6PNbu+
         sWOJusGDoLvHLaKFbJSvGS6Prh9xaBd7ato/m6HvQbUtTF5ZzYz03H+DMl5wSS/+rtXg
         6PAw==
X-Gm-Message-State: AFq9FYLxUYKTpM3E2a7tfdW4xcl6IGuYYDobgRWYrUYWWlKs1T64q9+h
	A14Z2bhqS5Ndd8JxXd8gB7+0DG1AO8f3c75jSMeJ2twHtGkd2wDW+7FAnIjxGnVNQytomOrJ0uK
	RlkAYthk6CsEORWMU5Wxrn+/KfXBeCC0=
X-Gm-Gg: AYBFou3OaFCnXJhmfDLEgjFQXZ3FsFQjONJ2JzyVAqQ4DFyl4ax+qTqs5ZV66a98RfP
	kcDUyw4Asg1FtOawu72iaXqZlKt7puRE8GP8bTs5DEj8/IfN+VnIkUIPjMBAern3Iu9OZ9IqoU+
	EesqsXoX9rVSrEcWvZgzGtDweQy0cuoa7O12YnPzkWZflpd6SL9/lJKKUhNYqnkAaczyfunupzh
	KaKmDxbx+mmhtF5/ZoRjatZQ7iKB8VHD0qPnth3XbjXGpxmd+gHhAmZredCXi9bC+CGtbLhvJuM
	xm6HBsnxsduueZ4TSJiGjCgqVuw5krIbVNYjTs3F5hNUarqjF0B+7beTEJsMg+y1
X-Received: by 2002:a05:620a:4452:b0:93a:14c:329c with SMTP id
 af79cd13be357-93f29b38f59mr2080531885a.1.1792508943339; Tue, 20 Oct 2026
 08:09:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
 <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com>
In-Reply-To: <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Wed, 21 Oct 2026 00:08:51 +0900
X-Gm-Features: AclHuK9nc0h8kj0gCao7e_T-U19nJMVA1hyBpYnS_JylA7afiLVcYJWsaKe-rtQ
Message-ID: <CAP8tz2+CQcQyTdj3YFpEaiVh=hVoK5Xo8WFxGZNMJoCCM-u=hQ@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I can see where create_branch() is called prior to setting up HEAD,
> but I'm mildly confused about the index/wt updates prior to either! It
> seems to me that should be one of the last steps, hm. Unfortunately,
> I'm having a hard time finding the responsible code outside of the
> "merge" case (which probably has a similar issue).


- merge_working_tree() updates the worktree and the index. It is called
  from switch_branches() on every branch switch, not only with -m,
  because do_merge starts at 1.
- The "merge" here is not -m. It is the 2-way merge in unpack_trees().
  -m only adds an autostash step for when that 2-way merge fails.
- The order is: update the worktree, create the ref, write the tracking
  config (which fails), then update HEAD. As you noticed, the worktree
  and index are updated before the ref and HEAD, so a failure later
  leaves those changes in place.
- As you guessed, the -m case has the same problem. I tried
  "git switch -m -c y origin/main" with the lock present (v2.56.0 plus
  my hint patch, which only changes the hint text). It stops in the same
  place. If local changes conflict, HEAD stays on main, the file is left
  conflicted, and the changes remain in the stash.
- Running the same command again in that conflicted state stops with
  "a branch named 'y' already exists". Switching to the existing branch
  y stops with "you need to resolve your current index first"
  (checkout.c:887 in v2.56.0). Neither run changes the state.

2026=E5=B9=B410=E6=9C=8820=E6=97=A5(=E7=81=AB) 22:07 D. Ben Knoble <ben.kno=
ble@gmail.com>:
>
> On Mon, Oct 19, 2026 at 9:41=E2=80=AFPM =E4=BA=95=E4=B8=8A=E5=8F=B8 <inou=
e.tsukasa.4@gmail.com> wrote:
> >
> > 5. Root cause
> > update_refs_for_switch() -> create_branch() -> setup_tracking() fails t=
o write
> > the config, and the code calls exit(1) in setup_tracking() (branch.c). =
At that
> > point the worktree and the branch have been changed, but HEAD has not. =
This
> > exit was introduced in 27852b2c53 (branch: report errors in tracking br=
anch
> > setup, 2016-02-22).
>
> I can see where create_branch() is called prior to setting up HEAD,
> but I'm mildly confused about the index/wt updates prior to either! It
> seems to me that should be one of the last steps, hm. Unfortunately,
> I'm having a hard time finding the responsible code outside of the
> "merge" case (which probably has a similar issue).
>
> --
> D. Ben Knoble
