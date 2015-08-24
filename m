From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 23:39:06 +0530
Message-ID: <CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:09:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwBh-0007e8-HX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbbHXSJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:09:37 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33326 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbHXSJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:09:36 -0400
Received: by oieu205 with SMTP id u205so15213096oie.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5wtjDaE7bX/etqzIWBrCYGLq04ECp1m3dA0CpsuxO3Y=;
        b=pReB1o0dwvb4pYvFQrRGw0mAWOt4ew5oIKU+dYqPjAyLfFiqsJIJxM1V8Zn4AiYK61
         p2HDwRGzadEWASu19RCk4uOgcJuUxrmA28rlzvQbi1skGR+0W10CqL3Yx9YDdcqoCo/1
         xDYDVpXiPWCBgEeiolUO+nsHdQiNdNIRdGX8j4sIwV0LtN+nGuwYPuWaqca52WABfrvm
         CtSWt8U9SnKwF4f21SPqEk3BfbFWJWhKp4YjQEC6jPDIIhFW/tBrpVTobPsCrwDbY25s
         Wt5sM7kZrtkXPU+5avT3ib5i523nuEL08cLdpjKFJcmTjmPnf+gkbCxDMwS34HUMZyZ0
         CUQg==
X-Received: by 10.202.221.4 with SMTP id u4mr3453298oig.104.1440439776177;
 Mon, 24 Aug 2015 11:09:36 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 11:09:06 -0700 (PDT)
In-Reply-To: <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276472>

On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Interdiff:
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 1997657..06d468e 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -133,7 +133,8 @@ align::
>>       `<position>` is either left, right or middle and `<width>` is
>>       the total length of the content with alignment. If the
>>       contents length is more than the width then no alignment is
>> -     performed.
>> +     performed. If used with '--quote' everything in between %(align:..)
>> +     and %(end) is quoted.
>
> That sounds like a buggy behaviour that we may want to fix later,
> though.  Perhaps document it as a known bug, e.g. "Currently it does
> not work well when used with language-specific quoting like --shell,
> etc." (while punting on fixing the implementation for now)?
>

I might have misunderstood you, But based on the discussion held here
(thread.gmane.org/gmane.comp.version-control.git/276140)
I thought we wanted everything inside the %(align) .... %(end) atoms
to be quoted.
So I'm a little confused by what you're trying to say.

-- 
Regards,
Karthik Nayak
