From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 01/14] advice: Introduce error_resolve_conflict
Date: Wed, 6 Jul 2011 14:58:42 +0530
Message-ID: <CALkWK0k57L5vc7oVQKw=G9FXtYkmnp8QaWrW_p1CvupyNGofZg@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-2-git-send-email-artagnon@gmail.com> <20110706083512.GA15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOPt-00031z-R4
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab1GFJ3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 05:29:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34849 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab1GFJ3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 05:29:04 -0400
Received: by wwe5 with SMTP id 5so6751583wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yD4XG5tEjbWXrkVcfVBvyR9K9scKzfAI8VZOyyZFqgA=;
        b=uhfOzI575a2YujQ4krMs1cHqXZxW5ITwnRppKBL48NRzxbRfpg+s1XniO0Rfe8z2hI
         HqWqFNUN7TNXxIOh9QnVqCMLd+2PcTv7CGBrR12H9iYC99fhbdQJ9gfGDpzwmGV2WolA
         D1e5tTPa9R1LZxCQMSm0RMpzcY6H2a+KGy7Jk=
Received: by 10.216.60.72 with SMTP id t50mr1781560wec.92.1309944542161; Wed,
 06 Jul 2011 02:29:02 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 02:28:42 -0700 (PDT)
In-Reply-To: <20110706083512.GA15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176670>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -19,6 +19,15 @@ static struct {
>> =C2=A0 =C2=A0 =C2=A0 { "detachedhead", &advice_detached_head },
>> =C2=A0};
>>
>> +static void advise(const char *advice, ...)
>> +{
>> + =C2=A0 =C2=A0 va_list params;
>> +
>> + =C2=A0 =C2=A0 va_start(params, advice);
>> + =C2=A0 =C2=A0 vreportf("hint: ", advice, params);
>> + =C2=A0 =C2=A0 va_end(params);
>> +}
>
> Rather than copy+pasting this code verbatim, wouldn't it make sense t=
o
> move it and expose it through advice.h so the old call site can use
> the same code?

Yes, but I was worried that I shouldn't expose it because your commit
message (2a41df) says:

    It is local to revert.c for now because I am not sure this is
    the right API (we may want to take an array of advice lines or a
    boolean argument for easy suppression of unwanted advice).

So, is it still alright to expose it in advice.h?

> For what it's worth, with that change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-- Ram
