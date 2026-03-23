Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511A3BC681
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288980; cv=none; b=Rehx+9E2RY0V+Rz3+GpemqsEV/2BA52d97ZsV6KQmOURMhbF3/Tv71wVcf6r/un5QEmSr/TckFFipaPEHhaRCMCp+JYAZk8Jr89jMhLForpMPwUMLuM+lG5iSrS9BH7znkDbJgQItxguo7KO1nhyeSjlIJcyyLcR27TYnTxIUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288980; c=relaxed/simple;
	bh=cvl9GZ8m/2Kj0V8zTiehkR2A7R/kWhsR9UT6GmTGh4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYnkMIXZj+ugGY/aleoHt0aJZNwSbT3RMLho55+jy2Pk0pp4+o6MAQS61TeHOWjKOy5mWwIiqiX0v6d+6f3G/Otclrn4yFkMA+soqL+XT4gCiK82nhwkzAPvYa2LVJaioY9wmlIRrSM6NVg9dZxGMkUmgjLinUP7pb2rCyX8E2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=XPJDTaL/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KQIjdvsa; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="XPJDTaL/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KQIjdvsa"
DKIM-Signature: a=rsa-sha256; b=XPJDTaL/Iww+V7WaRM9KoeE3Xnv2voisRlVzX4zLJlq0iMfqHMUMMiKjaiTNUPp3DW1YawZDUvd5ZvyIiX2PmZQAReQSx9eIcB8ehql6FpfBw9QZT73VKrMsf/OF+lZFz/xqnzGC9hLQVj4Q790wUDCE8msgi8TibnNbsy8ygTkaOJi/wCHT874mSpL8b5uTX4f6m8plqh3f8LNIcxm3MpKyAaitKqz5hx1j+zhJVCD6g+hBnkOXoUB1Y1wl8iqNA6zR7wTOb3kkdHonXzOu61uYUvAPVFMoeTLKX+xiPqY2VvZEx+BG0r/7TpRTk+fA1UgwIy1O1vWKzE1b3QpjcQ==; s=purelymail3; d=malon.dev; v=1; bh=cvl9GZ8m/2Kj0V8zTiehkR2A7R/kWhsR9UT6GmTGh4k=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=KQIjdvsaas2vXEx5v1jv22uUQWbOTMcKHHL5QQmbLvOlrZjdq3bbPN/lNjOT1s9LWeSQOtKPhd+2qmoKfBmapLj0GAbki2XFxQMGDjQ5Hcwil8LKFCnQcuOIcZWf3eckzGojTPJeTVMwESMmis4022vNemX3xgwXoH++GlY6+XMQwTVFP+bheC7iMc26lsENrUJlL9te5gpAGc7J7ZPYBEWGQ3GAvQh4G3KJHlsmqbfZLBjjxaivKI4e8/AtDluI8Wq8CorVOxF8qtGK873LoLqzaLGfc2ZCCGnAG86fju5HQsnyD8qvhfxs9tvV3uH86EfQGjhEPc8KyT/l3N/MEw==; s=purelymail3; d=purelymail.com; v=1; bh=cvl9GZ8m/2Kj0V8zTiehkR2A7R/kWhsR9UT6GmTGh4k=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -765109581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Mar 2026 18:02:02 +0000 (UTC)
Message-ID: <b0d49276-a9d3-435d-bb39-8cf7a08fbd11@malon.dev>
Date: Tue, 24 Mar 2026 02:01:52 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] replay: allow to specify a ref with option --ref
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Yee Cheng Chin <yeecheng.chin@gmail.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Toon,

On 3/24/26 00:09, Toon Claes wrote:


> +	die_for_incompatible_opt2(!!opts.ref, "--ref",
> +				  !!opts.contained, "--contained");

> +	/*
> +	 * Reference to update with the result of the replay. This stops replay
> +	 * from taking refs from `onto`, `advance`, and `revert`. Ignores
> +	 * `contained`.
> +	 */
> +	const char *ref;
> +

Do the comment and the code implementation match up here?

> @@ -427,13 +446,9 @@ int replay_revisions(struct rev_info *revs,
>  		goto out;
>  	}
>  
> -	/* In --advance or --revert mode, update the target ref */
> -	if (advance || revert) {
> -		const char *ref = advance ? advance : revert;
> -		replay_result_queue_update(out, ref,
> -					   &onto->object.oid,
> +	if (ref)
> +		replay_result_queue_update(out, ref, &old_oid,
>  					   &last_commit->object.oid);
> -	}
>  
>  	ret = 0;

It doesn't seem like there's anything here to prevent users from 
inputting multiple branches? I think this will result in at least one 
branch becoming orphaned, without any error being reported.

Consider this command:

	git replay --onto main --ref refs/heads/target topic1 topic2

In replay.c we have:

> if (onto_name) {
> 		*onto = peel_committish(repo, onto_name, "--onto");
> 		if (rinfo.positive_refexprs <
> 		    strset_get_size(&rinfo.positive_refs))
> 			die(_("all positive revisions given must be references"));
> 		*update_refs = xcalloc(1, sizeof(**update_refs));
> 		**update_refs = rinfo.positive_refs;
> 		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));


After topic1 and topic2 are put into update_refs, only one ref 
(refs/heads/target) is updated, since what is written in the patch is:

 > +	if (ref)
 > +		replay_result_queue_update(out, ref, &old_oid,
 >  					   &last_commit->object.oid);

I believe this is not what we expect :P

Regards, Yuchen

