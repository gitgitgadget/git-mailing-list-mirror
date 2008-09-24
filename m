From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 2/2] git-gui: Do not automatically stage file after
	merge tool finishes
Date: Wed, 24 Sep 2008 10:50:33 -0700
Message-ID: <20080924175033.GZ3669@spearce.org>
References: <200808310052.21595.angavrilov@gmail.com> <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at> <1221651652-3712-2-git-send-email-johannes.sixt@telecom.at> <1221651652-3712-3-git-send-email-johannes.sixt@telecom.at> <bb6f213e0809170525q286f5d42xfd734660dc935cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:52:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYXP-0003cF-89
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYIXRuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbYIXRuf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:50:35 -0400
Received: from george.spearce.org ([209.20.77.23]:34343 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYIXRue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:50:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A2A73835F; Wed, 24 Sep 2008 17:50:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bb6f213e0809170525q286f5d42xfd734660dc935cbf@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96668>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 3:40 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > If a merge tool was invoked on a conflicted file and the tool completed,
> > then the conflicted file was staged automatically. However, the fact that
> > the user closed the merge tool cannot be understood as the unequivocal
> > sign that the conflict was completely resolved. For example, the user
> > could have decided to postpone the resolution of the conflict, or could
> > have accidentally closed the tool. We better leave the file unstaged and
> > let the user stage it explicitly.
> 
> It completely reproduces the logic that git-mergetool uses. Namely, if
> the file is unchanged, it asks explicitly, and if the tool returns a
> non-zero exit code, it does not stage at all.
> 
> You also cannot simply remove merge_add_resolution, because then it
> would leave the diff view stale.

Is it just a matter of calling reshow_diff instead?

-- 
Shawn.
