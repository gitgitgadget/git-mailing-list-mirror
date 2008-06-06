From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Multiple user questions
Date: Fri, 06 Jun 2008 16:19:49 -0500
Message-ID: <fa67IkKd22OcyCOfHZx_EORkS5DPZLP5IEWlE3dg-pOOdKgeIL0hpA@cipher.nrlssc.navy.mil>
References: <200806062247.42074.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4jMn-0003kZ-RZ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760894AbYFFVUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757898AbYFFVUD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:20:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41508 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513AbYFFVUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:20:01 -0400
Received: by mail.nrlssc.navy.mil id m56LJn4k022349; Fri, 6 Jun 2008 16:19:49 -0500
In-Reply-To: <200806062247.42074.devurandom@gmx.net>
X-OriginalArrivalTime: 06 Jun 2008 21:19:49.0920 (UTC) FILETIME=[0DAD6A00:01C8C81B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84118>

Dennis Schridde wrote:
> I just ran into a lost stash again and thus would like to get an answer to 
> this question, which was forgotten last time:
> (lost-found is really growing in a pace it will take me very long to find my 
> lost stash.)

How did you lose it?

If you did 'git stash drop' and then realized that you dropped the wrong stash,
you can apply that stash and then recreate it since 'stash drop' also prints out
the sha1 and 'stash apply' can use that.

For example:

   # edit edit edit
   $ git stash
   # hmm I don't need that old stash anymore
   $ git stash drop
   Dropped refs/stash@{0} (5dcea62df980fa157e7755f82125dfc3bbd52ff5)
   # whoops I didn't mean to drop _that_ stash
   $ git stash apply 5dcea62df980fa157e7755f82125dfc3bbd52ff5
   $ git stash

Of course, that only works if you realize pretty quickly that you dropped the
wrong stash. Also realize my example was rather simplified and the working
directory may need to be prepped before reapplying the dropped stash.

-brandon
