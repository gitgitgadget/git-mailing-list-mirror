From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Thu, 24 Jul 2008 22:13:33 +0200
Message-ID: <20080724201333.GA3760@blimp.local>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7DJ-00081n-Mp
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbYGXUN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYGXUN5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:13:57 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:8197 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYGXUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:13:57 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf40K7
Received: from tigra.home (Fac14.f.strato-dslnet.de [195.4.172.20])
	by post.webmailer.de (fruni mo63) (RZmta 16.47)
	with ESMTP id 203b95k6OI67UL ; Thu, 24 Jul 2008 22:13:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EA95E277C4;
	Thu, 24 Jul 2008 22:13:53 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id A879336D15; Thu, 24 Jul 2008 22:13:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89954>

Avery Pennarun, Thu, Jul 24, 2008 21:57:03 +0200:
> I often find myself being on a branch and wanting to do the equivalent
> of a series of cherry-picks from another branch into the current one.
> Unfortunately, "git cherry-pick" only does one patch at a time (which
> is very tedious), and "git rebase", which is much less tedious to use,
> seems to specializing in applying your current branch on top of
> another branch, not the other way around.

Try this:

    $ type gcp3
    gcp3 is a function
    gcp3 ()
    {
	git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
    }
