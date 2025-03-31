Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183207082D
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435481; cv=none; b=rF2FLfIsl6bZu0Z7LEGBmOqMx9Vf/GNlxB+24/WRMRkYtNnwme5htSuZ5w8KXMCHpy+lCXg0C/O5Sak+9+5yapHrqChZg6i7eAaSYbiLIQ+rkkAxi2bI2poDmoKGLfTBM0yqLUFcZhM7gVD+j/9WhMzclEcr4zVYW526Y5tBvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435481; c=relaxed/simple;
	bh=pTLDmnI+afC3Nv3/HAfLh9/64GM/HHUowwTUwz0a30o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH87BdCOGkPqKE3ioHR+D4+GSB1n9uVyfnzXG2ap9KqZkjrMAPN6XW1G9CIMLzWxz0BKFPv2c2zQqqNwak2kFiHPFe5nnWAbi0gXOQbTCUX1EJdlxn6BqdPdm/cDHXQMVl6SVpdCRDT0enUT7yYt7roYRKJwNv2DieZBLCxz4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSL9Tn5v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSL9Tn5v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-399744f74e9so3035873f8f.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435478; x=1744040278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86XV/qomHzRdZdRbCet2TdDrszHAZ3TvkYgp+Zq+8lA=;
        b=WSL9Tn5vvJKsZrhmDOmKyblKD8y62R5aEjgdOUy9RnDUt1kcG0eSR56eXF8ZR3eObt
         wVpl/sksvdKguRCJ6expGEECRqCHeowxsXE8C2gxrUMRtk5pjgcopaeN+DKq1HNh/lB2
         SF1MvQED8IVD9FxBHWlLQhk7iYjpVeywcWCKHTq5BvwpEC8O5e3bHEBrB7OouYTlMyZe
         BZQciRen+c8DuED3gzdq15j7HJ5RKjmAzJI0L5QoPvjsWB0RJfZil12gWyHkgFGoWdA1
         FNK/Zgs9Ud9mQf3UGKBBQ38u1SdErZ/fu2OsbamRcQZniK45CIqU1GYaeD4VYv/5uHUm
         b4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435478; x=1744040278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86XV/qomHzRdZdRbCet2TdDrszHAZ3TvkYgp+Zq+8lA=;
        b=RXAk/xlOmMEaAPP/6t6zgkGuhezDFygGXGSlh35QF7EZkuW/7YrhgzP/OP7wCkkHez
         IVaZNP4LdSAq92uD/yESN00+LM34YnVkLZri0BY4jCydOZ8oXqDzSX0gIoa0VhNi5snq
         Zm6UO4aIf1Jy7fBzU3jXmbhGtBk+ERdoilY8/RniS/7cSAP1ivJOKuER2d0q4fj2EDo2
         8AsdzG3xL91M7EGNDM4LJUtrIv9b0W1Ze6LNP8O2wYhrrG+qDrt37LjyO1O+D3ur4uES
         cfgd5t0Nf2Zh52XdrtcVPdrKAgMvtTJECAnAF5eVpujfdeatUV2vnTQoP9+Oodbd2+l4
         9AQg==
X-Forwarded-Encrypted: i=1; AJvYcCVz8PT9NOMkVQ26B45OfdmiXMQNjCz03WRotiasN/Waiz/UeiamjbKU4oUYEZAWorggayQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxU7gHcehxnTdasDAstPlIJ2KeeLyBZYHU9Qc4Zk2YYJbaXAER
	1c7bH00ZvSl0/V+CTt/ALgoDcyOu5ZrKumvHTZhrJWXKufDsHuvn
X-Gm-Gg: ASbGncstbTboc7ZdC6UaKcleimms32s/YCIxoctOU7R7a5cwM9XSbNhFLc2Lp1cWFo0
	XJAAMDsit5damMc1aoWBRcNBRQBTrvTJJR2NO6X2+az8I+XBZzIFz9lOxtOxy0b48qgGfKCasmZ
	untXtvCw09Ud+9W9RwiNptlDg++UuSRhbVtW98+mSuciDuPwfJIrdhQX0libd8ptRsQ8YfgtyDh
	WlFCHuYIyPByGNAacUMG+17K3HtF/jAUx2RXwvIB6m++DtNsHWucoMdPQGn2z8vezojxXI1t8uu
	kq7OYzSSbvlXDBBfWd0IXAvvM8Ohb84LdFV00woLq6zGg3alkfL7GsUdrUagWWuBHt40rd5/AQO
	po15vfdJfctfgHJQbgSYg
X-Google-Smtp-Source: AGHT+IGotJbQzk9uo0qJEKK4NPShBLI9Nkm6IrgKiHafURR4pbPR4+jnKekFaBj0mzs5dF0789SFSQ==
X-Received: by 2002:a05:6000:2a3:b0:391:4389:f363 with SMTP id ffacd0b85a97d-39c120db48cmr8195047f8f.21.1743435478237;
        Mon, 31 Mar 2025 08:37:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a433bsm11726601f8f.97.2025.03.31.08.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:37:57 -0700 (PDT)
Message-ID: <69b0ab3f-2d6c-49da-866e-71c0eb907f7f@gmail.com>
Date: Mon, 31 Mar 2025 16:37:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] wt-status: also abbreviate 'merge' and 'fixup -C'
 lines during rebase
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <e297b71ba123b642c2e724d7dda475fa52dfdeaa.1743181401.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e297b71ba123b642c2e724d7dda475fa52dfdeaa.1743181401.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 28/03/2025 17:03, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> When "git status" is invoked during a rebase, we print the last commands
> done and the next commands to do, and abbreviate commit hashes found in
> those lines. However, we only abbreviate hashes in 'pick', 'squash' and
> plain 'fixup' lines, not those in 'merge -C' and 'fixup -C' lines, as
> the parsing done in wt-status.c::abbrev_oid_in_line is not prepared for
> such lines.
> 
> Improve the parsing done by this function by special casing 'fixup' and
> 'merge' such that the hash to abbreviate is the string found in the
> third field of 'split', instead of the second one for other commands.
> Introduce a 'hash' strbuf pointer to point to the correct field in all
> cases.

Sounds good. It is a shame that the parsing here is not better 
integrated with the sequencer. I think that would be a much bigger task 
though. The patch looks good and is definitely an improvement on the 
status quo for the user.

I was going to ask about a test but it looks like one of the tests added 
in the next patch checks that we abbreviate "merge -C <oid>". It would 
be worth mentioning that in the commit message.

Thanks

Phillip

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>   wt-status.c | 31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 1da5732f57b..d11d9f9f142 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1342,9 +1342,11 @@ static int split_commit_in_progress(struct wt_status *s)
>   
>   /*
>    * Turn
> - * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message"
> + * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message" and
> + * "merge -C d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some-branch"
>    * into
> - * "pick d6a2f03 some message"
> + * "pick d6a2f03 some message" and
> + * "merge -C d6a2f03 some-branch"
>    *
>    * The function assumes that the line does not contain useless spaces
>    * before or after the command.
> @@ -1360,20 +1362,31 @@ static void abbrev_oid_in_line(struct strbuf *line)
>   	    starts_with(line->buf, "l "))
>   		return;
>   
> -	split = strbuf_split_max(line, ' ', 3);
> +	split = strbuf_split_max(line, ' ', 4);
>   	if (split[0] && split[1]) {
>   		struct object_id oid;
> -
> +		struct strbuf *hash;
> +
> +		if ((!strcmp(split[0]->buf, "merge ") ||
> +		     !strcmp(split[0]->buf, "m "    ) ||
> +		     !strcmp(split[0]->buf, "fixup ") ||
> +		     !strcmp(split[0]->buf, "f "    )) &&
> +		    (!strcmp(split[1]->buf, "-C ") ||
> +		     !strcmp(split[1]->buf, "-c "))) {
> +			hash = split[2];
> +		} else {
> +			hash = split[1];
> +		}
>   		/*
>   		 * strbuf_split_max left a space. Trim it and re-add
>   		 * it after abbreviation.
>   		 */
> -		strbuf_trim(split[1]);
> -		if (!repo_get_oid(the_repository, split[1]->buf, &oid)) {
> -			strbuf_reset(split[1]);
> -			strbuf_add_unique_abbrev(split[1], &oid,
> +		strbuf_trim(hash);
> +		if (!repo_get_oid(the_repository, hash->buf, &oid)) {
> +			strbuf_reset(hash);
> +			strbuf_add_unique_abbrev(hash, &oid,
>   						 DEFAULT_ABBREV);
> -			strbuf_addch(split[1], ' ');
> +			strbuf_addch(hash, ' ');
>   			strbuf_reset(line);
>   			for (i = 0; split[i]; i++)
>   				strbuf_addbuf(line, split[i]);

