From: Conley Owens <cco3@android.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Thu, 6 Mar 2014 15:12:27 -0800
Message-ID: <CAFFUb6X7NJfQQKkJsM+KWn5hiE0C_t3-_DKZh7tONBCm3XVfRQ@mail.gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
	<CAFFUb6ViYitJC1sjL_nyWY1RHuJKURfcZ+_5Zk2kr+suh+txZg@mail.gmail.com>
	<xmqqk3c7yyku.fsf@gitster.dls.corp.google.com>
	<20140306211645.GA11926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhSw-0005ZT-Ha
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaCFXMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:12:30 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64883 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaCFXM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:12:28 -0500
Received: by mail-ie0-f175.google.com with SMTP id to1so3418543ieb.6
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0rIt87zD+g6uWiGCKdPjI4EKcf1xojNvV7BnSkDBtGM=;
        b=SjUdifYie0QZu6+u0jJ20WdLeqOM8GyLuyW6+00H15TCdDMx9mfXBv7gP8uRBPRwtS
         bxc9e1FggaZrjaqiMrxKpV6YQMekaXc/+vbzqIls9BaoTfNmhhsukHSl7YACV2zPh8E6
         Z+YBt0xFBgqGkcR1nQPl1yeaaXRi6JIMEx/lb/aqAmnObAyit9KM3fHAUKhBp4Gid1M7
         a+Ijfp90JxjCWuCg0ZF2HNpuHBRsE+17uuXzi3EWAVcPOwFg24zmUW5JVB9P02l14+ZM
         7FFbgi/0ooGkuu6uLRIhiUb9n66sTLti7uVztvtQcVpaE7baVAzt2SbUTjW+Sb+6ZUXv
         kGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0rIt87zD+g6uWiGCKdPjI4EKcf1xojNvV7BnSkDBtGM=;
        b=gIQ1YTeTiyqo5M8hVU56siQPAnnNciVYCPUQ0HrqjIkyeIEajMiJTNTLkbkKKRT1Io
         TNQWKvCPCY7TIxioM9szJNsEwzlLUhnDTCY+I5qyKL34uwgBfV+CBxspJi3TlR6dap40
         UNTUsaNg/xTGlxhVCseA2CS6cjQ/DX+ybRjlt+Mz319kvgUPHB7wcl4b8wORBtJup4TI
         XYfwwzv0uKJpA6VmrL4rLL6JCexkmtyK2EjY9EvB8POM98MbOH2RTj85+vwA5/zfxfdN
         adbpv1OXIVhooN/9HzXI7ruhB0jt0J0CKCCDG7tCHfhsJtN0zEmqj4uhjl4m0qKfMekt
         FOyw==
X-Gm-Message-State: ALoCoQnxv/TzlsPEyl05to3KAPooyGb5jrrSCHlDHaJmXcwKWQi44o8MWDDVeX9pvjX/xosJNIU/
X-Received: by 10.42.214.80 with SMTP id gz16mr12585338icb.6.1394147547961;
 Thu, 06 Mar 2014 15:12:27 -0800 (PST)
Received: by 10.64.145.101 with HTTP; Thu, 6 Mar 2014 15:12:27 -0800 (PST)
In-Reply-To: <20140306211645.GA11926@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243570>

On Thu, Mar 6, 2014 at 1:16 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 06, 2014 at 10:24:49AM -0800, Junio C Hamano wrote:
>
>> > OK, I've tried using my own build from master, and I still get the same results.
>> >
>> > I've done a little more investigation and discovered it always hangs at:
>> > `atexit(notify_parent);` in `run-command.c:start_command`
>> > when running:
>> > trace: run_command: 'git-remote-https' 'aosp'
>> > 'https://android.googlesource.com/platform/external/tinyxml2'
>> >
>> > Could this have to do with the atexit implementation?  (eg. limit on
>> > the number of functions that can be registered, etc)
>>
>> Thanks.
>>
>> An interesting theory indeed.  I read that an implementation is
>> supposed to take at least ATEXIT_MAX (32) calls to atexit(3); while
>> I do think we register functions with atexit(3) from multiple places
>> in our code, I doubt we would be making that many.
>
> It seems awfully weird that it would _hang_ in such a case, though. That
> sounds more like hitting a mutex that's internal to atexit(), or
> something similar.

You are correct that it's a mutex internal to atexit.  The crazy thing
is that there is only one thread sitting and waiting for it.
====================
(gdb) thread apply all bt

Thread 1 (process 71053):
#0  0x00007fff8cb67122 in __psynch_mutexwait ()
#1  0x00007fff833d0dcd in pthread_mutex_lock ()
#2  0x00007fff8d4a77e0 in LockHelper::LockHelper ()
#3  0x00007fff8d4a8d0a in dladdr ()
#4  0x00007fff83412260 in atexit ()
#5  0x000000010597b35e in start_command (cmd=0x7fe1cd801b30) at
run-command.c:374
#6  0x0000000105998959 in get_helper (transport=<value temporarily
unavailable, due to optimizations>) at transport-helper.c:142
#7  0x00000001059970bd in get_refs_list (transport=0x7fe1cd801370,
for_push=0) at transport-helper.c:954
#8  0x000000010599635d in transport_get_remote_refs
(transport=0x7fe1cd801370) at transport.c:1227
#9  0x00000001058b7469 in get_ref_map [inlined] () at
/Users/android-build/cco3/master/git/builtin/fetch.c:278
#10 0x00000001058b7469 in fetch_one (remote=<value temporarily
unavailable, due to optimizations>, argc=<value temporarily
unavailable, due to optimizations>, argv=0x7fff00000000) at
builtin/fetch.c:862
#11 0x00000001058b6f22 in cmd_fetch (argc=<value temporarily
unavailable, due to optimizations>, argv=<value temporarily
unavailable, due to optimizations>, prefix=0x0) at
builtin/fetch.c:1158
#12 0x0000000105890acc in run_builtin [inlined] () at
/Users/android-build/cco3/master/git/git.c:314
#13 0x0000000105890acc in handle_builtin (argc=3, argv=0x7fff5a370648)
at git.c:487
#14 0x00000001058906c1 in main (argc=3, av=<value temporarily
unavailable, due to optimizations>) at git.c:533
===================

>
> Conley, can you see if dropping that atexit clears up the problem (you
> should be OK without it; git will just fail to notice the child's
> exec failure with as much detail).

Yes, I'm unable to reproduce the issue after dropping atexit.

>
> -Peff
