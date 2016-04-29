From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] t9824: fix wrong reference value
Date: Fri, 29 Apr 2016 21:40:05 +0100
Message-ID: <CAE5ih7-AZCoJp2tO2KWRO4A9mWhdsNb_QTew93CmFCRh9kmATw@mail.gmail.com>
References: <0102015462bcd1c3-4196e36b-515b-447f-beca-649922456098-000000@eu-west-1.amazonses.com>
	<xmqqmvocz5d6.fsf@gitster.mtv.corp.google.com>
	<ACC53CBE-D83A-49E9-9DC7-C99F485D3E55@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:40:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFCx-0001MJ-G6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbcD2UkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:40:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35543 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbcD2UkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:40:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id w198so16774368oiw.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=173DcyWl9YXEjmPhjNL65TCq5tTV+8REhPeRk2dklic=;
        b=GtSkisGD3pVM+xswBE6zq1ERxI+OsDQsjx54OM3v3gNm1YRb5fnhwPfkMCSTqtlEn7
         ELeeF7Ez//2n04PgNSCcvLm5sZsaYeM1S9x/Tv2xdSblER3QClTmwz5KDnJxe7sLKOi1
         d4BEE0dmKtETdctysbcpdiJcL0BYC6usnuxNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=173DcyWl9YXEjmPhjNL65TCq5tTV+8REhPeRk2dklic=;
        b=hz2d0qUQFdcuhaIseyMpHuaU3UH3Dy0khHEDt4XfdppQdDhKRjLY/8r8eFWQDw487o
         +fgZUTxCGYbqPqs/0b6z3LGshEOeCP7o0AeFOH1ZpOBYqdkUUb9fd3DaZgMBhPqCHbQw
         pfVuAzjDVvaxx7rsvVjYA91B6P4OSTy0T7U9MQ2pRDcPc9HE2bjrXRhicex+1Rr3yYnD
         hxRWwWVZoXWzfqiIJFTU1r4JSVMCnj+TaeoJmI76BlAbp/vt9ML5JJYePXREyOb24GMK
         nTn1JfWzEVXoiUmsm8exj/htlFyte7HYfcAMr8ExxoTGR556Fed5ANV3cvVTk90UsDW0
         nTUg==
X-Gm-Message-State: AOPr4FUTJVNCIfRnSJSv6BE/R7+RX9/ps+uN5kK+rUXNkK9STt9Ps3EZmI94zkytL7VpwXQ0+g+Kap0B+OE9sg==
X-Received: by 10.202.207.205 with SMTP id f196mr9254415oig.142.1461962405789;
 Fri, 29 Apr 2016 13:40:05 -0700 (PDT)
Received: by 10.157.37.88 with HTTP; Fri, 29 Apr 2016 13:40:05 -0700 (PDT)
In-Reply-To: <ACC53CBE-D83A-49E9-9DC7-C99F485D3E55@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293051>

On 29 April 2016 at 21:29, Lars Schneider <larsxschneider@gmail.com> wrote:
>
> On 29 Apr 2016, at 19:34, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> 0492eb4 fixed a broken &&-chain in this test which broke the test as it
>>> checked for a wrong size. The expected size of the file under test is
>>> 39 bytes. The test checked that the size is 13 bytes. Fix the reference
>>> value to make the test pass, again.
>>>
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>
>> That breaking "fix" seems to have been acked by you.
>>
>> It was sort of clear that SZEDER didn't actually ran the test from
>> the patch, saying "As far as I can tell after eyeballing the test
>> script,", but you obviously didn't actually have a chance to test it
>> until now.
>>
>> Thanks for fixing it before it hits 'master'; this time I think it
>> is safe to assume that this was actually tested ;-)
>
> Yes! Lesson learned! Sorry Szeder!

How does the old saying go? If it hasn't been tested, it doesn't work!

Luke
