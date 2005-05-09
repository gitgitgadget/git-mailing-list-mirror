From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 10 May 2005 01:08:00 +0200
Message-ID: <7i3bsw0zhr.fsf@lanthane.pps.jussieu.fr>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
	<20050509212842.GC15712@pasky.ji.cz>
	<7iu0lc129m.fsf@lanthane.pps.jussieu.fr> <427FE248.7040403@zytor.com>
	<7ipsw010i5.fsf@lanthane.pps.jussieu.fr> <427FE938.7050904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Tue May 10 01:00:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVHF7-0003lJ-2k
	for gcvg-git@gmane.org; Tue, 10 May 2005 01:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEIXIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVEIXIH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 19:08:07 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:28359 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261337AbVEIXIE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 19:08:04 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49N7vOr060252
          ; Tue, 10 May 2005 01:07:57 +0200 (CEST)
X-Ids: 165
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j49N80pC025315
          ; Tue, 10 May 2005 01:08:00 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVHM0-0007Ou-MA; Tue, 10 May 2005 01:08:00 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427FE938.7050904@zytor.com> (H. Peter Anvin's message of "Mon,
 09 May 2005 15:50:32 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.165]); Tue, 10 May 2005 01:07:57 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427FED4D.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>> In such cases, manual intervention is necessary anyway -- a file could
>> have been written half-way.

> In the case of git, it should not be necessary even then; there might
> be a broken file in the repository but nothing would reference it so
> it shouldn't have any effect.  Functionally speaking, operations on
> the git repository are in themselves atomic.

Yes, you're right.

I still prefer using a lockfile to flock -- NFS-safety is important
for us.  And experience with the Darcs user base (who are probably
less Unix-savvy then the Git userbase) shows that they have no problem
doing

  $ ps
  $ rm _darcs/lock
  $ darcs check

when Darcs complains about a stray lockfile.

                                        Juliusz

