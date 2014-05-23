From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Fri, 23 May 2014 15:34:01 -0700
Message-ID: <6057662E-B230-40FB-AB98-3E94BA70C7C1@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521102742.GB30464@sigill.intra.peff.net> <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com> <20140522055852.GA16587@sigill.intra.peff.net> <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com> <20140522184113.GC1167@sigill.intra.peff.net> <0E298290-243D-46E5-A177-C6D3553D7153@gmail.com> <20140523200534.GD19088@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 24 00:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wny2T-0007Ls-KG
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaEWWeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:34:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46545 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaEWWeE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:34:04 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so4672051pad.16
        for <git@vger.kernel.org>; Fri, 23 May 2014 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=moau5JH9agZsWp9/9mjdIaKZeWoYWI4InUroVG7d0tk=;
        b=vDZUXXUgPcAKzNSPVEYKfV7VW/T1qW0e1M1sDdclgVsiYKyjH1qBhwPE9kp3TB54sx
         GqY3ITIpo9MoIBXi/68U2oqFa1G1uqjp7NmF3kdby3vytyTYOnpZ+EM033MviA1mWSYC
         7M1L5h1HLe7mriSmPIFQ3vqWmIQYqaoTc3k1Lp8uuGfLXhEfRelQiBZEGSUgWD3Egeg/
         gT+LtZ0k/2IhRymeFjC2a57eaAV2x92uhTU1BOsZpO0NzbEeHMb9t0JjxR5FQfH9Zcy/
         i8A5z3D3sCBzcZO5o+HWyK/fGFItKVtZtL7oq/WIqpWlFnz/cNBd46pK+Kld4Chsw+OS
         5WEA==
X-Received: by 10.68.129.99 with SMTP id nv3mr9512631pbb.128.1400884443670;
        Fri, 23 May 2014 15:34:03 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id gd7sm4566105pac.34.2014.05.23.15.34.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 15:34:02 -0700 (PDT)
In-Reply-To: <20140523200534.GD19088@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250041>

On May 23, 2014, at 13:05, Jeff King wrote:
> On Thu, May 22, 2014 at 03:52:08PM -0700, Kyle J. McKay wrote:
>
>>> Christian brought this up elsewhere, and I agree it's probably  
>>> better to
>>> work over the whole buffer, NULs included. I'm happy to re-roll  
>>> (or you
>>> can just pick up the version of the patch in this thread),
>>
>> The only reason I brought up the code difference in the first place  
>> was that
>> the comment was "This makes config's lowercase() function public"  
>> which made
>> me expect to see basically the equivalent of replacing a "static"  
>> with an
>> "extern", but actually the function being made public was a different
>> implementation than config's lowercase() function.
>
> Yeah, sorry if it sounded like I was complaining about your review
> elsewhere. I mostly found it amusing that I got two opposite-direction
> reviews.

I didn't seem like complaining to me.  I also was amused.  :)

> I agree that clarifying the situation in the commit message is best,  
> and
> I've done that in the version I just posted.

It looks great.  And I suspect you're correct that a modern compiler  
would optimize the index-based version to be as efficient as the  
pointer arithmetic version.

--Kyle
