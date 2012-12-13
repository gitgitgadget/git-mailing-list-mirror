From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 20:55:59 -0500
Message-ID: <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
	<CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
	<7vvcc73yzh.fsf@alter.siamese.dyndns.org>
	<CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
	<7vpq2f2az4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 02:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiy28-0003xA-77
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 02:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab2LMB4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 20:56:01 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:61923 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab2LMB4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 20:56:00 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1284603lag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 17:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aA1kDvRDJ36bt+MfbUMNQpcJA3tKoTON1gAfBF2CACk=;
        b=mClgGrVsxXqmAllEKfWjf2TdF7wlrwahfGJSyt5e+2RI+SoznGrNG0ill0MaXe6VuL
         HKkAJVTGHUKN15avh7xvejLWriVHpFwwPdnI91mcSicgFKhjTESR2CpRHhl4fHtqXd/3
         x6omnFcG7UrP8ImZsU0AXfPV49IffV9TPYqasEUa27KLBmXH7WtgZIDqLWJoYrgB5oKp
         WOWlD2ISIFJHcPqCrpvHcA+2+MUsqC+mRCD1lJIX0u6f2toIY4SpuxAIn96NnslawuOR
         9QFExa4fLWoZ1HQSXXmkimpiOej6aY9rOt8ODUgP4qOvyIzYr78JqDlU1CyKhS40Y7I1
         gCtQ==
Received: by 10.152.111.161 with SMTP id ij1mr152381lab.28.1355363759336; Wed,
 12 Dec 2012 17:55:59 -0800 (PST)
Received: by 10.112.29.195 with HTTP; Wed, 12 Dec 2012 17:55:59 -0800 (PST)
In-Reply-To: <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211432>

>> Is there a reason why picking among the choices in a sliding window
>> must be contents neutral?
>
> Sorry, you might be getting at something interesting but I do not
> understand the question.  I have no idea what you mean by "contents
> neutral".

I was merely asking if an algorithm to pick between the
2+ choices was allowed to look at the contents of the
lines.

I.e., an algorithm would look at the C comment
example and determine that the choice starting containing
a full inserted comment is preferable over the one that
appears to close one comment and open a new.

And the in inserted-function case it would prefer the one
where the matching { and } are in correct order.

Morten
