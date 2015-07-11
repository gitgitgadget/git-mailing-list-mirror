From: Chris Jones <chris@christopherjones.us>
Subject: Re: [PATCH] git-filter-branch.sh: clarify an error message
Date: Fri, 10 Jul 2015 22:04:00 -0400
Message-ID: <1436580240.2553376.320852705.0F1D7187@webmail.messagingengine.com>
References: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
 <20150705130706.GA5435@peff.net>
 <aca69b93d8ab5f3c610d6201ed4334e1@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoV5-0001wi-5j
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbGKGm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:42:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50435 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859AbbGKGm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2015 02:42:58 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2015 02:42:58 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A0CC20B56
	for <git@vger.kernel.org>; Fri, 10 Jul 2015 22:04:00 -0400 (EDT)
Received: from web4 ([10.202.2.214])
  by compute4.internal (MEProxy); Fri, 10 Jul 2015 22:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	christopherjones.us; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=+mlohfWeAuKxofAs
	EC/NsJ+fP8k=; b=ADpwB/IMX5nbpzL6wLma2tOvUN+bPZ4XlOXfeNVJIWvUfTzd
	BrsMOA7gtGYyRSCYJPDPrDuvR9w+vP21plPOEwbOy/60L31U0MUwzEJyoCWNeuhD
	6Pp1/d8sRJt4zb1D+cS94q4w7FsBGiklmda4twIE2cjDLCC6MJgzdk1CyMg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+mlohfWeAuKxofA
	sEC/NsJ+fP8k=; b=VBZgd8j+tjXrJVzZeRpaadgmlgbIlKTyDH8rAvCGiyq6Sqb
	B8fMpsp2bGiVC2rQTxao15haeLHAcHQQ3t0oHgUyzsom5bluoGOPTxgQIjU6joRP
	rfesKvvG9FRBbbp7HIccHGfGf4rc9dq51PxdhULFTBrH9CYT9C6lyjeuI0Rg=
Received: by web4.nyi.internal (Postfix, from userid 99)
	id 6867410896B; Fri, 10 Jul 2015 22:04:00 -0400 (EDT)
X-Sasl-Enc: PuXsbxw0H6SeN9Bk0E29M2/9QNtP6DUVV1VxPIb0qXmR 1436580240
X-Mailer: MessagingEngine.com Webmail Interface - ajax-bfc056ae
In-Reply-To: <aca69b93d8ab5f3c610d6201ed4334e1@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273846>

How does "You did not provide a valid range of commits.  
At least one tip in your range must be a ref." sound?

-- 
Chris
http://christopherjones.us/

On Sun, Jul 5, 2015, at 10:41 AM, Johannes Schindelin wrote:
> Hi,
> 
> On 2015-07-05 15:07, Jeff King wrote:
> > On Sat, Jul 04, 2015 at 07:39:04PM -0400, Chris Jones wrote:
> > 
> >> Make git filter-branch output a useful error message when a single
> >> commit is given instead of a range.  Currently, when given a command
> >> like git filter-branch --msg-filter 'echo "TEST"' -- abc123, it will
> >> give the message "Which ref do you want to rewrite?".  Instead, what
> >> is needed is a range of commits to rewrite.  This makes it give an
> >> error message that says "You didn't provide a valid range of
> >> commits".
> > 
> > Yeah, I agree the current message is a little confusing, and I think
> > your message is an improvement. I wonder if we can even go a step
> > further, like mentioning that at least one of the positive tips in your
> > range must be a ref.
> 
> I agree, and would even further suggest to use the "did not" form instead
> of the abbreviated "didn't" one.
> 
> Thanks,
> Dscho
