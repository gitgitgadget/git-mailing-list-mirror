From: John Keeping <john@keeping.me.uk>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 14:17:25 +0000
Message-ID: <20130120141725.GL31172@serenity.lan>
References: <kdgtir$apt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 15:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twvic-0001HI-Gm
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 15:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab3ATORc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 09:17:32 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:41902 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3ATORc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 09:17:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 74EC7198005;
	Sun, 20 Jan 2013 14:17:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTx7F6neP0Iq; Sun, 20 Jan 2013 14:17:31 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 0A5A4198003;
	Sun, 20 Jan 2013 14:17:31 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 05446161E52D;
	Sun, 20 Jan 2013 14:17:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpP2TlsGTGwE; Sun, 20 Jan 2013 14:17:30 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0B2CD161E557;
	Sun, 20 Jan 2013 14:17:27 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <kdgtir$apt$1@ger.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214020>

On Sun, Jan 20, 2013 at 03:05:18PM +0100, Stephen Kelly wrote:
> I find the fixup command during an interactive rebase useful.
> 
> Sometimes when cleaning up a branch, I end up in a situation like this:
> 
>  pick 07bc3c9 Good commit.
>  pick 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
> 
> So, I have to reorder the commits, and change 1313a5e to 'f'. An alternative 
> would be to squash 's' c2f62a3 into 1313a5e and clean up the commit message. 
> The problem with that is it ends up with the wrong author time information.
> 
> So, I usually reorder and then fixup, but that can also be problematic if I 
> get a conflict during the re-order (which is quite likely).
> 
> I would prefer to be able to mark a commit as 'should be consumed', so that:
> 
>  pick 07bc3c9 Good commit.
>  consume 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
> 
> will result in 
> 
>  pick 07bc3c9 Good commit.
>  pick 62a3c2f Another commit.
> 
> directly.
> 
> Any thoughts on that? 

Are you aware of the "--autosqush" option to git-rebase (and the
"rebase.autosquash" config setting)?  I find that using that combined
with the "--fixup" option to git-commit makes this workflow a lot more
intuitive.

(Which is not to say that I wouldn't find an option like 'consume'
useful but I find myself reordering the list very rarely since I started
using "git commit --fixup=...".)


John
