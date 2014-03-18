From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Tue, 18 Mar 2014 00:07:41 -0400
Message-ID: <CAPig+cSu=zgXdd55dj-u6mOzHqpUme7r-7OH+jjnOEt2P6C0vw@mail.gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
	<1395093144-6786-2-git-send-email-quintus.public@gmail.com>
	<xmqqob14a14s.fsf@gitster.dls.corp.google.com>
	<CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
	<CAPig+cRGwBV5CE3X9yGZGRNtKojCagz_F_f4Kd+S+D_qX+ZwJw@mail.gmail.com>
	<CALs4jVFVO8Jf-nn0PMtOYeMMKsB869KWQv8vV5kAg1itC1isiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlJb-0001gN-3A
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaCREHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 00:07:43 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:49989 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaCREHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:07:42 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so17635129ykq.7
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 21:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W9f0S3IkL/rKbY2YfFS6jsWtFONuOSpX4v3Tw7PMUJM=;
        b=xUmEAKQ7kBWQd0d/RroKo/C2nMh3x2VNGPb1ORRD2p3ncLzkudlRFt9yCzI3WzXoGF
         fMipdLYy594Z8aprBERWShyLIZa9hmn6Ir/UzFiJZ/00EKF8tpqe/cPMTjexXnI2iJAb
         7eN0C6lIhAe9Po5I8I/VuxdRtC5DIT6AT/YCLu70LkGzIGm72Sy8NF2tvTb4aZ0mV+Dh
         ISSiLdoCPQ4PicrMw9EDXXQK5JM/yKpkmBDD2cr1Ro+eXPzpZ9p1SYzRldhBpcE2m+zw
         tq06tSn7bSVarSZQ6o5dU7lVHyxadTFG7uPwcSavseRop5VRa6pJpO/CmV3b2yMK99Pm
         3S9w==
X-Received: by 10.236.16.83 with SMTP id g59mr15117850yhg.14.1395115661980;
 Mon, 17 Mar 2014 21:07:41 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 21:07:41 -0700 (PDT)
In-Reply-To: <CALs4jVFVO8Jf-nn0PMtOYeMMKsB869KWQv8vV5kAg1itC1isiQ@mail.gmail.com>
X-Google-Sender-Auth: DFjzBL3J4SYqckqI5b37B7laNBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244323>

On Mon, Mar 17, 2014 at 10:33 PM, Quint Guvernator
<quintus.public@gmail.com> wrote:
> 2014-03-17 21:59 GMT-04:00 Eric Sunshine <sunshine@sunshineco.com>:
>> I can't speak for Junio, but the description could be made more
>> concise and to-the-point. Aside from using imperative voice, you can
>> eliminate redundancy, some of which comes from repeating in prose what
>> the patch itself already states more concisely and precisely, and some
>> from repeating what is implied by the fact that you're making such a
>> change in the first place.
>
> Wow, thanks for the detailed review. This mail will be something to
> which I can refer when making future changes.
>
>> In the subject, "general style" is a bit unusual. This isn't just a
>> stylistic change; it's intended to improve code clarity.
>
> It felt a little awkward, but I was trying to follow our guide [1] for
> commit messages. It is all right to omit the leading identifier?

Since this particular patch touches so many different files and
functions, it is difficult to craft a suitable leading identifier. The
alternative would be to split the patch into smaller pieces.
Ultimately, as the project maintainer, Junio must be the one to decide
if the monolithic patch lacking leading identifier is sufficient or if
smaller patches would be preferred.

> [1]: https://github.com/git/git/blob/fca26a/Documentation/SubmittingPatches#L87-L116
>
>> A patch of this nature doesn't require much more description than
>> stating what it does ("replace memcmp() with starts_with()") and why
>> ("improve code clarity"). The following rewrite might be sufficient:
>>
>>     Subject: replace memcmp() with starts_with()
>>
>>     starts_with() indicates the intention of the check more clearly
>>     than memcmp().
>
> This is more concise; thank you. I will adapt this as the message for
> the next version of this patch. Would it be wise to mention magic
> numbers, as the discussion surrounding the rationale of this patch,
> especially with Junio and Michael, has centered around that?

I was thinking of mentioning magic numbers in the example, but decided
that their removal was a natural and obvious consequence of the
improvement to code clarity, so it wasn't strictly necessary to talk
about it. On the other hand, it is a good secondary justification,
thus it should be perfectly acceptable to mention it. If I was writing
the commit message, I might start by saying "As an additional
benefit..." and then talk a bit about magic number retirement.
