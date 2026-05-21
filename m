Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538793803C7
	for <git@vger.kernel.org>; Thu, 21 May 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384935; cv=none; b=V8O/9rxWYicSBlKlb9DU0dUgC4S3ELOoNGQPGKEHmN/b2WoKl5beWXXTEoI9bItPUycVAJr867RFaI2TFuHSDoO+x2x1y+BH7RPeWEzlOAlX8AUV3F2E3pGO8jd+snDztYm0XCGeCfmggdHYkt+xeCiBfNWwFoMRsQE+xywGwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384935; c=relaxed/simple;
	bh=SLpH7ZY0MNVAwl91f0r1u+sPzAu8tMlXxtZpI+M91yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od/NS3yAy6QJ87gtqK9kfpdBlW2ODSxqB+evXg2fKyqZaAc1RmL3p21iDqN9XVpTKZ8o48JoLNEuwSxlwZkcXtaMmRUwlcY4To8/ZDP3HJGyMFbFtg63NbqhSr83aSn1M3aVqJVsPKQC3wjcDTef0FxJ44ZeMNQ3zm+C/vrBd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWwGl5Jy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWwGl5Jy"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911dfc86901so675488685a.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779384933; x=1779989733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hV7Yugi81MjjNI8M0EwX7feRjWyOyTeUoIbtVkc1qKg=;
        b=VWwGl5JyBQP95h73rsjJF4UipWasm5V8VsnC4FDgxZXEYUiJO7GeTleIbwfY84yzh7
         QfWJNU8J70iyzNpiNF05RMxI991YoRTfR4drPD26WEfy/aWki7jXUbF7r3VRfes33bld
         6JQUSTlKTOcBJV/zRVMa5vYq1dkF2Noy3CTGLIv/TfU561RoHsPvA5lbEBsPd7A1VZS6
         vXomHOFvvn0tZ5PmuWlWJNpHEogy+Z5e4+ejXxHWLavBbXyrYOhY9jHzT1IKXNujMBz6
         z+OZ+1Q6R3K2X2XHqHO+CUXYv66vaW14UexB/cJr2Jy6FLwY622OBkA3shUsDL0XjWH5
         talg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779384933; x=1779989733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV7Yugi81MjjNI8M0EwX7feRjWyOyTeUoIbtVkc1qKg=;
        b=KbwJqZ+LbctOpH7X1OJazG/DaPY+VumzXT44LmVwv9xHbUD03DPo/zuwQTYbbRWjQv
         ABstCtLMiJJZV7ya4yz0RYife4XAOt6dWz97Vr7kMWj1/B6YEKrjpJaCBG6Dk/j0WSev
         llKndbaxsrJ9usmqXew1keK12pvkcC84vIj+fV5JSaV5ngDYuwCCGr3AuYv6mn6yg34m
         d4yc59jDOPOGsftXAZ8vZm47gekrU2oz/qbbtgLBl1qG4/4+mINzSuGMtagjH2qHLLvt
         pTj4U4SGJZvlVu6TWGKVSQ4NHdpPBoZ5Y8du5vTq5SGSokbS6so9PBJ1lPfrUoBPH/Km
         Q1Zg==
X-Gm-Message-State: AOJu0YzDSDkUigyKyXVm6MQ9OYKGOWUcxKRiTkamvI5UMU3FY/bH1Hut
	bQqtlINw7CajeSZLu6vXGK+ZrhGfWfKNbuDutxUjNDwUJviZx1zpTBVh
X-Gm-Gg: Acq92OHULE8MPmbARrjQsfGxYZKlonu/BGCGMiEMMG1PMRT5A3rOEVcVlRZz00OyAyg
	5j28LN+Y+eP8nGZmNUXnJohLE3qB1pXcSgBEp9sKmi46aXp1czeNF9AZ/4Ei6BmyU9Vj9KHG2/s
	Q4bD1t88KILWVvTAp0bNnYYrNb77fP0AiX0nZ+EpcJcV1o6uS+W8oqxsqJnKQqX8v3VgPravMxo
	JKDwK/YOyAQ7bZz/qIFQW/JCrxWt1Oad+ozJNRdf9hJrWD9pmWSYhz7ZoS/Nrk9lAkV2f+ecX7+
	EEGSnZ0zNFrQog18cN0+1kdV9LFg4tFIAbflnH925x12Ulp8Eg127LC6rTHZmt0NSs7AL6Awovo
	bA/rZSv3gbN+rzgxwGQEkB/2n2bS2ZGGyUXSw7qgHhtkPfRXshBSIxdc85aoWe1q/MA/fT4TkcJ
	dmMYy0d9lR3rlrL2DDsSLoA4DDoWLjI6bb9ge4cpYEQ0qYL+mIJLzsf6151p733X3qhPT38IUyZ
	/YQplSZlg==
X-Received: by 2002:a05:620a:1a28:b0:8ef:c472:cd7e with SMTP id af79cd13be357-914b496a41emr11652085a.35.1779384933027;
        Thu, 21 May 2026 10:35:33 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abcb6a87sm147271485a.41.2026.05.21.10.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 10:35:32 -0700 (PDT)
Message-ID: <bb38c5d4-b388-4eca-badd-69ec7ce67b90@gmail.com>
Date: Thu, 21 May 2026 13:35:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] git-gui: adapt blame/browser parsing for bare
 operation
To: Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Aina Boot <bootaina702@gmail.com>
References: <tencent_407FE60B6954528497709B6CAD49018D120A@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_407FE60B6954528497709B6CAD49018D120A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/21/26 1:02 AM, Shroom Moo wrote:
> On 5/21/26 4:24 AM, Mark Levedahl wrote: 
>> +proc find_path_type {head path} {
>> +	if {$path eq {./}} {
>> +		# the root-tree exists in every rev, ls-tree gives data on the contents,
>> +		# not the type of tree itself. So, if the rev exists, return {tree}
>> +		if {[catch {set objtype [git ls-tree $head]}]} {
>> +			set objtype {}
>> +		} else {
>> +			set objtype {tree}
>> +		}
>> +	} else {
>> +		# test that the path exists in head, ls-tree gives info on the path only
>> +		if {[catch {set objtype [git ls-tree {--format=%(objecttype)} $head $path]}]} {
>> +			set objtype {}
>> +		}
>> +	}
>> +	return $objtype
>> +}
> In v1, argument parsing relied on file exists within the worktree to 
> determine if a path existed, without using ls-tree. In v2, the use of 
> git ls-tree seems to actually be intended to list directory contents, 
> rather than querying the type of the path itself. 
>
> If $path is a directory (a tree object), git ls-tree outputs the 
> object type for every entry within that directory, one per line. 
>
> The variable objtype is assigned a multi-line string. When compared 
> against "tree", the match fails, causing the function to return an 
> empty string, which subsequently leads to an error. We can change to 
> "git cat-file -t" or similiar approaches. 
>
> Shroom
>
git ls-tree $rev $path --format='%(objecttype)' gives the type of the object at $path in
$rev, or an error. The types returned are "tree" for a directory, "blob" for a file. So
this gives definitive information if the object desired exists in the given rev, and is of
the right type. (We don't care about commits and tags, those cannot be blamed or browsed).

git-lstree $rev $dirname/  lists all of the objects in the directory, while git-lstree
$rev $dirname (no trailing /) gives info on the directory itself. There is no name for the
root directory itself, all of its contents are listed. That is why the root './' is
special case.

Asking the worktree that is on version 33 about whether frotz is a directory in version 2
is just asking for trouble, at best the worktree is authoritative for the checked out
version, but even then there can be uncommitted changed. In the root of git-gui, I get

/git-gui.sh browser gitgui-0.9.0 Makefile
'Makefile' is not a directory in rev 'gitgui-0.9.0'

so the types of objects are being checked.

Mark

