From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to pull remote branch with specified commit id?
Date: Wed, 14 Jan 2009 08:01:24 +0100
Message-ID: <496D8DC4.1060904@viscovery.net>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com> <496C6234.9040903@viscovery.net> <496D0E65.3000200@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 08:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMzm8-0008It-8r
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZANHB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbZANHB2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:01:28 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47282 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZANHB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:01:27 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LMzki-0000Zd-SD; Wed, 14 Jan 2009 08:01:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A0C65A865; Wed, 14 Jan 2009 08:01:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <496D0E65.3000200@kitware.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105591>

Brad King schrieb:
> Johannes Sixt wrote:
>> Consider this: You accidentally push a branch with confidential data to a
>> public repository. You notice it early, and quickly delete the branch
>> using 'git push the-repo :refs/heads/that-branch'. At this time the
>> objects with the confidential data are still lingering in the public
>> repository. But with the current behavior noone can access them even if
>> the SHA1 happens to be known.
> 
> Might a repack (perhaps an automatic one) put the object in a pack
> (perhaps in a delta chain) that can be fetched through another ref?

No, assuming that-branch was the only ref that contained the objects.

Even if the repack happens before the branch is deleted, the objects that
were *only* in that-branch will not be sent out.

-- Hannes
