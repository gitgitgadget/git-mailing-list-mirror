From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 11:43:16 +0100
Message-ID: <4D5E4D44.6000203@drmicha.warpmail.net>
References: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net> <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net> <20110218104151.GB7262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 11:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNr8-0000xH-NT
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1BRKq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:46:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37189 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1BRKq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 05:46:28 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C5C3F20389;
	Fri, 18 Feb 2011 05:46:27 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 18 Feb 2011 05:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=43YrEM0JXCNR6nhzTri3UQT5ANY=; b=cNa71lTvQE7uQbytgBJopW3t0B99I0kTj5Woz24puFgSYrGxXlf0GFP+XlbtHgjFR/SL51vWSO968Eacf6FAH0LfO3StrOT8aFwW8VMG1229yuubArWlXW6+hSwubmPcWPrpRXDMwbRIEj/rVrPewx5I+F8KGnx0pVymMCFX7i0=
X-Sasl-enc: PcXbGopumGh/2ErTPxIy4a/o2U2ByIpZulNk8MfXrpxI 1298025987
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DB8BC40A6F3;
	Fri, 18 Feb 2011 05:46:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110218104151.GB7262@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167196>

Jeff King venit, vidit, dixit 18.02.2011 11:41:
> On Fri, Feb 18, 2011 at 11:12:42AM +0100, Michael J Gruber wrote:
> 
>> Currently, patch-id trips over the diff extension for marking
>> the absence of newline at EOF.
>>
>> Fix it. (Ignore it, it's whitespace.)
>>
>> This uses the same detection rationale as in buitlin/apply.c, which was
>> introduced in
>>
>> 433ef8a ([PATCH] Make git-apply understand incomplete lines in non-C locales, 2005-09-04)
> 
> Thanks, this looks good to me, with one style nit:
> 
>> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
>> +			continue;
> 
> Whitespace around relational operators.

You think

+		else if (!memcmp(line, "\\ ", 2)&&strlen(line)>=12)

is that much better?

Nitpickers need to brace for smartass responses ;)

Junio, should I resend with two extra spaces?

Michael
