Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42455775
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537614; cv=none; b=U8ft18Mp71OvJcoMBIQB0AhMDtVYcWzWRaNgtwm57cImg39zx2ahixvjlDr9fNGI9NhSlvvQZbTRoo0UHvWTdNV4PTA47QDeR+TY2d7od96MY1EPyzL6YAO4eV8NvcIpwWsrrLrwSX8MeckW6ynNecBfo19DHa3Zx5e8NBC0J98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537614; c=relaxed/simple;
	bh=yXhRHoC9ffrCvtNMZ3CuqJTxDVNgZ4wcpTSR0rz+ebc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz9To7XS0uujZEMYfoWcqccDkMdOzwpy0zj+fRk3u73nRb6omJBp3R1rNTlt5rrcpImEd8zvOJy7vUWXiSp9v4a5SxmUMPAZ5a1v2jMY0gemZjOTe8m3/rqiOqxHNJ7PELa6im7vZEXH+tAbZuZlymWkNezuoNgXWC7fu9sJRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+8xiL+j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+8xiL+j"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41493e0fbf2so3569835e9.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537611; x=1712142411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LTQOtBHeS6Y3FZhPp+X4+Vt11plnlnkGFOblVJaGHds=;
        b=c+8xiL+jyRXzYMs+bhSBeBE2uRUTLqga8dB6Lm/G5erJs52nl05E7Tap862jqeGeXM
         INDWoOXSdzoyGGZFeCMH8CDb8b+wioH6Hyv3maebti4TF9cxJBLc1gYboHGc7BEnQsd2
         jKBRAuwDPypQLXCbNyZnD/uBzjyJ2tIZleODDe+u15dRGtIn9OBsfHgB11qPGLiKcPci
         SfO7B8t6yl7N55RzfSXtqgATSucaAl071SBYW4MNQAVANAep9BJ2vIO66cI9UjZH2e4S
         lfHu0XGWXlFHwkIbcHfuIr/mRk6zupAuyNta3RXXEs31duZ1Ny8KY6l29A7/fPMNMQWX
         P+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537611; x=1712142411;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTQOtBHeS6Y3FZhPp+X4+Vt11plnlnkGFOblVJaGHds=;
        b=sr7lcKynzbnkYLo6R0wUDOOEzMaQCjWDH1sV/YCAXtA9SK2rMhjxdys0UBwZFeSKnN
         h3YSvF/S+2QBHbcpWu8DKKkVVb5TM64eQHhXERkWOnWB2TkSH46jIvjQtja8d/W/cRsS
         PRAAWzGXtiMszV0BbwxIBNUSRW4bVOSqZ5aooizAkRcP06G1/TeEydyFnAsGOc0kSeXB
         3ghe5DpLoaQmLHe7esUFLQe2l8uLljyupapSNm3CTsR7qhzEvoeG3fR7rRVYhR462vLe
         GRHQZYQ8VY1BJYwrHBZgNsFuZpDlMqoYgKbNufKtdCrEl/dxVj3+E5/BXBHnj10bg7T9
         BRPw==
X-Forwarded-Encrypted: i=1; AJvYcCXPoVmLLaTOZEO9nY4lEryOC2XsrncRfHDKpxnzgsmA+z8PHKL6eYdQWbIGgGZmtJ/B4d+WEcLe91MlFChiYnWtmG8c
X-Gm-Message-State: AOJu0YxBzxPZlkcCvsfC7j8CYkBXlVlrnIH+S5PGNYkPopWRh9kq2GWX
	bLstXVW+rehRpWarV2BtLG/r3Wc0RmG0oI/DnoLmLhF8Xz6OlfOn
X-Google-Smtp-Source: AGHT+IFQHWnD2yudS/tkEzjANnRNZLFyyY7ED9JU2kSNl7IEnjuKL793h2mjBWrpWYyWi5icQ/q9ug==
X-Received: by 2002:a05:600c:1c97:b0:414:8889:5a3c with SMTP id k23-20020a05600c1c9700b0041488895a3cmr1721281wms.30.1711537610955;
        Wed, 27 Mar 2024 04:06:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1? ([2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id q18-20020a05600c46d200b0041488978873sm1797984wmo.44.2024.03.27.04.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:06:50 -0700 (PDT)
Message-ID: <b578630c-08d5-4a85-85db-c0bdb24a8486@gmail.com>
Date: Wed, 27 Mar 2024 11:06:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] add-patch: do not print hunks repeatedly
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
 <b3c6a5dd-2d78-4149-95f4-57cf8bd1240a@gmail.com>
 <db774d76-5ecb-4b4d-9ede-dce0217c324b@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <db774d76-5ecb-4b4d-9ede-dce0217c324b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2024 18:46, Rubén Justo wrote:
> On Tue, Mar 26, 2024 at 02:39:18PM +0000, Phillip Wood wrote:
>>> Printing the chunk again followed by the question can be confusing as
>>> the user has to pay special attention to notice that the same chunk is
>>> being reconsidered.
>>
>> As we print a long help message if we don't re-display the hunk it ends up
>> being separated from the prompt. Personally I find the help message quite
>> annoying when I've fat-fingered the wrong key - I'd prefer a shorter message
>> pointing to "?" to display more help. We already do something similar if the
>> user presses a key such as "s" that is disabled for the current hunk.
> 
> Yeah, I would like that too.  Maybe something like:
> 
>       $ git add -p
>       diff --git a/add-patch.c b/add-patch.c
>       index 52be1ddb15..8fb75e82e2 100644
>       --- a/add-patch.c
>       +++ b/add-patch.c
>       @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>        static int patch_update_file(struct add_p_state *s,
>        			     struct file_diff *file_diff)
>        {
>       -	size_t hunk_index = 0;
>       +	size_t hunk_index = 0, prev_hunk_index = -1;
>        	ssize_t i, undecided_previous, undecided_next;
>        	struct hunk *hunk;
>        	char ch;
>       (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
>       Unknown option "U".  Use '?' for help.

Yes, I like that (though I'd use the same quotes for both parts of the 
message)

>       (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
> 
> 
> I think such a change fits well in this series.  Let's see if it does.

I think it is a good fit with not reprinting the hunk as it reduces the 
number of lines we print after an invalid key which keeps the prompt 
nearer the hunk text.

>>> -	size_t hunk_index = 0;
>>> +	size_t hunk_index = 0, prev_hunk_index = -1;
>>
>> I found the name a bit confusing as we have keys for displaying the previous
>> hunk and it make me think of that. As it is used to record the index of the
>> hunk that we've rendered perhaps "rendered_hunk_index" would be a better
>> name.
> 
> OK.
> 
>> Also as it needs to hold a negative value we should declare it as
>> ssize_t like the variables on the line below.
> 
> Very good point.  OK.
> 
>>
>>>    	ssize_t i, undecided_previous, undecided_next;
>>>    	struct hunk *hunk;
>>>    	char ch;
>>> @@ -1448,10 +1448,14 @@ static int patch_update_file(struct add_p_state *s,
>>>    		strbuf_reset(&s->buf);
>>>    		if (file_diff->hunk_nr) {
>>> -			render_hunk(s, hunk, 0, colored, &s->buf);
>>> -			fputs(s->buf.buf, stdout);
>>> +			if (prev_hunk_index != hunk_index) {
>>> +				render_hunk(s, hunk, 0, colored, &s->buf);
>>> +				fputs(s->buf.buf, stdout);
>>> +				strbuf_reset(&s->buf);
>>> +
>>> +				prev_hunk_index = hunk_index;
>>> +			}
>>> -			strbuf_reset(&s->buf);
>>
>> I'd be inclined to leave this line as is to make it clear that the strbuf is
>> always cleared before adding the keybindings.
> 
> If find having two strbuf_reset()'s in a row confusing.  Maybe it is
> just me not seeing that that second strbuf_reset is "close" to noop.

If we don't print the hunk then the second call to strbuf_reset is 
indeed a noop. In our code base it is common to see a call to 
strbuf_reset() immediately before adding new content to the buffer, 
rather than cleaning up ready for reuse after the buffer has been used. 
If you grep 'strbuf_reset' in this file you'll see all the calls come 
immediately before adding new content to the buffer. By moving the call 
inside the conditional we're moving from a pattern of cleaning up before 
adding new content to a pattern of cleaning up afterwards which I think 
is harder to follow given the way the rest of the code uses strbuf_reset()

Best Wishes

Phillip

