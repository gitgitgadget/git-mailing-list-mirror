From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 12:57:34 +0200
Message-ID: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:57:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCm2U-0003FU-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 12:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcFNK5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 06:57:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44153 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbcFNK5g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 06:57:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 942062216D;
	Tue, 14 Jun 2016 06:57:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 14 Jun 2016 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=sY2qOFLu7Ln49/rgn1ff+uu3/tE=; b=iSk8+S
	b8/QF3YNtuOqPfLlvhgnE+Yyq+wclN3KATjozCqN5rUPA6KKCnLSRS6FcSXRoTQm
	OP0YOIS9TJDlHtjPZSdDEpchv8xcdNd9XpXarkHYyM+AEHUzshgyzRdM+L43CMUe
	SgQy8VRnM8tQHrfAzcG7jeJZdcwmzf0T2BGXE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=sY2qOFLu7Ln49/r
	gn1ff+uu3/tE=; b=XRglc1ONDgtl2SMZx1szOEMSFO/EFPrYrZr9jToEYvV0Ff4
	wjWXEydVizKgfA6L/wuo8ltV179otxfEc+rb0oWReWHK234Kg+Z6IH3aSYtLpcnO
	KfkYQ4qbyd251Z5MegUa5tFCwKBWreA99m3UOYc3w1WiddMcIIZTfnFrTDts=
X-Sasl-enc: j2vLTiBpXBiaPLqAdhBythqBnDDM9Mkw4xkrtgiCMNkn 1465901855
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id EC43FF29FB;
	Tue, 14 Jun 2016 06:57:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160614094121.GA13971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297283>

Jeff King venit, vidit, dixit 14.06.2016 11:41:
> On Tue, Jun 14, 2016 at 04:39:38PM +0800, ZhenTian wrote:
> 
>> I want to set gpg -v to pgp.program, but if I set it, it can't call gpg:
>> ```
>> error: cannot run gpg -v: No such file or directory
>> error: could not run gpg.
>> fatal: failed to write commit object
>> ```
>>
>> I have tried set gpg.program value to `gpg|/tmp/log`, `/usr/bin/gpg
>> -v`, `gpg -v`, `"/usr/bin/gpg -v"`
>>
>> only after I set to `gpg` or `/usr/bin/gpg` without any argument, it will work.
> 
> Ah, right. Most of the time we run such programs as shell commands, but
> it looks like we do not. So you'd have to do something like:
> 
> 	cat >/tmp/fake-gpg <<-\EOF
> 	#!/bin/sh
> 	gpg -v "$@"
> 	EOF
> 	chmod +x /tmp/fake-gpg
> 	git config gpg.program /tmp/fake-gpg
> 
> -Peff
> 

The content of "gpg.program" is used as argv[0] when we build up various
commands to be run; we expect it to heed standard gpg options.

On the other hand:

git -c gpg.program=echo commit -S

'successfully' creates a commit that has

gpgsig -bsau Michael J Gruber <mickey@mouse.dis>

as the last header line. gpg.program=true fails (as does cat, unhappy
with the options), so apparently we do some error checking but not enough.

Michael
