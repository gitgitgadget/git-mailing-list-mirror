From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Wed, 02 Nov 2011 11:27:31 +0100
Message-ID: <4EB11B13.1060003@drmicha.warpmail.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com> <7vmxcfn23i.fsf@alter.siamese.dyndns.org> <loom.20111101T205618-231@post.gmane.org> <loom.20111101T211624-511@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 11:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLY2l-0004z8-Rs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 11:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab1KBK1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 06:27:35 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38177 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab1KBK1e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 06:27:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E25C720409;
	Wed,  2 Nov 2011 06:27:33 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 02 Nov 2011 06:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=IM4IzgGzZFqNEj9dOBYI9T
	zhgYM=; b=ZCPvEDBvt8NzR223kKcj0Zlxx2b3ARoyddS/vlmWYPfujklvAiFq9W
	IkNxseSaYhYvhRDgmSo58RDDdY5vyy65q/I/IOJMql274/Kt3+PqPkWUTpjqbQGq
	uNCYAno/OONpqVwbOUlvq/ACXs0IB0NyH16vAnn+76XvFogW9O+cU=
X-Sasl-enc: 9ipf7Cr5ytLsEwmtvO/lB/D8VKsdR9tVEtsh1yVsll3n 1320229653
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28E3F4833F7;
	Wed,  2 Nov 2011 06:27:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <loom.20111101T211624-511@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184625>

[Re-adding cc's]

Stefan Naewe venit, vidit, dixit 01.11.2011 21:18:
> Stefan Naewe <stefan.naewe <at> gmail.com> writes:
> 
>> Push with https works, if the URL looks e.g. like this:
>>
>>   https://github.com/user/repo.git
>>
>> rather than this
>>
>>   https://user <at> github.com/user/repo.git
>>
>> and having a ~/.netrc like this
>>
>>   machine github.com login user password YouDontWantToKnow
>>
>> If the URL contains 'user@' I get the 'need ENTER' behaviour.
>>
> 
> Another update:
> 
> If I revert deba493 the 'need ENTER' is gone and everything works as above.
> 
> 
> Stefan
> 
I can confirm that (and feel partly responsible given the history of of
deba493). For the record: A simple test looks like

SSH_ASKPASS='' git push -n bitbucket
Password for 'bitbucket.org':

which succeeds with a simple ENTER when you have the (log and) PW in
.netrc for that host, and your config says https://user@host.

The workaround is to remove 'user@' from the url in gitconfig, it is not
needed nor used, probably: I haven't checked yet, but that would mean we
can't have two different logins on the same server in .netrc. Can we?

I'll try to have a look later, too.

Michael
