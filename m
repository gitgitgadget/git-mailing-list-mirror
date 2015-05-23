From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] upload-pack: optionally allow fetching reachable sha1
Date: Fri, 22 May 2015 18:01:08 -0700
Message-ID: <xmqq617kds4r.fsf@gitster.dls.corp.google.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-3-git-send-email-fredrik.medley@gmail.com>
	<xmqqioblh91w.fsf@gitster.dls.corp.google.com>
	<CABA5-zm3LqA+BAHj0EegoXmTuaNobhEHyD0v2kg=VfCzzqx-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 03:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvxoW-0004DV-ND
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 03:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810AbbEWBBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 21:01:13 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36996 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784AbbEWBBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 21:01:10 -0400
Received: by igbsb11 with SMTP id sb11so2605247igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zdenVgJDkOUPrXkBVdq5RVLviVd5s1hr7U+P+PPgP4Y=;
        b=XzlXX4Ry35rI/hfzPdD1shKFbHv2EWZT4FLd1tBP3uVKS8cv93+eCX3byJAlSRvuK0
         whNZHRYa1L4Wz4oi2aM4NVJGT+o0axIvpCvkQzdhuaMcd5RIRt5Suq+tlwgnv0NetN2O
         f+I5PmJPNia1a0j6jJfD3EVEKvh1FfzE8nWr8mHthk1WDk2PsOqc8eYRWUkMeLq06uJd
         dHq+tEPbWSKAZb/gnOOn8F1ke6b0jzb5dGl5FiIMI8+UyfHiEv9frvgiQMLgX+/SVicl
         QDh1VpZXLhT6DB2mVqD0wMSSioUe5Wm5p0Lf3iekyrlma2Ti38yUO0hkgUekusjxTzB0
         HqSw==
X-Received: by 10.107.16.149 with SMTP id 21mr7265144ioq.53.1432342870187;
        Fri, 22 May 2015 18:01:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id g1sm3084186iog.4.2015.05.22.18.01.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 18:01:09 -0700 (PDT)
In-Reply-To: <CABA5-zm3LqA+BAHj0EegoXmTuaNobhEHyD0v2kg=VfCzzqx-+A@mail.gmail.com>
	(Fredrik Medley's message of "Sat, 23 May 2015 01:55:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269785>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> 2015-05-22 0:15 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>
>> It looks like this new set of tests are well thought out; good job.
>>
>> I spotted a few minor nits, though.  All I'll amend while applying
>> so there is no need to resend only to correct them.
>
> I agree on all your comments and your proposed amendment further down
> looks good.

Thanks.

> Should the test code contain the explanations you've written in this email?

No, I don't think so.

I was just showing that thinking aloud while reviewing would be a
good way to do a review.  The practice

 (1) makes sure that the reviewer actually understood what the patch
     wanted to do (and the reviewee can point out misunderstandings
     if there are any); and

 (2) shows others that the reviewer actually read the patch ;-).

The latter is primarily meant for other people who review the
patches.  I want to see people get in the habit of responding with
something more than just a single-liner "Reviewed-by:", which I
often have hard time guessing if the reviewer really read the patch,
or just skimmed without spending effort to spot issues, and this
message was my attempt to lead with an example.

Will squash in the fix-up in the message you are responding to.
Let's move the topic to 'next' after that.

Thanks.
