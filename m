Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442534A3C
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751117886; cv=none; b=TCMOR1zQ7xA1HCzL5W8lmFvz4fRaVkvfdMyLOInLeFXJlPFRu23pLvgKWGvN9oOV3S939RXOY5eRE4ymJN8QrgfMbBqx8WpMgrgcpwf5mRH5sylY9MGA7UeP+iw1LjSyTI1x9DZ2Wfk8P1j8kKYLBBDoRsX/U8T33DfO0QIxel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751117886; c=relaxed/simple;
	bh=Zw9FiojhYffeHHpmgSBL0QCjQpDClSnHwY9MkqUHSmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU1iom+Vp4c7wEXMrqvnRY07dJ0OeLLzwXR3XEV1MVjb5/BWtE80eBqsmeM6mEMuTCEYWb6TdJFqrXG6MdE99JCOqgvJpD3O4Yp2TxXUn37DgtIXxmmT87ZnjoCel2lB5FpQjv9i+VjzMDu3qnt2CDsU4wj6nJYRAByoqBf8pzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrvT2MGN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrvT2MGN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453749af004so16696405e9.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751117883; x=1751722683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VXIEQtk7XFNaLPPQw1Lupsak6Mk+RvTGmyADseR7pGI=;
        b=YrvT2MGNscNuuvebyfc/ppfmBdpMlHIlaPpO6M85HJ984u4pF6KdFUv2e7vlawNWDk
         vAg4AzZ36QntU7n0ZtRF5OyjZLU2ukgN3mLZ3FtvX9LCbRhJO9Nw7UaVbF5p6XF9Mgm1
         SjFTWaRn5w07H5BFOFEULg/7koWWyIhRBmBzFQhqn1heMtONHuHtX/P1Pey+e04sK9TJ
         GlmxiJi6xDnl9heAA1YOQAq3iTFV+F+9dPDlXHT4/nJkmslzR5n5/LUoWTfgCmjN6zWi
         ilbxQQ90gUBBULRCxnuk/kPlVWtY5F0Pk0xXjEKk6xsPFbJhuuyMC0YcMpo3riwhakdw
         CHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751117883; x=1751722683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXIEQtk7XFNaLPPQw1Lupsak6Mk+RvTGmyADseR7pGI=;
        b=pVlpVpqVX69v9gmdlVE020sjhpVZa03jpns6VLaYn+sxhYpNaIEPoVwYcYs/M1alSL
         aALfs9z/NvhaDjGtdcRdJh5I0y3AQ8Rg35IG8/KqV/x5E8mETs4ayoU3GV6WGL8r7K89
         HwWF2YLboK0ONHwgsk0L6qT6OK2YXybQIfEUlueqEsKI06nmiamxYlKIAZjR+uhRF+cU
         R0cvtspIKpRJnlbLjQqyPehFpYoiK+qItEms2optDywE6Mtx/JE73QcQpe1sPL1k5Yd9
         Cu5atJHG/WRUKT1NOGp6oD492d/31ISBSkx/KVxXpz7HY+etVt8wGuEDdcvBopc3cjUu
         /z+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVAr1lgSmViUo+Fytx7aB7VqP+eaXxL++kf7C8+mzA117006oltd06h1yNUj9X0nQMfn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMZtnKRtk41N05VKmhvvmgedi1QfcohOkhNQvAEczGSYpLL/K
	3sI1ZcWotzqJBNPngA9iC/Vtg8BabKBwsGs1zQPh97EpZjVDV4KxoE4X
X-Gm-Gg: ASbGnctWP4Yaud8Qa58Yf4TmuGuRfFNbdea3QhxSbcdyxviINhTw+8wmQoAcSXLRNtD
	MlNdfisvPbBwQ56NPtJL8fdaFBMhbb2QSN85hvGOm8BB//7bldEwgLRNap8xfK9KlcrdrsyG5pO
	rxWMpD9NttNarCGMy7gryUejGdrznZB2p+HpQFUCUTgVI6RwumR7Uj4ofjZpkCvqONur1wCuWiC
	OUssFEix+/qujXvF7XpBlGGJaMcb3nUSG7y/1ghtMzJSwtsuXH064MnAqsTmweFQUn348xzjpH6
	MlQsbca/kxiOH59BmUeV6TIdwtSrbQJmXvwqlFAdnCDxWAJTNbhBv66S/LZ3uwFOztrsCykRYBo
	TMnMI/OXuBiGBMaViMaIwyW7Vn5aViFW+ia67Dg==
X-Google-Smtp-Source: AGHT+IHO+q8DuMuL30Lx9rSMkfHyhW7BJ9qPeR4TiZu0fEzHjZDbkHlpJU9cTQBcw7jozsYiA1Q0Hw==
X-Received: by 2002:a05:600c:699a:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ee5570fmr79637125e9.17.1751117883142;
        Sat, 28 Jun 2025 06:38:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f842sm5266188f8f.86.2025.06.28.06.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 06:38:02 -0700 (PDT)
Message-ID: <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
Date: Sat, 28 Jun 2025 14:38:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Junio C Hamano <gitster@pobox.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, christian.couder@gmail.com,
 git@vger.kernel.org, shyamthakkar001@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com>
 <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com> <xmqqms9t8cfd.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqms9t8cfd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2025 15:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +	size_t cutoff;
>>> +
>>> +	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
>>> +	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
>>
>> This finds the "Conflicts:" line. I was surprised to see that the
>> string it looks for is hard coded and not translated, however the
>> sequencer (also surprisingly) does not translate that message either
>> so it should work.
> 
> There is a funny chicken-and-egg problem, though.  It limits the
> search for "Conflicts" by using wt_status_locate_end() based on the
> current value of comment_line_str.  When core.commentstring is set
> to "auto", the code that reads the configuration does not touch the
> comment_line_str variable, which is initialized to '#'.  So
> 
> 	[core]
> 	    commentstring = '%'
> 	    commentstring = auto
> 
> would have '%' in comment_line_str upon entering this codepath, let
> wt_status_locate_end() use '%' as the comment string to find the end
> of the log message, and then looks for "Conflicts:" in the result.
> 
> Which may or may not be what you want.

Oh, good point - I'd not looked at the config parsing. So we'd create 
conflict comments that look like

     % Conflicts:
     %    some-file.c

but so long as the commit message did not contain a '#' character [1] 
"git commit" would select '#' as the automatic comment char and our 
conflicts lines would not be treated as a comment.

Should we be resetting comment_line_str to '#' when core.commentString 
is set to "auto"? That wont help if the commit message contains a '#' 
but at least it would be consistently broken.

We could move adjust_comment_line_char() into libgit.a, use that to 
select the comment character used in append_conflicts_hint() and set 
core.commentString to that character when we run "git commit". I think 
doing that would mean that appending conflict comments would always work 
with core.commentString=auto but it is a more complex solution as we 
would need to remember the comment character and then pass it to git 
commit once the user had fixed the conflicts.

One final note - although the commit message mentions a change to "git 
rebase" I think this problem already affected cherry-pick, revert and 
merge before that change. In practice I suspect it is only cherry-pick 
where one is likely to see this problem because the template messages 
for the other two commands are unlikely to contain a '#'.

Thanks

Phillip

[1] For some reason adjust_comment_line_char() will not select '#' as 
the comment char if it occurs anywhere in the message but the other 
candidates are selected so long as they are not the first character on 
any line.
