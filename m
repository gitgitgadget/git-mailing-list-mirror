Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF441D63F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931637; cv=pass; b=Er/QCN4WzZN2mQUfqWjchThv5dMXoNgXE0zy37Gih0SFJGG6tQwhyFKXDk/u4RfD3kBStGoXOjI+0ScwZ6D9ePwHqqToriFqhgNsyIG2Tv7WBwXnqF85CIXiFoeVz7bYWxAGY7iyGKb17GAoSAs4x2XXw+S2ap1+mlVX4eww0C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931637; c=relaxed/simple;
	bh=brqDeEfBdSqByZWKKrbL9MPOF5hDatvRrs2HrlaxmpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deIG3onE32WAESgRNXkodzV/wPUaoM+dbvt3UwYr/PPVmpXa+iMDjslCt0JqalYmMDVOuu2xgUqur6uxtFJyWAWXtNAdMrqfzdxFCFuwxkT1n3jFSu/iltT37bexc3URl4FYrpOShiH3HW40q8A/cnZ4zpQfC9zSD/bwlOO/iOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXSeqdC7; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXSeqdC7"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so5449938c88.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 02:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790931635; cv=none;
        d=google.com; s=arc-20260327;
        b=UYZJ9l+CqcG/RFFuwO3VCyBOlYo8KMjvtGx/DGurWl2ovu1BE0I6BlsamifjLjbh8j
         24F8pWUkKkGGhitab/gPmlV+ocvnbdK3dDr0HSBjdnP29GOwKdEFpw/4EFEkdmRogAB7
         1D/Xg00GJRx1ag0q8RZpppVqa4C4eg4qyB7ug0st2Q3+rSfv+MQp4lWMaRQNK+QLsS0v
         ucy/YtsazsAX2Bt2C/ZqxL32H4N9G+fg6JznVx7afMJFOHVczOAbk1awAKDMq1d7Ycoe
         dGtIaH7+6TEHiWTnRUNddpjJaw9Zap5Qupefa9yY2N2dxy/cJ60scga5JFIQthIkEndu
         XcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ch4GLso+XeX2SCOSycRa7do860NmISKn4G+lm3vGp0=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=b9bBh748Vm1fYXeD3IipE8fCbrQI3KZyqeUTxpnYxRDp9m69vpTHGPjEHgQNtoquT1
         wSqiWqELyv4umhGBh+4erl9HvGuBdCPwdV9PrwXxYu/y0vwkzCcnAUDMdlr4pDOsOC9C
         ratMD+ryaZPlKeIXtjHfvCQYRukztKubxWtaZLA9OkiGgymrXMPaXcDh/x+dQXmxXV4r
         pU9PlsVFv88tFp+SpDvdNuQ5/AHMHyIzapdtVP0iZV/LWcXYWTJH1ArgSirVW91ZHTA8
         FRW0phLp1JGkAbzu22gd58Ih6/6bUYNAQ7E0W57gIgxrF5bOpiS4yCs+AMLF7ObIu/RX
         PMNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790931635; x=1791536435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ch4GLso+XeX2SCOSycRa7do860NmISKn4G+lm3vGp0=;
        b=fXSeqdC74igU05l2k4fojcYaGlyJG5/1Q23RWS4S7JoAePyg9aQawvT68FB0KGiDUP
         ftBpxky6PHqLGXgxQ38X5Q+mFidnELM8LSCgYUwODzWJBuMiopbp7BCEujr5LYm8QZ4V
         YD6up1f3eZgg6vJVamTXm4ml3iqGD7MbTRV5YYeyGTFZDBNfTuHUexyrWWKj0r2Ka2QG
         lgyPr5tX2vjUywTUPb3hADoVD3NLrao7mLmEs+8JfPa5UtODugFIvCjgoFgxfTI8uKr/
         BY5fDyx2ltRl7p8xPKLZBLZnyR9Orh8lR5/Mi9rrYrZo7m+PCa1AYK9pJTuOr8ELM5/b
         7EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931635; x=1791536435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ch4GLso+XeX2SCOSycRa7do860NmISKn4G+lm3vGp0=;
        b=MMZVDoOkzfTQuMPepUF/2SobKKiradOokiAV/0o95A0TNt12Q6dM0dB38gSwTT/HnP
         NVGaQGF9txBPyZY5H4QzBoZCP4syPz3FsAlX7wUGWZvIiLkmIsRIa3mwit468pt4GM4t
         xY9p6jM+vum57coWuZLP5yB/ZYdCOx6omjmKL8uROWkTr/9ZaTtm8rgZQsuDMNWwc3Gj
         +jFqhdQ2NDQRD9YmRTMN8veC2CJOcvI3pyXYIzwF38yCJ+bkTIpGjKqcTG+5zOLoqiIN
         KqWFTfaQ/W7E6CrU2pDlskb2uMFBddmn0wb7E4jZu2YSk4CvfkDO7NeA8rTKswoqPgIb
         2srQ==
X-Gm-Message-State: AFuF++k/nx9rjSA8w0x3o3Nh0r4ODluWT45msbhdxWhvgPo0NsR0bjj3
	JAIsMSkTwcNVfYySf9TeyuCQ/MevW6/Vf/Jmf1fyWqXByGhblomzjq5xag92SYPB//7295CnvB8
	Aeg02LLyKsV51WkFKzeJ1vjjICBauXoQ=
X-Gm-Gg: AYBFou0dJ2ikk/3RG0cs/G8mxjPa9wZIegzO9+HJ63Pq5TESMw6Vja5i1a5FVEOebtx
	BEJ+K2I0lSIHyw0V9AsIdMxfx3dF+8T0kuOhoDSbcCHRw8t2sTguRgRxISvwaLtMqvIzZ2tn2O0
	bHpkzt59acSudr67DfGM19PKaxfIYFgz7Zs7VkQV+A6FXIa7+T3eKIuQG/Z/GAH9uMhLmllLlZB
	AU5BtyDAqFrvyp6f9gZpDfkhPsekzIlq8ROI04gXp7vzOh1Apptbtz3sKcW5q1YP1Pzj3tjTIDr
	3OgLWgctrkqfUdrglEK6nj4MNmhemNqWNbPOrCFpLLaCZk/vZiqT5LpD8bvytxpA/rjioMglXy/
	57+b9/VEAYg9WajJy+6+u1Ip45yKyAXGqYjq+JskQCAJJINfWtIqvBCV/H07ISc1KXaAyVMVdYu
	bToVO//ky6/2cHF/8ZnrGEKwP+GFwHMMD3MsieEzzNG3Qoxuubsg==
X-Received: by 2002:a05:7022:7e0c:b0:150:3c69:2adb with SMTP id
 a92af1059eb24-1503c692d2bmr711702c88.2.1790931634901; Fri, 02 Oct 2026
 02:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com> <20260928133846.2094261-3-christian.couder@gmail.com>
 <xmqqy0ckgea3.fsf@gitster.g>
In-Reply-To: <xmqqy0ckgea3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Oct 2026 11:00:22 +0200
X-Gm-Features: AclHuK_wqML-NrKLoJoIwfVPQZAcQTlcFZwl4zMT1scTWmPyzr8aXdEugmw6pPg
Message-ID: <CAP8UFD2OFRv1-MXVK3mR+_hMAmXvH1Y=f7j8zhMHo3wkbcK32w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] setup: extract path_allowlist_apply()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +     /*
> > +      * A .gitconfig in $HOME may be shared across different
> > +      * machines and the config variable entries may or may not
> > +      * exist as paths on all of these machines.  In other words,
> > +      * it is not a warning worthy event when there is no such path
> > +      * on this machine---the entry may be useful elsewhere.
> > +      */
>
> This might be a minor point (as not many people may be using the
> safe.directory feature that this was moved from), and this dates
> back two years, starting with dc0edbb01c (safe.directory: normalize
> the configured path, 2024-07-30), but the above design decision cuts
> both ways.  If you misspelled a pathname, you would never be told
> about it.
>
> I wonder if we want to allow users to explicitly mark that it is OK if
> a path does not exist, in much the same way that a pathname-typed
> configuration variable can be prefixed with :(optional) to tell the
> system "if this path exists on the system, use it, but if not, instead
> of warning, pretend that you did not see this specified".
>
> That way, a user can first specify the value normally, and then when
> they reuse the .gitconfig file somewhere else that does not have the
> path, they see a warning message.  You would help them by giving a
> hint, e.g.,
>
>     Specified path foo/bar does not exist.  If you spelled the
>     pathname correctly, and the path is allowed to be missing,
>     mark it as optional, i.e., ":(optional)foo/bar".
>
> or something along those lines in the warning message and the world
> would be a much better place.
>
> In any case, it is outside the scope of this series, beyond leaving
> a NEEDSWORK comment here, and/or a #leftoverbits comment in the
> review.

There is the following new NEEDSWORK comment in the v5 I just sent:

+        * NEEDSWORK: this also silently ignores misspelled paths. We
+        * may want to warn about a missing path unless it is marked
+        * as allowed to be missing, e.g., with an ":(optional)"
+        * prefix like pathname-typed configuration values, and hint
+        * about that prefix in the warning.

Thanks.
