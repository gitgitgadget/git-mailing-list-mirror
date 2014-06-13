From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] gpg-interface: provide access to the payload
Date: Fri, 13 Jun 2014 11:44:28 +0200
Message-ID: <539AC7FC.8040707@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net> <558044a975c940d19370394900bb44bf4fb2387d.1402063796.git.git@drmicha.warpmail.net> <20140613075550.GI7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvO2Q-0006Lr-CW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 11:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbaFMJom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 05:44:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53901 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbaFMJoa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 05:44:30 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 343FC20902;
	Fri, 13 Jun 2014 05:44:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 13 Jun 2014 05:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=lhLAdJUtQasD3p7o1jkIbn
	I709E=; b=V4vhYWnDEVZ4sHv0AjdpU3UIfI6u8OLvQt0srbKWh5uLbFtCJaIg4c
	V0A9hqHyft7xBMjGLYyPFkH0r5B4U77luiwkDA7TWDPKV0nSDpHU4NvDv3ew5XUE
	6K4X3f/dx7i3kRV5igOe5l0n8sQNCVCXzr2XPKbVFImoXcnt8rHNA=
X-Sasl-enc: XHtYS+cBJwSNsv0G+Hp3KoEgmJTuseejfsQ19IhSoSbC 1402652669
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 80A8C6800F2;
	Fri, 13 Jun 2014 05:44:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613075550.GI7908@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251535>

Jeff King venit, vidit, dixit 13.06.2014 09:55:
> On Fri, Jun 06, 2014 at 04:15:27PM +0200, Michael J Gruber wrote:
> 
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> [...]
>> +			free(signature_check.payload);
>>  			free(signature_check.gpg_output);
>>  			free(signature_check.gpg_status);
>>  			free(signature_check.signer);
>> [...]
>> diff --git a/pretty.c b/pretty.c
>> [...]
>> +	free(context.signature_check.payload);
>>  	free(context.signature_check.gpg_output);
>>  	free(context.signature_check.gpg_status);
>>  	free(context.signature_check.signer);
> 
> Perhaps this is a sign that we need a "signature_check_clear()" helper?

... or simply switch to language which has (or can overload) free for an
object :)

Do we have prior art for such helpers so that the new one would be
analogous?

Michael
