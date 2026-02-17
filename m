Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFF36D4E0
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341090; cv=none; b=m91IcNcPffJpyKzC3Y2bfFw5fH+NjQm8X70zxc+x5Zi2EjLd3VU/8Askr3XTwIZahZPIo4HX4kcGq3LdAlGh+NZFpMI3jaZnHcrhWwaXGW2y4MIzq4NHHxOq8iSwuCuvaNiKL2ecXMEGGHoelCfwTz1k2zv90idCUYelSQcGi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341090; c=relaxed/simple;
	bh=abYS2ocfvphNvsCVN/tu1dWW66Ve3wUcazLqf5Qfhiw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KVPRaOXtywo2mwaDSyIc1YSDJY6AT4Ed7xkUbs2PKWU+BGC6J/9RVhB9UMn3DaHqvKipVkwFL8NLinUPR2f564SJ6pYc30feS75WFNCCeSiTCVGxb5/mxUk2czYcrmvrZVoBRL3hTwrJmUt+Y8RrqtcNdC+OUnHtfeM+3rmguEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtL7Ca4E; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtL7Ca4E"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b883c8dfb00so851986966b.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771341087; x=1771945887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St70udpKaAjUQCFgBKAn/7Ky28X95T4/7V9MsvAi1Ik=;
        b=dtL7Ca4EPbL4TpiUh+Nq8ctvXhgI3vx4j9EaqqrIkAbwxdUWLDKCbS7x9b6zQZyeP5
         p03o8kL8Wd0Z++0RqI8JJpTfgdDdGm2t+3HelGOlj18b3xCujkNtB+5WSu3rJkVGnQaj
         FczJlY4/gf//+qu+7gEnDlOUM2U/eOEUcIptihyAR9AxhQ8z2OzSP3N7fZKmnJ33Mp91
         s55tYE/UGnwuWVKGFtL1FD0REcAcWfAdgbb0CEpbPt74+eP7wzHlXtuUlambf//bHAto
         DnL1/B3OmHlYn31OXgQALTKCLEZmF6HHiHs0FjHunQwI11QqX44IRLPGmIra5ImwAEKN
         JJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771341087; x=1771945887;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St70udpKaAjUQCFgBKAn/7Ky28X95T4/7V9MsvAi1Ik=;
        b=iChlApg0JGDt+JB3uedR5HYQh81CumyjmHVYC542+yEXXBVHUSV/bACfuoszHkBl6/
         yYlXatEBV69bZ942gEZdbkl0ThiE1uDw8k7KuCbkblb566ZK+ttmyvz8ACp4qT3pXUrE
         7NmUbhcjY1QE3TR2k0M3BRxtYJ2t5FFBEzhWfnngr50FlhP0LhST40mrA+utI6xldyYn
         zgas2kc6TK3nXZ5AAtpv/UFyIB/Xd1ZccAyW3PB1uFUEhfCC2XZmOZImEPnOnfAcFC9y
         9Yq7nHbec1nRtq/FVjN+PzCpiNud5vh9ruWgzdj4gaarIn+W89ViPD9rlD3TT+b9w8WO
         +5Hg==
X-Gm-Message-State: AOJu0YxSCJtLCEJCLkITWMjJcatZrwrBoaM2JcXwuHahMxHbxoiMFKTN
	Fm3CuTJc5TlykyR844XLdYtPdfYXDKAzExm5TVKfu4saEVlluBuZF6ar
X-Gm-Gg: AZuq6aK4nVxO6vZy3kYLRY6JEW+qQH/qLFdJIKK7+EiU8hQqn9AwwD4rEjpTNu3WIJw
	4aThosTF/zGWRIoVs2kf8DQHXr0HK2QME+ef4bNEPwzWl5LGgXW2GCAhc68FSrHPbDLeJ81xdrw
	siXUXvNGUrYXSWnQG1PKNbUbTnnCD8DN0UNOinvHcdNQw8Zltg6OXFIrNYi9OfcskemAWYPiCCU
	dUQEc0lBeS1H28O95TrP+yWtOSEkKT1GkzAv/l9+pCPmbToYcBPH3gvn3yaxMf0izwbJLw4n9Z+
	jJhXh95iIgkaID5M97TGi+GEbg319JyOrU/wt3S9fgk+4ipB27aY/eldzCS3mbA3wtU+3GGmty5
	n6K4v0mJvnPM359MscKV3PCvnuB5qI3Nv2JLxt9BeKIfpLvi6Et6dMg/5ZBvKfcly+M2AM2JIkH
	nwYljn20nZnXMb+S4Hu+9vSUoPfVkDEbtdmZoZCGkrXpHvDODgL2CsfAc8TUkyr8Ia0xQCRMo6b
	pYRmg==
X-Received: by 2002:a17:906:c144:b0:b8e:12fa:ff2b with SMTP id a640c23a62f3a-b8fb4462fa0mr838540166b.37.1771341086918;
        Tue, 17 Feb 2026 07:11:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385f5dsm364254666b.20.2026.02.17.07.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:11:26 -0800 (PST)
Message-ID: <cfea5749-af95-4a46-8a3d-9022d28edb2c@gmail.com>
Date: Tue, 17 Feb 2026 15:11:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation
 changes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Evan Martin <evan.martin@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <833b54f7-bb6b-4bb7-a5ec-fc0fa679abf8@gmail.com>
 <CALnO6CBqbJ3s6XO0s_bTagJxT0N8nseyJb1T-H7+B6qqWNKoUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CBqbJ3s6XO0s_bTagJxT0N8nseyJb1T-H7+B6qqWNKoUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/02/2026 13:38, D. Ben Knoble wrote:
> On Tue, Feb 17, 2026 at 4:20 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 16/02/2026 22:28, D. Ben Knoble wrote:
>>> +if test -n "$DEPFILE"
>>> +then
>>> +     for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
>>> +             "$SOURCE_DIR"/Documentation/config/*.adoc
>>> +     do
>>> +             printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"\\
>>
>> This forks two processes for every file which is a bit inefficient and
>> will be especially slow on windows.
> 
> Yeah. I couldn't find a way I trusted to behave in the presence of
> strange characters, though…
> 
>> If we quote $OUTPUT first we should
>> be able to use a single sed process for all the files
>>
>>          QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT"| sed 's|[/\]|\\&|g')"
>>          printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>>                  "$SOURCE_DIR"/Documentation/config/*.adoc |
>>          sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> 
> …and this version matches a concept I considered. Let me think aloud.
> 
> To quote output, we backslash-escape any "/" and "\"; we are going to
> use it in the replacement side of sed's substitute command with "/"
> delimiters.
> 
> My manual says "&" and "\[0-9]" are also special in the replacement
> string.

Oh, I should have remembered '&' needed escaping as well

  We have no backreferences for the latter, but my sed on macOS
> complains about bad backreferences in cases like
> 
>      echo abc | sed 's/^/foo\1/'
> 
> OTOH, escaping backslashes already covers such backreferences. So I
> think we'd need something closer to
> 
>      sed 's,[&/\],\\&,g'
> 
> ? If you agree with that reasoning, I'll include this in the next
> version. (I'll also try this out a bit first.)

That looks good to me

> PS in patterns with so many "vertical" characters, I find the commas a
> bit easier to read than pipes :)

Yes, that does make it clearer

Thanks

Phillip
