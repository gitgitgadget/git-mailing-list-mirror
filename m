From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] branch: list branches by single remote
Date: Tue, 16 Aug 2011 15:37:33 +0200
Message-ID: <4E4A729D.9030906@drmicha.warpmail.net>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 15:37:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtJpt-0004HL-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 15:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1HPNhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 09:37:36 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33948 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343Ab1HPNhf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 09:37:35 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6138F21698;
	Tue, 16 Aug 2011 09:37:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 16 Aug 2011 09:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=UDVPGIbyO4R2ogVTqKkVBy
	B5V7U=; b=EcGlDCQlWeEVU2rOyyN3Z35mSPUWKerBXrHYEUo9y8smAQmHB7b8+V
	xnJ6LiA9dTOnUj/FJs61tOrviN2kq75ZLf4a7voF94Cmwauy3SlBF7vsGr6kTNwR
	NJmItd6oWLPh9eHmjzWaHfOeU1hhhmYeRWUdM7tzhjmZMKV3RdtWM=
X-Sasl-enc: bI3AqpZ+tny9ahvOcnFDG+JWaxjnwQyU+Z1V8RcdWANH 1313501855
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD59741E391;
	Tue, 16 Aug 2011 09:37:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <20110804040646.GA5104@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179447>

Jeff King venit, vidit, dixit 04.08.2011 06:06:
> On Tue, Aug 02, 2011 at 07:17:38PM +0200, Michael Schubert wrote:
> 
>> @@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>>  	if ((kind & ref_list->kinds) == 0)
>>  		return 0;
>>  
>> +	if (cb->remote && strncmp(cb->remote, refname, strlen(cb->remote)))
>> +		return 0;
>> +
> 
> This isn't right. You are assuming that a remote called "foo" will have
> all of its branches in refs/remotes/foo. That's true under the default
> configuration, but technically speaking, the remote tracking branches of
> "foo" are defined by the right-hand side of foo's fetch refspecs.

You are 100% right here, but...

> So I think you want something more like this:

...the op still might want to filter simply by the remote name.

Reminds me that I have to resurrect my patterns-with-branches series....

Michael
