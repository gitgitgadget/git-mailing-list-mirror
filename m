Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EF10F4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="DrxtjnPg"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698C13A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:13:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc4f777ab9so45903005ad.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 17:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699406034; x=1700010834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRLheATbIuXKQYPWY/0iefoaxrv9N/J+k/mXLdLiKJg=;
        b=DrxtjnPgDE8Bqu60YT9w6NlMYCa+g23ZxV16I83jmLYezCCjDxSDGMcv6i1Ag98zEV
         V8HVs9JkYLEuappcS3AUYZi+si/3J3fgCFVAt7InfztXdbijJQmWBylCeedvPpvTj77U
         w2xl7zr0TXM+iw6mk6UCCJBi4RJvnGx+rJiK3SJm5qocY0Wl8nY16moyXBT4Ajl5W3s9
         p5ahLJ4P6sy5s49ExBX6VaMma0Wnme+hiTGK0tMNAtPTMc7VfALxF6eXJo5xxkrDc98O
         5nS0H9xmfOkjIxrAA8jOXX2JJSsLQuHeY7Ai+Nef7pHKrcf+TNj+IV70Gur+09azsP8l
         nJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406034; x=1700010834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRLheATbIuXKQYPWY/0iefoaxrv9N/J+k/mXLdLiKJg=;
        b=d6L4mJNwvpA5zyC1Ds/Hhkkk/TGFt0Mcn7jhvJzAJi8esjArBJ3nCVcaZe3v7quXlA
         AJf34RgbB47nwHicKaC4Hz5xb34rZTRMXh7lCOCRCa4UiGjWXsvXzPy2HVwTjA8dmaI0
         bDnX36OLxcc1Kl074iTWmsnYEgSPP2ukuZ6WPZiUszCDu5Flg0aW1H4JuTn+qgDX12Hs
         XoXgMIwOPzE7MQRN048DnlcaWLj4slremtw4pa3CQnbyjsELZsoisz2kj78dvsy0XMva
         vvtjjfFNAVfkxgBEiUsRNJT6/Se4Mh1qeiaPO/xMjBKN33ijC5IHgaR2fwj8mL2ofybC
         tD0w==
X-Gm-Message-State: AOJu0YzeOInrjC4/SVLs0oXP8jEeG8e51IjfHxi6UrQb4WWBGkCsRTwJ
	Jb1wYakhsxn+zFDWgUJZdAG4OpjtAV/cmi/XoA==
X-Google-Smtp-Source: AGHT+IHeT+qRAOst4AWXJtx4CL6FBvKpkjhirs8NlTZINdUenhHssxS/AlZews7Axx3bxVw61wYufQ==
X-Received: by 2002:a17:902:b596:b0:1cc:68c4:8c60 with SMTP id a22-20020a170902b59600b001cc68c48c60mr619445pls.18.1699406034031;
        Tue, 07 Nov 2023 17:13:54 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902e88500b001c5fe217fb9sm416837plg.267.2023.11.07.17.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 17:13:53 -0800 (PST)
Message-ID: <cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
Date: Tue, 7 Nov 2023 17:13:52 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWWo7IEKsiSx-C@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZUoWWo7IEKsiSx-C@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Nov 07, 2023 at 01:26:00AM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a boolean flag '--full-deref' that, when enabled, fills '%(*fieldname)'
>> format fields using the fully peeled target of tag objects, rather than the
>> immediate target.
>>
>> In other builtins ('rev-parse', 'show-ref'), "dereferencing" tags typically
>> means peeling them down to their non-tag target. Unlike these commands,
>> 'for-each-ref' dereferences only one "level" of tags in '*' format fields
>> (like "%(*objectname)"). For most annotated tags, one level of dereferencing
>> is enough, since most tags point to commits or trees. However, nested tags
>> (annotated tags whose target is another annotated tag) dereferenced once
>> will point to their target tag, different a full peel to e.g. a commit.
>>
>> Currently, if a user wants to filter & format refs and include information
>> about the fully dereferenced tag, they can do so with something like
>> 'cat-file --batch-check':
>>
>>     git for-each-ref --format="%(objectname)^{} %(refname)" <pattern> |
>>         git cat-file --batch-check="%(objectname) %(rest)"
>>
>> But the combination of commands is inefficient. So, to improve the
>> efficiency of this use case, add a '--full-deref' option that causes
>> 'for-each-ref' to fully dereference tags when formatting with '*' fields.
> 
> I do wonder whether it would make sense to introduce this feature in the
> form of a separate field prefix, as you also mentioned in your cover
> letter. It would buy the user more flexibility, but the question is
> whether such flexibility would really ever be needed.
> 
> The only thing I could really think of where it might make sense is to
> distinguish tags that peel to a commit immediately from ones that don't.
> That feels rather esoteric to me and doesn't seem to be of much use. But
> regardless of whether or not we can see the usefulness now, if this
> wouldn't be significantly more complex I wonder whether it would make
> more sense to use a new field prefix instead anyway.
> 
> In any case, I think it would be helpful if this was discussed in the
> commit message.
I've been going back and forth on this, but I think a field specifier might
be the way to go after all. Using a field specifier would inherently be more
complex than the command line option (since the formatting code is a bit
complicated), but that's not an insurmountable problem. The thing I kept
getting caught up on was which symbol (or symbols?) to use to indicate a full
object peel. I mentioned `**fieldname` in the cover letter, but that looks
more like a double dereference than a recursive one.

I think `^{}fieldname` would be a good candidate, but it's *extremely*
important (for the sake of avoiding user confusion/frustration) that it
produces the same object & associated info as the standard revision parsing
machinery [1]. One notable difference (it might be the only one) from
`*fieldname` would be, if a ref points to a non-tag object, then that
object's information would printed (rather than an empty string). But maybe
that difference is what we'd want anyway, since it's a better one-for-one
replacement of 'git for-each-ref | git cat-file --batch-check'.

I'll try implementing that for V2. If it doesn't work for some reason,
though, I'll explain why in the commit message.

[1] https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt-emltrevgtemegemv0998em

> 
> Patrick
> 
