From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Tue, 18 Sep 2012 06:22:01 +0200
Message-ID: <CA+EOSBmapjFxKkfPVAxg8q=J9gkiz8Hg0B4=pxfRi0RGQ_kEwA@mail.gmail.com>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
	<7v392k5w7u.fsf@alter.siamese.dyndns.org>
	<7vligc19d1.fsf@alter.siamese.dyndns.org>
	<CA+EOSBk0hN+v+PK8jzCCZgG0Ko7SsHOSB=cM7nnaSsrUOaJ-7Q@mail.gmail.com>
	<7vzk4otmwb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 06:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDpK8-0001jB-6W
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 06:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab2IREWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 00:22:03 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57667 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2IREWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 00:22:02 -0400
Received: by ieak13 with SMTP id k13so1655764iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=mxXOwKa/Yt9GYaoNRUE795D3QQVlbAPOgGcm/IuwZyg=;
        b=Ajy1OoCUHiC/UjveXrIlew6BI3Pu1gj1wU6bkrVXnJ3f5s8o85DINapPQmnn+O42Jn
         LLoNI5EL/U58TquAZsst7qx3K2VsJCXoPP56tRRP86ZRzGhSLNha5I3QRnyRZjOygPGt
         8H0d+Lby9JmNeuTdOhdS9BAy51RKbkmh/lco+u2TFpcOHHfWRr8xDqSg/DAZtXokLEsD
         j4dh7qGGsAaAdORhczZVrFLSnju0ZL1q879L+iNnQ3IFP1tGJ59sEk5DQT6Ff2kaSlYT
         IFM5CLSPJ51xGOgORgFKk8EABQ9FFbe0KTlDaIlolumWhGL2kwU/wJyvqttps8hAQPku
         Je1g==
Received: by 10.50.236.100 with SMTP id ut4mr9023632igc.34.1347942121067; Mon,
 17 Sep 2012 21:22:01 -0700 (PDT)
Received: by 10.64.82.194 with HTTP; Mon, 17 Sep 2012 21:22:01 -0700 (PDT)
In-Reply-To: <7vzk4otmwb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205788>

Ok.

Please use the patch that you have already queued in the ep integration branch.

Thank you

2012/9/17, Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>>>  - That "165" thing I mentioned earlier.
>>
>> Thank you so much for the comments, that's fine. A single
>> consideration for  MALLOC_PERTURB.
>>
>> You can use any value between 1..255 for MALLOC_PERTURB_
>> That chooses the byte that glibc will use to memset all freed buffers.
>> In general it is defined as
>>
>>     export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))
>>
>> (as drepper pointed out http://udrepper.livejournal.com/11429.html)
>
> Drepper never recommends RANDOM there.
>
>> Using a random value is slightly better than using a fixed one
>> in case your fixed value is someday just the right/wrong value to mask
>> a problem.
>
> Quite the contrary.  When you use a fixed pattern, it is easy which
> other pieces of memory has uninitailized contents.  When you use a
> random value, you sometimes get an error and sometimes the test
> mysteriously pass, which does not help debugging.
>
> openSUSE folks seem to use a fixed value for this exact reason of
> repeatability of tests.
>
> http://jaegerandi.blogspot.com/2012/01/finding-subtile-malloc-bugs.html
>
>> So OK per the original expression?
>
> No.
>
> I am not convinced 165 is the perfect value, but I am fairly certain
> any fixed value is better than using a random to deliberately worsen
> repeatability of the tests.
>

-- 
Inviato dal mio dispositivo mobile
