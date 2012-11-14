From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Notes in format-patch
Date: Wed, 14 Nov 2012 10:17:49 +0100
Message-ID: <50A361BD.2010806@drmicha.warpmail.net>
References: <50A0B896.8050700@drmicha.warpmail.net> <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net> <7vhaotfou6.fsf@alter.siamese.dyndns.org> <7vzk2le918.fsf@alter.siamese.dyndns.org> <7vr4nxe7nf.fsf@alter.siamese.dyndns.org> <7vfw4de5oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYZ6l-0007Hz-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 10:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766Ab2KNJRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 04:17:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55795 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753514Ab2KNJRv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 04:17:51 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 44B8620BF9;
	Wed, 14 Nov 2012 04:17:51 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Nov 2012 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qzsks/Zd3MI9yxByAHfk6Y
	PFMCI=; b=sX5ox8135PqOuWJF2so8k+0EBRW6m4O9U/ewIgPAclC6uCUOUYzIyH
	k3TM395MCYCXV9LHyok6nGpyAWDAoFRMF71r222ur4xhsRyJ4Pj9FVITDIw0A2sQ
	Y/7/R38gO8KftVWBJjhI/46SHUPUFDqA4SwxLpOED9v08kOTpSiBA=
X-Sasl-enc: G4W/6XSI81VPPo+T2vYX+qyR/GWPSJGTZCCS7PUITnSf 1352884671
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A7933482748;
	Wed, 14 Nov 2012 04:17:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <7vfw4de5oc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209706>

Junio C Hamano venit, vidit, dixit 13.11.2012 19:09:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> ... and it is broken X-<.
>>
>> The blank line should be added before the diffstat, not after the
>> notes message (t3307 shows a case where we give notes without
>> diffstat, and we shouldn't be adding an extra blank line in that
>> case.
> 
> Second try.
> 
> -- >8 --
> Subject: format-patch: add a blank line between notes and diffstat
> 
> The last line of the note text comes immediately before the diffstat
> block, making the latter unnecessarily harder to view.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  log-tree.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)

Thanks, that patch works. I'm curious, though, where the empty line
between the --- and your diffstat comes from. Do you have an empty note?
I'm not getting any (origin/next+your patch).

The fact that we don't usually have that empty line was the reason why I
preferred to have no empty line between the --- and the "Note:".

Michael
