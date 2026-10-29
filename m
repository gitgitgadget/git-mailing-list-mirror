Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293067;
	b=j56fVlXRoDxdCRYAzBLd4u2WUF8qItedpWkiRZhXN/apnI2+om2Se38Wr2G4/sA0d1gB
	 rUVLTIXDqDbvKuWE+qCFMThyKquC1Gyd7rgDmqjkxaRTvUBuDBzEOXhAyQwhn8xyVWbUd
	 XWReX2XlPbBCzK+nhVgBAoRay0vbTFwal7qpGmkJOs0E/0c1mlFD4LNtvxaztirtwVFIo
	 ADKa6CRlSYWtAtuwT4J1NJPykOpz88vZXGN8VMOPqu3pweMpxOwNgOtNYDWJxo3DLNkyO
	 5eZXKAIMn0eyrzFfyeOj2JcOHkAGV1KuA1QTH60XrBVqjhEoJjxRwFB1ckw/NADdg4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=S+1Rm7VKd2VrOJqKjNfCb86V8+7z//PMwDCKYjjyWjs=;
	b=x0G5mVmQFTJOQ9HagvilouSnQDp8t9x2OT55MGAFSq30nidw4IlcjyOkVRpyQp/x9M+d
	 VID+nOmWp0BqFTdzwuA9rAMn8wcJGRrlAxw7Tm3rOAjPVwTOCwOsW88kz/jjfOO4dMq9q
	 IhVTCsT0dD5Y45C0Ps7Hx+wZoZ6rh+chIVzRDsYPUTKRxyopLEhfFeO1CJE1tRpuFwvKG
	 66epqXGr1zKBZ8muS1iTSQSOdWaHPRBSMQemTgwww1kh4pclVmTHOeV7HebOofO+74wLb
	 FiT6VF6PiLGK74ucObIRfhLzJd2maZvW3ctt6UeA6b8Qg1MHIquq6gT9HoI3CWBwoZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JjZC3T5K;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B260A260D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E75B260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JjZC3T5K
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a85c656c58so1661756fac.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293066; x=1793897866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S+1Rm7VKd2VrOJqKjNfCb86V8+7z//PMwDCKYjjyWjs=;
        b=JjZC3T5KrGBCOtTR5p7HbnXD7E2nFXjBeue1x88+YNA776YYkCfc/sr3ZiQxuTBtVm
         49toGRrKUXzGRlb+4Xp+w61OHd0xXWGf7DinnrZcB6CQkzVnpLKKo0XccVGlUGfSpiGl
         K6x1MGnXEv7Ke/ktdGypTRGn4ZftWwIiA1Wc2+UA+QpenKLGxnDCpec+nQJj5S7nqbil
         Nt8EXpF7IZPFo1zi82DhUygtcQczSHE06vETAc2ZAVvCYjSoLO8HKnJNTphwHTP8NL0f
         zJQTROqK5xtMUH1x4I3cS9C7oSRHmsxhNHDc9kLZJJM6krQ/3bevShKk9bCOuPmbkHLs
         hrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293066; x=1793897866;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+1Rm7VKd2VrOJqKjNfCb86V8+7z//PMwDCKYjjyWjs=;
        b=wMLI8jj+uVnMGg2TuDlK5zqBbXk2WMweASwavFjsVsBOIPUO414gMtxltPPJebypv7
         0rHjOSGWoUk0T8w1/Rnbmazyi+zKwTYrhaFr4r5PidlZ3DycyWFhGSZ26S0/f6r6YBD9
         FXDqHAzBsNsgnrU36SKp5U8VDs9141xnThRNchxamEAEsApgk7AJZHJd618EnudFbjWM
         V9VRlTdDHPKQHYa0KeD4hx1m8RIBTpMJejPxMccU6TENsABQ2KR+GZZz9SGZ1sVZiDzw
         wTLGN06gWjRU+LfhWGKoKU0kVXT4bVcK29E3KXo8Of3Ej314PWbIN1k05MK8Phbq4EBO
         clpA==
X-Gm-Message-State: AFq9FYJFTQUcF6CQbwcFwtJQn3F5CW61KsMJaWCeYgVPCqEQsmtFA4ds
	IOHDRR/Lhy0rTMZAMncduTMgnC+AzRPlDZD7BSwfODOxv0AmAs+P/GdKnQHjsA==
X-Gm-Gg: AYBFou0JDxnkjz/N9Qj3Ty1INb6v6s4mPw0CMV8UnIUMfRJRE1/5B8LbaqN0EzaOczn
	eyntI5o/KBc75P0TeNUQYxVBeTHH1bTqXRxR/7l/cQBxRrot/STSYlnL9MRVaGWEX+ljSHQ8zJf
	U6iEQngg5XId87RyU78kUfepuPGdgLfj/jM5Q8JJgX07fF2v6aPs08N+PNtOTVdu3wqOhiTXYkl
	9u9gLWjKTDFEWxhaQtnbeuQrSNeE4jSXdxLwXuzkGjudQW9CAabdBpTi2++AMLxckwszeyVq+S1
	MVTEmXMx//fEaGVRUxrQJCZ4i13ErbxdYJFmQ56F9niRwP8dGsXa68wTk7XMs/xEHvZEgzrp6i2
	Vv6sL7Zd9hku/yD9X1rxD2BVKz2sCU2guRT5q49ipxtTv5XbtssDTY1LgNKuNb5CbeEga9cDMYo
	zYY06d05wipL3etr6jgYxUxGngXiSUQu3Ms6vCTEH0zVRI+CDBcDFNSAhuI1TGKnOy0t504Zc/z
	4ZSN5gbIICRZocvBW38R2eLVyYi5bI+NriqEdvXTA9hwW1By6gyI8b4uHAVq+NpF/oh8IkRvQVv
	/LA6RfDCBoygSMUen2QsYlcs2R1o68FQ1K7L929y6T0UveC2stSLgw==
X-Received: by 2002:a05:6870:3508:b0:494:7435:ebd4 with SMTP id 586e51a60fabf-4a8bb52d7e8mr4944269fac.34.1793293065616;
        Thu, 29 Oct 2026 09:57:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a901fe4b34sm320941fac.6.2026.10.29.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:45 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:57:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the
 quarantine
Message-ID: <auNvMUNxmeJe31Bq@denethor>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>

On 26/10/28 03:18PM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Since 722ff7f876 (receive-pack: quarantine objects until pre-receive
> accepts, 2016-10-03), receive-pack writes incoming objects to a
> temporary object directory. Child processes see it as their primary
> object directory, and tmp-objdir passes the repository's own object
> directory to them via GIT_ALTERNATE_OBJECT_DIRECTORIES.
> 
> The connectivity check passes --alternate-refs to rev-list since
> 39b44ba771 (check_everything_connected: assume alternate ref tips are
> valid, 2019-07-01). Inside the quarantine, the repository's own object
> directory is one of the alternates, so --alternate-refs runs
> for-each-ref on the repository itself and lists all of its refs.

That is quite interesting. So IIUC, because the "real" ODB is an
alternate, all the references from the main repository are marked as
uninteresting even though they have already been processed. For the
connectivity check performed by git-receive-pack(1), there isn't any
reason to consider "alternate refs" from the "real" ODB that is
configured as an alternate.

> That includes hidden refs. bcec6780b2 (receive-pack: only use visible
> refs for connectivity check, 2022-11-17) added --exclude-hidden=receive
> to the check so that repositories with many hidden refs do not have to
> load all of them on each push. The hidden refs are excluded from --all,
> but they all come back through --alternate-refs.

So we effectively consider all the references a second time, but always
all of them including the previously excluded hidden refs. Yikes.

> Skip an alternate whose repository is our own when listing alternate
> refs. This is done by comparing paths, which is a hack: it is mainly
> here to measure the cost of the bug, and a proper fix would have the
> quarantine tell its children which directory is ours. It is safe,
> though: alternate refs only serve as negative tips that are assumed to
> be complete, so dropping some can only make the traversal walk further,
> never make it accept a missing object.

This indeed sounds like a bit of a hack. To me the underlying issue here
is that downstream git processes don't really have any concept of an ODB
transaction. We rely on the git alternates mechanism and overriding the
primary object directory to get the unaware child processes to behave
how we want. This typically means setting the quarantine directory as
the main object directory and the "real" object directory as an
alternate via environment variables. That way any writes that are
performed by a child process are written to the quarantine.

For the connectivity check though, we don't really expect
git-rev-list(1) to write any objects. Consequently, I don't think we
neccessary need to set the quarantine directory as the primary object
directory here. That would avoid git-rev-list(1) processing the "real"
object directory references a second time.

[snip]
>     I also tried resolving the object directories that --alternate-refs uses
>     before the quarantine is created. That got a bit messy: it needed a new
>     internal rev-list option, and receive-pack had to carry the list of
>     directories through to each of its connectivity checks. And it only
>     fixes the check itself; other processes running inside the quarantine,
>     like pre-receive hooks, would still see the repository as its own
>     alternate.

For the connectivity check performed via git-rev-list(1) it certainly
matters, but I do wonder though for other processes if this really
changes anything for them in practice. It could potentially be nice if
there was a mechanism to more explicitly propagate a pending transaction
accross process boundaries, but I'm not sure there are many usecases for
that at present.

>     So the question is really where this should be fixed: is there a better
>     way for processes running inside the quarantine to tell the repository's
>     own object directory apart from real alternates?

Building off of my previous thoughts, maybe it would make sense to make
the connectivity check a more explicit part of the ODB transaction
interface? Maybe for the "files" backend we could introduce a
`odb_transaction_files_check_connected()` callback that configures
git-rev-list(1) with the appropriate environment to validate the
quarantined objects and not cause this bug? Happy to explore this path
further if it seems reasonable.

-Justin
