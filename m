From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Mon, 29 Apr 2013 11:04:41 +0200
Message-ID: <517E37A9.8040609@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net> <043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net> <7vwqrtjmtx.fsf@alter.siamese.dyndns.org> <5177AE7F.1040400@drmicha.warpmail.net> <7vehdzesr9.fsf@alter.siamese.dyndns.org> <vpqwqrrolpl.fsf@grenoble-inp.fr> <7v38ufdaih.fsf@alter.siamese.dyndns.org> <517A6C0C.1020506@drmicha.warpmail.net> <vpqk3npctn8.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 29 11:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWk0o-0003xR-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 11:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3D2JEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 05:04:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46945 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700Ab3D2JEe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Apr 2013 05:04:34 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E5C8D206DB;
	Mon, 29 Apr 2013 05:04:33 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 29 Apr 2013 05:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=SBoiwyrm2oQ0X19PdtsI75
	6DRe4=; b=RiKVN12175YMpwxpPqCTVx8xCl4PFgSNwhTKrEs//QapgK5tlKCVW4
	ADZxDAwyR7L+O8W66pEHYzUW9sAb4tS/I7nNPneZ8y7QLqEyOyeaqcXkSHTNLubD
	S/5bkNOPMxL+Rd6MOhkOexnaXv/ay3lIDglL4LCMTOKaI3hI20QNU=
X-Sasl-enc: OJzC/bKQzBd7tNNThnAlB6ABLeejo6f+GRs3KBsy52vz 1367226273
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E33D0C80003;
	Mon, 29 Apr 2013 05:04:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <vpqk3npctn8.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222783>

Matthieu Moy venit, vidit, dixit 26.04.2013 15:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> BTW, textconv does not have to be slow - just use textconv-cache.
> 
> Right, thanks for reminding me about this, I had forgotten its existance ;-).
> 
>> I'm still looking for a way to at least treat "git grep" and "git show
>> blob" the same way.
> 
> I agree they should be treated similarly.
> 
>> - Implement the --textconv option but leave the default as is. I did
>> that for "git grep" already (just drop 7/7)
> 
> That seems sensible.
> 
>> but it seems to be cumbersome for "git show blob". I have to recheck.
> 
> It should be possible to have a tri-state for the --[no-]textconv
> option: unset, set to true or set to false. But the code sharing between
> log, show and diff might make that non-trivial.

Right now it's a diffopt bit...

Michael
