Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5C3D9690
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542208; cv=none; b=nKlPIBJkndLphea0FluLNwzgOxAPFTs/fdvBC8HVltcp/S5znOI21zUeKz1jglWssiK3iGE1L8LROkG3YmmOKqtQmIQNcnzfg8uI1CyxMs+8INNiwaHzzWKIJiy6NA65pqwx4KpVDohcrEt0sUh5hv+uc5TT3YEnKvhHjEA6uWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542208; c=relaxed/simple;
	bh=ka51gtuopewvjxMB7bno/IRnd5Zpo8mHk1cQDwL03f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsPcXdo7m0tp7SJUBWLkElvJvkCJ5o37L1c6MroOiRzZBRwyrjy/IsYISYxbxRXvwyuEMnZPvBzk05QvjJisZ7L9WsEMfcSkahpdKhmwgw1ot8/IKCQOocgST+RZi6GK+mTs1ve72VowD2/elt8d/YeztNpjQf4M0UZQ+9zixOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=lPsXqack; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=BJMnRF/x; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="lPsXqack";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="BJMnRF/x"
DKIM-Signature: a=rsa-sha256; b=lPsXqackLD8R1gbt5f6dR4IS70DpN5kcO+c/33j9gVcMo2m7dwFOMfrdqroSBO72/noHajpyEyDVq6Eh9hTNTmHPgHDqywpV9Z/JG3RJ1LYfvZxeMkpjuZr5coQmGWZ2lpxaIqtYsMlkEtZ9a67CVhsFsWjfyE32RV/ZOEybDi9Q55MXzjwEILl0DfbJo9Z/BZeNczrEyy4d+BETUynhfZLwyqwuMiV+Uggw7nnHuc5y/DOM77vk5fXPyZDscfWAmSkhX6QhqJLkghQYiNDkiFF+oGPvN5RqshGWMzNIq8nQrCYD0OpRkhkKoV//2XJecU+S1r1Jd64Dlrd8U2+BKg==; s=purelymail2; d=malon.dev; v=1; bh=ka51gtuopewvjxMB7bno/IRnd5Zpo8mHk1cQDwL03f0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=BJMnRF/xkbRNEnGmrk8TY980hgRHAeQ8l7hH41KpmGLSw3BYlUCLtINO19l4kuvSzZmi4H/vemoaZSjJQReeOKU46Sm6lyMgp3oZwEFVmqt3qttD7Ip0Qf13GBl5luKLlOSU/uIE6q9UNaFOqCBN9xXzB0leH8E7DwOlYJdkLWregbAnwxUnTX7KkOWk1ZwCKvtOuxO6z9noB8BHBZ0WvXxb7y/4boijBetAu1b3f2LCJ6JFdGVj2EEl3dVvDtR+wV+f9uSaIt7/cj5ypQavGabU6hmAeNJtPASMbSMSBy6Ce+KICyg8uUpV5HppH33XZYTDo4Mtnjo6jEX1817t2g==; s=purelymail2; d=purelymail.com; v=1; bh=ka51gtuopewvjxMB7bno/IRnd5Zpo8mHk1cQDwL03f0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 276130062;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:09:58 +0000 (UTC)
Message-ID: <3cd5e386-aaa4-4a96-92e1-1ed244d39c9e@malon.dev>
Date: Mon, 20 Jul 2026 18:09:51 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] environment: move trust_executable_bit into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
 <20260717063559.1633567-4-cat@malon.dev> <xmqq8q7961xe.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq8q7961xe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/26 00:01, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> diff --git a/environment.c b/environment.c
>> index fc3ed8bb1c..75069a884d 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -41,7 +41,6 @@
>>   static int pack_compression_seen;
>>   static int zlib_compression_seen;
>>   
>> -int trust_executable_bit = 1;
>>   int trust_ctime = 1;
>>   int check_stat = 1;
>>   int has_symlinks = 1;
>> @@ -142,6 +141,13 @@ int is_bare_repository(void)
>>   	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>>   }
>>   
>> +int repo_trust_executable_bit(struct repository *repo)
>> +{
>> +	return repo->gitdir?
>> +		repo_config_values(repo)->trust_executable_bit :
>> +		1;
>> +}
>> +
>>   int have_git_dir(void)
>>   {
>>   	return startup_info->have_repository
> 
> Two comments.
> 
>   * Missing SP before '?'.  It may be easier to read if it is written
>     like this:
> 
> 	return repo->gitdir
> 	       ? repo_config_values(repo)->trust_executable_bit
> 	       : 1;
> 
>     which more clearly highlights the ternary structure.  If you tilt
>     your head 90 degrees to the left, you can almost see the parse
>     tree of the expression.
>    

Okay.

>   * Does it make sense to protect against a NULL 'repo' case, as
>     repo_protect_ntfs() and repo_protect_hfs() helpers do?  Or is it
>     better to crash loudly with a segfault to let the developer know
>     they have a bug to fix?  I lean toward the latter myself, and if
>     we go that route, we should probably stop using 'repo &&
>     repo->gitdir' elsewhere, rather than sweeping the problem under
>     the rug with defensive checks.

Sounds sensible. I will drop the checks and adjust the calls themselves 
instead.


Note that repo_protect_ntfs() looks like this:

  int repo_protect_ntfs(struct repository *repo)
  {
	return (repo && repo->initialized) ?
  		repo_config_values(repo)->protect_ntfs :
  		PROTECT_NTFS_DEFAULT;
  }

Do we need another fixup commit for it?

Regards, yuchen

