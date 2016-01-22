From: Andrew Stewart <boss@airbladesoftware.com>
Subject: Re: git-diff: unable to turn off diff.autorefreshindex with command line switch
Date: Fri, 22 Jan 2016 14:12:15 +0000
Message-ID: <5BAA7C36-0059-4F0B-96B6-7B6E66D7C315@airbladesoftware.com>
References: <4432B7DA-921D-4D1C-8DC5-55A4E3722F73@airbladesoftware.com> <20160121213801.GB6664@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 15:12:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMcRr-0003NG-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 15:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbcAVOMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 09:12:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47492 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753540AbcAVOMR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 09:12:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C512F2067A
	for <git@vger.kernel.org>; Fri, 22 Jan 2016 09:12:16 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 22 Jan 2016 09:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	airbladesoftware.com; h=cc:content-transfer-encoding
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=s5kSh
	RHWvjQ5Nodc1CzgFAaqe+E=; b=DP9z4FaVA+VTku894YCe4dYav8BxvH7FTykxy
	JLrLJTmnSFYiNACDMCHnQw4Vb9skiT/HIcduNRKGoMKc4dxVPJ8iT8TO/88a9FHg
	0WUmT1RCvuPuwXojq7Tk2HkPj0aXg76KXr8KfxC5MxIF82YyU/8uyzHWDA/yFuhO
	vSqrEs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=s5kShRHWvjQ5Nod
	c1CzgFAaqe+E=; b=pFHw9MJjU9U5cRxreyOdTyBTVeQ7Ldsl0P2MzRLOfEJiN0q
	dtGVszbcJ/c9O46X0RG6OnefuGF6Jt3+rnieRvKYeCFPHQBaTGIvOMY6NtjSutbb
	2NuS+KunnNSaM2C7URIsqkHWp1nqke27msqfC4pWVzpayT44EYP36NvRK45M=
X-Sasl-enc: vjiS8TVxDF8YMB4dJ8yec6wcg//qulxPr0F1kBfoALw6 1453471936
Received: from andrews-mbp.home (host81-153-212-242.range81-153.btcentralplus.com [81.153.212.242])
	by mail.messagingengine.com (Postfix) with ESMTPA id 39C8AC01713;
	Fri, 22 Jan 2016 09:12:16 -0500 (EST)
In-Reply-To: <20160121213801.GB6664@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284556>

> On 21 Jan 2016, at 9:38 pm, Jeff King <peff@peff.net> wrote:
> But note that your whole test is going to be racy, and possibly depend
> on the resolution of your filesystem's timestamps. Did you run your test
> as a single script, where the initial index write and the `touch` may
> happen in the same second? If so, trying running it slowly by hand,
> or inserting "sleep 1" between the commands.

I ran my tests by hand, taking more than 1s between commands.

I also used `stat README` and `ls -l README` on occasion to confirm that `touch` was updating the file's timestamps.

-- Andrew Stewart