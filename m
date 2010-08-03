From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 03 Aug 2010 15:24:17 +0200
Message-ID: <4C581881.9060202@drmicha.warpmail.net>
References: <i372v0$3np$1@dough.gmane.org> <201008031202.53804.jnareb@gmail.com> <20100803124831.GB11608@coredump.intra.peff.net> <201008031519.11012.jnareb@gmail.com> <20100803132026.GA14883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHTY-0006S8-Se
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0HCNYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:24:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58491 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752192Ab0HCNYG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 09:24:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0E6C41A2ECA;
	Tue,  3 Aug 2010 09:24:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 Aug 2010 09:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=uU0SYiEZLRMYvWnfSJM0CMf/vsA=; b=T/sDJpaO3wndk/EQJtLUSeCWQMkyov0g6j9cIS0nq6oQ9FOLltJzBc/S+0/VrJlR9MoWUf2+PLwXT8Dl4Is8BELD9x+ibmycCcCfOCA2zXvQM7ZWFRj5Qw6AT5PJAH4rh31cdSgJWSWig6zXPR0x9kKnDdbFm8pC6mns8Dv75do=
X-Sasl-enc: WJKr6FWvA9P/jaF8iLH7xg0Li+uxuZHba7dqi/NjIM/C 1280841845
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F26485B575;
	Tue,  3 Aug 2010 09:24:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <20100803132026.GA14883@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152517>

Jeff King venit, vidit, dixit 03.08.2010 15:20:
> On Tue, Aug 03, 2010 at 03:19:09PM +0200, Jakub Narebski wrote:
> 
>>> I am not sure there isn't some unportability at the lowest level. We
>>> freely interchange between time_t and unsigned long in the low-level
>>> date code. It probably happens to work because casting the bits back and
>>> forth between signed and unsigned types generally works, as long as you
>>> end up with the type that you want. But it isn't necessarily portable,
>>> and there can be subtle bugs. See, for example, my recent 9ba0f033.
>>
>> Well, at least there is not a problem at lowest of low, i.e. repository
>> format level, thanks to the use of textual representation for epoch.
> 
> Yes, the good news that this is purely a code problem. The data format
> is fine. It would just take somebody going through the code and
> switching all "unsigned long" to "long long" (or time_t, or even
> "gittime_t" if we want to abstract it).

...and fixing the parser algorithm at least in tm_to_time_t()...

Michael
