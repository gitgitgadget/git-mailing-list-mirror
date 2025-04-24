Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EA1F09B1
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499395; cv=none; b=afqXYnfIzqxi0MmSwH65tS7AWEcrXOxMsae8ngFLYliphD3lQhMqEWl13lI0k1lYm7yHCEkfhd407/RARvOiMkOZiPmc22kqAgHyvMQ6NNoToT5W5dBb+TdIzZ2X3NVw3T5xJjNhlaHJPng+H6tuntWUNoqSJLPlvj/B6hsQN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499395; c=relaxed/simple;
	bh=lJpAzQ7OX2xJ9vGC7nKYLaOOAMFMHpDeJ41VZpZsiCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANaJr38gUJdlGPm2eP4ELWUgvKmk6VMia+Lbliy2L40GlyOKN51/rqps4+raIvBeBm+mSAh+Ko0D9Wc4BZ5+/haWyGdkdeA/VNmhidL0/jJv7bBdFuMkH5X6Dbk7AOnSDy6kiCh2jvocxN0it7kt76Fkgbzyno3RBX4fHgUXp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrN2YdWl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrN2YdWl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227d6b530d8so10015825ad.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499393; x=1746104193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=827vkfO6NtYTr71YbC0uRS9GnNzybcT/ZbLiDo7BFAs=;
        b=TrN2YdWlKWYj3zzWLchgIIwkGYoN/QxOV7PCpZyXvZZ5kXLIi7f5vPyRtLL3Pvo/om
         flO2FQRxwPjm5bjZw17gR+C52j0+5awIN8a/IAAR3XV/GodsruhqLSOEg0bvhL6njVJo
         ZffUmeIPtd5lPdUKe7ef7hsyXSBJ1O3UD6ajLcwAs/PlZrmxBSoCmIZKwF8TlSTgw1VF
         iVzpNe4GV3Rsz3RyJhowuTQgTIuRGB1JTsEIlxiSA31vy8nUMZtNF4ZgMtsC2GRYWUXU
         x4m+7CzAa/p0YtUtOcG7N2rjh6Cawwto1cgGvxLpCr4vY4wl5HbfgNzqIhhtf/F9BVFL
         GBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499393; x=1746104193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=827vkfO6NtYTr71YbC0uRS9GnNzybcT/ZbLiDo7BFAs=;
        b=PnYEm5wVLLBALkUGOzm045lH/sdgzLqwqCH5YaQN/nkqUQV7PIbzBr0ImxvquwBbfN
         NVHxMpL/fgJSLmj+E+BVcigX/aHI3Zsn0tEvtXkd1FD4HW8FtDJABiVpuw4r1+VLeS6C
         naMgKIFsX5GHcvm7bmPG20de65lF6+9lLG/YeBK1+XZTHJPg9MAdV8VG7//Axne4DXG/
         QjwOgktvExbry6ZtagwzecRFHz6D5J3b+AUVjvS9YwbFCS4LBLG/vdFU03cj+7Z8QRHg
         PKUzUZuPa92AyRstA7oGBsE6xT2T+6TxzKVmHra4oI3P8oe5PnpVkk969hOub7bYiUvf
         AUpA==
X-Gm-Message-State: AOJu0Yzx2gk61zhWPerMXVX4NC/8b5wMbfUm8EpfNjJMm3UszKFpOlI2
	X3NEe6gYvpvjof7BbNQsR0PTO3zAzFOqUlcoB6HdIgIjVvLifUHg
X-Gm-Gg: ASbGncvEYTevELB5M920VYKNTA+TDDBtp1Eipx9OfAY1A9I7m34+Mbgs3AwHHhND0+6
	WQBJTWzLv+LPvhKyRbPPkByFyAUte01pjqAhLGIAgjD8qfkc7jLR2Ae4pSVVAZ+7ak0zeSpyJ6w
	iGhEswvcyxVLCkYtB4YSVEt/4BsXq9sbobZ9/deLxyIj5cE7xDWVIILMJqdT207cx5UD/ULBx1n
	Ij+/IsnqzjfE5e61NoSHnWn/BrWHdisg0XOSvoy171rjsek+Kt1z0orYL2pSwGNWg5QomXjtVnT
	Ta3F5TIar3FSotpRO73O5moHvds+SAK6HCG/
X-Google-Smtp-Source: AGHT+IF6+I5TXoTrVRJ7N7bQFT6xU1R8P7AQx69akCDi10mL7p+4N2VtZM9qrHtDIucc98l5arGcTA==
X-Received: by 2002:a17:902:f54a:b0:223:65dc:4580 with SMTP id d9443c01a7336-22db3dea005mr34072135ad.52.1745499392814;
        Thu, 24 Apr 2025 05:56:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4d76f56sm12414555ad.9.2025.04.24.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:56:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:56:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aAo1CvpcXYfNonTF@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAet23peGs2OZUcn@ArchLinux>
 <aAjUr5AY9gTCpVlS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAjUr5AY9gTCpVlS@pks.im>

On Wed, Apr 23, 2025 at 01:53:19PM +0200, Patrick Steinhardt wrote:
> On Tue, Apr 22, 2025 at 10:55:23PM +0800, shejialuo wrote:
> > diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
> > index 262b28c599..6be0cdb8e2 100644
> > --- a/t/helper/test-string-list.c
> > +++ b/t/helper/test-string-list.c
> > @@ -1,48 +1,9 @@
> > -#define DISABLE_SIGN_COMPARE_WARNINGS
> > -
> >  #include "test-tool.h"
> >  #include "strbuf.h"
> >  #include "string-list.h"
> >  
> > -/*
> > - * Parse an argument into a string list.  arg should either be a
> > - * ':'-separated list of strings, or "-" to indicate an empty string
> > - * list (as opposed to "", which indicates a string list containing a
> > - * single empty string).  list->strdup_strings must be set.
> > - */
> > -static void parse_string_list(struct string_list *list, const char *arg)
> > -{
> > -	if (!strcmp(arg, "-"))
> > -		return;
> > -
> > -	(void)string_list_split(list, arg, ':', -1);
> > -}
> > -
> > -static void write_list_compact(const struct string_list *list)
> > -{
> > -	int i;
> > -	if (!list->nr)
> > -		printf("-\n");
> > -	else {
> > -		printf("%s", list->items[0].string);
> > -		for (i = 1; i < list->nr; i++)
> > -			printf(":%s", list->items[i].string);
> > -		printf("\n");
> > -	}
> > -}
> > -
> >  int cmd__string_list(int argc, const char **argv)
> >  {
> > -	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
> > -		struct string_list list = STRING_LIST_INIT_DUP;
> > -
> > -		parse_string_list(&list, argv[2]);
> > -		string_list_remove_duplicates(&list, 0);
> > -		write_list_compact(&list);
> > -		string_list_clear(&list, 0);
> > -		return 0;
> > -	}
> > -
> >  	if (argc == 2 && !strcmp(argv[1], "sort")) {
> >  		struct string_list list = STRING_LIST_INIT_NODUP;
> >  		struct strbuf sb = STRBUF_INIT;
> 
> I'm a bit surprised that the patch series stops after this patch given
> that the only remaining subcommand is "sort". Is there a specific reason
> why you don't also convert that function? If you did we could declare
> victory by deleting the whole "test-helper string-list" subcommand.
> 

Actually I also want to delete the whole file. However, as you have said
as following shows:

> It seems that the only reason is p0071, where we benchmark performance
> of sorting. I dunno... that one is of course not a good fit for our unit
> testing framework. But it's a bit sad that we cannot remove the whole
> infra only because of a performance test that nobody ever runs in the
> first place.
> 

I think we should delete the whole file. I'll find out a way to do this.
It's wired that we keep the "test-helper string-list".

> Patrick

Thanks,
Jialuo
