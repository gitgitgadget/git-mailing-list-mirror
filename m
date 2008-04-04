From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 21:33:56 -0400
Message-ID: <20080404013356.GM10274@spearce.org>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com> <20080404012723.GL10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Goddard Rosa <andre_rosa@lge.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 03:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhapW-0006ou-0h
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 03:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbYDDBeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756481AbYDDBeF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 21:34:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37337 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYDDBeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 21:34:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JhaoN-0007Tv-JX; Thu, 03 Apr 2008 21:33:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7B8820FBAE; Thu,  3 Apr 2008 21:33:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080404012723.GL10274@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78791>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jonathan del Strother <maillist@steelskies.com> wrote:
> > >  > >  # git gui
> > >  > >  Error in startup script: bad event type or keysym "["
> > >  > >     while executing
> > >  > >  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
> 
> > >  These changes should help (haven't tried):
> > >         \[ -> bracketleft
> > >         \] -> bracketright
> > >  but some European keyboards do not have easy access to brackets, so
> > >  other keys would be preferable (comma and period, for example, or 1 and 2).
> 
> I wrote up a patch today based on Michele's suggested change.

Hmm, maybe I should offer the patch.  :-)

--8>--
Subject: [PATCH] git-gui: Switch keybindings for [ and ] to bracketleft and bracketright

Thanks to Michele Ballabio for the quick fix.
This resolves the error introduced by c91ee2bd61.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d4e4c17..1a67105 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2739,8 +2739,8 @@ bind $ui_comm <$M1B-Key-v> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-V> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-a> {%W tag add sel 0.0 end;break}
 bind $ui_comm <$M1B-Key-A> {%W tag add sel 0.0 end;break}
-bind $ui_comm <$M1B-Key-\[> {show_less_context;break}
-bind $ui_comm <$M1B-Key-\]> {show_more_context;break}
+bind $ui_comm <$M1B-Key-bracketleft> {show_less_context;break}
+bind $ui_comm <$M1B-Key-bracketright> {show_more_context;break}
 
 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
@@ -2784,8 +2784,8 @@ bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
-bind .   <$M1B-Key-\[> {show_less_context;break}
-bind .   <$M1B-Key-\]> {show_more_context;break}
+bind .   <$M1B-Key-bracketleft> {show_less_context;break}
+bind .   <$M1B-Key-bracketright> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       "toggle_or_diff         $i %x %y; break"
-- 
1.5.5.rc3.148.gb77a7


-- 
Shawn.
