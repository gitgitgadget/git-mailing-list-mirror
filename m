Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980421256E
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272958; cv=none; b=d8lgl/KRY0YiYkJ0cDIQpoCwzzfmy5oFHZdIAG580Ogn18TlzKjkD2Y8IrAPEmC0iamYZ1QFQovU9ecUMKRpV8LaBo/ewo/nmidrur9Ivg3cUNSQwvQ+8FDKPYbReSNCV/45/2BthC9nOr4OJKGIr38bWtSPLXVL7t4y4MiTqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272958; c=relaxed/simple;
	bh=AVcbc6Xs5I4kRIvBXKV/ehm6cRzPkJTvOjSuj4XhsCE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KpewKToCIbL4yUihABs5mNFrJylhTAV5Leb0O03NvGPpTSf3WDx/KCec84+LrOaRbbGyflXgsCHZUgQirPBrud/zEBsyA044biRfNsUBN15O8mS+GbWVuaK52LM86AEMi/fOOoFx+teJ17I6TXFasli1YD/zZYHyjF7DCkQNpm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBlOWtta; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBlOWtta"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so10937795e9.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755272954; x=1755877754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZITHrwo7Gjcu9FpeSVxJycfTLK0MBeZIOULenjdYT8A=;
        b=UBlOWttag44W3rts4UL5PrwfdpX21KZ/wwxwZOV5r+81vW9ru+o6JjMtgPAdbQvkk8
         Dv0ap/3zY+T5EMQgc7LGmFqf2g09s4VJHEL2/OJOehJl+b49B4VGiazSi0AYnSk8+mCx
         RhS5sDpTUPrq4meGpz5YYtjGxhcGB6uoO8wHhSRowck1YDSlmcMyxF8J3aE8VUZgvDd1
         b5Ld71DzidZb2LpQjRy0SNtw14tbqJt30pEfDw3/EZSsbKpghU9yWlKZi/W3eLYpY0fL
         9EN/vGJhV+p5VtiHeYNYALHeBnukpfHxgro/XfmjxUj5FblLCEdfjWHuJij+rgjM/dkU
         UHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272954; x=1755877754;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZITHrwo7Gjcu9FpeSVxJycfTLK0MBeZIOULenjdYT8A=;
        b=WlnHgCzBVyNi9726BjbzdSJGjWmkrVhGhV2dxeUoP2Q5V6Wy086BqVDg4NPFJc8+U6
         fKH2NhnYOOtXpcL3RY1vnI0kc7UGKoLUhoG3fj1YHLg9CnieLO6tu/QyBG6KCIU//Mpg
         M5OlgQV8n8U8Gfg0Pj5ZxKp44+bMlT2Camy21faaLAZO5MeE786qa562t1JI+v9gF9vF
         CTxs+LAj8J+mJiP/XYhQimW235QmBEN5Ls6dpTh0JEaIxBel0MOBDGhXc4NhqhQHXpLC
         /D8Du2kAvD9r6OmiIvDfh9fjRaKUMG9SHY18d08Xvh3vnNRfDUoIYZe1W39wH76fBRa1
         cyiw==
X-Forwarded-Encrypted: i=1; AJvYcCUcXSmv+ixz3x/8/RjMSllWSgq6gJOBSyAnaskrV0nSv7ANufdq3IMObjW/e9Nks7pwlnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21U2zGgOR2VHgA7Paqt+HRq2+pzyhpyiNmguCvTsOWMWwQIxs
	HxmhPvSfZHmQT79J0xcIRpijuIQawz6gqsQdDjRfyPZQtfPp/ztlh+1v
X-Gm-Gg: ASbGncsDuiv++2PxZauGhZ9weJ5wC4lZav9Gkhj/9xLi1zqyW+F2l3i8Iprh6P1ZZBg
	qnlKKucV57Yxd46ndy7b50zRLKs4NQey+q53FwvVFKtLEsokt/Kbvuir8opWLclbjKef0zPwX+I
	m8rehv0qdQZYuIyePcDGFZ+lUCjYtMGFCEYoIvse0EEw/oF6SSyw9m3dcXXddEUmNYmGISfM+UF
	+wTRLLEeiScU5ohI/mMJswAuoX46sJdZIQvd6+nDskC9pujAytjGKk2YFM/AuHVDNlk0GAiCKAL
	lfA7+cXKe85vgB2/Ew5dQE/5Ber7TQK0ySErrw764oxK6w9S1zYWNZZxixsdNW2FvJ0KDbuS9BA
	tG3M4/XtSqzJvoc4TvfKSadk6wQJN0BlhbPqMte47tnvAVE3LZvqK8eFPgf/pXlf+ndlObrH1eq
	rj829w2j0H+UE=
X-Google-Smtp-Source: AGHT+IGfrvL0x1N2yK006sTEvDIWy4XRYfHamNJsJAdKth2MHAODgrTuaioae7Li5ka8DYkmFG0knw==
X-Received: by 2002:a05:600c:4451:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45a21867837mr21028135e9.32.1755272954023;
        Fri, 15 Aug 2025 08:49:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78c221sm66872645e9.26.2025.08.15.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:49:13 -0700 (PDT)
Message-ID: <2560a90d-4015-4087-97f1-3733a58261e4@gmail.com>
Date: Fri, 15 Aug 2025 16:49:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <20250814232644.GC2937@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 15/08/2025 00:26, Jeff King wrote:
> On Wed, Aug 13, 2025 at 02:19:14PM +0100, Phillip Wood wrote:
> 
>> I had a quick look at the callers of describe_commit() and they all seem to
>> use an oid that they get from looking up a commit so I'm not sure under what
>> circumstances this call to lookup_commit_reference() can fail.
> 
> I wonder if it would make sense for describe_commit() to just take a
> "struct commit" pointer. Then it could skip the call to turn the oid
> into a commit entirely, and the compiler would make sure we always have
> a commit. :)

I think that's a good idea, it would be clearer to the reader that we've 
already looked up the commit before calling describe_commit() as well.

Thanks

Phillip

> Something like this (totally untested, and not something I'm planning to
> follow up on, but maybe inspirational):
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 32f5bf513f..3e8691a4c4 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -352,26 +352,24 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
>   		    repo_find_unique_abbrev(the_repository, oid, abbrev));
>   }
>   
> -static void describe_commit(struct object_id *oid, struct strbuf *dst)
> +static void describe_commit(struct commit *cmit, struct strbuf *dst)
>   {
> -	struct commit *cmit, *gave_up_on = NULL;
> +	struct commit *gave_up_on = NULL;
>   	struct lazy_queue queue = LAZY_QUEUE_INIT;
>   	struct commit_name *n;
>   	struct possible_tag all_matches[MAX_TAGS];
>   	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
>   	unsigned long seen_commits = 0;
>   	unsigned int unannotated_cnt = 0;
>   
> -	cmit = lookup_commit_reference(the_repository, oid);
> -
>   	n = find_commit_name(&cmit->object.oid);
>   	if (n && (tags || all || n->prio == 2)) {
>   		/*
>   		 * Exact match to an existing ref.
>   		 */
>   		append_name(n, dst);
>   		if (n->misnamed || longformat)
> -			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
> +			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : &cmit->object.oid, dst);
>   		if (suffix)
>   			strbuf_addstr(dst, suffix);
>   		return;
> @@ -528,7 +526,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>   }
>   
>   struct process_commit_data {
> -	struct object_id current_commit;
> +	struct commit *current_commit;
>   	struct object_id looking_for;
>   	struct strbuf *dst;
>   	struct rev_info *revs;
> @@ -537,7 +535,7 @@ struct process_commit_data {
>   static void process_commit(struct commit *commit, void *data)
>   {
>   	struct process_commit_data *pcd = data;
> -	pcd->current_commit = commit->object.oid;
> +	pcd->current_commit = commit;
>   }
>   
>   static void process_object(struct object *obj, const char *path, void *data)
> @@ -546,7 +544,7 @@ static void process_object(struct object *obj, const char *path, void *data)
>   
>   	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>   		reset_revision_walk();
> -		describe_commit(&pcd->current_commit, pcd->dst);
> +		describe_commit(pcd->current_commit, pcd->dst);
>   		strbuf_addf(pcd->dst, ":%s", path);
>   		clear_prio_queue(&pcd->revs->commits);
>   	}
> @@ -556,7 +554,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
>   {
>   	struct rev_info revs;
>   	struct strvec args = STRVEC_INIT;
> -	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
> +	struct process_commit_data pcd = { NULL, oid, dst, &revs};
>   
>   	strvec_pushl(&args, "internal: The first arg is not parsed",
>   		     "--objects", "--in-commit-order", "--reverse", "HEAD",
> @@ -589,7 +587,7 @@ static void describe(const char *arg, int last_one)
>   	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
>   
>   	if (cmit)
> -		describe_commit(&oid, &sb);
> +		describe_commit(cmit, &sb);
>   	else if (odb_read_object_info(the_repository->objects,
>   				      &oid, NULL) == OBJ_BLOB)
>   		describe_blob(oid, &sb);

