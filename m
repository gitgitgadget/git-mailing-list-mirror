From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 13:05:33 -0500
Message-ID: <20111020180533.GA5563@elie.hsd1.il.comcast.net>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
 <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net>
 <4E9FE061.3080601@gmail.com>
 <20111020090912.GA21471@elie.hsd1.il.comcast.net>
 <7vmxcva8k1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 20:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGwzz-0006zi-IE
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1JTSFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 14:05:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58190 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1JTSFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 14:05:42 -0400
Received: by iaek3 with SMTP id k3so3705036iae.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jQQnfJvycXtC6/fu4YDuGHIjOyzffdHn8qpTXOCjMEU=;
        b=dw0EZtHLxt0kdH11gTdpb+2EFjydHsoAwsL5k2edzMDZWREPeo2T3RYwp74xi2VMEE
         buxJ9Iq1c4xS+YXwZblf5Q9ejLQssLv/DFyMBfM+S5jOfAlpvmIqfhGk8ICPmIY0VlqS
         el/cD+rDHd5h2CWjudX/1AihMy/GrVQ8kst4E=
Received: by 10.231.27.203 with SMTP id j11mr4707477ibc.10.1319133941966;
        Thu, 20 Oct 2011 11:05:41 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n30sm25517812ibl.4.2011.10.20.11.05.40
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 11:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxcva8k1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184032>

Junio C Hamano wrote:

[...]
> Then the additional test can become part of the patch that corrects the
> parsing logic, no?

Yes, that works, too.  All I was trying to say was that the
description in the patch I quoted didn't make sense to me, since it
included a mention of a buffer overflow without giving any explanation
of what it was talking about.  I don't actually care in this case
whether it is fixed by mentioning which patch this is testing the fix
from or by squashing the two patches (though the latter certainly
seems reasonable).

Incidentally, Ram might wonder why I fuss so much about commit
messages.  It's actually very simple --- I think of them as part of
the code.  Suppose someone discovers a regression was introduced by
such-and-such part of the patch 1.7.7 -> 1.7.8, but at first glance it
is not clear whether that code change was supposed to have any effect
on the behavior of the code at all.  Such a person is likely to make
mistakes in fixing it, right?  So after getting the right behavior,
patch authors spend a few extra minutes to make sure the code is
intuitive to humans, too, and this includes making sure the rationale
description is clear.

Just like the code for the computer, this is very much something that
isn't always going to be right the first time and sometimes takes some
debugging.  So, sorry for the fuss, but I hope it helps.

Jonathan
