Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317318;
	b=cXef0y9QHZgs4Y62+k55cTdzupW3Qyub0uiuHI4f8Z58QxUE3qZJ5o8QeF+/MM4r4iYz
	 /lhrdmi95nRFystHQy4kCWp/oWn6+LrAeuKRrR11OYQ6AJ+h3ZyfaBV9hO+VMlkN/LbmH
	 nb/j7AxfcqDdyuAJzeIIe1Zk0395ID6eHuNQ7ASK42dQiFUHFCAU8TtN7KgLqy0RSZnPd
	 m7V1h9Q00cWZPocA0YgWPLPOIuJ26knOK4XlCjOKhwBNUupDfus3JLHZpX9pMmTC5rdMv
	 fgmrqjmlyh5vRQ9POZVmbo9x/sqf5a39OZwIg+CdnjB130uI6QMnS0tnnWZBwHEgiDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XrjkBZX3toMaRtSkChj4tiDxKs694wLio/mdr8+tkU0=;
	b=u6qbV5Pfr/XTjn398kmZ4dtj/IMpjUvKpoa+GB9O0RdbBVACeHX0HYNB88ezwL0zAVRU
	 0XViHZ8APO57lVgMfsujd0L9Gdw1LMfYLURyZ8YvyBDc+5mRUKhx08Oetif4lZTUAJbbz
	 j2CAvBOm7Jfy7s7chThaC1JRUHYD90pQDak3ml98ixiTphLox5gTLkyXNoid/MxaZkE3w
	 a2Li/mmybY4wPY8OrfzopkaSNS7QW2iyZhPYFMBWc5zzMlq7TYPsGfR6Xyo1rVOjAHIUn
	 Q1PskegQ4t8oqkg3H3J4fJNqUYebEjuXKcMn/7TTfu70jXDLiTNlalFCFQHbPf25bmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HS/fFDQK";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907C606A750
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1907C606A750
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HS/fFDQK
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1897136c88.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794317317; x=1794922117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrjkBZX3toMaRtSkChj4tiDxKs694wLio/mdr8+tkU0=;
        b=HS/fFDQKdD1arIo7WyrnvrHFchy8lij/WeQt80mEIgTJmh9/IttTSB4QCSySzoErAh
         AuiTHrpwPeayTNSZhS/V4Enlfc3MwQb3aMw9KoR9jVAIDXFGxVjxdeyN9Oo4+4JZ5cDB
         7NHJ7YOU3Skt9UdosUp51S1fzXz+McomhqGiSezbA2XSNIqJoDbVqKSZv0s0qxoLyxaS
         2TY939QUcTXe5tKrxG3tg1p44/nreguzrBIglMLPhv3b1Xv6H+zePh9BVdSh6y35vAgQ
         uQAwaUpoP/GCxVFlPnMQdplfs8xkNgeMyk5/aNTFduZwPmCcJppV1XG826LqA36lxq4G
         EcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317317; x=1794922117;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrjkBZX3toMaRtSkChj4tiDxKs694wLio/mdr8+tkU0=;
        b=zUZsH2F91FcgAxTNjCmGydLgmVCx/Ib72xGo+mpZGmCdgrmjDkK1uRWokfVt84cmWE
         wo4B/CEesg6hqG8bczvDJd0GpQTP5OVwY9/0DXoURZanzcBIOUj/ZmWavhKK3KpNg/9U
         MmuuHtMLMkXp+/uxBEVK5iwDpaJeJMai6orydf8kia+aNq+tlSXfii+aTiQRQutmDLud
         Hxfh2tQ6KnmH5dhS5eDOCSA66Tq4rIB9CrVuIzXE+RbRBYIvlzLBjiNiIdKsCL8lfGcN
         lCpRy8MpNjsHDR31+eMPDC8TMOdMuH0Wvv2HV8RmdKd3QvOha3do/9tzJaxDNA0SFnW6
         /X7w==
X-Gm-Message-State: APuU4Z/X4Tws/uck/YujM5u6Veh6HMsXxdJIxRk3xY1w8cu9lliOqYap
	eKDHTGMtTmF03+3fL9BgdHvldBzE+2trAtTNWNnoqQvPfJ7KjQtNYDtg
X-Gm-Gg: AYBFou3P2KlxqLoH8HiIW0/x8RJBwVP9E+VbGKhzppMM0EdXKSaWDQ8ryTGutvJx9rJ
	yJisdFxXHqDHwGbBAlfcsQTAKM7nQjfYbhVtL3Gk9CW66pbS95xs6u9saI+KMjtsP+8dO0jG5pC
	ZPpcU4HxPrHcDfy5yOQ2R/Y8LgVQF+0DZy+6utEbn5y2+o0dDGSv0b5WgX7bghAWvz+sR+19P3H
	ThN/fdjySmuaahUMwOJr9tAa9i8PsAsjuxDKL1QsfjMlkEIuSaCniK4x2SX2sX7ChHCEqreQ4Zp
	bQMy7JbAW098xr7+5oADEvaNvloQa20fGM28YwEdzuyEyt3Q5HFCD6Bcq0XOWv2jvKmIYuVtmGv
	eRJ91X9OrvFN4UR3joF927+nqLbWXsq8CHL5gupGgIjU70w4gFyTkUHTx8QVpmBwq5bhDMRoKIW
	Z0BDPvAA5WfNseRWGmREvR4o6yKNP4PaUUFqb565nwDgkjDX2/hV0ZM6DPK3M171L5jcW8AIOK8
	rMvoARw9mmvGUYpimv9KuDpeGNg7gpgUMObOjzp1LdKbMZM+3EWFUZx4iHA7AVq34Co71ih2TZb
	LV1ZhN4VA942gvW1LvH/Et/6WtM8qa1sjrTyXdvscw2c
X-Received: by 2002:a05:7023:a42:b0:1b3:a22e:b74d with SMTP id a92af1059eb24-1b3b61874edmr3371722c88.34.1794317317079;
        Tue, 10 Nov 2026 05:28:37 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4eef8sm8288762c88.16.2026.11.10.05.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:28:36 -0800 (PST)
Message-ID: <1161ae1f-6639-4e27-8832-3771f73f5e79@gmail.com>
Date: Tue, 10 Nov 2026 18:58:34 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] object-file: move logic to derive loose object paths
 into backend
To: Patrick Steinhardt <ps@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-2-fbbc86c29693@pks.im>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-2-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> The logic to derive the filesystem path of a loose object is contained
> in "object-file.c" even though it's an implementation detail of the
> "loose" backend. Move the logic into the "loose" backend accordingly.
> While at it, inline the call to `fill_loose_path()`.
> 
> Ideally, we'd be able to remove the externally-visible declaration. But
> unfortunately, we still require access to that function for use in the
> dumb transport so that it can derive the target path for downloaded
> objects. This will need to get abstracted eventually, but for now we
> simply continue to expose the function.
>

This is well explained.
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 96fc2ed213f..0f29162d752 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -18,6 +18,27 @@
>   #include "tempfile.h"
>   #include "write-or-die.h"
>   
> +const char *odb_loose_path(struct odb_source_loose *loose,
> +			   struct strbuf *buf,
> +			   const struct object_id *oid)
> +{
> +	static const char hex[] = "0123456789abcdef";
> +

The hex[] gained a const while moving but that looks obviously correct.

Rest of the move looks good to me. We didn't lose anything. One thing I 
noticed is that http-walker.c no longer needs the object-file.c include 
now. So, we could also include the following in this patch:

diff --git a/http-walker.c b/http-walker.c
index 13730a2784..05c0262810 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -9,7 +9,6 @@
  #include "list.h"
  #include "transport.h"
  #include "packfile.h"
-#include "object-file.h"
  #include "odb.h"
  #include "odb/source-loose.h"

-- 
Sivaraam

