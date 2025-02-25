Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B80BE65
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452120; cv=none; b=OBNvym0LYxlLczKQR+6+patH9o1ePwYlDaW5s9q7e1RX9wM/ZCYggU+1OyaVutBpiYyEWAdBnroHhBXEPhAj3Hray/PINUI0PkwfVup8prk7mg+z0Ogluywp9E0YNUt+eyBwiRp0GGeRAK1oRmVDXns6eMf30eRxeRZWwkkkmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452120; c=relaxed/simple;
	bh=ngdk+6u/x4FGYm4Fp37FScPUkoSyQjeE5ACJr8wCWxQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SHjRZGdCpV8NCNMBJpua5xvkHi6bdNNjmqdwyKWrIanpCYv4qQEkjpBClKAeOPisFwIXIj3Pr8h/tTLvsg+mGA48pLJ9eiO8mkgI/IGF3MuPL55ooR1sAkVKbGP6IhS21PebN+Z6ZfsE77fjkYliSrDnwuZcQQIp4HXN930jLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcI+ADWJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcI+ADWJ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8f6so46241811cf.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 18:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740452117; x=1741056917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4nNKQy66zHLxYScS5vwu19Hgm/y2PC6ui8nrKx+vAU=;
        b=AcI+ADWJd/rrwN+bjUXRdM6Cv7/d8P9WtlO7hv4ezMdgY/mx3jZlzxzOa3dPawL7GC
         thHq3E0a3W9srTz5rqlhAgXvrImKVO8nKuwVDJfYWOCGH1+/2rQprrULH/GdYMwjVYNO
         zIvSzCHcedBWNgAFTrG5thdez9jGOXwHLXSxvgJ6OTN1w/z8g7aeWGPjiEEuOfHG0N0/
         Qonh0SJ+FEHoX3WlSCY6qrvKfuZB5Pq3m0ILJmWICLTQD3xsn71We7CJjMGTs8v32blk
         tbEX5pdK/iw1oVZnDpSn42utZITjBjdndSZgwzc/tOTOpNeGqvgqFvfgxYllaVPhQ8VN
         twyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452117; x=1741056917;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4nNKQy66zHLxYScS5vwu19Hgm/y2PC6ui8nrKx+vAU=;
        b=qjXKznIjwmbzKnrWUDx4gevZ3U44P5056kx89x8w1kzb7ds4xUb2rnj4pnunJP+jou
         P8D6SfJNQ8N7dgCmQMraD6y9CUx3nvcJsnwG1xX4MU8S+41S4HATri4s44kA0mqYF385
         B7lHSjHijPC2qA6ScQzps7vykyBJx9vLew0KJgAvvqNaYrsCsfC6ononZJ1jhuO4daiJ
         2JjtfluXao0w02jaxdDRbki56xO2AJDMcCKSyWmsJTLG8NWy3a9ieJnniPb9vGI6TsIr
         iGhc4bCl3oZrkW/+iavnwMQGhfF9z9qoSnOJChxSxxYVZMI4FLGY7S6xRG8j6F0OaAz5
         7naA==
X-Forwarded-Encrypted: i=1; AJvYcCXM22rSQjtH+eMAakTE1cmr0+yH+vspqzQlZPOnGXhxTFy6rp+mysNiAO0Zj+4yvA0PcjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN9NtVhlDl/CtpjjRp3l7bWxpC7ehY1TkgZNtILnoF/fT6Sp5
	opHmmbUhylUuJ065eTlrw5hfHKWqqXmP+xxrPHZblD4825GFA6powMIKRg==
X-Gm-Gg: ASbGncvS66qy7LkLZ9kbOT5HZwqetL4jLqKtWx/RCNJO0owz6lNxHM1JQKQevbz3XVV
	K4CtZCMN4TQrKel9Otc9Ex8zdLn+ndV4f43XbmMyi2J1aPXGDE3fVP9edm6eWOZbKv5nf/iENr1
	IfrEGYrqTpAwg+IUc45wF1nPxVUTgafqeZaxTIf7Y4OA5tPHcWeQV/mjQ1QAjWbYQWqY7CCUSaH
	/niXhStnz66Ae5tPvdMpqLaqdVFThHslRu0VO3dHsXz/motqAMdfoGoqiTZ+5UWofRZwn9FjZbo
	9H+7ryq6PBVI0GMrByb494t59U9bdIvbKDUFeP6adl8ALzLakb7L/yxwMXMj0AL8NoSMqP01068
	+Fnin4B5FAM/7wGFD2iA=
X-Google-Smtp-Source: AGHT+IFcjT36zWghrj+FiuCOJ3Eqc1Y9jtJSOEMNL1PhLvigrZ0I4gC/RMuV5c5rfBn/4l10tP5slg==
X-Received: by 2002:a05:622a:4ccd:b0:472:789:4701 with SMTP id d75a77b69052e-472228c7c4bmr233447291cf.16.1740452117136;
        Mon, 24 Feb 2025 18:55:17 -0800 (PST)
Received: from [10.0.0.127] (modemcable037.167-175-137.mc.videotron.ca. [137.175.167.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e071c2sm4653601cf.10.2025.02.24.18.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 18:55:16 -0800 (PST)
Subject: Re: [PATCH 2/2] config/remote.txt: improve wording for
 'remote.<name>.followRemoteHEAD'
To: Bence Ferdinandy <bence@ferdinandy.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
 <140794b8846e94ec3ff77920f0153f65d434f07e.1739554578.git.gitgitgadget@gmail.com>
 <D7SID7X5ZGKY.BZY6LVZ57YUR@ferdinandy.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f7ec8e1b-7f77-c989-e07d-73e6c5d05e2f@gmail.com>
Date: Mon, 24 Feb 2025 21:58:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D7SID7X5ZGKY.BZY6LVZ57YUR@ferdinandy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Bence,

Le 2025-02-14 à 17:05, Bence Ferdinandy a écrit :
> 
> On Fri Feb 14, 2025 at 18:36, Philippe Blain via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  Documentation/config/remote.txt | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
>> index 1b9814e8aa4..25fe219d103 100644
>> --- a/Documentation/config/remote.txt
>> +++ b/Documentation/config/remote.txt
>> @@ -110,12 +110,12 @@ the values inherited from a lower priority configuration files (e.g.
>>  remote.<name>.followRemoteHEAD::
>>  	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
>>  	The default value is "create", which will create `remotes/<name>/HEAD`
>> -	if it exists on the remote, but not locally, but will not touch an
>> -	already existing local reference. Setting to "warn" will print
>> -	a message if the remote has a different value, than the local one and
>> +	if it exists on the remote, but not locally; this will not touch an
>> +	already existing local reference. Setting it to "warn" will print
>> +	a message if the remote has a different value than the local one;
>>  	in case there is no local reference, it behaves like "create".
>>  	A variant on "warn" is "warn-if-not-$branch", which behaves like
>>  	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
>> -	Setting to "always" will silently update it to the value on the remote.
>> -	Finally, setting it to "never" will never change or create the local
>> -	reference.
>> +	Setting it to "always" will silently update `remotes/<name>/HEAD` to
>> +	the value on the remote.  Finally, setting it to "never" will never
>> +	change or create the local reference.
> 
> I'm personally not a huge fan of semicolons, but I do agree that the text does
> not flow particularly well. Wouldn't it actually make sense to format this as
> a list, with an entry for each option? The would probably also help in quickly
> parsing how many options there are.

I think lists are a good idea in general, but since there is no uniformity with regards
to that in the rest of the documentation, I would keep it as-is for this series.

Thanks,

Philippe.
