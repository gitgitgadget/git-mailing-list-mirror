From: Madhu <enometh@meer.net>
Subject: Re: git-cvsimport problem
Date: Wed, 28 May 2008 17:45:13 +0530
Message-ID: <m3iqwytyjy.fsf@meer.net>
References: <482192B9.2010406@opensourceclub.org>
Reply-To: enometh@meer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 14:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1KhI-0007oc-34
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 14:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbYE1MWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYE1MWs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 08:22:48 -0400
Received: from [59.92.5.68] ([59.92.5.68]:27379 "EHLO moon.robolove.meer.net"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751418AbYE1MWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 08:22:48 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2008 08:22:47 EDT
Received: by moon.robolove.meer.net (Postfix, from userid 500)
	id 343B4A6D0E; Wed, 28 May 2008 17:45:14 +0530 (IST)
X-Url: http://www.meer.net/~enometh/
X-Attribution: Madhu
In-Reply-To: <482192B9.2010406@opensourceclub.org> (Alenoosh Baghumian's
	message of "Wed, 07 May 2008 16:00:01 +0430")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83089>

* Alenoosh Baghumian <482192B9.2010406@opensourceclub.org> :
Wrote on Wed, 07 May 2008 16:00:01 +0430:

| I run git-cvsimport in verbose mode and I see "* UNKNOWN LINE *
| Branches:" many times during execution , will that cause any problem ?
| And my repository doesn't include any branches ? so why do I see this
| message ?

You must be using the beta version of cvsps, cvsps-2.2b1

,---- From the CHANGELOG:
| 
| 2.2b1
| - add a new line item in the PatchSet output which indicates which 
|   branches fork off from after this PatchSet.  This is actually
|   the only way to correctly indicate the branching.  The 'Ancestor
|   Branch' thing is actually broken by design, and is now deprecated.
`----

git-cvsimport uses the -A ancestor mechanism (after patching cvsps-2.1
for some corner cases), this ignores the Branches line.

I'd be interested in knowing the git-cvsimport authors' opinion on
reworking it to use the Branches mechanism.
--
Madhu
