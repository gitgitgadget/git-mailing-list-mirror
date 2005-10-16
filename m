From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 16:33:21 +0200
Message-ID: <435264B1.2010204@de.bosch.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 16 16:33:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ER9Z1-0003MZ-3S
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 16:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJPOcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 10:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVJPOcd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 10:32:33 -0400
Received: from smtp-v.fe.bosch.de ([139.15.237.2]:14030 "EHLO
	smtp-v.fe.bosch.de") by vger.kernel.org with ESMTP id S1751309AbVJPOcd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 10:32:33 -0400
Received: from mta4.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta8.fe.bosch.de (Postfix) with ESMTP id 2CFBD3C00E
	for <git@vger.kernel.org>; Sun, 16 Oct 2005 16:32:32 +0200 (CEST)
Received: from si-imc02.de.bosch.com (virusscan6.fe.internet.bosch.com [10.4.98.11])
	by mta4.fe.internet.bosch.com (Postfix) with ESMTP id AC33B44004
	for <git@vger.kernel.org>; Sun, 16 Oct 2005 16:32:29 +0200 (CEST)
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by si-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 16 Oct 2005 16:32:31 +0200
Received: from [10.4.106.24] ([10.4.106.24]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 16 Oct 2005 16:32:30 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
X-OriginalArrivalTime: 16 Oct 2005 14:32:31.0231 (UTC) FILETIME=[70DE68F0:01C5D25E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10158>


> On Thu, 13 Oct 2005, Jeff Garzik wrote:
>
>>I have real users of my git repos who can't just download a 100MB pack file in
>>an hour, it takes them many hours.

Seems that I'm one of these users (but using an other repo).

Pack files are very nice saving bandwith and disk space. But what I 
dislike is that I often have to download same information twice: Remote 
.git/objects/* repo grows and I update my local repo daily against this. 
Then once a month/release/whatever .git/objects/* are packed into one 
file. This new pack file then is downloaded as well, but most/all of the 
information in this file is already in my local repo and downloaded 
again. Something like

- detect that there is new pack file in remote repo
- check what is in this remote pack file
- if in local repo no or only few .git/objects/* are missing, download 
the missing ones and create an identical copy of remote pack file using 
local .git/objects/*. Don't download remote pack file.
- remove all local .git/objects/* now in pack file

would be nice.

Or is this already possible? Or do I misunderstand anything?

Dirk
