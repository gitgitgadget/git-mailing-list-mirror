From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: diff-tree -r and new directories
Date: Thu, 10 Apr 2008 09:24:59 +0200
Message-ID: <47FDC0CB.7050203@viscovery.net>
References: <47FDB3DB.8020705@viscovery.net> <7v1w5eyzeh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrAK-0004ny-V1
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbYDJHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbYDJHZE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:25:04 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12509 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYDJHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:25:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jjr9X-0001D1-BU; Thu, 10 Apr 2008 09:24:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2388C6C4; Thu, 10 Apr 2008 09:24:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v1w5eyzeh.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79186>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> In one of my scriptlets I have this:
>>
>>    git diff-tree -r --name-only --diff-filter=AM -z "$rev" HEAD --
>>
>> and I had assumed that only files would ever be listed because of the -r
>> switch. But this is not true: If there is a new directory, it lists only
>> the directory's name instead of the files. Is this the intent? Is it worth
>> changing?
> 
> Hmm. you would need a better reproduction recipe than that.

Heh. It turns out that the questionable directory is actually versioned by
git. My scriptlets have added it as a submodule while I looked in the
other direction:

  $ git diff --summary $rev.. -- . | cat
  create mode 160000 D/Project/foo

:-) Problem solved. Thank you.

-- Hannes
