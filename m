From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 13:22:38 +0200
Message-ID: <48C65C7E.3030305@viscovery.net>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> <48C61F94.3060400@viscovery.net> <loom.20080909T085002-376@post.gmane.org> <48C6569C.60000@viscovery.net> <48C658DE.3070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 13:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd1K0-0001Dv-10
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 13:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbYIILWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 07:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYIILWk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 07:22:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51752 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYIILWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 07:22:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kd1Is-0006In-E0; Tue, 09 Sep 2008 13:22:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D5F769F; Tue,  9 Sep 2008 13:22:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48C658DE.3070001@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95375>

Sergio Callegari schrieb:
> But in any case it would be preferable to smudge on checkout since
> uncompressed OO files can be quite huge.
> Also to have uncompressed OO files in the worktree means that if you
> ever need to send one as an attachment to somebody you need to reopen
> and resave it before making the attachment, which is a bit uncomfortable!

True. Choose your poison.

>> A file that you have just 'git add'ed must not show up as dirty even
>> if it
>> was processed by a "clean" filter. If it does, then this indicates a bug
>> in git, and not that a corresponding "smudge" filter is missing or
>> misbehaves. Yes, I have observed this with my own "clean" filter some
>> time
>> ago, but I have not yet tried hard enough to find a reproducible test
>> case.
>>
>>   
> But am I correct in saying that it will show dirty if you clean and then
> smudge in a non symmetric way?

No.

The "smudge" filter kicks in only if the file in the worktree must be
replaced, for example, due to 'git checkout'. After the filter has
completed, the stat information of the smudged version is stored in the
index, and so the file does not appear as dirty. (Again, if you observe
something else, then git must be fixed, IMO.)

-- Hannes
