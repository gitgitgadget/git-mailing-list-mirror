From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 15:04:40 -0700
Message-ID: <CAGZ79kZx=ML-tT6vvjynZ91x6JYqpgKVaEp-Q43MShz0J2EanQ@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqq614qyebl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:04:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNpl0-0003Xt-7r
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 00:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946278AbbHGWEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 18:04:42 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35001 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946136AbbHGWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 18:04:41 -0400
Received: by ykcq64 with SMTP id q64so94566482ykc.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LFfuKR/XS+lFzxtjTuq6vqVDL4j9VvkuGMSxWu/IOeU=;
        b=D4jmp/2D1oXg/a0hFtDEkg3f8cOMj8Z+Fz5Ig69jJBpI8xkSohMqBMX+I8e+upeIME
         Gq3RSeYc9aj5YVnfdhg9CvG5tqDhRzIk2xqIlO1HPMtU+yz2y3iqi/BQI1yOCcWJeSLG
         /hrMXaSdv5LgW0kCLaftHidsqQu7Vno61gZT1aYiLg8MOcBnoXYKIhD+Orz8zIIBwH+S
         wQUo2pujJcXNKl41up4GKbM/9reGpk7L6Hgyp0awIpfBPvXLZB02pT7FoAoJUhKGchC6
         SyIWNZ98/dZZfJqCc3mVFnUZK1F+g+/0/igKP1xW71JBtpOCY7tgqWl/hC3Jh/Psvl01
         OojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LFfuKR/XS+lFzxtjTuq6vqVDL4j9VvkuGMSxWu/IOeU=;
        b=ALTIB+8zOJO4eqJX66B+j5a+rcBUgUoDWeWTSvUKBX+DE76Rula0hhPNqOnCUKSpPx
         zxhNA5me0tzF2VfrpvhscoLms7QuJ7u7oqcMQBVWI4CUqhceYrugIn+IXTEXjQBRNxjf
         zI8yZSLEAiesFuRh29LZN1ExVpMwF/83XGJrqscSPrhI1xdekSfL4tywBLiUtPsTq+Ay
         C3TN4vl+j7oFJHWuRTjLwDa4EjP00SA4XAuRfBaPBUVKhKFo8BTV2IxY+NpXeK44hb0v
         kOzIEJ6tU5RFn41nb3ZF6BoZHTKYLT2u8VugsevHE6Aj+I1rGvuBWLuXaKOSPFojY8Hv
         QXhw==
X-Gm-Message-State: ALoCoQluDlUWVzKo+pfPLb07MmHLHxB795GSlPKi/skul01xVdl7E1eyAzpJxwrhVj61nNxLXGxb
X-Received: by 10.170.55.20 with SMTP id 20mr10094823ykx.25.1438985080350;
 Fri, 07 Aug 2015 15:04:40 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 7 Aug 2015 15:04:40 -0700 (PDT)
In-Reply-To: <xmqq614qyebl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275494>

On Fri, Aug 7, 2015 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Aug 7, 2015 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>> ...
>>>> We can drop that hunk as it only uses the new method
>>>> `submodule_name_for_path` but doesn't change functionality.
>>>> So if you want to keep Heikos work, I'll just resend the patch
>>>> without that hunk.
>>>
>>> Does such a result even make sense?  Note that I wasn't talking
>>> about textual conflict.
>>>
>>> If we followed what you just said, that patch will try to directly
>>> read the data in config_name_for_path string list, which is removed
>>> by Heiko's series, if I am reading it right.
>
> By the way, the above is more important part of the message you are
> responding to.  The result does not simply link, because your
> unsorted_string_list_lookup() will no longer have the string list in
> the first place X-<.

I looked through Heikos series and think it is an improvement. I mean I
can redo my patches on top of his. Specially this patch will be easy,
as patch 2/4 (extract functions for submodule config set and lookup)
implements get_name_for_path. All I would need to do then is expose it
to the shell via the helper.

>
>>>> 2) Come up with a good thread pool abstraction
>>>>    (Started as "[RFC/PATCH 0/4] parallel fetch for submodules" )
>>>>    This abstraction (if done right) will allow us to use it in different places
>>>>    easily. I started it as part of "git fetch --recurse-submodules" because
>>>>    it is submodule related and reasonably sized
>>>
>>> I personally think this gives the most bang-for-buck.  Write that
>>> and expose it as "git submodule for-each-parallel", which takes the
>>> shell scriptlet that currently is the loop body of "while read mode
>>> sha1 stage sm_path" in update and clone.  You will have immediate
>>> and large payback.
>>
>> You said that before. I feel like this is a bit to narrow.
>
> That depends on how good a design you make for the internal
> "parallel execution" engine.  If it is made to take an arbitrary C
> function with list of arguments to call it with, for-each-parallel
> would be just a degenerate and narrow case where that arbitrary C
> function happens to be exec'ing a shell and feed a shell scriptlet
> to it.
>
> The internal parallel execution engine would be reusable without any
> change to call C native functions, allowing you to do everything
> inside the process in the future.  And the "narrow" case is a good
> first step to validate your design actually _works_.
>
