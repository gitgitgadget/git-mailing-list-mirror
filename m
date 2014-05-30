From: Rodrigo Fernandes <rtfrodrigo@gmail.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Fri, 30 May 2014 09:08:57 +0100
Message-ID: <CACJZPBtJZ+gDvtHnRwi8JOO7rFAg=pPBvEQ=-FwKnp9Gr+FStw@mail.gmail.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net> <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
 <20140529194932.GA16665@sigill.intra.peff.net> <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 10:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqHss-0005Mj-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 10:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbaE3IJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 04:09:42 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:58877 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbaE3IJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 04:09:38 -0400
Received: by mail-yh0-f48.google.com with SMTP id a41so1271740yho.7
        for <git@vger.kernel.org>; Fri, 30 May 2014 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QsbJ9XLtY53W6QXBNy/ZF8TFGAOg0lumzyEIVpWGhA8=;
        b=jBX0lLZld9oa5pxK1FycIfD1mkvgm3BS+7MvGo+sXdRoGApplEvA3qmRPB41kdq3fC
         n65Qm0NY5CNbKtIN+iKXCAOxwWGcZMIVzqDvtDCdwEKkH7qUY1IDOaqQf+TyDQ3Ro72A
         BEW76kJ3UxnFvCjur5z3UZpUbqKUtLizaPAD7PxTkNKG3G1whDNvCYeRojNBhly3Vqq7
         Xi3S/w+2OIzY04TFuZYa+nSPWEg5b9KkcexYRWPihx/OCfCDf/5WOZ6+KBT2/o5TXOGi
         SYOL9XYtSMMpiKMjb5xVR07dQz573ltLDzJ731tqCGFNKd/yLheXF8dhBZdsDBSh88VP
         0Q2A==
X-Received: by 10.236.229.133 with SMTP id h5mr19079641yhq.64.1401437377304;
 Fri, 30 May 2014 01:09:37 -0700 (PDT)
Received: by 10.170.51.136 with HTTP; Fri, 30 May 2014 01:08:57 -0700 (PDT)
In-Reply-To: <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250435>

Jeff,
Do you have any idea how does github understand that is a bug and
fixes it automatically?
(I'm saying this because on Github the date is correct).
Cumprimentos,
Rodrigo Fernandes


On Thu, May 29, 2014 at 8:57 PM, Rodrigo Fernandes <rtfrodrigo@gmail.com> wrote:
> Jeff,
> I have no idea what was the tool. The repo is not mine. I found the
> problem when I was doing some tests and the commit parsing was failing
> on that repo.
>
> Cumprimentos,
> Rodrigo Fernandes
>
>
> On Thu, May 29, 2014 at 8:49 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, May 29, 2014 at 11:57:15AM -0700, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>> > ...
>>> > to at least make --format date output consistent with the rest of git
>>> > (and to make "%at" consistent with "%ad" and --date=raw). That still
>>> > doesn't address Rodrigo's concern, though (we would print "0 +0000").
>>> [...]
>>>
>>> I actually am not very much interested in deciding what to show for
>>> a broken timestamp.  An empty string is just as good as any random
>>> cruft.
>>
>> I was thinking specifically of the first part I quoted above. We are not
>> consistent between various methods of parsing/printing the date. That
>> may fall into the "if were doing it from scratch..." category, though;
>> it's possible that people currently using "--format=%ad" prefer and
>> expect the empty string to denote a bogus value. I'm OK with leaving it.
>>
>>> I agree with you that it would be nice to have one escape
>>> hatch to let the users see what garbage is recorded, if only for
>>> diagnostic purposes, and DATE_RAW may be one good way to do so (but
>>> I'd rather recommend "cat-file commit" for real diagnostics).
>>
>> Yeah, in case I wasn't clear, I don't actually like DATE_RAW as a way to
>> do that. I'd prefer "--pretty=raw" or "cat-file commit", which already
>> work.
>>
>>> I would be more interested to see whatever broken tool that created
>>> such a commit gets fixed.  Do we know where it came from?
>>
>> I don't think it has been said yet in the thread. Rodrigo?
>>
>> -Peff
