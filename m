Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0E70818
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775372578; cv=pass; b=dkS83+76KC75pyTsR0q68HNWfM79NGbP87n+dlstb2VHxM6ae7ufDdQKw8qgiVmEV18+HSp3b87SntYSEUh+0VuFsBmIYjhZWtM2D8JuQEPGb3dJUCDdRkYeVfgngZ8NyoKfyMIibMHP4rUqL9968HcqrbuZxV0w33Uu005BMpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775372578; c=relaxed/simple;
	bh=GpBnodRKT0R6xdm8evQyPdmH5jc+p8imEt/iZiQZJzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBwUK/FGj3MQzFbj2FG9+J2KjmczknV7ooenZkNFRYFJhMW6e2ZWvIjfzA9q4R/e0HnEE3Yf8VYleMT8QNqcut+H9SIMEc9NEaN2qupPgf0Fz2/o4zIKGgO5aC/aFZyjco30PgFQsbJz4C8egG7p7JB+V+sM48SoZQrpGxk7BAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAae/rTn; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAae/rTn"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ce102afb0aso727923eec.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 00:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775372576; cv=none;
        d=google.com; s=arc-20240605;
        b=f7WIk3C9J6e1JF12vHC6xxZZttnsq+OImDi5bwOpTc1pusdQO+KCPBCkfIFB1jj/cF
         bq4k7SPyNglhieV89ud6bawEcth/uDoYwr7gFnl3ztnTKQzKedueYBmDtyrRqvW5OjFu
         lgZMfK3ymd0zeuaXtQCFewrFSXLOnq/0b7UjmCN+eu2EezuhNsydUOGpfbeAghWP0Yf0
         M4pem88w+FcCVDiW9A60t1FDEkQ89UnwbzKxtWHVr+7audBcwkrSQ71qg6/3bEHmm0lg
         r45KM58JLRRtx5eyDwR3B5UA2QMPgNOfyZJaCHN6hQJv4oL4CvCsd6W+t9vLtWs7aeEi
         qaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pcapcvnG0q+3ZFKZhztzY+3ofuLfzdErCbByWdqpvSI=;
        fh=w+IUSAN9ukWD4a6xnFm4a4zREkhhv402ILMrJaHrR4U=;
        b=ZfSCRtKiocNEljh/dlEMJLuTVX/Kc72NZYrpejfUG58q6p6P6pnGC3rPu63TIqChSP
         5k5I6AKfFZ8Ge6UrzHSv2MMUDw7OG7io8gGwPQ69ukht2DO4A3g4VtI6JGlD/6FbE8Jr
         X5SaavHTqnWMH7I2dZpRZLXtS5l/f+bxX99CiivXdnXuihX4GWs7eV7NKv70tOCnp8RM
         Oexwt0HPGaHycjML4uunQLLrsDDWIvxmfqVgXmii+BoA7lrzxlEu8u2V/eL0HyWYbHB9
         AD8Yb89f1cqI3gXbuSu7LlGFsRpCImUODNx3xXBp8TRZ0sPq3GK9Y0b/2HQ2YELNoOPx
         g4yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775372576; x=1775977376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcapcvnG0q+3ZFKZhztzY+3ofuLfzdErCbByWdqpvSI=;
        b=eAae/rTnKLG7o4tVTqtkAvt+Dh6/WZ2xSjGUSqEi5zs6B1dS4sVAs0pAF8uwf7YWyq
         w/w7o+Oe1z5zIyuRCx/MFCX6PX2fyIwWJM6GkLq4PE4JHhdATnVPrJWXi+dEVfI1aQPX
         ws+WJVZU4d/GRaHEbB5fr1oNdfMUheBo4GasdZEuJKR+28IC0iJPGiAahDPfuV4aE1sG
         kDA0Sozm0R2WO3jIOfl6hhbtNtkiAm2x5J1xR6Nr8/84WROxdTOkxWNNfIvSpF+wODDQ
         vciGe3BJ7L7Ik35nQUBNkD3PG8ywJ+JEid54va4Tnpqzb3yAs4pkvJ3mWDigbgdFvzyT
         YqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775372576; x=1775977376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcapcvnG0q+3ZFKZhztzY+3ofuLfzdErCbByWdqpvSI=;
        b=sps/W4GuLk7QVqi0eZCxDRdfPYFYWK0sZk16l62YwLDCk8bdW0aon01fImguB+ExZ+
         j2NseMj5ASMn/04t+IjIiZN+yA/Pz9obRCQ41uAfqP78LIdnDiSdP2cSZRefnEdCqC1G
         3qxfzLqZ1Yl3ap1Z7BgZrDYJFzeKoiap9+q9FauMeztSccHneorfyQGzK9eoXhAa072s
         LvTyfNbiHZ58cvq8MVX59wk1pLm+6QttLfY4PEgLOQugDXZ1l06pRvrHoKbNk2PZ588w
         jfNA5O0OLHezQmdDC+1sZaEtMBuTpxY/oNFnkCQzGHGQ3uXe5p6+IVMpKHe+X0YkQQqP
         Hf6w==
X-Gm-Message-State: AOJu0YwdtYqHrLImNH5FORawJi0a/aK+Wlt62N6iQt/qPimUnQnhsWrl
	wjmVN8RD+GmNxqBCpg++5uIxiKL4O3A5Gd6urJJoQBaJpkG/w2lfhNlyVGpvSrzrrnBtuqIjKrX
	hn2Ry6ICIXefqj0KwI3CkUo3oy6knEWE=
X-Gm-Gg: AeBDiese8cSlDkUZXIsIsaybXn9j8jpS8aL37StSkvQbPr0gjxWv1mjrP+LTOwuHWpg
	4WOXuXGb3gc65Dlxzh00vM1/+DRtPWQhjXylMs0wxGCAXToCIObF/mIhwjzRG78q/41TJHlSkLX
	V95NhuEs015mK6SB45Y4/Lu69700PtBo5tP1uEg13B5NEnTdEEpPAlGONbMA5bBW7cQUdNyyyVa
	NRaIW5z2fTkvNZPQEFVcswlHr0tMJCZqQ4DWmL5w8RKQL9vS8f4cCtNlRvxCy/Bs5C8dOwtpYkv
	qDYBHgbum9LWm9xlEzddCNDKoqaKjfd1/w6MM+xlKTGkwCmSA2e0TWvDyn7Oa20eQoKQb0Cv/w=
	=
X-Received: by 2002:a05:7300:1348:b0:2c1:623d:d09f with SMTP id
 5a478bee46e88-2cbfba8dbf3mr3931797eec.24.1775372575870; Sun, 05 Apr 2026
 00:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260404160357.11534-1-deveshigurgaon@gmail.com> <adGfyHbIKixz4dnx@exploit>
In-Reply-To: <adGfyHbIKixz4dnx@exploit>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Sun, 5 Apr 2026 12:32:41 +0530
X-Gm-Features: AQROBzDKfRvWlzkummOqMQfVBHRAaer8Z30Z2cHB6_nPIemsKAb_dT0lRy5PqhY
Message-ID: <CAG7UgETEGxwXDGoVHT7dPXMDk70FdJd_w+TCPi1LqSvhuqWu4w@mail.gmail.com>
Subject: Re: [PATCH v2] stash: infer "push" when push-specific options are given
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, ben.knoble@gmail.com, quentin.bernet@bluewin.ch, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

> > +test_expect_success 'assume push when options imply push' '
> > +     git reset --hard &&
> > +     echo changed >file &&
> > +     git add file &&
> > +     git stash -m "implied push" file &&
> > +     git stash pop &&
> > +
> > +     git add file &&
> > +     git stash --staged file &&
> > +     git stash pop &&
> > +
> > +     git add file &&
> > +     git stash --keep-index file &&
> > +     git stash pop &&
> > +
> > +     echo untracked >untracked-file &&
> > +     git stash --include-untracked untracked-file &&
> > +     test_path_is_missing untracked-file &&
> > +     git stash pop &&
> > +     rm -f untracked-file
> > +'
> > +
>
> This leaves 'file' in the staging area. Using "git reset --hard" like
> you did at the start is probably the easiest way to clean up.
>

Understood, will use "git reset --hard" here as well.

> Apart from the testing, since the following is not true anymore...
>
>   For quickly making a snapshot, you can omit "push".  In this mode,
>   non-option arguments are not allowed to prevent a misspelled
>   subcommand from making an unwanted stash entry.  The two exceptions to
>   this are `stash -p` which acts as alias for `stash push -p` and
>   pathspec elements, which are allowed after a double hyphen `--` for
>   disambiguation.
>
> ...you should probably change the documentation for "git push" as well.

Yes, I will update the documentation as well and send a v3 shortly.
