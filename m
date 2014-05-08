From: Jianyu Zhan <nasa4836@gmail.com>
Subject: Re: Is there any efficient way to track history of a piece of code?
Date: Thu, 8 May 2014 15:32:47 +0800
Message-ID: <CAHz2CGV6==abb0SrXOyqwumxEVLFnTtqe1Z4j2A7XcvJNuoAHw@mail.gmail.com>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
 <20140508070051.GA4532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 09:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIpg-0003Jc-BI
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 09:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbaEHHd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 03:33:28 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:47056 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaEHHd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 03:33:28 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so2169081igq.7
        for <git@vger.kernel.org>; Thu, 08 May 2014 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fpl/btR/kFlIuLt8ylPWWUeU49YJ/uPBculirZh6S8Y=;
        b=OBGrrOdBt3xobfw8MT6jpIPv0K+LKcOSqIoryfP9EjC2zdODlJo9z2eLjWBCNzCBq3
         gNP2xhl9jfroUSzw0ial3y1XHOgA3c/kS5UzRiHAa3BtDIhILmHgjvVTafA3ir3pz1Kf
         EkWMnVd7ZoMhYcEnfnDUzBkSo6mCGDd74QI6itvqO4Vh5fPiE/TYT5VqUN6rufA5i4Gt
         FRvv55UROxT1GYSfLD40b6xK4rsVbXf4zOK/hZHdLdzJ8QYlKHIRq0ielheNsa1DdNMt
         wTzrp0bJaeV386YSR2cROLSGuCIPMIRd4vsBkCuKG0I20rSghALIWtcHW01P7kEpbKnZ
         0j3Q==
X-Received: by 10.50.43.165 with SMTP id x5mr5246706igl.46.1399534407612; Thu,
 08 May 2014 00:33:27 -0700 (PDT)
Received: by 10.64.12.143 with HTTP; Thu, 8 May 2014 00:32:47 -0700 (PDT)
In-Reply-To: <20140508070051.GA4532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248412>

On Thu, May 8, 2014 at 3:00 PM, Jeff King <peff@peff.net> wrote:
> Try "tig blame"[1]; from the blame view, the "," command will restart
> the blame at REF^ automatically.  If you don't mind a more graphical
> interface, I think "git gui blame" can also reblame from the parent from
> the right-click context menu.

Thanks! It helps!

Hmm, but you know, we are cli people so we met git ;-)

My by-hand recursive digging history works for me and I've consider automate
this but failed since the pattern match to find the correct line of
code in each recursion
is a big problem.

The root cause of this problem maybe that git is not semantic-aware. It if is,
then we could easily weed out the trivial-change or grammatical-change
in git blame.

Here a structural program comparison tool may be a direction.
http://yinwang0.wordpress.com/2012/01/03/ydiff/

That being said, storing abstract syntax tree, instead of raw object in git.
But that goes too far...

Thanks,
Jianyu Zhan
