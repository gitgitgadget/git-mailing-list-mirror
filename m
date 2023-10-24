Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65929437
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdv9rP3j"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CCFE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:01:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408382da7f0so37275275e9.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698156060; x=1698760860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HHkKianCxFBcRDL593EH77nm8GXs8q4EUBFf931idtA=;
        b=kdv9rP3juFillEjkspsjOyUuIKIvMKreNOiU6k3SzbxpncTT1ceOAOtO9UrcSwwxLv
         zbCCXRGPy9f4Swbqn3Ki0cmHhqVzjislr/uV6AyHwQXp5T7uLhAeTDWlEWboY1PC68k4
         er/r1pCldGqWhcKYhE/Sx6n07F6AXrwuKf8zLrap4H9c6Tr7ULGI9Nl2hgXRaE0e2Bli
         1+xxTqXS68o2Aj9kX6RxxEeeXAkYASvIPYiIBGNawuX902RFYyu8yOOrl/vUVMibbCoY
         qIAoveAYnlUliH95sHL0SGW/WeDYXtYpzXFq8JFIWTeXvQ6DIY3jhiI4AhKwbnz4LOdy
         0HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156060; x=1698760860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHkKianCxFBcRDL593EH77nm8GXs8q4EUBFf931idtA=;
        b=aXoG1gFeFKrLdXHeH/GjWJIPmKHZVviZLKb/x/ALph7tmQTBaXGIPyyyTzNF+CkoDb
         HsS1vbWCGVt7Vw152re6DY+XfnlYuTHQYFdFU2ivXj4l/XmDBqXhDWIk1Qkc+VSLQgW2
         gN4mBF0v9xWrpL/dg6gNU1HMReA8+/GFWUbN7FyWrKhJUZWFtjbs+1MewIhLC6b4YY5g
         EJfMNyGudN6RpDlDtUQUCbRy3HLzpbv8q3QjZuh6BohevHhR8xEvwi+Y5nkj1FI3Zk+P
         8yMbcuY/n3OgnPLMHE3tvR085BS8eBVviM47O7bFVC7mYxcBNCntmvp9z4VQJAt7Lviv
         +g2g==
X-Gm-Message-State: AOJu0YwBrdT3W6Tza0C8LGCtFBH2894rdDszjhEBr8AD/TfqPXW9WevJ
	6soHEN+SmcfS/NSj1urLsceDSK10Ihk=
X-Google-Smtp-Source: AGHT+IE4rN3FhnDdFlL9C9Hpo4Z6Jkgo/Wr43+g2ZDMW5YZ/u4mmGFckYGRu2MdSzoJgsZraQMDWow==
X-Received: by 2002:a05:600c:4e91:b0:408:4551:fade with SMTP id f17-20020a05600c4e9100b004084551fademr10056677wmq.38.1698156059664;
        Tue, 24 Oct 2023 07:00:59 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b00407752f5ab6sm12302504wmo.6.2023.10.24.07.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 07:00:59 -0700 (PDT)
Message-ID: <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
Date: Tue, 24 Oct 2023 15:00:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, phillip.wood@dunelm.org.uk
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com> <ZTeZ3KEQLIVU/sq2@ugly>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTeZ3KEQLIVU/sq2@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2023 11:18, Oswald Buddenhagen wrote:
> On Tue, Oct 24, 2023 at 10:26:29AM +0100, Phillip Wood wrote:
>> On 20/03/2022 08:05, Johannes Sixt wrote:
>>> Am 19.03.22 um 13:48 schrieb Oswald Buddenhagen:
>>>> during interactive rebasing, i sometimes find it necessary to move a
>>>> hunk from one commit to a later one in the branch. now, if that hunk
>>>> cannot be re-ordered with the later commit due to conflicting with it,
>>>> it becomes necessary to squash the later commit onto a temporary commit
>>>> created from the extracted hunk, not the other way around (or using a
>>>> stash). unfortunately, this causes the author date of the later commit
>>>> to be reset, which can rather seriously falsify the date if the branch
>>>> is long-lived.
>>>
>>> You want `fixup -C` in the todo-list. See the hints near the end of the
>>> todo-list.
>>
>> Unfortunately "fixup -C" only copies the commit message not the 
>> authorship
> 
>> (that's usually a good thing
>>
> why? what would that be useful for?
 > it seems rather counter-intuitive.

In the same way that you do not want to change the author date when 
using a fixup to move a small hunk from one commit to another most users 
do not want to update the author information when they make a small 
change to a commit message using "fixup -C"

> it's also inconsistent with commit -c/-C's behavior, which seems like a 
> red flag to me.

That could mean the option is mis-named instead rather than the behavior 
being wrong.

>> but not it means it wont work for what Oswald wants to do).
> 
>> Maybe we should add another flag for fixup/squash commands to take the 
>> authorship from that commit.
>>
> that's a possibility. but given the above, it might be better to simply 
> change the behavior of -c/-C to keep the UI lean and consistent with 
> commit's behavior.

"fixup -c/-C" were conceived as a way to reword a commit message at the 
same time as optionally fixing up the commit's content. I think changing 
the behavior to automatically update the authorship would surprise 
people and as I said above most of the time one does not want that behavior.

Best Wishes

Phillip
