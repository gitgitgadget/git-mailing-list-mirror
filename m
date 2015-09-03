From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Thu, 03 Sep 2015 10:13:47 -0700
Message-ID: <xmqq613rl92s.fsf@gitster.mtv.corp.google.com>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
	<87twspe6ix.fsf@marcos.anarc.at>
	<xmqqegjticd7.fsf@gitster.dls.corp.google.com>
	<55E7FEF3.2020400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@koumbit.org>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 03 19:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXY5C-00073m-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 19:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbbICRNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 13:13:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32874 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbICRNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 13:13:50 -0400
Received: by pacex6 with SMTP id ex6so47517807pac.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tVPhn3/I7Ngn32eK2yORW2CcOF2ltIHrMpvHc1e5CKs=;
        b=rrcn3DeTI6KIVidHC2xEl8b173k9/mLrEQfeXFEowyAFYMoMdoH6D224mQguZJ/ggr
         3QCXgejuRqSoe/2fjd5P9+vJK/sZlhtxEPuyhihGuBupYdeKQH2rBVRYXhbzh3hh7lPR
         pz1SCPUC1vg8rMc+SauILNVhUDaJFpvpl15iEzZswBrJv//8ToMM7XI4kHFdzv8CIoKt
         sigYU0ZSeojAzkoJPz3g56WzT6IpQhS7KJ+QutiX6YuxOhHhLNEoRDh7WbRHt/eBblmQ
         ZCx00uDxgwgZVSfAM1lwE3sXXFLmTRhYg63e24etAPzZd7MACXrnTF+IpxY5HmCGADT3
         xApg==
X-Received: by 10.66.186.141 with SMTP id fk13mr2237678pac.7.1441300429634;
        Thu, 03 Sep 2015 10:13:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id uh10sm23350106pab.41.2015.09.03.10.13.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 10:13:48 -0700 (PDT)
In-Reply-To: <55E7FEF3.2020400@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 3 Sep 2015 10:04:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277234>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Is the design of your independent implementation the same except
>> that 'o' is used instead of 'x'?  Independent implementation does
>> not make the same design magically better, if that is the case ;-)
>
> Interestingly, the patch to the tests lists * to o changes only, no < or
>> to o.

Well, in that case, then the opposite but an equivalent problem
exists in the design, no?  It promises to make roots stand out by
painting them as 'o', but it sometimes fails to do so.  In other
words, ...

> The reason is simply that the patch doesn't change anything for left nor
> right commits. I would say that is the best compromise since it does not
> change the overall layout, provides more information by default and does
> not override information that is requested specifically.

... it fails your last criteria.

> If we want to put more information into log --graph simultaneously we
> should really go beyond ASCII and look at how tig does it, e.g. using
> unicode characters.

That's another way to do so, but shifting columns to show where the
history is not connected also does not change the overall layout,
provides more information by default, etc., and a big plus is that
it would be an approach to do so without having to go beyond ASCII.
