Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198531197C
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453124; cv=pass; b=ddtSWiBPRUvlzmlTTrdaBPp4tVR36k1mWk2D/FGPV7GqXzzJWwVwnJMyqz67N6QsM8GzZ1UKWMsEJMBwGWUKzCw1efa4wBjstrZSMxvyubui4+zyylrfjwzOBSJV1aOYyvIdekUz38m3iClEHQ7AjSDdQ2e3y7c1f3hAdCBWSrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453124; c=relaxed/simple;
	bh=LemxddiPzArlAQ+Yxl9S+MC8tllb/dne6cc2rv6qZpQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/qAcoywjhV39PGUKqxTxbfS4N+RBOq9ggEaytk9k+yRlUc57T+JtaUhsxCCWemPkustSsaBE+UZ0h5Y3JxTcSc/I4UIDmKPS12FTTL1qe82BwyKuQtIIRN225D+7iz5mw6WZ7VWjngkUwfSPWRIfYPCV2pIVj/wp4nu6l2HwIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqki+GXz; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqki+GXz"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso44232e0c.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 09:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453122; cv=none;
        d=google.com; s=arc-20260327;
        b=ZA0BqPz6VLC+vLalGBZ5RwfmyIh3ner9aRrQ23xxHlPkY2BBKl0sjYJCwy8L4cHPci
         LsOdsmi51jJh39aHTx8ArFz8GEtmfoG320nl5/HnhvzFFqDpRZSr+8zMNcEVpx3uAsOo
         l7quwh7JfCGMVRxFi4Vph4At09B7WycI7WQc0mB18z2A8z5UU80BN24jlLXlq/Q4xMta
         4rbA3NdKLL62WBK8Rrs97VNrL6c0y4EXFR58jJ3stROABfFJo3lMBfzp1m08IdgApuN4
         hb6Tl17Tr6jAqrsrz+djOJxg+NgRTaNsbrApBxRpuYp70EUcN8eZ69nLNvNYob3Cf28/
         HvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5GPRXoyjRBfAkd3eM2as9Grj6B5WwPIjokzHY2cA1+s=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=qctomV3ZcRwz0SVC9EUjNEVoeD+7f9JUar1Vncw88VchppNSuTFQLg5mJL8JPcmfqT
         00XDOpNxiw4WNe23F/isURSC6knrVRSwzDFzw7b4fpujhSJtFcExy2T9DjIoU5HhsO0M
         7+OvlWfdax8c6HgccOXcNbsFtcqsmm8a3XmbD+c31+iz/1V3kzEc17qpvFhVmbbPfEuF
         fbNbKNaoiQye01qr3jHriveCRtpOiMX/QNEHJKYz5QB/yqVsWKNhZ/vmAiqrKpBOJkDi
         Abw+sNjElv80lbWCjXTXMMwAsx8+suGDP/ObXJWZsI9lZrKi3blqYIm0V4uPFob+TRC/
         8HGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453122; x=1789057922; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5GPRXoyjRBfAkd3eM2as9Grj6B5WwPIjokzHY2cA1+s=;
        b=Nqki+GXzbYkOn+yFeDXGz62lbQgHXSXHH7DZodg4Y+9bWv98D2MpM7oHUpEvIORHUx
         pneL68ocycMJLMUaCyMzBm/gV8R0In3O4FEN2W7elPTbKPuKvynYrgkzC7JCedMS1a/K
         ydsUMg+Y4dq/GlOKsQ4obn7odlQJY8bn5m8/c5nBlOMDbt9BBTLjNC60bguBDmqAYrJX
         3sQJn8N4J06AxZVXXycX9W6X0dCU69dSc3gbcqjL8voShdZMNGjIY+2Wnp8A0JXaZO7b
         FMciPB5jmcWyr5dYOHmiflDS4OAgC1JDcWD9mpttL55KGOaTg3+AGl3g0IJYrfyexKxA
         UsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453122; x=1789057922;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5GPRXoyjRBfAkd3eM2as9Grj6B5WwPIjokzHY2cA1+s=;
        b=bQxgPDCPkvJ6s2aKrQ64LjcM28FAacwkMLEJtnpcCzMvCthewM7Aqk8yaDCLgpWv5J
         I/7IuM2nrvgJHfT9j6c1goPF5IRKscPO14pKiKBpx/4skohQIMMhMBZZoNbE17XdQM0g
         s5DK0Hl8lA+7clNAud7dIMed2H0dXGegO2ZlGIx8FTCJ7k982JH3dUW15pS7FJSvBRMO
         6+aKt37Z8EIFPeuD2+LWn91q83VZIkZEUvRnBwAKW4Z99Fhh9GOUcAj4Xu3wTBHh+2lx
         sdvLg45jP9ZGn02uq2JdH3nhLUJ/oQjdt16BYXyYwJVRGCtQH+7DWvlmMOT38ZRWtKqC
         FZnQ==
X-Gm-Message-State: AFuF++nOTE7bcp2vWfJmQsV+EzHjO52+KZKgbmSVle9dCivi/3TDcNc/
	Hv1miue9UPboCCU5VNfoO1tNLSWruGpB40SarCTdSQ56URU7ptsYpmQrija15HOhN18B1A3YkQn
	JkUMuG3ET36lYD6WV5QzWtlIV5fYMFKo=
X-Gm-Gg: AYBFou1B9ZrmPD+rM+fliLjYIjgdMNZLwP25y9fIyt0FRSxvLIj0NRsyySg0fpSjoPB
	stEhWrWAKLAE5AiEluy8WF/F3ZKmJWf9RJNGiEODypwDRHu4syZutyhfm3SLd2ftlmX0GElmIeI
	ruydZNEv81k8IlbDXtYKtEDymNNtzLbkEULu+1hxNTk503kun1G82QqIHTCR8IN18oD/YLCH0UC
	HE5lYiGrH/jtCzO0LAeLk2lsPq07JYYdhNsVFjGZPMBrDWFPpIx/0byUOPntrG1AbZYg/LuVdP4
	7o2xqOftBfTiuZ0rNkC7Be4rOfuzbJLc/aBEGfWPr74ZPqpYfH2ApwGNrYHkXh2yeLCznAA665+
	agYiHyhGLwSvd9xc4ZY2VzL5SoB5O39QzECg=
X-Received: by 2002:a05:6122:4145:b0:5bd:71cf:e97e with SMTP id
 71dfb90a1353d-5c7d27c4415mr6047482e0c.5.1788453121713; Thu, 03 Sep 2026
 09:32:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:32:00 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 09:32:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aplF-zxlGRqZs6tf@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-3-6283b1fb9b1c@gmail.com> <aplF-zxlGRqZs6tf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Sep 2026 09:32:00 -0700
X-Gm-Features: AcwNN1VGhoI0XxC4gFQi8jD-SSc_99Ngehfuu9t_7-NKp2-HAgk0j82GHW03-Xg
Message-ID: <CAOLa=ZTZeO0DRh67TQ0uY=pWUrePwg09_=D_qyyM7ZigzvZLJg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] receive-pack: move message generation to separate function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000000486e1065a96b194"

--0000000000000486e1065a96b194
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 03, 2026 at 11:28:00AM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index a9a3d21c24..9ac10465ac 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -2535,67 +2535,72 @@ static void update_shallow_info(struct command *commands,
> [snip]
>> +static void report(struct command *commands, const char *unpack_status)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
>> +
>> +	if (use_sideband)
>> +		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>> +	else
>> +		write_or_die(1, buf.buf, buf.len);
>> +	strbuf_release(&buf);
>> +}
>> +
>> +static void report_v2(struct command *commands, const char *unpack_status)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
>>
>>  	if (use_sideband)
>>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>
> A bit hard to see, but aren't these two functions now exactly the same
> except for the enum passed to `generate_report()`?
>
> Patrick

Oh yeah, that's a neat consequence I didn't even see. I'll definitely
send in a new version with this change.

--0000000000000486e1065a96b194
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f5f32748b760076_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWm9QOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzEvQy9zSExLY2hpaXFSNlpVbTNZUlpHRHpGODU4YgpkRnhWSmNLd0tN
T01ieDZWaDFPay9YWUxrSGhFNTdrUnB6VWdTSGROZG9GMm1tQlg5Yms4L3hYWFExK1ZBRHZzCkdE
K25kc1h4UVBRSTlLQlBYY3ROM1pTbStCQk5NdTFxQ0NtWVpXdVhEY0ZkT3FvaTRtcWlsRjg4S1lU
eG5aT2wKd3NyWGpQMXBEU1pYdkpNbHVMV0dGeUx3WmhWZ2VoSFh2UWxyeUIyRmlma1l0TnhDZHBT
d1VPUE9nTUhzUERTaQplcEhZNzZJeEpHYjFQQU0ycHBCNVNUdlhOeS9ML1hWa1JURUlCSDdGZzM3
RkJCelc0SnA1NjFQeHBBblBVeVIyCjFJN3paZnBoN01xZm1sTnhza2VsR2NiMlVxWno1OGRxMnBZ
cnFkaTd0L3IvSWkxeHNXZXdqZDltK0hFSDFWckUKN1JHQi8rZnl1Nm9idXB6TUh6VStDMVVBWGRZ
WFd5VVZFTCtjd3VaNEYyZVh6QlExZDhXa3RIb1JRbUV1b05abApjSlZzSHZRQnFYN2FvTlJhTVB0
bUEvVEFEd2c0VEI4TG5wQzJNSWtpUU5xVXFJRUdDS05IMm03WFZUUUpwSTcxCkVZRlhlM0FLR0pI
RDgwOS9vSnVSVVZNRGVaaTZqalRHYkxiQlNjND0KPTJuajQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000486e1065a96b194--
