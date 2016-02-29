From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GIT_TRACE_PERFORMANCE and pager
Date: Mon, 29 Feb 2016 14:46:12 +0100
Message-ID: <CAP8UFD30fWvFPtSgY_6mVMCeQ9rMR-0EODaKbZdMmz_fo-qfKw@mail.gmail.com>
References: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
	<20160229113924.GC29769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 14:46:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaO9U-0004YR-3u
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 14:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbcB2NqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 08:46:16 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35613 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbcB2NqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 08:46:14 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so80056467lbc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0H8z7M1d9YYPSdMwzDDXtdp5zhwgptS+ZpzkMB1evj8=;
        b=ICLrow/EIOffdauBnFlp9F8AAaQpD6V5/3k+rxr5KMRnZYZRG3nxBlTDtYXS2QonNZ
         PdPEWbA9Iqbxbk6XpEeVquCB8QojDBJPZdENIfneusAmDukeTzGBatV0MFXnE5r9GZ2d
         /AI0XzIZLPTfrdgOD0JUGfagq63QXUEA6522/Bip6f8IT9LAaqLZlpgSxyB0ZdYU87IJ
         brlZPSCOo+5ttjR7oWlCszD/GkKCSplbCzII/BsZKM9Mwo0qOf8uE3q3QoDtxp7+3JY5
         KhICSxbkYcbQZVEqGT8wRaWeS2KJGG4+/9lCkZp8oMB+1wPK6E6ymY+rH9WDl1AoAjHl
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0H8z7M1d9YYPSdMwzDDXtdp5zhwgptS+ZpzkMB1evj8=;
        b=MSPGmkg+zVk3SIiwAHEH0tN+1pIz9FHbqGUaQmaLLOF/MzhJTkzZd1a/z2Olxw580A
         iT8MOfIOZhrpNINcsHYkQQeL+T9/Ek5AJ/RV+ca+UvSOezPoUJa6ro+jr0kLpZoyrdjf
         DhVy4pf6cwQ/0EJ+qbj/mBW89w01x9XLVrXlxyoDk7Rvtp2cLYfkqVlVRVxJrwCIHy6d
         PBCcwtR8i7C6JS4cX9zGNT/c2F7lULleziC2CF47TTMDFiXSKv+8mECqWiMVDwbs0zFS
         sSdKLXtL/0B0KC1pSUtI4rmTjb1FR/8b3i4EfFFlufjPe3ID1rVMqTNsocjP19wWMjvI
         9HaQ==
X-Gm-Message-State: AD7BkJKZB+K/kTOskhiFm1bBVsOQY5WTE5g/XKJYwV2oElQs2PV1kNSTCIYEvHCAw05DQGtozKF9BcSfKvctZQ==
X-Received: by 10.112.211.168 with SMTP id nd8mr5558285lbc.116.1456753572928;
 Mon, 29 Feb 2016 05:46:12 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Mon, 29 Feb 2016 05:46:12 -0800 (PST)
In-Reply-To: <20160229113924.GC29769@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287837>

On Mon, Feb 29, 2016 at 12:39 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 29, 2016 at 12:25:49PM +0100, Christian Couder wrote:
>
>> Setting GIT_TRACE to 1 or 2 seems to work, but maybe it is because it
>> outputs stuff at the beginning of the process and not at the end.
>
> Yeah, I think so. Try this (on Linux):
>
>   $ GIT_PAGER='sed s/^/paged:/' \
>     GIT_TRACE_PERFORMANCE=1 \
>     strace -f -e write -e 'signal=!sigchld' git -p rev-parse
>   strace: Process 31155 attached
>   strace: Process 31156 attached
>   [pid 31156] +++ exited with 0 +++
>   [pid 31155] +++ exited with 0 +++
>   write(2, "06:32:30.486995 [pid=31154] trac"..., 114) = -1 EBADF (Bad file descriptor)
>   write(2, "Could not trace into fd given by"..., 99) = -1 EBADF (Bad file descriptor)
>   +++ exited with 0 +++

Yeah, I get the same thing.

> We redirect stderr to the pager (note that GIT_TRACE=1 still goes to
> stderr; it never goes to stdout). We wait() on the pager process before
> we exit the main git process, and we don't print the performance stats
> until atexit(). So by the time we get there, the pager must be dead, and
> the pipe descriptor is closed (I'm actually kind of surprised we don't
> get EPIPE, but it looks like we close the descriptors in
> wait_for_pager()).
>
> One workaround is something like:
>
>   GIT_TRACE_PERFORMANCE=3 3>&2 git ...

Yeah, that works.

> though I guess I'd question whether trace-performance is interesting at
> all for a paged command, since it is also counting the length of time
> you spend looking at the pager waiting to hit "q".

In case of "GIT_TRACE_PERFORMANCE=2 git log -1", it doesn't count the
time spent looking at the pager because the output is small, so 'less'
exits immediately, and it could give the impression that
GIT_TRACE_PERFORMANCE is not working.

I am preparing a patch to Documentation/technical/api-trace.txt to
warn about that.
