From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 07/11] git-fetch: Limit automated tag following to only
 fetched objects
Date: Fri, 09 Nov 2007 12:28:28 +0100
Message-ID: <4734445C.6000303@viscovery.net>
References: <20071109110631.GG19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqS2b-0005dd-Jv
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbXKIL2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbXKIL2d
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:28:33 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11162 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbXKIL2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:28:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IqS1o-0000AC-4G; Fri, 09 Nov 2007 12:28:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BC8386C4; Fri,  9 Nov 2007 12:28:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071109110631.GG19368@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64166>

Shawn O. Pearce schrieb:
> Some of the test vectors for t5515 were affected by this as they
> were listing "not-for-merge" tags in .git/FETCH_HEAD that were
> being fetched under the old rule but are now not fetched under the
> new rule.  To be perfectly honest I have no idea why they were even
> fetching under the old rule, and I think that's part of the problem
> with the old rule.  It was very difficult to understand why some
> things would auto-follow a tag and others wouldn't.

The old rule was:

	Fetch a tag if we have the object that the tag refers to.

So, If you have an object lingering in your repo, even if it is not 
accessible by any of the refs - eg. it's a left-over from a previous fetch - 
then the tag was fetched again.

-- Hannes
