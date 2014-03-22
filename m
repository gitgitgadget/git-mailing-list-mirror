From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Sat, 22 Mar 2014 19:47:03 -0400
Message-ID: <CAEjxke-Qe=CYwR9akZ9anjjbO3Tf83f-Y0J4qOJ+i4pKZ=-vAQ@mail.gmail.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
 <1395353785-23611-4-git-send-email-jlebar@google.com> <CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
 <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 00:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRVdS-0008UL-MN
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 00:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbaCVXr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 19:47:26 -0400
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:45170 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbaCVXrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2014 19:47:25 -0400
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com [209.85.216.49])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id s2MNlObK020095
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 22 Mar 2014 19:47:24 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so3866963qaq.8
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 16:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cN2qLMwPjLzeii3MFkA0ukFCnWzE/HNlB4e0P+mfxNM=;
        b=IT6nmr6CDrRqR2g0ohPm1wmOvi77Ook9cWO+RizGBR8kCKJF4id1ZPzOFIwjVCUeS0
         flOnxD1l66Df2QQ+A7VR7CmgMrPxNN6P41Yelf7v7EFIPEMp4oFVG1kpd+zHnPJZe/eD
         IKJP9nbULLjKu3ROSm1bmldZZJGuoqLH3g10+xbKvI4hcw60hRV9G5qV4egINDB/UoZ2
         /tOltl5wSQMnswBdOVZM6DyhGD/2H58frS8MRGqbsav7huakiUsjsg3LQGgcSScn8gjp
         f8wo8g/mOcLGD2xpMEqH2voZeuZszeELICzsInepMHchiQlTjsK03X2KAA7x02HWs4Y+
         X7gg==
X-Received: by 10.224.137.202 with SMTP id x10mr132036qat.80.1395532044073;
 Sat, 22 Mar 2014 16:47:24 -0700 (PDT)
Received: by 10.140.102.212 with HTTP; Sat, 22 Mar 2014 16:47:03 -0700 (PDT)
In-Reply-To: <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-URL-Scanned: Yes
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244786>

On Thu, Mar 20, 2014 at 7:13 PM, Justin Lebar <jlebar@google.com> wrote:
> Thanks for the quick reply.
>
> When I send a new patch, should I fold these changes into the original
> commit, or should I send them as a separate commit?
>
>>> diff --git a/builtin/apply.c b/builtin/apply.c
>>> index b0d0986..6013e19 100644
>>> --- a/builtin/apply.c
>>> +++ b/builtin/apply.c
>>> @@ -4061,7 +4061,7 @@ static int write_out_one_reject(struct patch *patch)
>>>                 return error(_("cannot open %s: %s"), namebuf, strerror(errno));
>>>
>>>         /* Normal git tools never deal with .rej, so do not pretend
>>> -        * this is a git patch by saying --git nor give extended
>>> +        * this is a git patch by saying --git or giving extended
>>>          * headers.  While at it, maybe please "kompare" that wants
>>>          * the trailing TAB and some garbage at the end of line ;-).
>>>          */
>>
>> I don't think the change from "give" to "giving" here is grammatically correct.
>
> Is it?  I might be misunderstanding the sentence, then.  I parse the
> new sentence as
>
>   Do not pretend this is a git patch by
>   - saying --git, or
>   - giving extended headers.
>
> "Giving" is definitely awkward, but I'm not sure of a better word.
>
> I'm happy to rephrase this, but I'm not sure how.  I don't think the
> original makes much sense, but I'm also happy to leave it.
>

You're right; that makes sense. Disregard my comment about that chunk.

>> How about ``If none of "always", "never", or "auto" is specified, then setting layout
>> implies "always".``?
>
> Sure.
>
>> To leave "nor" here, I think you need to replace "not" with "neither".
>
> I think it actually works after the change, but unfortunately Garner's
> doesn't give me a lot of ammunition to back up that feeling.  :)
>
> How about "We don't expect this to be set by the Makefile or by the
> user (via CFLAGS)."
>

I feel like I'm splitting hairs, but I think there's a change in
meaning if you use that phrasing. The difference being "not expecting"
vs. "should not". I don't know which is correct, so I'll defer that to
someone else.

>> This would be better worded as "If src_buffer and *src_buffer are not NULL, it should ..."
>
> Done.
>
> -Justin

Jason
