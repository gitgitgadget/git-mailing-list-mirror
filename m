From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] git-gui: Add shortcut keys for Show More/Less Context
Date: Wed, 2 Apr 2008 01:34:23 -0400
Message-ID: <20080402053423.GW10274@spearce.org>
References: <1207047243-27738-1-git-send-email-maillist@steelskies.com> <57518fd10804010659t42569632u906f994519d527c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 07:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgvct-0003se-Hd
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 07:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbYDBFe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 01:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbYDBFe1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 01:34:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41252 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYDBFe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 01:34:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jgvc8-0006pS-PB; Wed, 02 Apr 2008 01:34:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18CFB20FBAE; Wed,  2 Apr 2008 01:34:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <57518fd10804010659t42569632u906f994519d527c6@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78681>

Jonathan del Strother <maillist@steelskies.com> wrote:
> On Tue, Apr 1, 2008 at 11:54 AM, Jonathan del Strother
> <maillist@steelskies.com> wrote:
> > Bound to Ctrl/Cmd + left & right square brackets, depending on your platform.

Thanks.
 
> ... I've just noticed that the shortcut keys don't apply while the
> diff view has keyboard focus.  Shall I replace "bind $ui_comm ... "
> with "bind all ..."  ?

No, "bind .".  I squashed this into your patch:

@@ -2758,6 +2760,8 @@ bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
+bind .   <$M1B-Key-\[> {show_less_context;break}
+bind .   <$M1B-Key-\]> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
 foreach i [list $ui_index $ui_workdir] {
        bind $i <Button-1>       "toggle_or_diff         $i %x %y; break"


-- 
Shawn.
