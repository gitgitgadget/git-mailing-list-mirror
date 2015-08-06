From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] builtin/mv: remove get_pathspec()
Date: Thu, 6 Aug 2015 16:18:34 -0400
Message-ID: <CAPig+cTn=KLryVJEz7_u7nt2AzB1zzc5y40euk=oP3ZWaaYF3A@mail.gmail.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
	<1438885632-26470-1-git-send-email-sbeller@google.com>
	<1438885632-26470-2-git-send-email-sbeller@google.com>
	<CAPig+cRREzwRJV-az-p-r1E7JyDqDZ4GPvM1cQQzXXNyLjGPUQ@mail.gmail.com>
	<CAGZ79kZ7oS+AQgq91WRaFTCKGUnZj-cZB1YPkjQo9KAueqEN3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNRce-00080Y-7l
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 22:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbbHFUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 16:18:36 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35206 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbHFUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 16:18:35 -0400
Received: by ykcq64 with SMTP id q64so67412598ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=semTichU8tZaCr+IhudrrMU7fCGpSp7/f/I5KtZhWy0=;
        b=Sny1EHD5BkOhlk8iwyIlV4JwaqRAD6jXHRAFAHSUeln65DxyKu5wGZPMM3YESju+Z+
         Q702hd2d7aqic00wJdojkwI0SmIytEhqrO9sUrwBjdcqIQlBtufq0FCn0Abfi2LJjAv1
         AGw0P5NfnYdI3TQc7/fVANWDBNCIxeUQ3lU7DbpuY0vA+7kWoO+iHbv4hKTmKbth7aRx
         GWhUPRedyphePaTA63TCn30UsHEFUYNHWJ80Rg53rLEBd5uvXr0GRkUjsZLTYVVGyXOM
         usc6TQ5n59CuWTuaBZEvRD4XOTgnVWbqZg8OJNwDGeWtCcNf7qldHuSVsj1SqvfcoqVm
         1C0Q==
X-Received: by 10.129.76.140 with SMTP id z134mr4155685ywa.17.1438892314744;
 Thu, 06 Aug 2015 13:18:34 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 13:18:34 -0700 (PDT)
In-Reply-To: <CAGZ79kZ7oS+AQgq91WRaFTCKGUnZj-cZB1YPkjQo9KAueqEN3w@mail.gmail.com>
X-Google-Sender-Auth: RXA9KAa0kfWMtd7qxMcgaJD5eZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275443>

On Thu, Aug 6, 2015 at 2:58 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 6, 2015 at 11:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Aug 6, 2015 at 2:27 PM, Stefan Beller <sbeller@google.com> wrote:
>>> `get_pathspec` is deprecated and builtin/mv.c is its last caller, so
>>> reimplement `get_pathspec` literally in builtin/mv.c
>>
>> Curious. Since this is just moving code around, rather than doing the
>> actual work to complete the final step as stated by the NEEDSWORK
>> comment, isn't it just moving the "problem" from one location to
>> another? Is it worth the code churn?
>
> Yeah it is moving around the problem a bit. And the code churn is
> unfortunate. Though when I was reading the documentation on
> pathspecs, literally the first sentence was "Do not use get_pathspec,
> it is out dated". And that was a sad taste for reading documentation.

By loudly warning you about deprecation and, more importantly,
pointing you at the accepted alternative, this documentation saves you
from wasting time (both time spent reading and time spent going down a
dead-end path). It would be a "sad taste" if it warned you quietly
only at the end of the documentation or not at all.

> It's ok to have such warnings in the docs, but as the first sentence as if
> there was nothing more important than avoiding the out dated stuff?

>From a documentation standpoint, there is nothing more important than
warning you to avoid it since it is outdated and likely to go away in
the future.

> I mean I want to understand the actual code and how I can use it, right?

No. It's deprecated and not meant for your use.

It's a different matter if you want to understand what the function
does because you've encountered a call in existing code, but that case
is covered by the existing documentation still being intact (that is,
it wasn't removed when the deprecation notice was added).

> And there are different approaches to solving the problem.
> I could have just reworded or even just rearranged the documentation.

The documentation seems fine as-is.

> The approach I take here includes a bit of code churn, but it moves the
> problematic pieces all in one spot.

Indeed, I had the "localizing the problem to one spot" argument in
mind, and even wrote it as an answer to my own question, but deleted
it before hitting "Send". The counterargument (aside from code churn)
is, that by leaving it alone, it serves as a good reminder of the
"problem" and is more likely to get noticed and (perhaps) fixed by
someone than if it is hidden away in builtin/mv.c.
