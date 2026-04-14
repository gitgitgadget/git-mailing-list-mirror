Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986822FE0E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175589; cv=none; b=ffFgaSzV65sh3USJfHUG3keKnCIOofeoxavuATLqMwcof08AY5oDgCAYnyuzQAIyinPAcoYWlEQiLmOZFDw6pA2nlPPAJThdeQQRKy5rQx72F2/+HitzI/5brybRfOH3PsfON57+EXRH8etqPf/orRvzBFQaNzrpmX4FITCnTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175589; c=relaxed/simple;
	bh=jBuF56WYoTlIyZbJGrHSB489ShUupnaEEokMgBBNfYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pHt5h0JNJlLoiP4sf7N1p/XD8bwx8SXyqzSLCY93GG3aEb72OCJTiPDfxMYGVOJBV2YtR8gS/SlnFftfGTp0iTDU5vCk84xuo5OtRBR2k3fH8nMxWf29p/xXjTbYCIEaLAlJKb9sJ65lAqY4r2PAyEfuV7pdKY+0vBiVYlap/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce5QE2Ex; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce5QE2Ex"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso44507615e9.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175586; x=1776780386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXDr47k6Y9ILRmeGDwSu5EJsHORIYaA4mtxGrfTbZzI=;
        b=Ce5QE2Exk/IExavQ2etTa+2K/8CtO0eGRmAQWJNR3oPN5RUt1rx5cLsaXhN03eEiAA
         8M2JRYnFmypEue5ciDwqgFdmOg59Z9m2nN/uvZQM5jzxvOM9liTwaLeIoGiFBzboT3St
         RlHEpxQaf+We/YbizrX9C9hHXwdMgj2AR/goHU+IBhuohcBROuWBc8hIDY5v0C7x0tJd
         fneM920jz12cJghQlZc+TWXHPyK6nBRmdoi+hGCRA8GJvsP8Lg4dpk29o5UIfoestJmN
         ReUyaGJzKaAbI9WRDF7uaHPe4BhqFjFdL6E68URCOrDlGIaFMecfnfbe7cbRkSD2PvrT
         SsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175586; x=1776780386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXDr47k6Y9ILRmeGDwSu5EJsHORIYaA4mtxGrfTbZzI=;
        b=C0sQv1/k7CWuuHx+qzJl+3mm0+A1SJ4uaA1/cZ92qs1bfytiBFH2YBqm7FTOAIG1GG
         hWj5xX3d1H7xtnXtf2zX0MS9eoCtCRvpLnH5avaoOJLVkfdoXd9DFDbbVLnTCWfw2mDS
         L7f2v0vTsdDYwdfpyt7eC3rh02DXlj5JvFQF6aWVxNLz41GkMSwtm3NoJ/YtNK6sbDr6
         ZOekHyOaemLQ+xjDjvlOGf3RsKRp1p0hlIs2n/5bihic6Ra1aipptiTdzBRG8QhqTcXW
         p6wN3OEQobWQEov+5Sc2UFFlA4NdiFsphLNIfUt0iG+5WsrODOMYWKAVFlJBldL2lC6d
         BALA==
X-Forwarded-Encrypted: i=1; AFNElJ+WKi0COfJ9b2Oy6ialJ3vhEvzIoGjSKr7r+T0douWoyg26fuxPp9qPN+tYqopAu7tPaQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4UDrzNGByrNtKDx9xzzwxYpU/Us2sdVTbX5atLZXfwwAPR+F
	GbdTPRxDiYzCEFylcuZA4FTKj+WXQsZdgW9GiN9IuxiceqoPL8b0a8Mh
X-Gm-Gg: AeBDiesnYDSLTby2tBpSAhni+r2u7u7xvA8HdtL/fzS4gzrJ+Yeg5fIP7U82du9GSK0
	muJkpueIsJjMr2/MXrORep9ACENjEE3jn4awTlVWsRMP/pW0eTQl0wMsAtfO0w5sADtsK8t0Zhn
	Zc7l6ikYj5TWV61rtvOdG8LNJruV+1te/0uWtxEqjyaNZw5D73Lprg6kLIX81+b1385vsOZcRfQ
	QaxeSEvBAqjzY9MYDDEu8WVTtCXArFwvUzPIReHqio8BgWajGJFP4/vWDM4s4mnXRduKDl+CmP3
	vajB+p+7GhjAa6/cFMOx7faSALvkyevKYHSuqp4adynsL3/qb+tchdw54xKYqXB7YfLNVWto11D
	eMdPYmDfoL9xyAta4/5fQzSp4IlBHOBlweia5Qlp5psJaIs0xTag0lgYrlsykg4i692Cf1kg82V
	n5Bh7S4yXVkLH3Dw39oQGQZzi6UEqlDBfb4OWNCBpYp3fwlOuyIozEUHumYClwKp2ov8iMotT4S
	9s=
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr252163275e9.2.1776175585894;
        Tue, 14 Apr 2026 07:06:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d684b55fsm128410235e9.26.2026.04.14.07.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:06:24 -0700 (PDT)
Message-ID: <e651e491-e59f-462a-9e81-35546112ce57@gmail.com>
Date: Tue, 14 Apr 2026 15:06:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 2/4] sequencer: allow create_autostash to run silently
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
 <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
 <e11a622bdf4752273dc2de26f3108d329abb04b3.1776171585.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e11a622bdf4752273dc2de26f3108d329abb04b3.1776171585.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 14/04/2026 13:59, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a silent parameter to create_autostash_internal and introduce
> create_autostash_ref_silent so that callers can create an autostash
> without printing the "Created autostash" message.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

I wonder if we should just update the two callers of 
create_autostash_ref() instead of adding a new function but the 
implementation looks sensible

Thanks

Phillip

>   sequencer.c | 20 +++++++++++++++-----
>   sequencer.h |  2 ++
>   2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..780628aab4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4657,7 +4657,9 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>   
>   static void create_autostash_internal(struct repository *r,
>   				      const char *path,
> -				      const char *refname)
> +				      const char *refname,
> +				      const char *message,
> +				      bool silent)
>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	struct lock_file lock_file = LOCK_INIT;
> @@ -4679,7 +4681,8 @@ static void create_autostash_internal(struct repository *r,
>   		struct object_id oid;
>   
>   		strvec_pushl(&stash.args,
> -			     "stash", "create", "autostash", NULL);
> +			     "stash", "create",
> +			     message ? message : "autostash", NULL);
>   		stash.git_cmd = 1;
>   		stash.no_stdin = 1;
>   		strbuf_reset(&buf);
> @@ -4702,7 +4705,8 @@ static void create_autostash_internal(struct repository *r,
>   					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>   		}
>   
> -		printf(_("Created autostash: %s\n"), buf.buf);
> +		if (!silent)
> +			printf(_("Created autostash: %s\n"), buf.buf);
>   		if (reset_head(r, &ropts) < 0)
>   			die(_("could not reset --hard"));
>   		discard_index(r->index);
> @@ -4714,12 +4718,18 @@ static void create_autostash_internal(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path)
>   {
> -	create_autostash_internal(r, path, NULL);
> +	create_autostash_internal(r, path, NULL, NULL, false);
>   }
>   
>   void create_autostash_ref(struct repository *r, const char *refname)
>   {
> -	create_autostash_internal(r, NULL, refname);
> +	create_autostash_internal(r, NULL, refname, NULL, false);
> +}
> +
> +void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
> +				 const char *message)
> +{
> +	create_autostash_internal(r, NULL, refname, message, true);
>   }
>   
>   static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> diff --git a/sequencer.h b/sequencer.h
> index a6fa670c7c..5d3bc83314 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -230,6 +230,8 @@ void commit_post_rewrite(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path);
>   void create_autostash_ref(struct repository *r, const char *refname);
> +void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
> +				 const char *message);
>   int save_autostash(const char *path);
>   int save_autostash_ref(struct repository *r, const char *refname);
>   int apply_autostash(const char *path);

