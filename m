Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B7450F2
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828110; cv=none; b=rz9eGOC3+A0BSg6XdI/yUYDeaS6GEPY3zTCTQEulwYTXbA/jMQ7d/fX6c+PliViNA63QAAiTzWHixyqhuHVAyya4ARoqJLY7Mv/NYErrcd6qmbk+NYmQA3K5YBHsFSKSbgZV6WPpKkzA+srq7za/o5xZNHpzz18mnZFXUaAm6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828110; c=relaxed/simple;
	bh=P+K6XmN7Bs+I2gM0e8HDszXj9Rz11xO+gvlIYCVP16k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHdptfsWPylmESiHIjAk3xJfire+9wbPIR6WdmHxPsxDYYHsfxCNv2c5diW5Km5+bME1XUQ6VDatU8WZfmtcb9YYv6wD6MwUW1Zb6ztJnDGoVhFraYQ9iCXLuQweEKXhXeTpG/CXfK0t2Ty1cOtioYWRC7Ja5ObIkq7GjSK0oVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybo87ZnG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybo87ZnG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698823a9881so641600a12.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828108; x=1783432908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndBseJCQYo8pIDhEvAR6TPb5bC7uyxQBA3hV2jNAvgI=;
        b=Ybo87ZnGmoJsIkne3ZXWzvYliy1ZSn+b41aS/tpM3orzoZlNgk20f+zS3QMzKbIMLe
         DRD+TrtAH19ivuj344unD1cgmlCRYleJarRtDRr2KQWtZECkN/jr6eek333FQamBOj8+
         aZSXOoyPVhzFrap+WxMlG3TVvFYmyNBt2cC3rWT5ONYDJ2A9RPL5E9CIRbDQRj+gTRVm
         b7soJ4PQsHgClT21q++e0u/Gw5Woz8GS7/KwQaJBOCvAWdujV/qKLby2VW0066JmNXy4
         ohY7xcBSc80rTyYdaSDVbZPd5vywr2bh1fjT7g7ZpN5a0wqteirvlK4cOn/ugQaF83o0
         RbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828108; x=1783432908;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndBseJCQYo8pIDhEvAR6TPb5bC7uyxQBA3hV2jNAvgI=;
        b=ouAl+WFeob+elJhtTg1uYfHmByoLErsJhEhnB7qRxJzf6DcsjtyQxJ+xjyKVOU9NXm
         xBr07A5DwZoz1Pa5Q05uQVMhv0R0SL/2WUOM+qMouxBnQd5/8JlOkCi+ufoJR6QoC4tm
         da/34ZLlWp2HohSl03ZIUWYYrnwFgEdTET+uS9dmBHvAkSy6o5SPYTFZCr5qTdy99KnG
         T31mBdeP1OqKUSoZGUcMsPWfL+2lQ4TIkUTl17Fn/v+ybJQsdCq+WM0p55De5XSYey2i
         AsBtjPAblO8ywOlxqoKRPR1MsEBZd78hiiBKIKUTksGlusmPhkN8NJll7XWrSlCiwZRB
         Sbog==
X-Forwarded-Encrypted: i=1; AHgh+RpEXk/pXF7t7xs0qE3whwLIM4aKLXWFIW8wWR+pUIVDeYRZWbTxu63U6Jpu/hS7pW58Vtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHyH4mFtCttVRtCZN4hdTWIdsH+4qY9vMPC4NYBR8TfZHsU2e
	GVQcByXBvol5cEKU3jC31XvCU3MATSh7p0BzUmkvNxlebALcf79UuHLq
X-Gm-Gg: AfdE7ckB2tLio3Qf4xJyvkO14d1Xgb5qVenXepnSzT/iL3+1pSuahpvZw/sCqT4fJ4m
	ubn55Yc8k+oP0EIqgKjvk1kcByngLjg08bJhmaV4VKPl36HizL9TQQt6o4B4egxvfCOkRt0QAdw
	HQYQ+hgO5pmr5Up82/uK+OQUEHms5AxT7PuvK2E6y3XAwXGChok3Pi3wd46OuTL7qLForrrN00C
	o7NX91ImYeyb5obKU7loVQ3/faM4BL9Xdz2yea3wrs3OFzeKTiRTl4b/COmeXS1to39ZfbsalKd
	0mST7npLX8zdzgEhncJrArZv0+nYtgyUjozuY/FcY3q45ZJLN17was+QBlJ+qrcTtgA522HZBtq
	n7MH/o+7mxrELY93U0ik6o9vMFEBBgKvZUPDGl5ApbC4R7Hd1dzLfIEadDPW2b1vWAiNKqurjte
	VlkSAV/NTK4NPZZL1fB3o31cxCcycsrDwXXEFBN7ByhPchj5QSguflxx+dEGSuNvECTM0=
X-Received: by 2002:a17:906:68d8:b0:bb7:eb68:514e with SMTP id a640c23a62f3a-c1297facf63mr25046966b.36.1782828107182;
        Tue, 30 Jun 2026 07:01:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1289176eb0sm134443466b.63.2026.06.30.07.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:01:46 -0700 (PDT)
Message-ID: <3c35bd17-e884-432d-a400-36a89964ed89@gmail.com>
Date: Tue, 30 Jun 2026 15:01:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Matt Hunter <m@lfurio.us>, phillip.wood@dunelm.org.uk,
 Harald Nordgren <haraldnordgren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 30/06/2026 03:55, Matt Hunter wrote:
> I haven't experimented much with the new 'git history' commands, but
> this discussion caught my eye and wanted to chime in.  (aka: please
> forgive my stupid questions)
> 
> Note: I have built and am testing with v6 of this topic.

Thanks for testing it, and also for your questions - it is always 
helpful to get the perspective of someone using the command, especially 
while we're still designing it.

> [...] 
> I agree with this idea as well.  And letting fixup! messages completely
> fall out makes more sense here than I want to say in git rebase.  The
> commented list of commits at the top is a nice compromise for the todo
> list you would have seen had you run 'git rebase -i' instead, and a
> glance at the list would confirm that the fixup!s you thought you
> included _actually are_ in the squash range.
> 
> I assume the same treatment would _not_ be completely given to squash!
> messages, since there is at least some expectation that they carry an
> additional remark that the author might want to reword into the base
> commit?

Yes for "squash! Some commit" I think we'd want to have

     Some commit

     Some commit body

     # squash! Some commit

     The body of the squash! commit

> Given the above, and how 'git rebase' usually works, I'm suprised that
> --reedit-message isn't the default behavior.  This may be my bias
> towards rebase showing...  Perhaps the typical use of this command is to
> just work fast, and expect a follow up 'git history reword' if needed -
> when the original just needs a little extra context?

That's a good point - if we want to encourage good commit histories then 
opening the editor by default gives the user an opportunity to double 
check which commits are being squashed and edit the message as appropriate.

"--reedit-message" is a bit of a mouthful - maybe we should call it 
"--edit" (or "--no-edit" if we want to open the editor by default) like 
"git commit"

> This is probably a larger question, since (according to the man page) it
> affects the other 'git history' commands as well.  When I run
> 'git history ...' and discover that I made a mistake after inspecting
> the results, is there a fool-proof way to undo the change and return to
> the previous state?  My first thought was to run 'git reset --hard ...',
> but the default behavior of --update-refs (moving other branches) can
> make this more complicated.

Yes this is a problem to which we don't have a good solution at the 
moment. I believe Jujitsu and git-branchless both have some kind of 
operations log that lets you revert a whole operation rather than just a 
single ref-update. We'd need some way to tie all the ref updates from a 
single ref transaction together either by logging the separately or 
adding some form of transaction id to the reflog. That would be a big 
change.

Thanks

Phillip

