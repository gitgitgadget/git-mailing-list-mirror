From: Chris Wilson <chris+gitscm@aptivate.org>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Thu, 4 Apr 2013 23:07:19 +0100 (BST)
Message-ID: <alpine.DEB.2.02.1304042302550.965@lap-x201.fen.aptivate.org>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org> <7vmwtei1wu.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1304042138100.965@lap-x201.fen.aptivate.org> <7vr4iqgg2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsK2-0004LU-3V
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764979Ab3DDWHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:07:25 -0400
Received: from lin-mail.aptivate.org ([176.58.121.181]:51505 "EHLO
	lin-mail.aptivate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764968Ab3DDWHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:07:24 -0400
Received: from cpc12-cmbg17-2-0-cust878.5-4.cable.virginmedia.com ([86.30.131.111] helo=lap-x201.local)
	by lin-mail.aptivate.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <chris+gitscm@aptivate.org>)
	id 1UNsJX-0001OR-DK; Thu, 04 Apr 2013 23:07:23 +0100
X-X-Sender: chris@lap-x201.fen.aptivate.org
In-Reply-To: <7vr4iqgg2w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220113>

On Thu, 4 Apr 2013, Junio C Hamano wrote:

>> I do not want to write an awk/sed script to remove all the submodules 
>> from .git/config ...
>
> Don't do it then ;-)
>
> I think "git config" was added exactly because people wanted to
> customize their configuration from their scripts.

OK, I didn't know about git config. I will investigate that. But if the 
only automated way to fix the configuration in .git/config is by removing 
all submodules and running submodule init again, I still think that's a 
usability issue at least. If you won't accept it as a bug, would you 
consider it a feature request?

>> I do, it seems bizarre that git submodule init can create this 
>> situation but cannot rectify it.
>
> I do not see there is anything to rectify in your situation.
>
> Whoever wrote .gitmodules may have supplied a URL you cannot access,

They originally supplied a wrong URL (one that I can't access).

They fixed it by checking in a rectified .gitmodules file.

In the mean time, I ran git submodule init, and now I've ended up in a 
situation where git submodule update doesn't work, and there's no 
submodule command to fix it, so I have to remove the broken submodules 
from .git/config.

> and the configuration mechanism is the way to use custom URL in
> place of it.

I don't want to use a custom URL, I want to use the URL which is now in 
.gitmodules.

Could submodule init at least change the URLs of submodules which are not 
checked out? (e.g. because they couldn't be)?

Cheers, Chris.
-- 
Aptivate | http://www.aptivate.org | Phone: +44 1223 967 838
Future Business, Cam City FC, Milton Rd, Cambridge, CB4 1UY, UK

Aptivate is a not-for-profit company registered in England and Wales
with company number 04980791.
