From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Mon, 04 May 2009 19:25:27 +0200
Message-ID: <49FF2507.6070602@kdbg.org>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net> <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: elupus <elupus@ecce.se>
X-From: git-owner@vger.kernel.org Mon May 04 19:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M11vX-0006wH-PT
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 19:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152AbZEDRZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 13:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757947AbZEDRZf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 13:25:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44460 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757375AbZEDRZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 13:25:34 -0400
Received: from [77.119.234.153] (77.119.234.153.wireless.dyn.drei.com [77.119.234.153])
	by bsmtp.bon.at (Postfix) with ESMTP id 9D98FCDF8B;
	Mon,  4 May 2009 19:25:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118251>

elupus schrieb:
> On Mon, 27 Apr 2009 17:51:05 +0200, elupus wrote:
> 
>> Hi, 
>>
>> I recently had a problem with git push honoring the grafts file. It caused
>> it not to push all data required for a branch to the remote repository,
>> rendering it impossible to clone the remote repository (missing blobs)
>>
>> This was with an not so fresh git version of 1.5.4.3 (ubuntu hardy).
>>
>> Has this issue been fixed in later git version? I saw a thread talking
>> about it a long time ago (long before my release in question) on this
>> mailing list, but nothing was mentioned about if it was actually solved.
>>
>> Regards
>> Joakim Plate
> 
> Bump, anybody know of a way to avoid this? The problem even occurs on the
> local machine in that git gc will cleanup stuff that isn't required due to
> the grafts file, rendering the repo invalid if the graft file is removed.
> 
> I don't think running filter-branch on the git svn imported branches seems
> like a good idea. since that would also wreak havoc on any repo that pulls
> from mine (ie still private repo like usb stick or other dev machine). 
> 
> Imho, grafts shouldn't be honored on either push/pull/gc operations. 

Right.

It's a know issue. But it was nobody's itch, yet, perhaps because too few 
people use grafts. There is a topic, cc/replace, in Junio's pu branch that 
introduces "replacement objects"; these are a generalization of grafts. If 
effort is invested, then it's best to nurse this topic.

-- Hannes
