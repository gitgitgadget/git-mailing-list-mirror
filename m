Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142733D6CF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983235; cv=pass; b=tetFsBh3LR5iB/H0TgedaTxDqA52gll7YnstYo1t6fqHGivSw9kv/VD8t4ytJCYTyZqmehHvIUrMKFpSHEzstUGZt+nYFY52EjiVamZJiMi+sqRKV/PDd3v+oa5ML8CbID/8VJO4oDskp3yMwU8p88LK9jwD8GNtCrZK9maLOhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983235; c=relaxed/simple;
	bh=3JvWNz1Mi1gvzZ0Al6C6tu0GhN4vsnnrRsKqOyTffrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEkyhAzkQDrkBdCJi5wPV+HMmQ+ts6MYr8bJ9WqnYHUdRnQHdM48p/LBRnyNNAfLkLxQn+sU7rL2AYNBgmjCGJcrDh7JzUoIv3sicLrrIECRLoUed4fZSw5Yh81E4OOp+7zrz5yc8OWqOxKNtNTsRwVYZtwCi+OPk9NJhkccNIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12337703742so34994c88.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 00:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768983233; cv=none;
        d=google.com; s=arc-20240605;
        b=kBM0OYZBPu4wdJq+3OVt2/oQantU9DaOsqY6RYeVuWhI7TpKt387jRSyVo5gL5X209
         CtBaARNY/80wmupJ/DABEN2Iku5SeE+hY/tC9vORfl1EbaV1t9+wrH1d6o5Hfbbs6SqK
         fV7UNuhCUXJB6z0JaO2ZP47utHKVDLjc3xJzZcVaFHsoh8MPB4pchRh0mGUQjCs+Owfc
         LtmUBGZneg9Us7/myH9uTlD1/UsQHS5Ns4dtA2D5Ny9POUuJqMjyG9uSyShSutC/sAXY
         IM+B4s56KiLPhaJWndOEaVsxT75mhymYwD3RkBhFOPw1vMCA7EV5UlAcLnSd1CQkpvHh
         ungw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Yov0l1xFQ3ORdpQeksbsTgQammfKIWpe8EGCudTRAbQ=;
        fh=fGUyBI4+rNIKds+mkludNnX8jk+xB13rRHITat/zaKY=;
        b=VxUKzpeB/sMiBdYQqcA1sI9eHZl7kh2Y6EbyhTeqJ+a32thr3NauIf0O7mt1kiRO5K
         2ebW4Pce7jmyDur3ib2OEht1sTvG0Vu3Z4LUFJSTxKHOWsqLY1o1ICMw9OM6WIcOJXP/
         aRgex1hlyJ4Pj5TCdMJkeQFwxItGiRESf1ovB+SWi1YYENnZDVvDSkcHHf7xKQ5H2Qh4
         zSCiv46/7Glcn58PQ0k27M204Mkhd1MIL8SrJP60ZlYN6+HMqFPva+seyhGlYEGkWZaK
         EmfnUtcclPfo4SN8fRv5+OWiQwXxjqWLafS/cadZCRuzXTSK52fZ20apir8nXJiF+ntB
         IDFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983233; x=1769588033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yov0l1xFQ3ORdpQeksbsTgQammfKIWpe8EGCudTRAbQ=;
        b=VPtV+i46QlBBNphXWlD+etRmRfT6jTvZB6Kfi3SOPMt63YvaPGuhYUcJg4Y5bwABN3
         T9uPJPTZviNGqmaqhJuv0UuiM9Ys2rVM3LGkZRYgep1Y89fnGAEII7RL+ZnaVcDZK9pt
         yOz4MXH71DHVXTKE4KpmlFNmbl342oDS/u23OuNOxMtsN6ofvN0rmRinsBbPzSO5wpFp
         ztA7uAkLNHCJ2t/yIxd1Lf1zrhTSMhZiVXzAOjy72cPfomixHKEgPV9A2+LM6bOIxOph
         J53Vk2fRenzLk0xjZDpok04u99sydK4nVqPsNFrWcESNcYFoQv+L3zvzRC62NfoKFy1U
         dhQA==
X-Forwarded-Encrypted: i=1; AJvYcCWpcxtQ6AHbFqjBEBgojP0qbMP01vQVnO0hLWlbAsorJ5uX/IYGQqiWnQo8jM94nMYTvgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYlIVn3u2/aO3kctKPkEa0u73yq7UKMmXhR1opIJa8K0BUxC1
	UQ6Dl9zcDouheJy8HN/Dtf9JLMzPo6otS/+obf3lbgW514UhgpK/TSiBWasH6DalCQp8rfks+JD
	Ym8ckRe26QtQb3nN81lZleutUv6lE+wo=
X-Gm-Gg: AZuq6aKHNDsaNpnkImiU4U/UMzhbNhGn94R+svcuYNsUSWkxBqy+ExMP34Nh6xQ6jrK
	cqIKtZVh5IARl+yxbjRwyupu9ZislbMbqgTnIYJV76BArvF7Hj+c7PMXaAiqcwsTrp/DKs6AyO8
	9dnxMmNTCvxXYXS2tDjsyKnT0v+fSkD/QnAUsk7c+hJ9lNmp2/h5cAuGnBEUUkn9jpXGeCiUjRH
	xo+lztMYvn3mUaDU0Z4jSz93ZQ2icLrO3jE8GHaDMEL2+cRAtLPnRCdskJ/1HbXdbAt/zObwA==
X-Received: by 2002:a05:7022:ea21:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-1244a76de1emr6839955c88.5.1768983233128; Wed, 21 Jan 2026
 00:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
 <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com> <20260121071344.GA570838@coredump.intra.peff.net>
In-Reply-To: <20260121071344.GA570838@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Jan 2026 03:13:41 -0500
X-Gm-Features: AZwV_QiFWIckwuEiRJx89edQYI0WHNDmFKMKiKFVEW5x9AD-5jowWglry-OQnCQ
Message-ID: <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
To: Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>, Patrick Steinhardt <ps@pks.im>, 
	Paulo Casaretto <pcasaretto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:15=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> I don't think it's wrong, but the cleanup is redundant between the "out"
> path and the others.
>
> Did you mean this:
>
> diff --git a/lockfile.c b/lockfile.c
> @@ -122,14 +122,10 @@ static struct tempfile *create_lock_pid_file(const =
char *pid_path, int mode)
>         strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
>         if (write_in_full(fd, content.buf, content.len) < 0) {
>                 warning_errno(_("could not write lock pid file '%s'"), pi=
d_path);
> -               close(fd);
> -               fd =3D -1;
>                 unlink(pid_path);
>                 goto out;
>         }
>
> -       close(fd);
> -       fd =3D -1;
>         pid_tempfile =3D register_tempfile(pid_path);
>
>  out:
>
> which would just let the close after the out label handle all cases?

Correct me if I'm wrong, but wouldn't this suggested change be
problematic on Microsoft Windows? Specifically, if I recall correctly,
Windows won't allow a file to be deleted if any processes still have
it open, and this change eliminates the call to close() preceding the
call to unlink(), so the file would still be held open when the
attempt is made to remove it.

If so, then probably better would be to drop the unreachable `if (fd
>=3D 0) close(fd)` after the `out` label.
