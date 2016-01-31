From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 15:36:44 +0000
Message-ID: <CANkmNDfzxf045izkZV_Ps6_s0hA7q4kziu3u+BRexX-FOkgyWA@mail.gmail.com>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
 <56AE1F40.8060509@kdbg.org> <CAEtYS8Qt1ewf3nAAiP_2ey5mV=9e3_To1fcaeV6f3+05uwHxgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 16:37:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPu3t-0004OO-8x
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 16:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbcAaPhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 10:37:07 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34136 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218AbcAaPhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 10:37:05 -0500
Received: by mail-lb0-f172.google.com with SMTP id cl12so62641060lbc.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h5u9h5zaWfUQ8Ua1NINaUwLSYiqvjqMNp2TX3+kRQwg=;
        b=Zu64myOcLWoErs2II6YT+IwQM4WquDd1UNAiGYuxGOlfH2RH1D3oVDDwhRWAssyvuC
         hdi+ZWrhLKeRCw6FYNnZU7oezJrMhfWpw4/JjmqwGfJlR846pnqDmGKW5vUyfe5n5Go5
         iNgAHVnYbUE+A5jOL69YrySubunmq4+cliH/84QcsE1sxdxjxLOozTL/gq/w6Hl4ConX
         2rrG3r2jkUAbBFu+m/D9vwhYk52VwSUQgKkV8hvajgkcuHR0cnnYwkB3kTA6sxr5OQj0
         S2kFlUUWynFhRwueP56++NpcvVYoYkAdnFqyT032dYJWl/MPCpw5+1tyBNQ8Hxq9ySiH
         jUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=h5u9h5zaWfUQ8Ua1NINaUwLSYiqvjqMNp2TX3+kRQwg=;
        b=LaJ6ysQuJcx2fKU9zc5MZhcz1LgZvXX6EyFe6NcPwIm5jPM+UWKqNjvF1JA7ja73mV
         T8zy08tZuEhSUPmAa1FDBgsAvzOTy07YxnBDxTNgjPyzsIRy/tEKGiF7HD/dPtd8WF7p
         V0E7dIC9UxxTkJ60eo+RR3jIeGbUdDXrpVB6x3LcgWy8v9pI8UsAieZ4tUmyInMwdry9
         pDzLD/JNBoYlNVHLTb31Z2UXVR/QaSsihD6KgkzjlBJ1m+RZdPM/fWHSMD/ZbDMkNqVU
         qV+bMDKh/GsHIMxfwDkxCKXFgpWlQQpcacFJWIldahqZoeXvWQ+/y4G7ccc60bxGPErS
         /0Ew==
X-Gm-Message-State: AG10YORPUmc42/gGqNimp0ps9CN5n+Hz+9UzpC5vSGIFXL0CxHLO65Zk2iopQqEVmu450EUJ4JMIQKHfQ/lmYw==
X-Received: by 10.112.12.233 with SMTP id b9mr5643852lbc.63.1454254623646;
 Sun, 31 Jan 2016 07:37:03 -0800 (PST)
Received: by 10.25.207.195 with HTTP; Sun, 31 Jan 2016 07:36:44 -0800 (PST)
In-Reply-To: <CAEtYS8Qt1ewf3nAAiP_2ey5mV=9e3_To1fcaeV6f3+05uwHxgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285151>

On 31 January 2016 at 15:05, Doug Kelly <dougk.ff7@gmail.com> wrote:
> On Sun, Jan 31, 2016 at 8:50 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 31.01.2016 um 15:03 schrieb Aaron Gray:
>>> I think I have found a possible difference in behaviour between
>>> Windows git commandline distro and Linux git
>>>
>>> basically If I do a :-
>>>
>>>      git mv logger.h Logger.h
>>>
>>> I get the following :-
>>>
>>>      fatal: destination exists, source=lib/logger.h,
>>> destination=lib/Logger.h
>>>
>
> Indeed.  And just to clarify, you'll get the same issue on OS X, where
> the filesystem is also case-preserving, not case-sensitive (by
> default, at least).  I've never tried using -f for this, but I'll
> usually use git mv twice to achieve the same result.  Annoying, but
> that way my local directory looks correct, too.

Ah, double up via a temporary name, cool hack !

Aaron
