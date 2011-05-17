From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] config: define and document exit codes
Date: Tue, 17 May 2011 17:49:30 +0200
Message-ID: <4DD2990A.8070400@drmicha.warpmail.net>
References: <20110517140725.GA17193@sigill.intra.peff.net>	<6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net> <BANLkTikjY956f7LxXGY5fcLkJJDuMnt6OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 17:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMWh-00057A-GB
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab1EQPte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:49:34 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54426 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238Ab1EQPtd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 11:49:33 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 54A2920ABA;
	Tue, 17 May 2011 11:49:33 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 17 May 2011 11:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TgQ/65z+frMJkp3FSKxbNTqdR0Y=; b=IaTXfZHgkN5pFb6CxyThbIqB+wDHIxz+EWqkaaXpJfsxVl5IoJeITLXJgpiPvKLnLAu0daWUZ4MFjkejeuL5uM0Bz47QQUgl5uB7+OxTSlNRIFmD6WZENjCmavWmxx5mxusWSDrhjnFPVNLZp3kiYZYHftHUq/Ygf3y0+AYpSKg=
X-Sasl-enc: 2NGFT8j7yiOfWY0JZSNRZnUYYpz9NmZnXVjzty6LFkBS 1305647373
Received: from localhost.localdomain (p54858FA7.dip0.t-ipconnect.de [84.133.143.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 727744058EB;
	Tue, 17 May 2011 11:49:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTikjY956f7LxXGY5fcLkJJDuMnt6OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173809>

Thiago Farina venit, vidit, dixit 17.05.2011 17:46:
> On Tue, May 17, 2011 at 12:38 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> The return codes of git_config_set() and friends are magic numbers right
>> in the source. #define them in cache.h where the functions are declared,
> 
> Why defining them on cache.h? Just because the functions are declared
> there? Is this a good reason? I think this pollute even more the
> cache.h and these constants are not used outside of config.c. So I'd
> move them back onto config.c. Maybe it's fine as is though.

Because, potentially, they are used by callers of these external
functions. It's the interface declaration. And in fact, 2/2 creates such
a use.

Michael
