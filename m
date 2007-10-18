From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git on afs (fwd)
Date: Thu, 18 Oct 2007 17:48:01 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710181746020.30020@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; boundary="-1602208999-79759986-1192747054=:30020"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 00:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IieA4-0000gr-OU
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759788AbXJRWsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759392AbXJRWsF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:48:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35955 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbXJRWsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 18:48:04 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9IMm17Q017166
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 17:48:01 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Oct 2007 17:48:01 -0500
Content-ID: <Pine.LNX.4.64.0710181746021.30020@torch.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Oct 2007 22:48:01.0160 (UTC) FILETIME=[EFAA9080:01C811D8]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--5.790200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 150567-147015-148033-148039
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61570>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1602208999-79759986-1192747054=:30020
Content-Type: TEXT/PLAIN; format=flowed; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0710181746022.30020@torch.nrlssc.navy.mil>



Added the mailing list back in.


On Thu, 18 Oct 2007, Todd T. Fries wrote:

> link() returns -1 errno 17 File exists on afs.
>=20
> To further muddy the waters, linking within the same dir is ok,
> linking outside the same dir is not:
>=20
> todd@ispdesk/p6 ~/tmp=A661$ mkdir dir
> todd@ispdesk/p6 ~/tmp=A662$ touch a
> todd@ispdesk/p6 ~/tmp=A663$ ln a b
> todd@ispdesk/p6 ~/tmp=A664$ ls -l a b
> -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> todd@ispdesk/p6 ~/tmp=A665$ ls -li a b
> 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> todd@ispdesk/p6 ~/tmp=A666$ ln a dir/b
> ln: dir/b: File exists
> todd@ispdesk/p6 ~/tmp=A667$ echo $?

That error is just bogus on afs. If it returned a sane
error, things would just work.

But, looks like afs only supports linking within the same
directory: http://www.angelfire.com/hi/plutonic/afs-faq.html

So, you could look into whether the temp file can be sanely
created in the same directory as the final filename.

-brandon
---1602208999-79759986-1192747054=:30020--
