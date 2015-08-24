From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 20:39:51 +0530
Message-ID: <CAOLa=ZQx_eWdq5cLskAT_c1OjZ-7DwWwZTC9S=ZafEDYHFGncg@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> <vpqzj1hkc5q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtOF-0000Cr-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbbHXPKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:10:22 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34727 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbbHXPKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:10:21 -0400
Received: by oiey141 with SMTP id y141so81935578oie.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UOi1IZzhLTxViscalLJF/fxb93/EqJ0z00KINSavOc0=;
        b=fN9EpAg2jJjJWVwy+5oHMo2JqFkBqqJ3jbMOEoIhJBaQ0fJZdH73wrsU45D984EY2Z
         HFRaBm4CKJzIDzVcsrn82DuNz6fQhn/WBSXyc+I9FmiU9ryFahpx73ad//10ZW+S1OJc
         axmTH5js4Kp/paIEQAMGpvV8zcyADWIxWK2EcSh/H0CKqIHvI6O8gj+HZFPigfXtR4a+
         NOcY5dS7Z0yONhrdb0muIzIOV/FLyfpcHdK6t2Mb3N7ihO/T9mYk9qzUoiqcPaCvol+z
         RzxNMT1u0Zu6F7EEc9SHRNnS7/joaycARVFh5t2DyE49+GNR/n3eFri6c7U2EyEHgwhl
         H6Ig==
X-Received: by 10.202.221.4 with SMTP id u4mr2526533oig.104.1440429020947;
 Mon, 24 Aug 2015 08:10:20 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 08:09:51 -0700 (PDT)
In-Reply-To: <vpqzj1hkc5q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276451>

On Mon, Aug 24, 2015 at 1:30 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
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
> There's no --quote, there are --shell, --python, ... (well, actually, I
> would have prefered to have a single --quote=language option, but that's
> not how it is now).

That'd be easy to implement, but I didn't because `git tag -l` is
human readable and
I didn't see the necessity for having something like `--<quote_type>` here.

It'd be better to just use `git for-each-ref refs/tags/` for that.

>
> I had already commented on a preliminary version of this series
> off-list. I think all my previous comments have been taken into account.
>
> Thanks,
>

Thanks for the review :)


-- 
Regards,
Karthik Nayak
