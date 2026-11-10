Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316265;
	b=PnVsHDBLZRMJtFGRf/5wjAy8LoU8vTzOnKgBXwx1oTjlV74wcyIkH2GWm30aoRd7KF3Y
	 zwWC0sS3i5M5tA1/ZS0PvxdxiQboS0uY3tqIQMx1Qyx583wFk3XRBVg/++Q0amlkpximm
	 HZSLtqvXxOvUEpXW5PDtqeRCW91RAuTMcSOf5j8ez2DZOGCPgggKOiZfVL/wD9dfLHOJT
	 SZ3E8Sge5Cgk3A7vo4vpufE0hyWCYeHePTh2spYSXDjGgr5Gxz7AT4U7VRPOEo6DCZHEH
	 g9d9EGjWgSxYUOWxV7lKfqFB3w5TEEQ+Tk1rK0Ux/H9TSrdf9fH3YDPNXxHb69TM7jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qiYiN8ixT70ckl/CeWCXGAwePirInhpUhTzfZrcdzIU=;
	b=oiT9izi2CoP2xzWO9tHADollNxkuRiBQE4d7NBdg/HXIjKB6pd6Xhb9QINe6Jv8O+qSa
	 YZYa+R8fDhr2hIZljFZrTyrb/k7JJ53Jeczv1FxBR1E9CjwWLveLik4zzAE4pxLv4CavW
	 1SO6wMtK4kTIqh3M/HwWoaxLkAVZ6QlRP1O1kcyO4PMHzT4KSOU/bVdeRe2NgYUF5sCo9
	 kyCoC1k7OUKYcD7nwQtyH+qdqVFoiLczzzMWwUg0BhBRIpXwk96J1oEVJcLkQsBL3Gofq
	 rLP6VbjQSEvlpvyrkdJPCLgD3mzxI5mjFF5p13y8FJzCIrqMKlAMNc7V2uaidDTjlcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l01AWWjo;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C16606A76E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C16606A76E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l01AWWjo
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so3942581eec.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316265; x=1794921065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qiYiN8ixT70ckl/CeWCXGAwePirInhpUhTzfZrcdzIU=;
        b=l01AWWjozI+rIkzch5fUpmXwpawB6BRe7Xqfg3XMnzTQEQVTMKFIJfBs+wnH2UV8lQ
         nzlQ0FtMvqKehhoDq0tBeTmtz3WGjbLTKBu6GEPFTa0tuGOa6lIokWe9umxcET8GdI/1
         qVpfuSdZDC4vrHPyBnOCeLjZiFiJquaAOxAbylEgqJW1MAJEHPYFYUj57u/BQoV2uykD
         d5KszdyZwapoVYFNnFooITZlspjxI4nMvQXUdmA7lZFOTGKFu0p/+N/nyJeZ5iT3vYce
         wm20WGXydoSSHnYcB8LmraavS9h7JcpuJx9m4kvH4JdOQE6vO0J3gAeXRSiuaKXwxK1U
         eYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316265; x=1794921065;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiYiN8ixT70ckl/CeWCXGAwePirInhpUhTzfZrcdzIU=;
        b=hCQzqZZmwVM2+MSqCloilSNHrzY+1Alxqs2w8oZ3M5drtnOzTZIiR2WM+68gQyZya6
         7VjkBSwL1ow87tBOjE0kRiL8S8SN4/ArEDgS4Af2kXw5CO5foGQo8/wq9fUJEo83wjLU
         mHca0rmuFkQzQ2OsWh3K+/TGQIC5HIylGw3Jrlo4WmRieo8ElITInTMGdzgz4pULTKvc
         eZxFxLCZR4jl4oICC6loUHeoQCmZ7KtPSNMQnT0HI2+NBL32Q6AU03Jh2m97+HJAeKsW
         z1YP3bqSkTHFt/Lu57Z8abhasnYaKJnXp+9IYarbAJVEhC8f3ZJncBGgmwW58N1YhIX8
         azzg==
X-Gm-Message-State: APuU4Z8BZFgJJgV5fMjID2atYf6XnZAHKY6lPhDpvLKs3u3a/j8BWhrG
	IUa+gjAHek/ODFhTtw0pBTeXhMb9WHDJjCjdfay269Mb2PyScOJNOG4Z+31chHmu
X-Gm-Gg: AYBFou1ukyxhJqUJvfp0/+PdXaPnaDAMJIH7/GIxDZMRQpgfU69gUr9shaUmql3drr0
	sMLs4+27FCqjsxhcGn21EiS4l5939USAhTLKKDA8TcUVGSX7Yld21ny/Yce8qwQDou9T5jgZMxt
	6Hz5LWoTz2q0wxxJBtR9Vz72k/X320aeHZbFM5XGz6Ea1sVe3tOjrqy78Cy7AyHZ/nOpvYvsi93
	cd/pgQtw+qHZguEjVgYakaxD4woQf3qjKfgq/SlRAQeypHOxgxp62m43MK28Ov+FWlDEm7vsdpC
	cg0R7nhsip+2K9AE1bkv1k8cVrFGp5Wda2PS/vGtJIFvm6sbKjIXHTmGVWMHF4mK2y3TYHUcbPW
	NbTtJq2qLV+AuSXDeZ9I7+z+K7wAIOpNUsA85BBvz1rtKb/pZIxIA6SQxWurox3ECACP+nXSpts
	FlbenkE67GWghSICSk+rwYvvCdkhCiWbKlhED1dVGAiSWngvaYRtwqu/4jf+HYvtI8+hfJgs2D6
	3GD0xnTPPFEL471oHSA+qVcyfNQVtdeDhpEM6/j1cTScBAi/lljMDyg7maPqIc7KeeV4Czynq1G
	hHrGlX8SBpbYphZWeEWkxXEnAsc3kgryRHSpgLVEh7Oq
X-Received: by 2002:a05:7300:c00f:20b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3751f561930mr3464316eec.26.1794316264028;
        Tue, 10 Nov 2026 05:11:04 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm8462471eec.14.2026.11.10.05.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:11:03 -0800 (PST)
Message-ID: <6a4a230b-2f8a-4a26-ae08-8439a0f597b6@gmail.com>
Date: Tue, 10 Nov 2026 18:40:59 +0530
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
Subject: Re: [PATCH 1/6] object-file: move logic to read loose objects into
 backend
To: Patrick Steinhardt <ps@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-1-fbbc86c29693@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-1-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> The logic to read loose objects is still contained in "object-file.c"
> even though it's an implementation detail of the "loose" backend, and
> that backend is nowadays also the only remaining caller.
> 
> Move the logic around and remove the accompanying declarations.
> 

The move looks justified as mentioned in the commit message.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   object-file.c      | 300 ---------------------------------------------------

All functions moved from object-file,c are properly moved over to 
odb/source-loose.c and they are marked static which is also appropriate.

>   object-file.h      |  45 --------
>   odb/source-loose.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 306 insertions(+), 345 deletions(-)

> diff --git a/object-file.h b/object-file.h
> index f44758c4f8b..65ab44542b0 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -21,7 +21,6 @@ enum {
>   int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
>   int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
>   
> -struct object_info;
>   struct odb_source;
>   
>   /*
> @@ -122,50 +121,6 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
>   int check_and_freshen_file(const char *fn, int freshen,
>   			   const time_t *mtime);
>   
> -/*
> - * Open the loose object at path, check its hash, and return the contents,
> - * use the "oi" argument to assert things about the object, or e.g. populate its
> - * type, and size. If the object is a blob, then "contents" may return NULL,
> - * to allow streaming of large blobs.
> - *
> - * Returns 0 on success, negative on error (details may be written to stderr).
> - */

We're losing these documentation comments during the move. Can we retain 
the same above the static functions in odb/source-loose.c?

Rest of the patch looks good to me.

-- 
Sivaraam

