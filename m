From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Wed, 23 Sep 2009 14:43:31 +1000
Message-ID: <d2e97e800909222143y2cb3b37bq7f6d018c06934ab8@mail.gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 
	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> 
	<d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com> 
	<4AB89B7F.3050902@gmail.com> <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 06:44:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqJiO-0002oV-KV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 06:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbZIWEns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 00:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbZIWEns
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 00:43:48 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:20484 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZIWEnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 00:43:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so386527and.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=n1bcl1aFToZ+sRR5pgpqI2ifOV1nbLYNiVqcISzDYf4=;
        b=hfrVTh610qZkAV3ezLU9pSliT1D7a3UkIDASzFNwrqpast8NOcD+2YR/CvRfmX3yhX
         wwBx4w5dODeeVaAG4uNGzbZn8IAKIU4bz9+A2KRvB4PmX5tfBDkO2ISyr5Pn7ts2Q8sA
         31RId8FyyQx5np2yn9RcZmo9P28FNYIrF4Snc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fbYbq8HHK6RQvF64xbc5PEzkVDYu0DGBDf9Y1i15y6U0SDzZRphXEn4h8Kl8zNH0dq
         mj6s2NFaeDc/mrqNvyg2k4k7I0SMtZWrRtSDZw1XLrmuQTR2SGZhXDP+C1GuYBMhhY02
         LFStRw4cAPyraiDq2eJQL8Mx9RFxuu1p6umAA=
Received: by 10.100.246.14 with SMTP id t14mr1941490anh.176.1253681031130; 
	Tue, 22 Sep 2009 21:43:51 -0700 (PDT)
In-Reply-To: <d2e97e800909220254sc677abeia220c19f6ef5bd28@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128967>

2009/9/22 Michael Wookey <michaelwookey@gmail.com>:
> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>>> On another note, I see *many* build warnings for things like
>>> "signed/unsigned compares". I'd be willing to work through these warnings
>>> and fix them. Thoughts?
>>
>> Well, first find out why these are a problem with MSVC and not GCC. Are the
>> types different on these platforms? signed vs unsigned should show up with
>> GCC as well. We need to make sure that we don't fix signed/unsigned issues
>> on one platform, just to introduce it to another platform.
>> In any case, it would be good for someone to have a look at these, just so
>> we can determine the cause for most of them, and then we should figure out
>> on the list how to deal with them.
>
> Well, at warning level 4, MSVC is quite verbose. Perhaps the current
> gcc build flags are more forgiving?

Ah, gcc does produces similar warnings when "-Wextra" is added to the CFLAGS:

  CFLAGS = -g -O2 -Wall -Wextra

IMHO, warnings such as these should be worked through and fixed, or
there may be some latent bug waiting to appear.
