From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed, 1 May 2013 17:39:09 -0500
Message-ID: <CAMP44s2rQ1ZQJ2X6HJ6+SkFiA7ip5vh_-n=nNNNs+AFt2Dhbbw@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-4-git-send-email-artagnon@gmail.com>
	<CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
	<CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
	<CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
	<CALkWK0=Z81f4c1X3uXO4O5q_Dj2hRJjSY-i-aDtZ0KqSyo5Wtg@mail.gmail.com>
	<CAMP44s2sRsJR9xxty9F4c7-G3HQrK3N=-o7KBSpG5TYpdhu-9w@mail.gmail.com>
	<CALkWK0kJj2J6gg-M+CcLdaM1cXhnLGUWCYwUqc+XGdDDyhwo2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfgC-0006St-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab3EAWjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:39:12 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:46294 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3EAWjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:39:11 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so2462lab.17
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DkwszxKQDd2SWRmAmArLh3GlD1O7P8Vic23sG0JGAO4=;
        b=jS19V9dsI/6RCmPLUOx1+EeYwWB3lpy2Eclmqy3gyaSrI6K8uS0P7aso2MTDWt/Nkp
         6tD6Atj7E6QOyTD5hk698QxVQStRZvxgS2gXGZlHaxr8Rsmbf9mW9LcwP2lc6+RnpF+Y
         EIyh/wOI+bT6BgOFXGSHw8C+nm6AeLAGEII2ptdhXRNi5AEDGKC/5SomP5Q1rWa8jbby
         SDwJMAPbAXPEhSxv5mbMyRoo04DohnX6dXeHPrGOu54gx8UBEoo9ikokfOcDtCrDh28Q
         15GSv8U46LUvQXyrLBYs77Oo37XKyAyd1p3x/o5QKjoaW1diUsKKn9YrRJfz3EGRKyhb
         Um5g==
X-Received: by 10.112.135.70 with SMTP id pq6mr1813455lbb.82.1367447949312;
 Wed, 01 May 2013 15:39:09 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 15:39:09 -0700 (PDT)
In-Reply-To: <CALkWK0kJj2J6gg-M+CcLdaM1cXhnLGUWCYwUqc+XGdDDyhwo2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223160>

On Wed, May 1, 2013 at 5:26 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, May 1, 2013 at 2:40 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:

>>> There's no need to associate one comment with one line of code.
>>> People can see clearly see the failure case following it.
>>
>> Is that the way you defend your comments? People can see that the
>> comment is wrong?
>
> In that case, all the comments are wrong.  Even the ones about @{N}
> and @{-N}, because we never really check @{\d+} or @{-\d+}.  Would you
> like to make the comments more painful to read and write?

If what I see in the code and what I read in the comments tell me
conflicting stories, I'd say the comments are not fulfilling their
purpose. Either add comments that explain what the code is _actually_
doing, or don't bother with them at all.

Cheers.

-- 
Felipe Contreras
