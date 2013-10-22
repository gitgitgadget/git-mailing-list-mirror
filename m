From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: Windows performance / threading file access
Date: Tue, 22 Oct 2013 16:30:39 +0200
Message-ID: <52668C0F.9050702@gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com> <52570BC1.2040208@gmail.com> <52574B90.3070309@gmail.com> <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com> <3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com> <52601562.2090301@gmail.com> <49cde110-f3e5-43d9-b399-6b5a6ce59014@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
 szager@google.com
To: pro-logic <pro-logic@optusnet.com.au>, msysgit@googlegroups.com
X-From: msysgit+bncBCH3XYXLXQDBBD4YTKJQKGQEJMWLWNI@googlegroups.com Tue Oct 22 16:30:44 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBD4YTKJQKGQEJMWLWNI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBD4YTKJQKGQEJMWLWNI@googlegroups.com>)
	id 1VYcyl-0008K2-NH
	for gcvm-msysgit@m.gmane.org; Tue, 22 Oct 2013 16:30:39 +0200
Received: by mail-lb0-f188.google.com with SMTP id p9sf824803lbv.5
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Oct 2013 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6nS1H3rW19Gp7dZOv0ca4FpMEc0WpAHoUrX3mYitOrI=;
        b=NlQWsUsnQgr549G489IZfTt8jt/pBlQi2U3kSLY7TLYo0SI8KXh/KOTZYzM2fcHzwx
         vkTPIrEWOis94p/VpJTxelkZyvO273/N2YnTAh1FLNfqXNO3eFOzkhDbC0TGPm2VH3+F
         sOCpyervqd1yrLuhUtxBUIfUOnRhmx56MQ4JJEkY1gJAh2bl3+57vI3+xs4O7wCPD95N
         aaREWg3RSadSSyOoCzBa1zkz2d9ShtMbmdIvUo7ZwYbIfYOQq8kIzJz8f4FqI5WyGmq/
         odCVQvKD0z3eXKhBVv1MvQ6RfG8e+RNdFZdk/JoTrc5jvoraNWn8X2X2mMh8NA0Sdbbi
         0XUQ==
X-Received: by 10.152.37.5 with SMTP id u5mr11233laj.41.1382452239466;
        Tue, 22 Oct 2013 07:30:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.105 with SMTP id j9ls46976laj.72.gmail; Tue, 22 Oct 2013
 07:30:38 -0700 (PDT)
X-Received: by 10.152.121.34 with SMTP id lh2mr8487557lab.1.1382452238589;
        Tue, 22 Oct 2013 07:30:38 -0700 (PDT)
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com [2a00:1450:400c:c00::233])
        by gmr-mx.google.com with ESMTPS id fk2si131901wib.2.2013.10.22.07.30.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 07:30:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::233 as permitted sender) client-ip=2a00:1450:400c:c00::233;
Received: by mail-wg0-x233.google.com with SMTP id l18so7851988wgh.6
        for <msysgit@googlegroups.com>; Tue, 22 Oct 2013 07:30:38 -0700 (PDT)
X-Received: by 10.194.143.100 with SMTP id sd4mr2131025wjb.69.1382452238475;
        Tue, 22 Oct 2013 07:30:38 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ft19sm6952221wic.5.2013.10.22.07.30.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 07:30:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <49cde110-f3e5-43d9-b399-6b5a6ce59014@googlegroups.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::233
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236472>

Am 22.10.2013 00:58, schrieb pro-logic:
>> The trace_performance functions require manual instrumentation of
>> the code sections you want to measure
> Ahh a case of RTFM :)
> 
>> Could you post details about your test setup? Are you still using
>> WebKit for your tests?
> I'm on Win7 x64, Core i5 M560, WD 7200 Laptop HDD, NTSF, no virus
> scanner, truecrypt, no defragger.
> 

OK, so truecrypt and luafv may screw things up for you (according to my measurements, luafv roughly doubles lstat times on C:).

> I've tried to be a bit smarter with the intent of my code, and this
> is what I came up with.
> 
> diff --git a/cache.h b/cache.h
> index 4bf19e3..2e9fb1f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -294,7 +294,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define active_cache_changed (the_index.cache_changed)
>  #define active_cache_tree (the_index.cache_tree)
>  
> -#define read_cache() read_index(&the_index)
> +#define read_cache() read_index_preload(&the_index, NULL)
>  #define read_cache_from(path) read_index_from(&the_index, (path))
>  #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
>  #define is_cache_unborn() is_index_unborn(&the_index)
> diff --git a/read-cache.c b/read-cache.c
> index c3d5e35..5fb2788 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1866,7 +1866,7 @@ int read_index_unmerged(struct index_state *istate)
>  int i;
>  int unmerged = 0;
>  
> -read_index(istate);
> +read_index_preload(istate, NULL);
>  for (i = 0; i < istate->cache_nr; i++) {
>  struct cache_entry *ce = istate->cache[i];
>  struct cache_entry *new_ce;
> -- 
> 

Ahh, I thought that you had enabled fscache during the entire checkout.

> Interestingly when I run on a cleanly checked out blink repo my
> changes seem to make matters worse in terms of performance, but when
> working on a repo with ignored files in it it seems to work better.
> So for point of comparison I decided to run it on a comparison on a
> repo with working ignored files in it in this case msysgit/git after
> a 'make install'. When I get a few hours I'll try to build blink and
> re-run the numbers on a much much larger repo.
> 
> This comparison is a average of 3 cold cache runs of the
> kb/fscache-v4 [a] vs kb/fscache-v4 with my above changes applied [b],
> with preloadindex and fscache set to true.
> 
> For comparison
> git status -s
> [a] 3.02s
> [b] 2.92s
> 
> git reset --hard head
> [a] 3.67s
> [b] 3.09s
> 

These numbers look far too good, so you don't actually do a fresh checkout, do you? I mean, delete all files except .git; killcache; git reset --hard / git checkout -f? That would also explain your 95% lstat times, if there's nothing to do...

> git add -u
> [a] 2.89s
> [b] 2.08s
> 
> 
> I noticed something interesting. Preload index uses 20 threads to do
> the work. When I was keeping an eye on them in task manager some
> threads will finish quite quickly, while others will run a lot
> longer. The way I understand the code at the moment the threads get
> equal chunks of work to perform. It's quite lilkely that even more
> performance could be obtained out of preload if the work splitting
> was 'smarter'. My currently best idea would be to use something like
> a lock-free queue to queue up the work and let the threads get the
> work of the queue. That way all threads are busy with work for
> longer. A candidate for the implementation would be libfds [1] queue.
> However my issue with this library and the reason I haven't tried to
> integrate is simply because the code expressly has no license.
> 

As cache/cache_nr are not modified by the threads, you actually don't need a lock-free queue. An atomic counter shared by all threads should suffice (i.e. pthread's equivalent to InterlockedIncrement/InterlockedAdd).

Karsten




-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
