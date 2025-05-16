Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AF236431
	for <git@vger.kernel.org>; Fri, 16 May 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390388; cv=none; b=ayuMzR3TShROjhFvtF2ZAOPfaraUj9LWCtHL4D6L8e9d0tp1NnuGa0lGWX6HTB75fv/xeSlQd4eeNlN0nwteUHcFFn89Oip8Q0U/zsJred9bwBlOu1By7f499d2bOT5MEFrs478tq7Q26ga4QEkQXJBZH5XtvmcX1ryD8lXixZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390388; c=relaxed/simple;
	bh=+xAt6iU69womL4vebUAhfEHbzAP4Gx6ZC6E0qWk1tcw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UcbRUtWNZTlWDd1bhw7hRDuFh+CWAev8wG/+BBxsOmsGQ+8+K4LkrpzQ+yd/+rzKTUEwbO9Db4T427msO8f33Et6vB7bJbSXEcAdzlnUvfHEUmXE0A1P4v3/6RFr1R115XbNsWSGclyhRQRb+MWp1dzuqLIcWlBZnxTRnYDGsws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS2SpuW0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS2SpuW0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a363d15c64so60133f8f.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747390385; x=1747995185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n3xVCHBNzAitp6xjpWFLAxIhBHIC5q4oCA1BQEsdXXk=;
        b=PS2SpuW04IyCklhC6k0BTDa5JH3Loge0xiRw6iLwrxTnf6dqrHWb5hWAgKGy/iUXFg
         rJEbdtoywe46F1+baqSDFgl+2rAEIciVfp1yI7JzXWJFQiJ2a7sIncyAJ95GD00eEg3o
         cHRSz/NfKk1r45obSGOrPFPd5rKjVtJjSFbmikZHBJyLL5bfH32ls4dIXAA8yUK59zhc
         OwVlyZUrsYyVPQSr+PG7k/B+nOJSHWTeNXzC0nehAjGBvimFZ3tq/0aKk94gU4+wzihJ
         1nCTvIUFl8f4LaWMQmJtkw6TR79V53ki6gimO9IKrbzyrdksm/Iu+hgeRgCKlGWr99ry
         FQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390385; x=1747995185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3xVCHBNzAitp6xjpWFLAxIhBHIC5q4oCA1BQEsdXXk=;
        b=EYU4USp6s96KuLkUNgxwW1uItoAFTZEcABddtC/zV1YWZIzBVUNLGuJ/DdhQy4H//G
         g7IEsCnn+Swtdc/aWAZFbUI9Q6N0iS9d1QbyotfQaboVRdRstkvLaMZ3kcRG4+3LJWpA
         q+h8eFTUA48pjn+Aovez1P7QwelO4GRNSrwmeCMEndJ9x8UAHY4QJFNEeMxHINzAmDNs
         HVuXVvL4xl6kL2xEiKEA2C6oIZ+iDRVclVsi1TmYCkCVbrrbwCpoo750dTGW2FxWDCoy
         q4LYrsFfgWb9D53kY8A8+8WbWtv0Npohv6drwWjISypZP7irBD4LMPaefu3Jtpd3Hg+D
         KF+g==
X-Forwarded-Encrypted: i=1; AJvYcCVg5zjWeMKTvlTyUowBNwCCgrmSQkgWow+mJR7cXoLXDbzK7yUYn0tkLLAGnr/F3B7l/9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHUM5zcMJWSBNCTMzGmt2CHCKYaY2mK9zzSGf0s99aeShLYTD
	xj/dhUPEmYqIea7SPRtME58CIr9TJ64gBcxMS0TbPsqiRwjnVqIO1k5Q
X-Gm-Gg: ASbGncsK9nKbzGINbYAlU5516/mhOT4LP7HZWm5rncS2BBXsjQN/9oExoemLwqaCspS
	bTtcH/1rzwGTixljf9fKgLLn8gtrGIThzGaZyEtN5qMkLtwWUfjFTlQQQYEltf26T4dWfH303kZ
	w3fetD71+SiuY3ESZnzCBmZx+eyxva+fXH6fnSbL+GP6f9EePA+gmUXoUo5WeYZr4hY8VERshSs
	QCYbKc+0oBvNi0BR1B3sGawVhfi/urp5QOCFh+ULAPodMxpQHD1jQyPY3B/BLsbpjlMMXiBGHFk
	Yyd3Yqq1hY5Oftz9IsGNR7kTbr/cqzlbtlhRKVIU0MQdZx/4QzD4z57U7O50u7eFtVA8pMTWsVP
	UvNcW1/YiTO8m8Su6Xw2KgnLw
X-Google-Smtp-Source: AGHT+IHsYfQJymjgMPEdvum5psSi7IKZ175GGDIUZb+eak0+npSDpGTt+ZysOBDz2UST46Uggx6adA==
X-Received: by 2002:a05:6000:3110:b0:3a0:b550:ded4 with SMTP id ffacd0b85a97d-3a35c821bbcmr2770388f8f.13.1747390385035;
        Fri, 16 May 2025 03:13:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8d23:ce23:3b:22a8? ([2a0a:ef40:700:a501:8d23:ce23:3b:22a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b5dsm2391208f8f.55.2025.05.16.03.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 03:13:04 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <8641d540-516f-4dd2-bafa-cbc2568b5281@crinan.ddns.net>
Date: Fri, 16 May 2025 11:13:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] sequencer: stop pretending that an assignment is a
 condition
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

Thanks for cleaning this up - I'm not sure why I didn't just write 
something like this in the first place.

Best Wishes

Phillip

On 15/05/2025 14:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 3e81bccdf3 (sequencer: factor out todo command name parsing,
> 2019-06-27), a `return` statement was introduced that basically was a
> long sequence of conditions, combined with `&&`, except for the last
> condition which is not really a condition but an assignment.
> 
> The point of this construct was to return 1 (i.e. `true`) from the
> function if all of those conditions held true, and also assign the `bol`
> pointer to the end of the parsed command.
> 
> Some static analyzers are really unhappy about such constructs. And
> human readers are at least puzzled, if not confused, by seeing a single
> `=` inside a chain of conditions where they would have expected to see
> `==` instead and, based on experience, immediately suspect a typo.
> 
> Let's help all of this by turning this into the more verbose, more
> readable form of an `if` construct that both assigns the pointer as well
> as returns 1 if all of the conditions hold true.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   sequencer.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757e9..e5e3bc6fa5ea 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2600,9 +2600,12 @@ static int is_command(enum todo_command command, const char **bol)
>   	const char nick = todo_command_info[command].c;
>   	const char *p = *bol;
>   
> -	return (skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
> -		(*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
> -		(*bol = p);
> +	if ((skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
> +	    (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p)) {
> +		*bol = p;
> +		return 1;
> +	}
> +	return 0;
>   }
>   
>   static int check_label_or_ref_arg(enum todo_command command, const char *arg)

