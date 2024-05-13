Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8328BF6
	for <git@vger.kernel.org>; Mon, 13 May 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614131; cv=none; b=SKDMXx+KDPPPO+Sb686Emvi+AfmCbMRjaaDRdIjzs7isL4jInZ7ZE/eIr3GHEYaQnLedSvV9UCXnIfFja6bjMP8870bGveKrtJAS7ivD+X3xZVibWI7nqGg7QpPYAmuQ3/pKOSIQn8aE4aO0oGOuWUW5Q+Iy0C2yQLdq9C801vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614131; c=relaxed/simple;
	bh=RH1/b/XWGVHRQBuJTTj5k8CkDO6hIy/WhfWv0mL4kRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RG9SNr40yzzfpI+TPowlgTNEqaROczgDeWdWFETDfZjyRTzMXhivMnQyXwyTNut/0oCqzch5RKGZEaLk7ZyUeK5X6/g15VxMizjFfuexRNLUBn0iGIkh/neGIrQct0T5MOm3vKtnkUzJ9KndeMSzBJ0og5qlikMBjpSLztD01jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CccCVG3+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CccCVG3+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420160f8f52so7613545e9.0
        for <git@vger.kernel.org>; Mon, 13 May 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614128; x=1716218928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xbVhumrXhhYmj0/ALg9uQ3ohWpCiqfyFBUMppu6Pf0k=;
        b=CccCVG3+O6o6Nor3anZuZYjY4q5Je2ZeP4M+mk+poQVpXK8WxUP/NFXkCCoyiRMZpS
         ACD91kesJSaRTlUycWeS6s/yvvmTbcEdw54ETKkgNsnb0zrmptoRJkDNccCBwH/X3zWE
         6ZadsfLDsw+vg07VBDGk136AjZlscFnMRXKRRAePF81SZqL5oWW4Nx9Dj2l2Zf0EdISJ
         REPwIrTP/QVN2nsKDTvFIEhMy81RXj82auPPXBE3uPVd1kZSZwCPvWAYUTNF6DKPNZU2
         mpmiQPigdflGKERVNTwXC4Ubbn6dFD4YnsBD6JpmeCJV+LAfa6JtewhkW98XStv9Ze7T
         H4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614128; x=1716218928;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbVhumrXhhYmj0/ALg9uQ3ohWpCiqfyFBUMppu6Pf0k=;
        b=KTSECypWFXUUNWw3hTaANHgJXXvROgKCrfVQRdmEoNZm0SvT+AobebiQZQcbWb33gz
         NxS0uM0nCuCuggLPg9btfQDKw/6l3/7ScB1l+GfGBoCcfQy2cvOqsUn9CExpDTC3dD+w
         hUQ2Yv4jRmVQv1GUrVDyEt6vwgBT29fE+8n7XQN5zKbU2I/odnRH8kYGFRXfKtMtf3Av
         22gxUgnJcl3zagipQtM9Od98JRnEsZGMQEsBC4IxBTveAMAKONhBh50meAQAkAJ8oBfQ
         wK/0tlULWpqifWUnsc8YAZ48iZ/ajBD07ts45cxdsa+gnlgHGQ9mTMnjqjB7JpyqOntn
         8eKg==
X-Forwarded-Encrypted: i=1; AJvYcCWFOeU1EIz6bE5Y3iuAm8nUZ5IchBDop/eE6mGedATx9AW5xd/GR7c2LTeq98QABadyOInvTYOilrWX725RFVHNz13L
X-Gm-Message-State: AOJu0YxfsOu40Fc57whX+lJpULQsm97Au/CEWma3QlX4v2YHiLRrZv/9
	XkMDV+cFKBVV0Gv1t3Xwgsb7WJ5tHqPrBO6/rZeuc6TQ8sM/WvG+
X-Google-Smtp-Source: AGHT+IEuPvvEcMXbCGAQhXAGGX+vTa+leyFO0Nvw2T+ljPJk8wuqotoyo5FsYnKzxJ1lUVjjOy7Avw==
X-Received: by 2002:a5d:69c7:0:b0:34d:2d3:340b with SMTP id ffacd0b85a97d-3504a7379cbmr6452285f8f.38.1715614128269;
        Mon, 13 May 2024 08:28:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbc5654sm11434478f8f.115.2024.05.13.08.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:28:48 -0700 (PDT)
Message-ID: <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com>
Date: Mon, 13 May 2024 16:28:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ondra

On 13/05/2024 08:26, Ondra Medek wrote:
> Hello,
> I need a simple script for unskilled users to do a fast checkout (LFS
> friendly) of the current local Git clone at a certain commit to a
> different directory I.e. something like "copy at a point in history".

I think using

     git archive "$commit" --format=tar |
        { cd "$output_directory" && tar -xf -; }

is probably the simplest solution. If you don't want to rely on tar then 
something like

     GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
     GIT_COMMON_DIR="$(git rev-parse --path-format=absolute 
--git-common-dir)" || exit
     GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
     export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
     unset GIT_WORK_TREE
     mkdir "$output_directory" && cd "$output_directory" &&
     git read-tree -u "$commit"
     status=$?
     rm "$GIT_INDEX_FILE"
     exit $status

Which uses a temporary index file should work (note I haven't tested 
it). You may want to add "--recurse-submodules" and/or 
"--no-sparse-checkout" to the "git read-tree" commandline.

Best Wishes

Phillip

> IMO all possible solutions are summarized in this thread
> https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
> I describe some of them with my remarks:
> 
> - git checkout-index : works with HEAD only.
> - git archive: influenced by export-ignore and export-subst
> attributes, so may not produce exact copy of sources. (And needs tar).
> - git worktree add -d : needs cleanup: git prune or git remove.
> - git clone: Unfortunately, -b param cannot work with commit hash and
> does not respect local worktree settings (e.g. autocrlf). So, a
> solution may be a bit complicated: git clone -s -n . dest/path ; cp
> .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
> rm -rf .git
> - git checkout: Unfortunately, modifies Git index, so some action to
> revert index is necessary after: git --work-tree=/path/to/checkout/
> checkout -f -q <tree-ish> -- ./
> 
> For me, the best solution is with git clone, because it does not
> modify Git index nor any source working tree settings, so no cleanup
> is necessary. But it's a bit complicated, though. It seems to me that
> "git checkout" could do this better and simpler if it would have some
> param to not modify the Git index. Is it possible to enhance git
> checkout? Or is there any other simple solution not mentioned in the
> SO thread?
> 
> Thank you
> Ondra Medek
> 
