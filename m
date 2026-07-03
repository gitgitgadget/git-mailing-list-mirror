Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482732B9A8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110020; cv=none; b=U9yAOhDDAH9bJmNJjtFpxAusVD7MF6CCR0IvKX89xxR4G7A6h6kQBMjmeYlmwUXQfpPpdMeMBFHFtrW28Cncr8W4tgChjQxi5pyq0n+9dNmF5+q49gfZ9z/tCHjgVq7Tnlm2TH5TpsBeLoYyBVGjws2ajDGl6til8LsW/YtXVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110020; c=relaxed/simple;
	bh=toyLMti7LszBD3zJGuaPJ2XoY9D5JQT5P3sowSAEz+0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N/uLBwtDiO9m1u6aEaCU63W6UiWJNqWl0eaO4DF5pQT7VVD8LOloXgsplSmNqHF/qWuC2S4/q9wnNlo6DpwUtEqWoinO8koZvXt3sSWC9gHZ5JQFgkELnr/D/ERHjH6HC1vwN05djr9qEjS0ohJnckoomp9xpiHR6QkfWFWG3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnbQhQgs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnbQhQgs"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80b9993928dso11211807b3.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783110017; x=1783714817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEDCHp7jLfkdzD0O1lMI2mOh8yW8/SoqhHyPdh3Y77g=;
        b=jnbQhQgso5rh0IOAJ2wK/iBv0U0K/UNoNOybWhR7MFLjvLxCCewaBLq90Ta/C4OJ/a
         lxPmOzwOaqQ/hpcsaahhZ3QitXfYrAwY780C8Glm4MQIQHTIa3OD06PP4/l2Nn/HXx4Y
         9PU8iShto+mI1rmLp6ZShz19+bahJEVgOzUJayXBSLwvw7vBK/ZXrNp85KGF18w18R7w
         2OvuvZMdfjvLb5r8cAOBzFoajSxTioUlvTW+T0Dl2pdpqN+JHMiUH2K99jmMM089E1El
         4DMpAw3vAtzR41eqxVz3LVU4KYqUkxDfcPm5WtC4QyPYcBScJ1qvtnLBpHN1EDQUfQyJ
         63mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110017; x=1783714817;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEDCHp7jLfkdzD0O1lMI2mOh8yW8/SoqhHyPdh3Y77g=;
        b=BcPHv4ZgFm/dCuOiC+3rGXS7vM/kDfY7/XavmP+w+cJIWDiPwD0hOTcKtn33lHlN77
         h/j1CFg9YSm8XVLEi9C32kPRURInUcw4rU3/aQOoM6JTtR47jXvGpqx1UI4FVmecMlWa
         I6N1wHq4M9Q6Re8DPjHGFScbzoERACYUH4k7Zlb5nySrXBG4zsS9ahfNvmcbD4KA3UBo
         yU/LqoMR/1O3WQXxcL2UT08sgy+llekkVgHQyps8Lnq5WKImTz5v31kur82C2vo8PGHL
         T9KtHV2BOsVXgm2M3/bDB/rQLgQ3lN80R1tdwMuIU6MA1HM1qNU4FOMGKs1sQEYCLiIv
         yPGA==
X-Gm-Message-State: AOJu0Yxs46uc0w7G7O+JeBA3s5gEbrWBJamgi5JhtKzQK1BlnhBTu3Fy
	1I3C+U+6Yg4ljPOJi2f4pkybrdWr1dHyiD/sgY5Pqiwn+5noNaebreMv5vTEag==
X-Gm-Gg: AfdE7ck3tlNv0dgiclQx3ROgXlQS7A8OSq5LkyDyPs3U/C/ujAJhcY/2nG2NnEyWeOH
	6jFQCw8fkb1BiQuDXQ9xGYRt7WMqGfdLMe2tlLUlApMYePIRodbEURw4YZ3IVfsIRfh0kh2foVu
	NNb4mp7dRcDBifAcM0DFgOBZEDOMbKAuE899C0pmemXeTaEbk0g0wz6weYye0eZy0dj/UhsSRP+
	eX6oUPVgAM+m/3rEkV0ranDAsFa/0xd43Eel7ZLsogze6Tg+7+dwkGMfiwULpKdWUPzFvd3Tkdk
	VDWN/DXfLnFOf7eY5J00cDCrAuUh/fAgVySKaSBCntaqs9JJ/xxsKI+WBG5/yg0eogWvNN7ULGf
	OOjiFk9SuEPqxJtE23mLxAVQXXGEPkBgfTf8E8DMvpnCU5GY33BgptA7jHrRWRCp7hdOQ4vRzRs
	yiNDmv4sDh7HHQf6TWX4rkkZPFZXQhkY0WMAW/W2r6
X-Received: by 2002:a05:690c:730a:b0:80f:9998:e614 with SMTP id 00721157ae682-8173861628amr7654897b3.28.1783110016951;
        Fri, 03 Jul 2026 13:20:16 -0700 (PDT)
Received: from [192.168.14.221] ([65.187.96.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448219f1csm28067627b3.20.2026.07.03.13.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 13:20:15 -0700 (PDT)
Message-ID: <f35346ce-056f-4add-b071-2703c2455daa@gmail.com>
Date: Fri, 3 Jul 2026 16:20:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: Re: [PATCH] precompose_utf8: use a flex array for d_name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
 <akd1m6KoUh7N8yyE@pks.im>
Content-Language: en-US
In-Reply-To: <akd1m6KoUh7N8yyE@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/26 4:40 AM, Patrick Steinhardt wrote:
> On Thu, Jul 02, 2026 at 10:35:54PM -0400, Ihar Hrachyshka wrote:
>> On macOS, git status may abort while reading a directory entry
>> whose UTF-8 name grows past NAME_MAX bytes:
>>
>>    __chk_fail_overflow
>>    __strlcpy_chk
>>    precompose_utf8_readdir
>>    read_directory_recursive
>>    wt_status_collect
>>    cmd_status
>>
>> The precompose wrapper already reallocates dirent_prec_psx for
>> long names, but d_name is declared as char[NAME_MAX + 1]. A
>> fortified libc can still see that declared object size and reject a
>> larger strlcpy bound, even though the allocation was grown.
>>
>> Make d_name a FLEX_ARRAY and size allocations from offsetof(). That
>> matches the actual object layout with the dynamic allocation, so the
>> fortified copy sees a destination whose size can grow with max_name_len.
>>
>> Add a regression test that creates a 261-byte non-ASCII basename and
>> runs status with core.precomposeunicode enabled.
> Hm. Why does macOS even allow you to create a file that has a basename
> longer than NAME_MAX? Does macOS count unicode characters specially?


Yes, macOS file names can exceed NAME_MAX bytes because the real dirent 
limit in system headers is:

#define __DARWIN_MAXPATHLEN 1024

#define __DARWIN_STRUCT_DIRENTRY { \
char d_name[__DARWIN_MAXPATHLEN]; /* entry name (up to MAXPATHLEN bytes) 
*/ \
}

(for a very old 32-bit ABI it's 256 but it's not really relevant)

This in-memory limit may be further capped by file system. For HFS+, 
it's 255 16-bit Unicode characters (as per on-disk format). For APFS, 
on-disk theoretically allows up to 1022 UTF-8 bytes, but my testing 
suggests they still enforce the same 255 character limit somewhere in 
kernel API layer. (Which means that they could later expand the maximum 
filename length further without changing the on-disk format.)

So effectively, today on Darwin, the real limit is "up to 255 2-byte 
code points", not bytes. Which is potentially beyond NAME_MAX.

...that said, Linux readdir() doesn't guarantee NAME_MAX limit either. 
 From readdir(3):

"""

         Note that while the call

             fpathconf(fd, _PC_NAME_MAX)

         returns the value 255 for most filesystems, on some filesystems
         (e.g., CIFS, Windows SMB servers), the null-terminated filename
         that is (correctly) returned in .d_name can actually exceed this
         size.  In such cases, the .d_reclen field will contain a value
         that exceeds the size of the glibc dirent structure shown above.

"""


The man page also advises against using sizeof() against dirent structs. 
(Which is what we currently do - against our own MacOS helper dirent 
struct.)


As a side note, it probably means neither Darwin nor Linux readdir() is 
POSIX compliant, because, as per:

https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/dirent.h.html


"The array d_name in each of these structures is of unspecified size, 
but shall contain a filename of at most {NAME_MAX} bytes followed by a 
terminating null byte."


>> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
>> index 1711794..8077f62 100644
>> --- a/compat/precompose_utf8.c
>> +++ b/compat/precompose_utf8.c
>> @@ -19,6 +19,11 @@ typedef char *iconv_ibp;
>>   static const char *repo_encoding = "UTF-8";
>>   static const char *path_encoding = "UTF-8-MAC";
>>   
>> +static size_t dirent_prec_psx_size(size_t max_name_len)
>> +{
>> +	return st_add(offsetof(dirent_prec_psx, d_name), max_name_len);
>> +}
>> +
>>   static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
>>   {
>>   	const uint8_t *ptr = (const uint8_t *)s;
>> @@ -114,8 +119,8 @@ const char *precompose_argv_prefix(int argc, const char **argv, const char *pref
>>   PREC_DIR *precompose_utf8_opendir(const char *dirname)
>>   {
>>   	PREC_DIR *prec_dir = xmalloc(sizeof(PREC_DIR));
>> -	prec_dir->dirent_nfc = xmalloc(sizeof(dirent_prec_psx));
>> -	prec_dir->dirent_nfc->max_name_len = sizeof(prec_dir->dirent_nfc->d_name);
>> +	prec_dir->dirent_nfc = xmalloc(dirent_prec_psx_size(NAME_MAX + 1));
>> +	prec_dir->dirent_nfc->max_name_len = NAME_MAX + 1;
> We have the `FLEX_ALLOC_MEM()` macro that would probably be a better fit
> compared to introducing `dirent_prec_psx_size()`.
>
> Also, when converting this to a flex array, can't we do better here and
> allocate the structures with the right size? Otherwise, I expect that we
> overallocate most of the entrise.


As I understand it, this is a *per-directory* buffer that starts from 
NAME_MAX + 1, then gets expanded as entries with names longer than 
NAME_MAX + 1 are encountered. It is reused for next entries.


>> @@ -145,8 +150,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>>   		int ret_errno = errno;
>>   
>>   		if (new_maxlen > prec_dir->dirent_nfc->max_name_len) {
>> -			size_t new_len = sizeof(dirent_prec_psx) + new_maxlen -
>> -				sizeof(prec_dir->dirent_nfc->d_name);
>> +			size_t new_len = dirent_prec_psx_size(new_maxlen);
>>   
>>   			prec_dir->dirent_nfc = xrealloc(prec_dir->dirent_nfc, new_len);
>>   			prec_dir->dirent_nfc->max_name_len = new_maxlen;
> Okay, here we indeed have to realloc though, and thus we can't quite
> avoid `dirent_prec_psx_size()`. Too bad.
>
> Thanks!
>
> Patrick


