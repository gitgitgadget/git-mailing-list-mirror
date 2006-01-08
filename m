From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/7] Add a minimal test for git-cherry
Date: Sun, 8 Jan 2006 10:58:44 +0100
Message-ID: <20060108095843.GD32585@nowhere.earth>
References: <20060108003815.GI1113@nowhere.earth> <7vy81r5ugx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 10:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvXHc-0000gY-8P
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 10:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWAHJ4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 04:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWAHJ4F
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 04:56:05 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44226 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030627AbWAHJ4E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 04:56:04 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B430B41955;
	Sun,  8 Jan 2006 10:56:03 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvXK0-0001CL-Ct; Sun, 08 Jan 2006 10:58:44 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy81r5ugx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14313>

On Sat, Jan 07, 2006 at 06:22:54PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > This test checks that git-cherry finds the expected number of patches
> > in two simple cases.
> >
> > Signed-off-by: Yann Dirson <ydirson@altern.org>
> >
> > +test_expect_success \
> > +    'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' \
> > +    'git-cherry-pick my-topic-branch^0 &&
> > +     echo $(git-cherry master my-topic-branch) &&
> > +     expr "$(echo $(git-cherry master my-topic-branch) )" : "+ [^ ]* - .*"
> > +'
> 
> I wonder if "+ followed by -" order is stable here.  If you make
> commits in the my-topic-branch fast enough, they would get the
> same timestamp and I suspect the order from rev-list would be
> left to chance.

We could maybe insert a sleep between the two commits ?  Not that I
find it too appealing, however...

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
