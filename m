From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 12:35:14 +0800
Message-ID: <CAKqreuyirQdzjh3Un=ieJMKLicyG7onyy=YTjZ4zOTqfV06eew@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<20160316171535.GC4039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 05:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agm8G-0005jV-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 05:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcCREfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 00:35:17 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36642 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbcCREfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 00:35:15 -0400
Received: by mail-oi0-f49.google.com with SMTP id r187so79865240oih.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 21:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JQSYA3WqigeXXd2m/ntEpleznGwzibVKwYFOWq8m1iw=;
        b=sTknNdiL0S5yhEvgqNuMm9Ppnrm4jurFL/x0od9cUd6G1VwXCqiSJt8adPT7xtqO2Q
         RxwQ+WSLeMEIyqhcylSQ2KgfrUvGWaMPFVdVxbHO+DHYjVMc+81hi6IlsjomYHQX9hSj
         t83nIL+vfXRKecl6j2W9h/1Qlz4aADdrQrISXAbjtTccMtlc4i7w8gDw+Prd8ilz8jlU
         0DHVz/7CxVQi0uqb3diOubVfqNLPqc5KqNlkON4JWqTkCORKBaK6/YoaIia7dt0uoLGw
         vnIIq13mXNxkgF1kM3Lsstkdz8xI4D3NsubSclPvh8Uw6MR+eLsLR4pVaOwOhmgqZ2Jl
         KQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JQSYA3WqigeXXd2m/ntEpleznGwzibVKwYFOWq8m1iw=;
        b=N39Awzvf/Y+nBgiu8EERCH8EXc+aqmkNkgYCi3bw6wkF5CkegwLDQqt6i/eAjkKtcO
         g7F7UYqhY2kcomH9TTXKbh6w8iMzGfq+0O49wZ2W97Zw+N0E//p3JTp+7/JA094Q8/nn
         bB+RyT9mpLMA8hW9+asdFOLqOTkTRV7UCjaTJijU5vGD68VQiX02l2WpA4+JGXzDIq14
         KTHPNAgcPDfcCrBsCQJN56nStoA9PNWgGKdbi0QOnRTND3VY+v/aAAnamZtZEdRTNOHO
         rx7Hhu8Ik+uogid2qAABQr2udrfYKWYm3f3XxATRBXYp6fhOSodtr9mq5QNsNXpGtO6F
         KwRA==
X-Gm-Message-State: AD7BkJI3s2BnvJxkPLD7yZJOUtU7J6pEo61x0brZZvltWRMDcFnq/4KKZ0CfGUoJ7AES9WltzbPDbkTtHQTY7w==
X-Received: by 10.202.181.11 with SMTP id e11mr8318301oif.77.1458275714519;
 Thu, 17 Mar 2016 21:35:14 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 21:35:14 -0700 (PDT)
In-Reply-To: <20160316171535.GC4039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289182>

2016-03-17 1:15 GMT+08:00 Jeff King <peff@peff.net>:
> On Wed, Mar 16, 2016 at 06:07:45PM +0800, Hui Yiqun wrote:
>
>> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
>> index 82c8411..0718bb0 100755
>> --- a/t/t0301-credential-cache.sh
>> +++ b/t/t0301-credential-cache.sh
>> @@ -12,7 +12,32 @@ test -z "$NO_UNIX_SOCKETS" || {
>>  # don't leave a stale daemon running
>>  trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
>>
>> +test_expect_success 'set $XDG_RUNTIME_DIR' '
>> +     XDG_RUNTIME_DIR=$HOME/xdg_runtime/
>> +'
>
> Doesn't this need to export the variable so that credential-cache can
> see it?

I'm not sure, but it seems that a little clean up code added before send-email
make the test fail. At that time, I run test without building. I've
send PATCH v2
which runs well on my computer. However, $XDG_RUNTIME_DIR is still not
exported, but that just works.

I will try to dig deeper into the bash script to see why.

>
>> +
>> +helper_test cache
>> +
>
> This runs the full suite of tests twice (once here, and once for the
> original helper_test invocation you left below). Shouldn't we just do it
> once (making sure that $XDG_RUNTIME_DIR is respected)?

I'd like to test the behavior of git-credential-cache when
$XDG_RUNTIME_DIR is unset.

In `t/t0302-credential-store.sh`, helper_test is also run multiple
times. That's why I
do so.

>> +test_expect_success 'force git-credential-cache to exit so that socket disappear' '
>> +     git credential-cache exit &&
>> +     test_path_is_missing "$XDG_RUNTIME_DIR/git/credential-cache.sock" &&
>> +     unset XDG_RUNTIME_DIR
>> +'
>
> I wondered if this might be racy. credential-cache tells the daemon
> "exit", then waits for a response or EOF. The daemon sees "exit" and
> calls exit(0) immediately. We clean up the socket in an atexit()
> handler. So I think we are OK (the pipe will get closed when the process
> exits, and the atexit handler must have run by then).
>
> But that definitely was not designed, and is just how it happens to
> work. I'm not sure if it's worth commenting on that (here, or perhaps in
> the daemon code).

I'm still confused.

What do you mean by "pipe"? should it be "socket" instead?

What is not designed? cleanup being done, my tests passing or the
synchronization?

>
> -Pef
