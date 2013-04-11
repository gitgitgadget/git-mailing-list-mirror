From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 11:25:47 -0700
Message-ID: <20130411182547.GK27070@google.com>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMC5-0007mG-5K
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab3DKSZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:25:53 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:59302 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3DKSZw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:25:52 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so981464pdi.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OXdQBZPEsXUskCcv73s17h8SuSvTT15sbx3dABBcryk=;
        b=YXj4ePnKCYprLU765AV+bq4pAt9GwomtclFZjZXBnIRo07HoHjm9urOlnoZLPTRZuw
         rx1eVsg/P6Tw2re5g45Ag+ad1Fc+zSDSDteNscBRd28ruyG8wBqJZt9j2RnUQ5DeAgXG
         jUpZczta0KabKJkv7A/il88YFz8CRSyTfYMranBOvdLK6ElEc4j6hwcvOsr3N9RnbFEG
         9FevEgs/znF1U8B+2TjUqVOoY/C4man/nUrmUmRqA28mv/+c7gVDgOyEK7ODgExB9+4B
         Y5kFPaMwLnCijHgLEhLHgNS6cLXsvsTzfaa1QUP3pX+DAUoHDyfKhnfOUeBek7eMnyW2
         eq6w==
X-Received: by 10.66.11.133 with SMTP id q5mr11252207pab.150.1365704751587;
        Thu, 11 Apr 2013 11:25:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id dr6sm5931436pac.11.2013.04.11.11.25.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 11:25:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130411181439.GA2820@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220905>

Jeff King wrote:

> I could go either way. I think 96b9e0e is the right thing to do
> conceptually, but I kind of doubt it was affecting all that many people.
> And though it's _possible_ for it to be a security problem, I find it
> much more likely that the site admin tries to set some config, gets
> annoyed when it doesn't work, and debugs it. So from a practical
> perspective, 96b9e0e may be doing more harm than good, even though it's
> the right thing.

Ok.  By the way, another commit to blame is v1.7.12.1~2^2~4 (config:
warn on inaccessible files, 2012-08-21), which made it into a warnable
offense instead of just a strange but accepted configuration. ;-)

I'm still leaning toward keeping v1.7.12.1~2^2~4 and 96b9e0e as being
worth it, though I could be easily swayed in the other direction (for
example via a patch by an interested user with documentation that
explains how to debug and makes it unlikely for the behavior to keep
flipping in the future).  Thanks for spelling out the trade-offs.

Sincerely,
Jonathan
