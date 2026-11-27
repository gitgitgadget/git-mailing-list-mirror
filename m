Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797775;
	b=zy4BKIq0na8U/KSP2dTvRhUDkMcz6xI+h4vM6weF2w8lLj8sySMNhqO1mBgZeZNsTrxY
	 xu8IqFf7hP7OStjGCgSqJurVr3rSH1XigcH+lZisftNPIcCAx074Q/CgFUgcKcpwcuhAC
	 pOuDz4gjQOu1PGMR6lTO3FLMBzYrAvT3UuP/CdaE1yLr5YZSu93CYPrTnMOeDOHiiH1ih
	 rAUzZQxIwvHQpYYXXbKjPBEeWz+r6tLhk+KpQcFTj54v1iIFxkKxrHEKNUa8OBoElf/e+
	 nY4+lza6rE1bsPMQWN0q+prC2icfSmjMd1u+n+RTeh52R7R+EqKtJmCNzAN5WBuQa0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UreNwihSM0bmRjyF4LIQSlBXp8gZoNRQaM901ln5iJU=;
	b=gd06/z7aOvnqR5SAO/GwdUnOL9MhO+ODfteeh5eZeaAzt3FhflMqY1J6AmrRAiqkfqY+
	 bD3AbzExv4dWaJ9UXujbFa+ruDbvOefdC8fcOQhyz+7wzfwd69Hooz6ge31+H8N0P8/z/
	 X1SWH8oIF6YLDp8ROfYd1TJQPsy8r1yfdAsWbe4Kh08vFy/IlaP9/rFSZmFunCwErtNqD
	 TGpwctp4jJRTcnDwnL3nhq2l6BZasaQDsy9w1pTZM/LVFVV8KE37sAstGVBxN78vp5guR
	 md93cvf9p6GMq2eBQPx1aSGDwrUIiMK/RUyakiR1J3mYNsrouKbm7m+lv8B96Wxteyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFDcCi0z;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C38606A32E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C38606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFDcCi0z
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so7808591f8f.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795797771; x=1796402571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UreNwihSM0bmRjyF4LIQSlBXp8gZoNRQaM901ln5iJU=;
        b=eFDcCi0zgnuvBydEzb2HaB6PRroNKxS4cBcNDGS+3zj3BWolZzrAWtyrHkOSOEtHUU
         KkXw7DML1Hn02o8u0/prdhlz/S8jgSVch70uGUQGcPDHfhoD5ZLaCWdNy8oJqjl60cH3
         GFRfj+VxlmjKX+mhlHtwfxiDWTiDRe/HS5eknhQ29hxLTy5LRWBa5HsikleGddU5gOWR
         cUklw5InbmHFZMSM2Ht0dHMAa9sQp4mKsvSW/XgLESlY7BC7V1tW+21NXroPe0O0wh41
         XIBB8peMZvKkoSjrpRbP7cVeXhCVxzr9LF4+HImp4fhGKuwB5d0P8CdhiM97V7uXN9RP
         0OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797771; x=1796402571;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UreNwihSM0bmRjyF4LIQSlBXp8gZoNRQaM901ln5iJU=;
        b=sRLoj4msZrQ7dqTc/N5rjDZUfU1rXZF+CMs9IR7S12hg8X8Sp6d833wffdye/x8syu
         9JDGVfO8WI2RB/dQFD16u9CxddDUe2yQm2laIKF4HH9B++qF8YziER0o1HbOhcgf7uJY
         0s1Dd1R2tw1YTiDLZjhvEbjyzbE0D2VqxTP1pa1uFe+6RrkHe7rwokIxhaemwxalno8f
         z5iNRqx/ADGorcQYEh+sPuXr0/XPI55Oq1cGyid+LZ4r2s0VC1Af7OjdS7McQvGJrkOP
         7W6locKjgsVGDbrXdhfzwQfmuAApDVAwE+DZ9gh/EOM5IV72sPl+w4O8I26zaGtQLDLm
         dIxA==
X-Gm-Message-State: APuU4Z+rPKQXDjPjMB0clnRUHD7028S8vNE/1HIISTUCZsQECthjCEAZ
	Bfu1F+udLIi/aUw+jCaygpSdQeKjfJyG6y9fR7L5qsfzMywMjievYAdu
X-Gm-Gg: AZFdTZemMVBYDY3FixS0kftbD829Uma4cRgoktEPJukP224NcCl5yxKgJXT8hQ7QYMu
	h1Yoe54bvolcrCQzVsGA8IsZRrme8QDLsPVPqdTGu6vKEVSekAj8wXTpD1mH4/xObiTMrusm9ZD
	s/ssuNDM8+qkMtOq66XhGU89d1CTSAQUKvHu+uiJiYAtKsQun00tGPDEyzqHxrwduRNieJPpHTe
	JfJtWqWyZtdBNreNqc1TqYq+JfCZuEhFo5hVd6klM8ofmHU/FZYu9TaYu2UEWwpdICvpGMF9KtF
	ZyYqhrw86sqGTqvpUeCJzhOlAThun2uBWrUxoiJhvwPbwL0S+ZeVGPg+Waj+wRoNxXeveKxLMJA
	Ynygv3TN0Gw6YaahZwErXo2DG7YROTpAZaOowjjAWDTBt+J1UfCKGIYJf0h4QSACdiCHOQn4355
	YpId7nUsASKK9m/U08o64d3Rh4NjpT+AO6Q8cZZKu4csqhdoMRWHuIa+irN9tNYD751ThtJSOpN
	W2cgJP/uqYjJG4C1nOtnYot88dyx11yOIgGg9vgG8qc+si8BGYdJdjNYMh84RQtqU0KGxTroN+Y
	xjPjtScd3Nra3WgTB4WD8Xc9OA++E7djsD1g2qFuj6Yo1Z0tO1U8uKadrnvsuyu+0FkRDg3PXKH
	QJbwcrmn/dpvKv6qSSCEZlMMZdcT1
X-Received: by 2002:a05:6000:491a:b0:4ac:37ff:140b with SMTP id ffacd0b85a97d-4ac37ff143amr45242008f8f.25.1795797770839;
        Fri, 27 Nov 2026 08:42:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb41f4sm46520838f8f.7.2026.11.27.08.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:42:50 -0800 (PST)
Message-ID: <95b44801-8c10-4d1e-bb41-c5ba3ee13695@gmail.com>
Date: Fri, 27 Nov 2026 16:42:49 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] var: add GIT_COMMENT_STRING
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
 <6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
 <xmqq5wxjia5q.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5wxjia5q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2026 20:56, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> what the comment string is because they need to do something like
>>
>>      {
>>          echo ' #'
>>          git config --get-regex '^core.comment(char|string)$'
>>      } | sed -n '$s/^[^ ] //p'
> 
> Did you mean
> 
> 	sed -n '$s/^[^ ]* //p'
> 
> to catch both " #" (the fallback) and "core.commentstring //"?

Well spotted (though I did say "something like" :-/)

>> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
>> index bdc74d291cc..e348d8895d1 100644
>> --- a/Documentation/config/core.adoc
>> +++ b/Documentation/config/core.adoc
>> @@ -549,7 +549,8 @@ core.commentString::
>>   	Commands such as `commit` and `tag` that let you edit
>>   	messages consider a line that begins with this character
>>   	commented, and removes them after the editor returns
>> -	(default '#').
>> +	(default '#'). Scripts can query the comment string with
>> +	"`git var GIT_COMMENT_STRING`".
> 
> Elsewhere in the documentation (such as Documentation/config.adoc and
> Documentation/git-var.adoc), 'git var' invocations in backticks are
> written without surrounding double quotes, so dropping the outer quotes
> here would match the surrounding style.

I change it to match the existing style

Thanks

Phillip

>> diff --git a/builtin/var.c b/builtin/var.c
>> index eb85a985b15..6dc8ec4ba9f 100644
>> --- a/builtin/var.c
>> +++ b/builtin/var.c
>> @@ -188,6 +188,11 @@ static char *hostname(int ident_flag UNUSED)
>>   	return xstrdup(buf);
>>   }
>>   
>> +static char *comment_string(int ident_flag UNUSED)
>> +{
>> +	return xstrdup(comment_line_str);
>> +}
>> +
> 
> OK, like other .read() functions like committer(), we return a copy to
> the caller to be consumed by list_vars(), which will free() it
> afterwards.
> 
>> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
>> index 883a45399e2..f228cb5bb6f 100755
>> --- a/t/t0007-git-var.sh
>> +++ b/t/t0007-git-var.sh
>> @@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity components' '
>>   	test_grep "^GIT_COMMITTER_DATE=" actual
>>   '
>>   
>> +test_expect_success 'GIT_COMMENT_STRING' '
>> +	git var GIT_COMMENT_STRING >actual &&
>> +	echo "#" >expect &&
>> +	test_cmp expect actual &&
>> +	git -c core.commentChar=: -c core.commentString=%% \
>> +		var GIT_COMMENT_STRING >actual &&
>> +	echo %%>expect &&
>> +	test_cmp expect actual
>> +'
>> +
> 
> Checking the default and core.commentString overriding core.commentChar
> looks good.  If you happen to reroll for anything else, testing the
> reverse order (core.commentString followed by core.commentChar) would
> exercise last-one-wins in both directions, though it is certainly not
> necessary on its own.
> 
> Looking very good.  Will queue.
> 
> Thanks.

