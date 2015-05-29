From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Staging commits with visual diff tools?
Date: Fri, 29 May 2015 11:57:44 +0200
Message-ID: <55683818.5010002@drmicha.warpmail.net>
References: <alpine.DEB.2.10.1505262147230.3709@alice> <20150527072826.GC6898@peff.net> <alpine.DEB.2.10.1505270831490.4687@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: John Lee <jjl@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 29 11:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyH31-0002G8-H4
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 11:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbbE2J5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 05:57:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56261 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754259AbbE2J5q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 05:57:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A16920D13
	for <git@vger.kernel.org>; Fri, 29 May 2015 05:57:46 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 29 May 2015 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=g8aIU1wFy033EyMlKxhyaBYz1bA=; b=eM2aK6
	dzFKD7iLl6ZRsb8A/8qwJocLf+uHRO860p2hXMvlyf7HJ766JmMmfZ3K5J1h7gB7
	0rlpM7+ummxr7TSm2zgmehBAtcQxNNYTuvd1MF7bXvPLVqoRZeoFNj/WPi1m4zj6
	WvkIiL6Vgfwt0tDrajLue+nlHrVFk0NSyfv3o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=g8aIU1wFy033EyM
	lKxhyaBYz1bA=; b=bRzzuwdFVp69H9nEyCZJbCl2ne0O6YeJU5wMeFwfjNM1R1g
	zt5LmTcbki2hXf22QN2pZI5aY9fkLqe0ECmTP3B5scAiHPi4V49wB7xIpBnVazi5
	79V5YBrRUrQ1hLXqQ8gGetjdK05nehxJAuaMytXuk815WCiHRjIje5TaLJI8=
X-Sasl-enc: nnPcH/YqFKHpDEF4WoNooA0D4IGKB3xQTi76RhrDzMB/ 1432893466
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B10796800BF;
	Fri, 29 May 2015 05:57:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <alpine.DEB.2.10.1505270831490.4687@alice>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270219>

John Lee venit, vidit, dixit 27.05.2015 09:34:
> On Wed, 27 May 2015, Jeff King wrote:
> 
>> If you are interested in looking further, see how the %patch_mode hash
>> is defined in git-add--interactive.perl. Specifically, note that "add
>> -p" is just one case: diff against the index and apply with "apply
>> --cached". But once you have a separate tool for picking hunks, you
>> should be able to drop in the different DIFF/APPLY pairs to implement
>> "checkout -p", etc.
> 
> My plan was to use symlinks, checkout-index, and update-index 
> --index-info, similar to how difftool does it.  I verified on the command 
> line that that seems to work.
> 
> 
> John
> 

Yes, having "git addtool" (or "stagetool") to go with difftool and merge
tool would be nice, and it could hopefully resuse code or infrastructure
from those tools, as well as the tool config.

I vaguely remember a sketch or proof-of-concept by Jeff (not reusing
*tool) but may be wrong.

Michael
