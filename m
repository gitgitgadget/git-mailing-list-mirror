Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794421635;
	b=5qou+2+SccjS/5u1+7UEjCUtmn9DHtgFE0nGw5pXhd4dZjA3HYgmMx6vn2uYgrdWYQla
	 lrs/aX+95W2UFoVOQzUVIY5GD5lMm9qsTT5OTBoM1v17qDf54W63E75fk7tViBgq45Iir
	 AXclt4eaxXJr2/7inYZLY7spWvFUDMAvE8xdGXM3ErHloSvC4aoZGZoHr92XNXl3isQsw
	 sITVMKefn1+FnFt+rR67J5nSq51rBBuykBB/zLhLsfYjvHqI7296upt2hEu3X4HCxZOHZ
	 /LPhC2dBtkI3xzLaxSzcZ0IbJET1rMaa2RTUh0bfYWKGbLaeqT0kbWA+xN2l2CuT2BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PmZlJjAyG2FovisMQp99b7SxhJzMi9jLhMVSzkTFklw=;
	b=NLvWiLQZV+hSyyokNNe4euXQE9DklgVm/y1dbmGH+RQacfrBRM4ezShb0RxigM19Z3Q6
	 Aj65g75PzNodzikGf85zPXTjF7aEjegzzi4J6G23aov2L0Z0uXTbxWyD1etJVcJQ64FEh
	 /f+8F5yUaC1IeYFC9Lzl8SuoAan/QZ+uUEWhl3g3UwXXaIPnHniMEA6RVs1EucY/iHWNm
	 NZFH4yiRYlaK2KsFihE4s86q5qrljBbt6nlZeZIJpjTiLifSudpdgvqE3QcTs95c5+yBd
	 I1tV7wlY740bamDjxokrAnVc6rt3qqEdBjYNcmtW4Tl3EaR6j07xMwYw7JnD9OQYSGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdOvKhg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5716606A332
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 18:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5716606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdOvKhg3
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so3019040b3a.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794421634; cv=none;
        d=google.com; s=arc-20260327;
        b=GuO6a6epXbwV77BlEEIK+5Vrt+Eg9sZCtIqBiBuREBGK7BuR8u3g7sro8UxniRqtqb
         464wwhBBK2M2uzpzs6hwvcMqPeANEVCu/FqAEUgLIXvB462pecjbMp5jDUwYVYA8kyYO
         OxXoPk4X7KPUmHwxysAswKJpeghw5JHGZd2FXID0zERPYLAuDLNU2jNdj7foT5/Rrmw2
         u5iGjL6venyz1DPUxGkjXgkRiTT8XSCDSEi3/RDhUvIU0id2q8X05p/r6qpvOyvi5Hi2
         urwdmmpGNDF9Ytnb02hSfQvq955eB32qAwBUV5kF9Zi5GQ8EwZe+KsQW5qdGc5qy8bsE
         0TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmZlJjAyG2FovisMQp99b7SxhJzMi9jLhMVSzkTFklw=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=eiMZv1d7EYInNZCsBqOUqF7WZanvFW9dwhCABCw1PczVhGX0UqQqFJCmOxJnelvnxV
         AiZX8vk3KmJ+MFX5lXIhYNRD946N63YgYML/HFz//07ypHO7j6CEsCkYnLDtzJIBqqUB
         4DD5qiMABjIeG2gzFJ3gDqdHe7Ove5YZUY56jU2uyWcitVFeuO4E6CliAAeHMGSnO6kd
         q8VKl9t6svcvzB4YjTnl+81URxeGYuIt2cARmTMt1ZiSI+sGT5/QA+vvnh2He1lPWOWs
         3Hv/ZHDRNlLxthtx5eUKGt/O1klnSDzM7bt1sXScIBAg6jrzcMBzgPuYKoO43iG9UBIU
         W43Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794421634; x=1795026434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmZlJjAyG2FovisMQp99b7SxhJzMi9jLhMVSzkTFklw=;
        b=QdOvKhg3wEu/wYxImvWVlsHxNt7CMPaSxsDuvGtgTCuVtg2PAzLWm5iZLeZerlhjn6
         5xZN6sAGU2qTiLc/kNSh0N5lY6TjMQHtGUC65iRWtfalVHPTjo//MEuIcRqWgYWo+eJc
         jZMaks1IlKQfe7nC8rBQ0dyJbAOHhy0MQtP4iGE1RoJOhVNxX2RNRM64lO8ieouaNxq5
         pNthS8gOup68m1wtxtLCqOCb/9eGwzYOTMHzkCZiL6SjQUlMFn8kqzQyOhGuAqljs/4t
         eZP1VOGb5ttm3+iiipdvnHYR0F4eqPWH2fgBZXS5up+VAL5RCpFe0P8cvhWTGav+L1YY
         MikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421634; x=1795026434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmZlJjAyG2FovisMQp99b7SxhJzMi9jLhMVSzkTFklw=;
        b=mhe9vTFU8gmeu4+h5uzAxjA6ZU28waxDsyaPfC0EJjpuR3FejMwAUUwnWGKFONgwO1
         KEbEMqzbp58lzA5ct4QUL5U2bZ8DCvGvXy8iNLFj0eFvetvaokPjIDoAG4FQ7/moUd13
         fql2MRl0C+fyx4KEJrNKqOre1Vtp+dqeQDjPXdi5e6E8dtXnKgj5oKww+yyBuyBPvGti
         19pBVFq1Ga4TpEVZxjG6VZXwM99TWpEeGO5vVHPkDwS+0Fq4uYT2KvtRsHp6keDmvgFJ
         45YMHGbwLlGjeYo+OtJ3UenuvDjIZ653R1FO0o1K1361KlfJpPn3eLITZgR6RtIqMRGQ
         DwFw==
X-Gm-Message-State: APuU4Z80mbxBjh7nb3F2jmHM/ZsumtnyrB9gEWE8/vNgTMJzbiaSd6tA
	SNmKGYlzbYJMNf4LM7z+F7NdV7VQSrPDZUh2D2VxzErctEDfb3poCe6JFUOvtd7Cz5OMTWq4I+C
	6/1mBocNZxZ5Rz5G9gDh59zhJJOzrJw8=
X-Gm-Gg: AYBFou0w8ncjDfTIX5czUo0o80oT8yYo8Wyk2jji2bxflVf84Y4T0ClZ8z5zk8ShUqC
	Nf85l5AdQuOyAPnw/T+24/yv1SY2+5T5G5wmX3O0Yk7D888LPx9L62mEdQ5rj4aydJtGlxJ8Vyi
	tpvQwKFtDwmpkZqLgU98eeaYhdcgEfl/IsoG1YUuqDngMkCGwCWV1SzYIOOnxNQ4/rxJWmW42Dp
	4oY41JlvE4yglMZga+ZOFywPsj3wDc/aJjGtE4bfs6slkdmTeK0y3+ohAPJVbfNmJFumN5fldrc
	VPzb3SwNa6lH9m36CMdQ7StHhJPQGMfmxHrzvAK6lTBtqcG2rL9d0L0YmluGyoo+ihbAkqzIg4d
	zeGMAd9SKJBk64B8+BQlsNc9woAC+tQfETsRc2EURF7Gfu7OtrTMH3Ap+aBV83VCsRFmaaKQ2Ut
	mb5bW9QnZSItYEf8sYqr2P39Hx3BnriU1x/j78brkROLPR/Dpg/88k688fOysGcBaXFrE5PNvBA
	TW28n5Po8OfM+Na3qV5xAmPgLBECi24Lm1r
X-Received: by 2002:a05:6a20:9e96:b0:3dd:85aa:452e with SMTP id
 adf61e73a8af0-3f2fe0a350fmr3409296637.32.1794421634025; Wed, 11 Nov 2026
 10:27:14 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com> <25eec8d9676d4adf82570616ca88a2b38d20afa4.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <25eec8d9676d4adf82570616ca88a2b38d20afa4.1793357550.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 11 Nov 2026 13:27:02 -0500
X-Gm-Features: AclHuK-ZWr-Zh6-oLVACewnzYwY4k1a0u7KF-MMOKnNRTP90akct5Mmwvgsb1MM
Message-ID: <CALnO6CB+AP=osF8mjkGGHWZz8YX322UoSjE6DCfYZkZ0rXxVcg@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] remote: resolve @{push} through remote.<name>.fetchRefmap
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On Fri, Oct 30, 2026 at 6:52=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A branch pushed to a remote set up with "git remote add
> --limited-fetch" has no remote.<name>.fetch entry to map it
> through, so @{push} cannot tell where it landed and fails with
> "has no local tracking branch".

I don't have the rest of the series paged in right now (esp. patches 4
& 5 which deal with --limited-fetch), so forgive me if this comes from
ignorance.

Wouldn't the same problem happen if we applied the first 3 patches,
then setup a repository's remote with a fetchRefmap and limited (or
none) default fetch?  If so, that almost makes this seem like a bugfix
for an earlier patch, and perhaps it belongs together? It also would
then be better justified in those terms, I think.

Such a reorganization would maybe let the early part of the series be
mostly about fetchRefmap (which I'm keen on) and let the end be about
--limited-fetch, which seems nice but I don't have a strong motivation
to review right now (personally---it's just limited time to spend!).

> Give tracking_for_push_dest() the same fallback to
> remote.<name>.fetchRefmap that get_ref_map() uses on the fetch
> side, so a --limited-fetch remote supports @{push} resolution
> the same way any other remote does.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  remote.c                  |  2 ++
>  t/t1514-rev-parse-push.sh | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 15cd96aa8e..ecd104766c 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2018,6 +2018,8 @@ static char *tracking_for_push_dest(struct reposito=
ry *repo,
>
>         remote =3D repo_remote_for_push_tracking(repo, remote);
>         ret =3D apply_refspecs(&remote->fetch, refname);
> +       if (!ret)
> +               ret =3D apply_refspecs(&remote->refmap, refname);

Ok, if we don't find the information in the fetch spec, we fallback to
the refmap. That also means the former overrides the latter in case
both are configured.

Does that match what a fetch does if both are configured and overlap?
(I'm not sure, as I can't recall what we decided the fetching behavior
is!)

>         if (!ret)
>                 return error_buf(err,
>                                  _("push destination '%s' on remote '%s' =
has no local tracking branch"),
> diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
> index 5a4f16867a..bcf00107f5 100755
> --- a/t/t1514-rev-parse-push.sh
> +++ b/t/t1514-rev-parse-push.sh
> @@ -80,4 +80,23 @@ test_expect_success 'resolving @{push} fails with a de=
tached HEAD' '
>         test_must_fail git rev-parse @{push}
>  '
>
> +test_expect_success '@{push} resolves after pushing to a --limited-fetch=
 remote' '
> +       test_when_finished "rm -fr upstream fork downstream" &&
> +       git init -b main upstream &&
> +       test_commit -C upstream base &&
> +       git init --bare fork &&
> +       git clone --sparse upstream downstream &&
> +       (
> +               cd downstream &&
> +               git remote add --limited-fetch fork ../fork &&
> +               git config push.default current &&
> +               git config remote.pushDefault fork &&
> +               git checkout -b topic main &&
> +               test_commit on-topic &&
> +               git push &&
> +               resolve topic@{push} refs/remotes/fork/topic &&
> +               test_cmp_rev topic topic@{push}
> +       )
> +'
> +

If you take my suggestion to make this change with the early parts of
the series, the test would probably need to be in terms of fetchRefmap
instead of --limited-fetch, as well. That might be one reason to
consider leaving it at the end, but=E2=80=A6 really the "problem" is the
interaction of the earlier feature more than --limited-fetch, right?

HTH,

--=20
D. Ben Knoble
