Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DBA55
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978011; cv=none; b=T9KxDG4nomGF+YkHhRRmxzuoPhqZVbOr+CnZwbhmcTRV6N8lDTddpw2DnH9c5eYZoIQcgTmkNNA88j+mPio9lyEAsytWWGqjLMX/sQ1eEJnTW0MphTdMHMEuk0CpRY8yMA09dNAbBT1YcWZY38nigXrnEEteTZ6tFnD/RgzAEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978011; c=relaxed/simple;
	bh=2c1eUxnWCoPWGr9RUzsLSzk7j89Gc9TBnUWqwuCvuEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQ5t4y6P9JppEXzMM3ti4+G9E9kgs5cRMxyYwkaItr4IqB7QkVp2eXk075s8yF1EeTy7RIsjk+GzkUwfWbd9NQ9sWGfdt2PQ1h5a7HiDPQiKbL6GDpQ0ZRNmSqsdy32PTl+86wjzgAu+cpeqLfFRQncXBafxqNN83ZD8SIxP5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuLi430a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuLi430a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso7980b3a.3
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978009; x=1763582809; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU8ycZJJKLrSmHITtae1SUOHnce7AxetLm1QB1jCaEo=;
        b=GuLi430arkuEAOi9sF7hUJw1QwShyNYl8Yu3OgsMdXW+aM7/oz23p/yYhITSWLENM0
         1Y/wW9xi2md2f3yapgC+00tSuvx4jASEUu79MmNvC0ECuWZ1bwkyZDr/eaqBY0jb6A/L
         GcnOBbHNY9pKx2RauDSEtAvJCi7+JPb+IneujiqFjxwEzoX0BrOwrlbPWJPd0PV1H4kS
         XmS6VnlCe5r2YX4bNQ7cKtH3SVrmldF+i4PTmhuW6cHUJWoYwjqJyjAc7j0eDtYUOX5P
         L1h4XVsJo3QCOwDLkfEkALpGSKLMKI77YswYP258jcSSA2Ab7X/BNzX0lheiQfvHY2i7
         HzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978009; x=1763582809;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sU8ycZJJKLrSmHITtae1SUOHnce7AxetLm1QB1jCaEo=;
        b=VpPXeKndNFGQaSGADrSRgnKFykXpi0qOuI0cxDGw44YUP/es6676m86g+t9IXesC1S
         1zNRpDdBKvpm/YFsniZ6bWb3BE33Lz0G6SE1psV3BlALvSt2lC0fyV/3/L3Rw9ocOKl5
         4UpV5XTBKcsJg8+a75apm5kSN+krr1apj0OcJ5DqqYbK6d0WmVn7lZ2usV6pKAoC0wX0
         kSjbutx+fXnrSrB7D4wIoEthNXXRYDvjsjfvQh6LKiuQclacccV8c3ZdItcPcETrxblc
         obUgc76mLIZ5KgwmsMaLitCqtS/8Xsfyrzarx+4z4wF/buz42ragvar7BfWg+D26y1Mz
         kGdw==
X-Gm-Message-State: AOJu0YyKrDouPerd0vtUYxarvZrJsMD8TO4ze2LXeVGLumaqp0okiF+B
	hwsKK2ps1+sGBIpB6tG5F7d3Tsbt8IMR072tzsfgFuZWISq4s+3F4kl+
X-Gm-Gg: ASbGncv7hLsaAeG8lYDwgGwzZuL+56BNcz72eb6lydJCNH63ePcS+a43Uh8cGqbd6PA
	6pk0gFRtw5OLsrSG04VYaE58yscpH2JTPIjHQCbHbeKiVMboZDB+lyqP/cSXsnfVaLKwaHxO5Xv
	0r2hF7bNdB2alAhObIbpKfb5Zy3WLjIylAboCK8JWkv26YzC5EHXJ4gtjfU/bbUjV+eDHoxevEY
	BaOrVB4er0//GqL9dCBE03S0vptVnFyYwjbTHwJjmrEeaQqLreKOkkebrlGTSxeAGTKtDXff4RB
	g5ICUCfuO9VS6Glpru0R+R3P9nkpct8kdMQ8yPBj1ipaEeiJAzJin8KvPereqGeK8jzHD35a2DY
	kHk8L6oC/ti91ozvz3LTzEgchLYPCY1g9eNvWI6wE7QUmVr/pL7WUBXcQzA==
X-Google-Smtp-Source: AGHT+IHapmBBtIe3nF4sB9I0OzOjbR0WyLpw9ht/FfVfIe8cl5TSCPR5hFWZokGO8UCasXI3YksZLg==
X-Received: by 2002:a05:6a00:228c:b0:7ad:11c9:d643 with SMTP id d2e1a72fcca58-7b7a4aed242mr4974792b3a.21.1762978009294;
        Wed, 12 Nov 2025 12:06:49 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c6951633sm19894299b3a.0.2025.11.12.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:06:48 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
In-Reply-To: <20251112103158.GA983233@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
	<20251112080215.GC979063@coredump.intra.peff.net>
	<87y0obis17.fsf@gmail.com>
	<20251112103158.GA983233@coredump.intra.peff.net>
Date: Wed, 12 Nov 2025 12:06:47 -0800
Message-ID: <87qzu32ey0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Nov 12, 2025 at 12:17:24AM -0800, Collin Funk wrote:
>
>> I see that an interceptor was added in 2023 [1]. Maybe your compiler is
>> older than that?
>
> No, I'm using gcc 15.2.0 (from Debian unstable).
>
> But I'm not sure if the linked code does anything useful for us.
>
> One, it's not clear to me if it is even kicking in or not. It only does
> anything if the region is "sanitizer managed", according to the details
> at https://reviews.llvm.org/D154659. I'm not sure what that means
> exactly, because I'm fuzzy on how the shadow map works.
>
> But even when it does do something, it seems to round up to the nearest
> page size. But we really want to know if we go even one byte over the
> requested length, because if we touch the 1235th byte of a 1234-byte
> buffer (which is going to be a NUL because of mmap rounding up the
> pages), then there's probably another test case somewhere where we
> access the 4097th byte of a 4096-byte buffer (which is going to
> segfault).

The glibc docs say that the length is rounded up to the nearest page
size [1]:

    Thus, addresses for mapping must be page-aligned, and length values
    will be rounded up.

This wording in POSIX makes me think that all systems will round up to
the nearest page size [2]:

    Thus, while the parameter len need not meet a size or alignment
    constraint, the system shall include, in any mapping operation, any
    partial page specified by the address range starting at pa and
    continuing for len bytes.

>>       char *ptr = mmap (NULL, getpagesize (), PROT_READ | PROT_WRITE,
>>     		    MAP_ANONYMOUS, -1, 0);
>>       if (ptr == NULL)
>>         abort ();
>
> I think you want to check for MAP_FAILED here, not NULL. And I think we
> always get that, because MAP_ANONYMOUS needs to be OR-ed into MAP_SHARED
> or MAP_PRIVATE. So here:
>
>>     $ gcc -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
>>     SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x400554) (BuildId: 1b7a82189bfffb3f73d420e138b9859add25901a) in main
>>     $ clang -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
>>     SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x4e9ee6) (BuildId: aca1d168eacebaa239082d8a45ab74c8470f4b31) in main
>
> I don't think this is ASan finding a problem. It is just telling us that
> we segfaulted for other reasons. And the fault here is because the
> broken mmap() invocation returned MAP_FAILED, and we tried to access
> that garbage pointer.
>
>>       ptr[getpagesize () + 1] = 'a';
>
> This is also making a map that is a multiple of the page size, and then
> touching a byte that's on the next page. That's the easy-ish case that
> we can often already find, even without ASan (though it depends on what
> comes after the mapped memory; it might be a valid page).

Oops. I clearly don't use mmap much. :)

> A more interesting test for Git is to actually map a file, like:
>
>   $ cat main.c
>   #include <unistd.h>
>   #include <fcntl.h>
>   #include <sys/mman.h>
>   #include <sys/stat.h>
>   #include <stdio.h>
>   static void die(const char *msg)
>   {
>   	perror(msg);
>   	exit(1);
>   }
>   int main (int argc, const char **argv)
>   {
>   	struct stat st;
>   	int fd;
>   	char *ptr;
>   
>   	fd = open(argv[1], O_RDONLY);
>   	if (fd < 0)
>   		die("open");
>   	if (fstat(fd, &st) < 0)
>   		die("fstat");
>   	ptr = mmap (NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
>   	if (ptr == MAP_FAILED)
>   		die("mmap");
>   	printf("last byte: %d\n", ptr[st.st_size-1]);
>   	printf("one byte after: %d\n", ptr[st.st_size]);
>   	return 0;
>   }
>   $ yes | head -c 4096 >big
>   $ yes | head -c 372 >small
>
> And ASan does often detect the problem for the "big" page-sized file,
> but not consistently! If I do:
>
>   gcc -fsanitize=address main.c
>   while ./a.out big; do echo ok; done
>
> I may get output like:
>
>   last byte: 10
>   one byte after: 127
>   ok
>   last byte: 10
>   one byte after: 0
>   ok
>   last byte: 10
>   one byte after: 0
>   ok
>   last byte: 10
>   =================================================================
>   ==988617==ERROR: AddressSanitizer: unknown-crash on address 0x7efd40b9f000 at pc 0x564fe77b64eb bp 0x7ffff49e8160 sp 0x7ffff49e8158
>   READ of size 1 at 0x7efd40b9f000 thread T0
>       #0 0x564fe77b64ea in main (/home/peff/a.out+0x14ea) (BuildId: 8db121bb5c048cb336f8be729e8cefebd6f059a3)
>       #1 0x7efd41233ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>       #2 0x7efd41233d64 in __libc_start_main_impl ../csu/libc-start.c:360
>       #3 0x564fe77b6150 in _start (/home/peff/a.out+0x1150) (BuildId: 8db121bb5c048cb336f8be729e8cefebd6f059a3)
>   
>   Address 0x7efd40b9f000 is a wild pointer inside of access range of size 0x000000000001.
>
> So it worked three times without ASan noticing the problem (producing
> two different outputs), and then ASan finally crashed. But it didn't
> give us the usual information we get for a malloc overflow. It's just an
> "unknown crash" from a "wild pointer". So I'm not sure if it's even
> finding these through its own poisoning, and not just catching an
> unlucky segfault.
>
> If we switch to the small file, then ASan never reports anything! The OS
> gives us a page-sized chunk, so we consistently read a "0" in from the
> byte after our requested size.
>
> If we swap out the mmap for:
>
>   ptr = malloc(st.st_size);
>   read(fd, ptr, st.st_size);
>
> (which is roughly what our NO_MMAP wrapper is doing behind the scenes),
> then ASan does catch it consistently, even for the "small" file:
>
>   $ ./a.out small
>   =================================================================
>   ==1008630==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7d11fe01b4 at pc 0x55cf89b1b4c8 bp 0x7fff471b84e0 sp 0x7fff471b84d8
>   READ of size 1 at 0x7c7d11fe01b4 thread T0
>       #0 0x55cf89b1b4c7 in main (/home/peff/a.out+0x14c7) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
>       #1 0x7f4d12e33ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>       #2 0x7f4d12e33d64 in __libc_start_main_impl ../csu/libc-start.c:360
>       #3 0x55cf89b1b150 in _start (/home/peff/a.out+0x1150) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
>   
>   0x7c7d11fe01b4 is located 0 bytes after 372-byte region [0x7c7d11fe0040,0x7c7d11fe01b4)
>   allocated by thread T0 here:
>       #0 0x7f4d1311a0ab in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
>       #1 0x55cf89b1b3a0 in main (/home/peff/a.out+0x13a0) (BuildId: 2cebfcd0a00064eaaed750af010fcecdae2f5666)
>       #2 0x7f4d12e33ca7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

Cool, thanks for the actual working example. Your patch makes perfect
sense now.

Collin

[1] https://www.gnu.org/software/libc/manual/html_node/Memory_002dmapped-I_002fO.html
[2] https://pubs.opengroup.org/onlinepubs/9799919799/functions/mmap.html
