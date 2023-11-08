Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7898817
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Cph52hL8"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44396197
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:31:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc5b705769so57716555ad.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 17:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699407100; x=1700011900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDZ1lbxCpYQjOffbM7wWni9lMnf9R7Pu35PInzoz+9s=;
        b=Cph52hL8zwv5lTMqrHT2bkDL4J0qhTyqT0h2hEfEP//tUqmw8P30GioXVreScnWJN1
         2bvBrGJU/nw+n+gOhWTsHP0TAFY7QOKBdwadNigSAJjLhJ2S8bR9olMX1SaONVNua1Jk
         jOr4BB8AfXUla/LrzaC8KfqjORkyDFTPmbPeYAlL0Io/51nfB29AOuY9ifsRoUUmEubR
         Iw67pm2yjKsJH09TPVPf8vFVIuc/hE4ssXE4at1v8uGLx3XxBNPfAp037y7xX8w+gzNc
         U4h837uaxhBaBLfPXWL3nDMRHHbWHMGemJ2wim1/FM/UUeiMnv3NQJ1lLKclXxmg5QHl
         oXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699407100; x=1700011900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDZ1lbxCpYQjOffbM7wWni9lMnf9R7Pu35PInzoz+9s=;
        b=aWq88tyP1YfWiwQMRXqAm8Haqn72WPhusFtIvtWsrBcDmen0bmgl4wh+FIUTbxWFQa
         /wCYPi3bxqgBDB6bVj9M4z1bqF2gfivHgSroli2LFPYQwB8336BIbStxhxkJhekRfn98
         Dx6vhXgmurHERe4zoTk/WxihDP3IkduYWoSW2XxXUNBYR6qyA+zf/eQyGV7PNd+gMuaY
         alSlcN0YsDw45yU0oRCbAuPYgjQ51lxYia6Tm/6OJbG4rVnc9VNes63YaM9fnCYZssvW
         YFchp9iu4IIKfC32vOGqfeqSQ/Rk7gGGqWvQLFZ5tWHPyZcs9Twv/XsxjZdj2XrcmKBs
         tHlg==
X-Gm-Message-State: AOJu0YxWx9u3Iyw41EnkLpdAvzU3bsITzZRzIQ//A7yLykOLchn/5uys
	2Gg8SdZHDQo8x8DTUVNQuje9
X-Google-Smtp-Source: AGHT+IE+Uqqvyx+bCMF2sIJBxmfd83yLDYAxrrnplQhw5Tj4SXfsgG0XLcKDye2ouph3B7L0FUZiRg==
X-Received: by 2002:a17:902:ecc1:b0:1cc:2ed0:5ab1 with SMTP id a1-20020a170902ecc100b001cc2ed05ab1mr797811plh.17.1699407099669;
        Tue, 07 Nov 2023 17:31:39 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001c5dea67c26sm439057plh.233.2023.11.07.17.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 17:31:39 -0800 (PST)
Message-ID: <21dfe606-39f5-4154-aaa4-695e5f6f784d@github.com>
Date: Tue, 7 Nov 2023 17:31:37 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] for-each-ref optimizations & usability improvements
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <xmqqo7g69tmf.fsf@gitster.g>
 <dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com> <ZUoWPpFHEi-PZjoD@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZUoWPpFHEi-PZjoD@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Mon, Nov 06, 2023 at 06:48:29PM -0800, Victoria Dye wrote:
>> Junio C Hamano wrote:
>>> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> [snip]
>>>>  * I'm not attached to '--full-deref' as a name - if someone has an idea for
>>>>    a more descriptive name, please suggest it!
>>>
>>> Another candidate verb may be "to peel", and I have no strong
>>> opinion between it and "to dereference".  But I have a mild aversion
>>> to an abbreviation that is not strongly established.
>>>
>>
>> Makes sense. I got the "deref" abbreviation for 'update-ref --no-deref', but
>> 'show-ref' has a "--dereference" option and protocol v2's "ls-refs" includes
>> a "peel" arg. "Dereference" is the term already used in the 'for-each-ref'
>> documentation, though, so if no one comes in with an especially strong
>> opinion on this I'll change the option to '--full-dereference'. Thanks!
> 
> But doesn't dereferencing in the context of git-update-ref(1) refer to
> something different? It's not about tags, but it is about symbolic
> references and whether we want to update the symref or the pointee. But
> true enough, in git-show-ref(1) "dereference" actually means that we
> should peel the tag.

Since both annotated tags and symbolic refs are essentially pointers, it's
not surprising that they both use the term "dereference." Even though
"deref" refers to symbolic refs in 'update-ref', its existence as an
abbreviation for "dereference" is relevant when coming up with a way to
abbreviate "dereference" when referring to tags.

> 
> To me it feels like preexisting commands are confused already. In my
> mind model:
> 
>     - "peel" means that an object gets resolved to one of its pointees.
>       This also includes the case here, where a tag gets peeled to its
>       pointee.
> 
>     - "dereference" means that a symbolic reference gets resolved to its
>       pointee. This matches what we do in `git update-ref --no-deref`.
> 
> But after reading through the code I don't think we distinguish those
> terms cleanly throughout our codebase. Still, "peeling" feels like a
> better match in my opinion.

Hmm. I think I mostly agree on your definition of "peel". In the docs, it's
used to refer to:

- recursively resolving an OID to an object of a specified type [1]
- recursively resolving a tag OID to a non-tag object [2]

Notably, there seems to be a strong association of "peeling" to "recursive
resolution". Which means it doesn't necessarily describe what "*" currently
does.

"Dereference" generally seems like a looser term than what you've suggested.
It does refer to symbolic ref resolution as you describe [3], but "recursive
dereference" is definitely also a synonym for "peel" [4]. That, combined
with the fact that "*" is the "dereference operator", leads me to believe
that "%(*fieldname)" would accurately be described as a "tag dereference"
field in the context of 'for-each-ref'.

As I mentioned in [5], I'm going to try adding this functionality with a
field specifier rather than a command line option, so the name of the option
might be moot. But, since dereferencing/peeling will still be relevant to
the changes, I'll make sure the terminology I use in the documentation is as
precise as possible (i.e., use "peel" where I previously used "fully
dereference").

Separately, this has inspired me to revisit something I've been putting off,
which is to add a definition for "peel" (and now probably "dereference" as
well) in 'gitglossary'. I'll try to send that out in the next couple days.

Thanks!

[1] https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---verify
[2] https://git-scm.com/docs/gitprotocol-v2#_ls_refs
[3] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefsymrefasymref
[4] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefcommit-ishacommit-ishalsocommittish
[5] https://lore.kernel.org/git/cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com/

> 
> Patrick

