Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630007484
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978288; cv=none; b=V2PK3yCnRkFbY5BT68bQuSCJ7pprICBP8kDSXwiX9XaC3EYAnj8oslnpFeI4nM6uQFsy0kOD+xLOgOrhKhKlpt7v8xMzy8z6of2NVSIZ3N/AIP5YdK1JLkeedA1JdPNyR3dr+l7l8ugVZlcVeOMd38EP9FXyxiB5gh8BUG4+xQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978288; c=relaxed/simple;
	bh=EMMZxHUDq4YEX7eTbWr3EhXcLDKNJfqsGK7cFxTScf4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=p5RwIfayHDPCSFmW269XcrXqV0Lc1KlCvqDM69bLOvxXNxvvynoQzAk2lmAk8bZooj/lHbWR/IxWT939tqz00cPo/3VuFFaXgDIlLf/7dY8k8Zt9pShSPc/0qd4dKyXl5vD3ggUFqQqJce3W35rberXe+JHOCmRJW/uBvjOM4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVZNfGr6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVZNfGr6"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-364adc689bdso1582715ab.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707978286; x=1708583086; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMMZxHUDq4YEX7eTbWr3EhXcLDKNJfqsGK7cFxTScf4=;
        b=NVZNfGr6Oc30nUrcMvdsm9YaPqbKs5I5KaN2gL9MrsybrfrAeMMhwUaoPQhCBcPIO4
         q2tvxUX8nk6rpgyUbH9c2LZ56DoDd6dbPQARIwVbSC0tW0If8LzRgHqSzNfekEaS8SKl
         f3I/pKydxhpZv3wnapb1JSh6qrpvVkbHJ8303TeicA/ha6lNCJ1Bu9OvKFvOzHXBmgAV
         23CyhfbuA1FSeutFFLFc470/8YDDakzxImldspawIccyoZw8d+3kcgfGrZ56GyKbPT9l
         EuJz0AK9LSTliMPMhDekVfbgL2JdgCb9pUr6ucvEA328rSSNQ7l7cIdLR3hNUGVSKKoz
         /uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707978286; x=1708583086;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMMZxHUDq4YEX7eTbWr3EhXcLDKNJfqsGK7cFxTScf4=;
        b=ZdKguNM/YFXP7jTtlXLr+iTf3Xc0kKgQdMm6KBOS+o3hv2lEjSON+Sj8I58H4oZ9+u
         hsqLDbAzNenWQ/nT+tXhkZK3bVZVzuQuliKhA7z66xyqlQ9E9i/BesS7kcPEGDM25MLK
         kg2T81T/bE5WHPqkVgLY9PSPQjaCY3niqqliVvoNaG5lQYzl8ghuwo9vxVBvJbT1KR/H
         3nrowqIg3b2+VZHLMTQ0GLxzdgB07H3n1yck/Wo//ZYLZJTKC207iQPc2eFNJopsFiTr
         +cU9qXe6xFEsGNLcPX+UchhTXnpW8gAGZPE5Js4t00Gd3E3f/4S5le7bwrrVH1BHwDfW
         rgbA==
X-Gm-Message-State: AOJu0Yw78eFvuGaS5p+k/TBPOR1POPlIDR+WP9+nf/Cyk/pblvmAAR26
	J5lY8oerNYu6A81Gkw/WJv5uWSWUSPb8CNWngrAnLES8pNPLJJ38
X-Google-Smtp-Source: AGHT+IFDD2bO6SpT2FxceSDb7MxL9sDJ31thGR+2LLUlSD4rssaiFWZBEWjKW9NepBbUD5cBMkvAVw==
X-Received: by 2002:a05:6e02:788:b0:362:9250:df39 with SMTP id q8-20020a056e02078800b003629250df39mr749885ils.21.1707978286570;
        Wed, 14 Feb 2024 22:24:46 -0800 (PST)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v14-20020a92c6ce000000b00364f35b5546sm194917ilm.28.2024.02.14.22.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 22:24:46 -0800 (PST)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  "Eric Sunshine" <sunshine@sunshineco.com>,  "Eric W. Biederman"
 <ebiederm@xmission.com>,  "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
	<20231002024034.2611-2-ebiederm@gmail.com>
	<023394e2-5f64-4a59-af96-b77dafb20051@app.fastmail.com>
Date: Thu, 15 Feb 2024 00:24:45 -0600
In-Reply-To: <023394e2-5f64-4a59-af96-b77dafb20051@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 13 Feb 2024 09:31:22 +0100")
Message-ID: <87v86qkzwy.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Mon, Oct 2, 2023, at 04:40, Eric W. Biederman wrote:
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Most of your patches have this sign-off line with your name quoted.

At least for email syntax from which Signed-off-by syntax descends
having a period after my middle initial requires the name to be in
quotes.

Eric



