Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC1372696
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959391; cv=none; b=ZVgRz0xmTZebQrC/xT8aKcyWMAR0kKdvqJCnWubxyuXOD3xQQNB5FuQF9xdWoYlUKChDi3Y80vspUPudFVmEQJcX8Zs3C4/d5ly5dYUV7lhVZYl9X+d5njuN77eppe0uWVKqzLNuAu1WgyuPofjh1hbh3c9NIGqHKmN3vuHMo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959391; c=relaxed/simple;
	bh=LPjP46mseiONoS84jyhZV63kHpHRK28jrSh6NAaO9qo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OmjOBRtIwrBTrN7VwyGDH2rxW3IPesN3bVO2frc7vEy76MC50wrGCpEKIEVKsqy5RSVBij4BZfmO8WKzgf0shRZofdoHjApkuB2kGYvn1XsE+OVcKCbZb5jhpk2kpvAoHMnY4Z6V3eJy8TEs1AnKS1wkOY5J/ePnpQtrdNfUZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QruHJJLs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QruHJJLs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so30479145e9.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959371; x=1784564171; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pq7IcHIdLg1Jmbiei/kedf4icKsLXZAQvrq7pb/DC8A=;
        b=QruHJJLsxYlkxqauZIYeVptqLhJ1L3uCJkM89yBFz0WPdQmFe6fYxs8iJNSgWOSGBV
         QZMl5CUxYm9O4BwKp7zev/00MP2vQ5yajIJ6bBeam3HP2H9+NeY+RlHNSkzo1pgEoqIy
         mOagbGPI55mH5GA3MUAIhikrpqWUsye7JeufHnHYRFIJY3Jb9XkG8qqPvdqrpF5cQd0B
         C8neDAzfEE31UyNrNmHvRBFSYMcpc6PNojTbsFa8sCwI6cQchvSxHAGxPNXsEfbujkwa
         rX0OthqxvIM61nIpKdM073eQIBlVV8Dma8GFuwZq8yglokRHC2cWz336lkn1p/8520KP
         ipLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959371; x=1784564171;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pq7IcHIdLg1Jmbiei/kedf4icKsLXZAQvrq7pb/DC8A=;
        b=D0AH6afc0lkBZ5CYKjFefjtVEGis6DcexehVsfzvPNV8Awr3vJqez34lv6eGQJJXJo
         qE9ZWoD1BhktY7SyIgl3S+WtZmLdHjyq/Ve7toziq43Kc9pSZ4+SeP9SbWdhAmJCBVH6
         CijOjRuihfbYIEzy5rUBqxmYtWnuuyyE1Q3ssxyUCQjHO76hEnTt4vjz7lmWa5s6Psjp
         INBb5WxaFPFhuKDXmfcJzRixAVj34WF2hvKlhzZrp+e+2jkRrRcAiThShFGxUFqzxZlW
         mScUOs/fHMKvoFwwAEx2MDx3a7otJA6yC+QoFhzf97dHHtKRd/OPTCeYaDx5r9cwwlxC
         5qgw==
X-Gm-Message-State: AOJu0YyETqZJhdJq6R6L9TH145EiQLb2/IEaXWqJ5ad5UNqv2Z6FADsl
	xc1mQQRtviMGT1AH1SoTUe50rvPkS6lSUzHo3av4w6Zvde+DM+pD0dg6
X-Gm-Gg: AfdE7cle/oMp6GyOTFxhlpOsJvN79wtVUKIYgKuEMe/wtaj3ujO+sIt6VqTTqKItpDg
	oMkVHuwfN3G1+qDz3bM/2Jprwa/K/E18OebII5W++IX/BeHeLj2bNo0K/JWLM+Lysr6A1ZM+0sl
	Jd86Q10T6t+AYr2t2XA+6M5JCnOAdxacI7CBIPYoMmIhlGOcUWxTE6/CwXju2efpyxn2gAQ+52g
	KG/EHyRaCctKzA7nx1j/qfpbShETCkNvVFhLq1Iv7Du1DCxYoMxTWPwpblXal5nEOBUZXTcEHNT
	fBVKMs7AkITKwGSmKTtdejDsD0IpRaxWAGQRmI8mEFjNAhlxcY0iVX5Q1kwdwHsn3fe2Yh/bPC+
	WyJpsdP0CjZqdbNcOrIarE71j4XuOPdDmaDnyqEEaC+T19bjvG0RHKA3ZdTxOQU9HMvuZcp4GYj
	jpPD96MO8QDWbpntqumg/mNmZLEpxEkxgj6gGrlFilfFSBSBftZYvdd5jG/SHlLXRXyC9qDjr9D
	/Ob7dGfNAWJ7UTA1FQEkL0ejhBqR1EufFnkDT5iOIOq7rbEbmOzFPMZjgo+685rFuc4jjXjpz7f
	sgnBLi+hE5hXoqN5wiZZ8LOxP8FUlwd2Ed8SSAKfV9tGggo46YeT3eGL7+9MeTW5nHflZA==
X-Received: by 2002:a05:600c:c4a6:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-494df2373eemr13768835e9.26.1783959370446;
        Mon, 13 Jul 2026 09:16:10 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508727f7dsm6476625e9.4.2026.07.13.09.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 18:16:08 +0200
Message-Id: <DJXKTG2TLTUO.2XCFIBA3ZAN2W@gmail.com>
Cc: <git@vger.kernel.org>, <ayu.chandekar@gmail.com>,
 <chandrapratap3519@gmail.com>, <christian.couder@gmail.com>,
 <gitster@pobox.com>, <jltobler@gmail.com>, <karthik.188@gmail.com>,
 <krka@spotify.com>, <peff@peff.net>, <phillip.wood@dunelm.org.uk>,
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v10 7/7] graph: add --[no-]graph-indent and
 log.graphIndent
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Mirko Faina" <mroik@delayed.space>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v10-7-82ddab26bc96@gmail.com>
 <alTuevrGiK3bwh31@exploit>
In-Reply-To: <alTuevrGiK3bwh31@exploit>

On Mon Jul 13, 2026 at 4:06 PM CEST, Mirko Faina wrote:
> On Mon, Jul 13, 2026 at 12:44:42PM +0200, Pablo Sabater wrote:
>> Some users may prefer to not have graph indentation.
>>
>> Add "log.graphIndent" config variable to graph_read_config() to read the
>> default preference. By default is graph indentation is true.
>>
>> Add --graph-indent and --no-graph-indent options to overwrite the
>> default preference.
>>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  Documentation/config/log.adoc       |  4 +++
>>  Documentation/rev-list-options.adoc |  8 ++++++
>>  graph.c                             | 10 +++++--
>>  revision.c                          |  9 +++++++
>>  revision.h                          |  2 ++
>>  t/t4218-log-graph-indentation.sh    | 52 ++++++++++++++++++++++++++++++=
+++++++
>>  6 files changed, 83 insertions(+), 2 deletions(-)
>
> [snip]
>
>> diff --git a/revision.h b/revision.h
>> index 569b3fa1cb..49e1380b80 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -314,6 +314,8 @@ struct rev_info {
>>  	/* Display history graph */
>>  	struct git_graph *graph;
>>  	int graph_max_lanes;
>> +	int no_graph_indent;
>> +	unsigned int graph_indent_set;
>
> These are both boolean values and could be set to be 1 bit wide.

True, I'll change it.

>
> Other than that LGTM.
>
> Thank you for the changes.

Thanks,
Pablo
