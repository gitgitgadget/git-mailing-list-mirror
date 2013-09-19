From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 11:47:51 +0200
Message-ID: <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<20130911191620.GB24251@sigill.intra.peff.net>
	<CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
	<CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 11:47:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMaq6-0003K0-1X
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 11:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3ISJry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 05:47:54 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:45423 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3ISJrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 05:47:53 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so4073969eek.3
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fcihXnvktHWriXhh1io2NB7ObFnoJK0neaGVGQJZMl8=;
        b=uOvrIA5NLWRPXH5HjVkqZ8NEogM+YBC9QTQQOtdhWC/QuU2wt4McoqTYUuazY1NuYu
         HcPUhwOL8Jocu59JEiTHTRSlWqsBcJf6xAl6/xVCJjNGDc9qVuXavLAuRxqYc2Tdz9Nk
         Kcm++NJqrOJPYyeVRACDqDizjWpFw17tAPttyjNDRDNepXAIJjnhrXlCOQMQ/kwkZ+ny
         aHvHCVwrFTF2IbCwW0q+ePsdLZ50iGazTMapu7UaAl6az1AmdoMpHxya0DJAbii45aoT
         tNU/fz93Uv9w6dD5J3aAPXMo/nryOMPCh5GK7zuu+pCt00vCwBvyf9ttNzasTDGM/rBs
         HH8Q==
X-Received: by 10.14.42.3 with SMTP id i3mr919751eeb.95.1379584071991; Thu, 19
 Sep 2013 02:47:51 -0700 (PDT)
Received: by 10.223.193.4 with HTTP; Thu, 19 Sep 2013 02:47:51 -0700 (PDT)
In-Reply-To: <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235010>

On Thu, Sep 19, 2013 at 9:37 AM, Junio C Hamano <junio@pobox.com> wrote:
> On Sep 18, 2013 11:08 PM, "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>
> wrote:
>>
>> On Wed, Sep 11, 2013 at 9:16 PM, Jeff King <peff@peff.net> wrote:
>> > I would prefer the static wrapper solution you suggest, though. It
[...]
>> > it still ends up as a single function call). The downside is that it has
>> > to be remembered at each site that uses strcasecmp, but we do not use
>> > pointers to standard library functions very often.
>>
>> Is it possible to add a test which fails if wrapper is not used?
>
> No test needed for this, as compilation or linkage will fail, I think.

But only when someone compiles on MinGW, no?

-- 
Piotr Krukowiecki
