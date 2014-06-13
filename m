From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/6] verify-commit: scriptable commit signature verification
Date: Fri, 13 Jun 2014 14:12:45 +0200
Message-ID: <539AEABD.3070906@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <48984553eb1d9ac53dd4b9604af568e22c735109.1402655839.git.git@drmicha.warpmail.net> <20140613111945.GC14066@sigill.intra.peff.net> <539AE476.4030205@drmicha.warpmail.net> <20140613115004.GF14066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQRQ-0000ky-7f
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaFMMSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 08:18:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38911 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751595AbaFMMSh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 08:18:37 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0200320BF3;
	Fri, 13 Jun 2014 08:18:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 13 Jun 2014 08:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=SFSP/gRvAxjOmfL2s6/qMN
	ZU7Gs=; b=KyXcvEqjUp8lDjoEUjqA4h0n5d8IFYh0mfg5mKu1L4hrmvqtDZdbcF
	gtajjOmIHJEPpLwfv3ZdPP7aMsGLEq4xIB3okCjn9Rzlc2LUN9euwAUFYmq3mXcN
	28Bt2HRSTi+2dlnUVqkpFyG3cghHRl+Xs4hz/VBpanxtzxkClOxmc=
X-Sasl-enc: ZMNLiSlK3u3CVTr3e/heDQMAQ6X0sNtxUxG4heGAWSSM 1402661915
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 518326800AC;
	Fri, 13 Jun 2014 08:18:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613115004.GF14066@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251555>

Jeff King venit, vidit, dixit 13.06.2014 13:50:
> On Fri, Jun 13, 2014 at 01:45:58PM +0200, Michael J Gruber wrote:
> 
>> I sneekily fix this in 6/6... I thought 3/6 is on next already, too late
>> for a real v2. Otherwise I would put 6/6 before everything else.
> 
> Ah, yeah, I assumed we were still re-rolling (and it looks like you're
> just on pu so far).

We are, I had misread a "What's cooking". So a reroll it is.

>> About the peeling I'm not so sure, since there's a difference between a
>> signed tag pointing to a commit and a signed commit.
> 
> There is, but "verify-commit" is always going to verify the commit, no?
> Not peeling will always result in an error, and never do anything
> useful.
> 
> I admit it's probably not going to come up too often, though. And I
> don't have any argument beyond "it makes sense to me", so I won't push
> for it further.
> 
> -Peff

I guess it boils down to the fact how plumberish it's supposed to be.
Since it's about verification, for some definition of "verify", I'd
rather apply as few automatisms as possible. If the caller wants to know
whether commit deadbeef carries a valid commit signature I'd rather
check that very object.

I also picture doing the "git-verify" thing in the future (with
"--commit" and "--tag" options which make the command insist on the
object type), and then we would not want to peel tags under the hood.

Michael
