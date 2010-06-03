From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu, 03 Jun 2010 21:55:58 +0200
Message-ID: <4C0808CE.2000506@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <vpq1vco41go.fsf@bauges.imag.fr> <4C07C2E8.508@drmicha.warpmail.net> <20100603170724.GB22779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 21:56:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGWO-0005kL-F2
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 21:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab0FCT4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 15:56:01 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39991 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754943Ab0FCT4A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 15:56:00 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 02882F932A;
	Thu,  3 Jun 2010 15:55:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 15:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4o64d+c9LnlvSx4o8UPvbOpGIlU=; b=JFojhARY83s7M3Pr49kDXJJNo39dTCh8jGFjP62M3RaihBARQTcHp8QBxNALxGtRwiBx//XPb28STYdafxCaWHUXu9lzMAdYgXYiefiBy0F+vefdVJuZps2FvkeOGLpkYRW4FiZ9pTfvM/IPNFEVthvtKxPllUpxEu9fL+VdN2A=
X-Sasl-enc: u/s5Cch2c2MOaIhHjVYWV5H/ci0GCM3BNQYt3qNm0Vrr 1275594949
Received: from localhost.localdomain (p54859BA9.dip0.t-ipconnect.de [84.133.155.169])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B232C5180E;
	Thu,  3 Jun 2010 15:55:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100603170724.GB22779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148358>

Jeff King venit, vidit, dixit 03.06.2010 19:07:
> On Thu, Jun 03, 2010 at 04:57:44PM +0200, Michael J Gruber wrote:
> 
>> May I kindly direct you to the next parts you cut out, especially the
>> one talking about "described thorougly along with the
>> rationale in 3/4", and to the commit message of 3/4? :)
>>
>> I'm not breaking existing tests, of course, which also test
>> format-patch/apply cycles with symlinks.
> 
> Yes, but you are breaking "git diff | git apply", aren't you? It is

We don't have any tests for that then. I ran all tests with my patch.

> already broken with textconv, but that is a new feature that people opt
> into by using it. Symlink patches are a feature that has worked fine
> until now with the above command.
> 
> I don't think "but they should be using plumbing to generate patches"
> is the right answer, either. Yes, we expect the diff porcelain to behave
> differently depending on configuration, but with the exception of
> textconv, it always produces an actual applicable patch.

...which is why you need to use diff --no-textconv for scripting, which
is why I use that to decide about the symlink warnings!

One could introduce a separate config for that, of course, if you mind
unguarded diff|apply. But don't you think that those "No newline"
warnings are just plain stupid for symlinks?

Michael
