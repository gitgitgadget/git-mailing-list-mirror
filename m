Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A143340273
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962288; cv=pass; b=DAehXBgIFK9UTmbFajeAmE3iOobxNisP+p6icJh4uOc1YOb9v0lUP++HJM1v9nhDYmnj2EjvS7SxWtVCDbVnWMyDCYm553P0t0+hQksoLci5X7XzIZLvlxm6myv3nYWQCaM+QEkFV/i59X4IQUum/tjRoxdv1p4vUCoLYzifV3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962288; c=relaxed/simple;
	bh=DKx35KGSMPV1O5hL7eRpZkE01otOHT+tSoXnCYem/9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onZi4zZP4SWsqI3qHvUsCsvtKm6eAdwKx5B6NjH4qjIudnXS0yP+OmTtOcdsIayE4rbTQn8Uu/ohUcmUZh2A8xx9VLbspaI/QoKvYDHQaHmSIdUiSAGUUS4JF+HRkxRMpz2sRYm+QEBUYQoub6ucYwB+RxklMYuqAmmKKfeT44E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN6tlGrY; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN6tlGrY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c565476d7so933714c88.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776962286; cv=none;
        d=google.com; s=arc-20240605;
        b=IWs/FUDoT0LLlWA9NyrIETKSOjLPFfZkq/pQri8+23zFCr6bkUj52e+XQcUkgGeSG9
         mN2uB9Sd208ZRPEaxpJL812RmfDJVa3zdw0CcRj5qoBtv+XFkUAIKJNymNTOnASMWLIi
         qOGMRnu5dt5WiK+llH860lyBlhNi/G99jkI9ZtRr0U6t99Nch5ByaEIYIEAY+ou2iJ5Z
         O3gJQ+QmmR6hZWAlZkjaUBACK9YxIfHfrOQtdbDqkVxM8w8K4tzW8bX9SMpY37uV/VYZ
         FqlHVq/7r5I6XW0J/cOuHbNXvMbdUpinPAai9+1G1MJM+6WMJW29iZ5gmbcar0sCxZSL
         1yFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DKx35KGSMPV1O5hL7eRpZkE01otOHT+tSoXnCYem/9E=;
        fh=96LaiMZGhWyf4ZVL5ic6jlaqg2fczxfmpGKpIdr0tQ8=;
        b=PNtUnJ++NzqWUlTFqW/xafdE/dvnC2Kc2jvuG4Xgw6odj9oo28yN6fRqzphYRi8Wse
         Wq1YBDPgy7fAtK/yzkZxNb0Jv2ons21M9APjLZtSAMafzvY0hANrfLpx6BLlZQgW97ZO
         2WfZC/033lcEUCuh22Atwq6PjiAz3lVRL0Do1GWBoo6PsfG2JQtLOzKh+H2HsJYPJ32d
         Kmx01Mbt+bmw1eIag8yxakkSTwMU0nThXd8ZWu3o+56GP1rH7UxZEneQNtJYlE+ORIwK
         Aaw1fgqO1Ns47ql5dttdmdMItxgfqHMz2S8VU01vKS6slb3eGIm6zkd+Y6ukd7SA9Etn
         PTbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776962286; x=1777567086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKx35KGSMPV1O5hL7eRpZkE01otOHT+tSoXnCYem/9E=;
        b=eN6tlGrYyfTcRgSJar89j7bQsy/ILjSJcmDUZ8WZO8Jum+XINAdutdxGjU0BtFoFPG
         +yKFqKiW5pAPD3p3x3WLIZvC3ZgpGiDpUbeds3RuGT0N3/PWkqFX+/P/1hh9FmugifWr
         HELmeqY0xe2+e7q8ZOOPbFp/KpWh1RYTnsfSaRkA27YScdcXzCyZQymgQ6zy/6we927A
         qbRKcyh7kRujgV/7XYoKEMI3ypBAlDOHJrEhEg/fF7vUfOEJHCbtkRbVPOm193R2IsfZ
         NPdMpVJBZF6KDsMRAHsYSJy6iuwHd9wQGhZbqSW5dxbdF1veur4JUA+BhF013K5RsE+f
         6M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962286; x=1777567086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKx35KGSMPV1O5hL7eRpZkE01otOHT+tSoXnCYem/9E=;
        b=rIWk8ZVKTMCgRMhKfPcK2biI1/RUp3pdestYPOJyPgQMif0yenwnR+KC5asaLizIlQ
         Xt9lWrvaps0xH7NejTLYfPNKjEweIuHIQsXzKqoOUnaRes8XFYM7d8pfKBq9RAkmKp/+
         bb9c9FBrz14VoX7vcdw2DbuCMCl5grkygjyuHajL29WeZ0SoPEVl+UlvZcNFJ9LvGRTJ
         1PDleeWDwVHjrk8EAw7QDwtEWhPi0obp9n98QPiIP4Y8veBcVTlu8NmzkpTU3dE9PBy9
         VPAVQbla7Jmon/dT1/lulgG2iKAdS0oMMIDw7XigXEcyPKol34uEgwaWNrwnZrY6wUYv
         ySEw==
X-Gm-Message-State: AOJu0YyETCJ/iF5eDhQID++v7QDah7qpwMLucQi/XwtVec6LUIJjO1sm
	E7F+eAIKEpYB8g1D8/mvIxoJy4IukhbKCEd+8wCZZjOBHA7IHOBXWufxXYN/DWeY20LNBoXy72z
	4D29NYCw0+TWKppWypqLIvoRPqyK2R/hXAs7a6SM=
X-Gm-Gg: AeBDiesCmRQ9p/z9UTkvHmMKcnUNT9Th9lgrgPrm65VWw0K8KGTdWkQJQt9gT3sRePm
	07HZUCkfhPkr2ONFqyUwOMQVxUGxaCL5C+zaPH33xV6l4sZwXzZsQB93aBGwDlb1KBhv800ziYP
	oDPg/b6D3RYQdr9p5w9erN1pB09NCeDTp6QEvEoN+ChENVrrm9vXUFjazVy7s3u/D7imRk30OQS
	7B511XTdRUVu5pwugr+vEYNrGRu1foDbQ8ugpoCHj87ZOU2+30GmoNABvHzfkLCxERo0LLgN4uG
	CVdxB3mmJw9HT4SSKu0+8aumB4tc5ZAqhcEMuRdgKQE9FXdZoNsrfrplbDUdA1iua0pPvatRm/7
	vKttankjbZMg=
X-Received: by 2002:a05:7022:458d:b0:128:d2b3:5df with SMTP id
 a92af1059eb24-12c73fa356dmr13254325c88.23.1776962285963; Thu, 23 Apr 2026
 09:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 23 Apr 2026 17:37:54 +0100
X-Gm-Features: AQROBzCtoETTexO4bw8nuajTPJOiLwWDJHoDL3XPCwxfbS5nC3NJ-MAha9oIYx0
Message-ID: <CAD=f0L8ZSCP-n6F055TmDNFfpB7gYrBEaKvvwMFkEMf2hQTe7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] repo_config_values: migrate more globals
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

Apologies, this v3 series was generated with an incorrect commit range,
and includes unrelated upstream commits. Please ignore this series.

I will resend a corrected version shortly based only on the intended
environment.* refactoring changes.

Thanks,
Olamide Bello
