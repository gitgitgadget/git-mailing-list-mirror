Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AC13B293
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559292; cv=pass; b=uM27Ri8ousgnv9IJt07hxIUNwQ3IdnG85ZO/H5CuNZukPW4eE577Y34oQmfUhA5AcasszAglRtqiuBinLjCAE9VTm+8bUy/wsQREit7W++uCTtSwyzxvg7JthbsvQgDzAk8aWs+lMf00VE95jWdEKG9EJ0IVSVhdU05mztYubtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559292; c=relaxed/simple;
	bh=yeeXROlFo55H1yH9yXhfBQ14u2uv3AVPXbumGY7QWuU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4DXLMR/tALku1sV/xq06x+FHl9XlOPHnvu4YEPI0U94M9sLbYVotHSD9gEOmM9Q4Vbb4iEOSrRHLCLSoWlMg1tG7V52kQMXDKeQBunaqSUxqcF+RCl3z+2Pgdy/A5lEj0a1eLXyXOvYHtzWfo5jeb6S9SCgJODjNWno64NIBFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llm1GR+D; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llm1GR+D"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7377dde7bc6so3076129137.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 01:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787559289; cv=none;
        d=google.com; s=arc-20260327;
        b=nS0kj/X2ICZnVIX84D89FIyokR4uWYKxxDaa5wFhJkpaebtQJdSwPeoRTMkdkRLK/M
         lWA1UuWa2pQ7wGkcPCGrgGQ1kvRJoOf6fr0SuXK0LAnWh7LtMUiqLGD6hI3F5mKwP/KO
         0QtPT3HhBbk07IE5dkxzDLOxUN6tUPFJ5CbhAViha7a2QUd07LXV+PstZMoVoy0l3xS4
         NBuvKUAjugw/n5qWENIRZG7L3E0K702Tl9njtqxsVW/AclvJdA4ilfsHOXGp8rFkf/UC
         3IhxmkeVcDnq8UH4SpWtSucwZuErtzE7p8fgCDhVd20KldqU1vIlig4vJhazxJ7i+sny
         pgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5JzD3w5RCJ1/EAAA24hIyprDNwPE70ZXGfldiKw8ixI=;
        fh=R0e903i4GOHrQVdggdwhyX7TTQ+IR/hBSCjxTjTr7jQ=;
        b=Uq46GJoQrLJvTd/nKonszsYHmrY/hZQUAmHUbWiGQ411dCkTMyXIsTDdSPGhSQnTsj
         6tewD9MoC0vDHrH9NF11RxA16A70QYJYDooWZY95bCfmJ1MThJPgNlgQfMVJQOfU4ggj
         To8qg1Mz0/M3cDDB8g7yIgD3wA3YmsxHd/FigNe8rrugB5mZaN3NudAtZIRay6odal17
         FH9slbPOKkPp77YXBB3M/LGfSbPHj76khyKoBHT2kfsIFWXivdR3oESnRSjsHSAdsBmv
         gv8oXCWVMQdXLJZQQkfjP4n2SNW7+CBCwLcqi8/tsKFMwlJul/2Mr/qgvHRtJhtawJfW
         KuvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787559289; x=1788164089; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JzD3w5RCJ1/EAAA24hIyprDNwPE70ZXGfldiKw8ixI=;
        b=Llm1GR+DeeTVStVMZ0YJfYfIQ+oeB49brFp7cWb8rO+GLm6GgwIkyWWpFGAW2p0dv3
         ecpFU8YK9lki5YANv/4KKsLaMDUYpUZTcfrI6QuRpQyKA5rXlS+xpkntT7+/1m8abMKl
         VOBFnmBZNHG9ec0HMjbI03AwIzImUmVD6rjIYyfzzKt0Z9S95fQCP8oh6uypJvMtN3e1
         ihz53MAtGQc2bfcaOkgqlAHQltrs/bxDM+yyW9fS7uXwKiNmXdRGV9iofGa+Vj/K8Ook
         U3wW/I357IFNMqe4Ywy7OLscKxxXrPEMiiluPoPngbnFJkH+FfZj+tza9jlAnOti8cF7
         AxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559289; x=1788164089;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JzD3w5RCJ1/EAAA24hIyprDNwPE70ZXGfldiKw8ixI=;
        b=Jkzg0K9RW1/+QbbPOyo4d74r33AalOR/Avvey+irHnf++lvLavqF3jeyKddo+zUj14
         IyAfiJBQQUhu5sm0RQvdHWngvNsl46ArS1VWcPuvRB5AZVmAt8CwlcTy0EkUo44TXbA+
         WxgYhmmJIcVX2VgOmd/6uFqVbERgugMaBzL3/ns5Yc2KV0qmOfPIB0uZTOqs+lEYFq3E
         sb8m0e6hEDicypN2W8WvzEPz5RWudful4QKL5wjkESwDVPN8WMb3WIpnavo6gPjneXdJ
         1rIhhyNArGB7l/BZzFrMTJnet+3O3lqVRDSuZNUm/HC1PBIXWEIT/UwFV4vojmee0gQ8
         3gbg==
X-Gm-Message-State: AFuF++kLyCLuq/FHaFCMZRnrsvlPV7H9uwqzVWhvu3rcuIUTuG7CWdXv
	jCg58V5wkI79EblWAyCVxzVmvrR6fibd5p35FCVU3MKPNIAv0FRgYHG45TdZBw3WxrWv6W+4KeR
	0nEMJ2XQiVrMKHq0K9cyW/L06HyGmTAHHPbCS
X-Gm-Gg: AR+sD125Zfy1foAA4p5/6m0dVNSLqFhEqFIYbz4tYbfyr5d+uBb+R4iljFtxP3QMWei
	oGsTfUU4jjs8RZ3g+o7DwzIlxOve9oDOUGU4WVdVPpe3dYPW7NDSmJ3hfEnXlmxrYWl/Bp9JVV/
	UOu+suW/IXjBcnB3aKMjOrVLmv1PRqYrtBUzMP/Cs/6lo8mUeeK7RpV4zXoFgEoOxBlSbmSKXjD
	stZo4MyJwkTVC8fT13mQVfWnhNgF39OthRQx/O9i0w1/8NtZG3ycY8r5Lxzs5GjgHeQeFATT3du
	ENWzbKjPvaFF34r1rx0STNlqx7y3D1obKqWhd7CCnpRftSfXboSXfdC1i2M8y56HMCBv+UWklnX
	6MF4afkO41qOUhcfxrE6IuxkkKoTZBuHRtjo=
X-Received: by 2002:a05:6102:244d:b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-778ed3945cfmr5633366137.0.1787559289564; Mon, 24 Aug 2026
 01:14:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 01:14:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 01:14:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aovXcPHCiBPxlLXo@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com> <aohXatWhxCAUQTcq@pks.im>
 <CAOLa=ZTkW14coLA4st-m6B6P-9pUr+Yzh7Ph6nb0ohXJSbTk4A@mail.gmail.com> <aovXcPHCiBPxlLXo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 01:14:47 -0700
X-Gm-Features: AcwNN1XogokQwOTC92GNWT9jwDB_b852WwXxh3oPItAjwQX96vspaTJdSq1oGZY
Message-ID: <CAOLa=ZTPsgfPTaT3L5OPkavfAOWaCS0b3JJa__pFbnC3JZLY4A@mail.gmail.com>
Subject: Re: [PATCH v2] hook: introduce the report hook for git-receive-pack(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, kristofferhaugsbakk@fastmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000007851bb0659c6949f"

--0000000000007851bb0659c6949f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 21, 2026 at 09:08:12AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Fri, Aug 21, 2026 at 03:34:58PM +0200, Karthik Nayak wrote:
> [snip]
>> >> +repository, but before the pkt-line encoded status report is sent back
>> >> +to the client.
>> >> +
>> >> +The hook receives the complete pkt-line encoded status report on
>> >> +standard input. The report begins with an `unpack` line indicating
>> >> +whether the object transfer succeeded (`unpack ok` or
>> >> +`unpack <error>`), followed by one `ok <refname>` or
>> >> +`ng <refname> <reason>` line per ref that was pushed, and is
>> >> +terminated by a flush packet.
>> >> +
>> >> +The hook's standard output entirely replaces the report that is sent
>> >> +to the client. The hook must write a valid pkt-line encoded report in
>> >> +the same format it received. The hook's stdout is fully buffered by
>> >> +`receive-pack` before any data is sent to the client, so the hook's
>> >> +exit status is known before the client receives anything.
>> >> +
>> >> +There are two distinct ways the hook can affect the push outcome:
>> >> +
>> >> +* To reject individual ref updates while keeping `receive-pack` alive,
>> >> +  rewrite the corresponding `ok <refname>` lines to
>> >> +  `ng <refname> <reason>` lines in the output and exit with status 0.
>> >
>> > It's `ng <refname>[ <reason>]`, right? I think the reason itself is
>> > optional. We might also want to clarify whether there should be a
>> > trailing newline or not.
>> >
>>
>> You're right, since 'send-pack' will default to 'failed' if there is no
>> reason.
>>
>> We do say 'terminated by a flush packed'.
>
> We only send the flush packet once donce with all refs though, right?
> I was wondering about each individual reference line: are they supposed
> to end with a newline or not?
>
> Patrick

Ah, will clarify that :)

--0000000000007851bb0659c6949f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 663ebe671acca22_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xTC9YVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVJVREFDUWU4WUFpOTBuUU1DSU9HbWJrL0JFazFPSApIVXprdGxOcTJI
NDE4WmhEZ0hnaisxeU1WTDRBaUZMNElmRHZWdit0Z3Z3NkQ4NmV2aGJzNzk3bFQzVHBhWjlDCnov
S1p3U0w0ek9Pa1RuOHM3UVpQdUE2bTFOdFBLb1pwMlA5bmpqL2tqQUJtK3BrNC81ZC9CdFBTRTNM
dnNPSzMKYm1wY2lYN2ZtSXg3KzVtcHRJMVp2bk14ZmZVd0FVOGJEQm9lZDk1U0I3MHNQVldvczgz
Y0ZZM1lvWldHbUpXRwo0Y2U1VDJPVVlZL1BFUFZWQjdtVXhqSDd4dXluaTJMT3ViREFtOFBibVlG
TU1MQmFVR1k5MXBhYkdkOEY1Q3hlClRBTDdlY044MVRDeUVKN0tGWU5Ya041Mmt1bGdJbFNTWDgx
RDViZ2FiWk1QTmdoSnkrSWxhOFJ3RWdnYUVmNkwKdFJ4aXg4WnN5R1NWUzB0dFBXSUlwdHlXZ09o
L1BxR0ErN3NxS0lDRU1UMEcyU201V3ExaVZhRWlpek11d2M4SQoxR1BROVZtZlBsdm4rZkNYY2cy
Wk9QQ0FqQXBiZW04RUJ3QW1Yd0ZiUUV0VTJndVNwRHhnakRoQk1mRlFuR3ZiCmJ6bkQ1NmdwVVVt
UHhGV0I4eXdhNUl4RmJiWTJTS0t1czhTWVBqYz0KPUkrR0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007851bb0659c6949f--
