From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH/RFC 0/2] git-gui: issues with merge tool series
Date: Wed, 17 Sep 2008 23:40:16 +0200
Message-ID: <200809172340.16367.johannes.sixt@telecom.at>
References: <200808310052.21595.angavrilov@gmail.com> <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at> <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 23:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4mA-0008U1-Pl
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYIQVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYIQVkV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:40:21 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:37874 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbYIQVkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:40:20 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 68E4513A36A;
	Wed, 17 Sep 2008 23:40:17 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D08A01D235;
	Wed, 17 Sep 2008 23:40:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96146>

On Mittwoch, 17. September 2008, Alexander Gavrilov wrote:
> On Wed, Sep 17, 2008 at 3:40 PM, Johannes Sixt <johannes.sixt@telecom.at> 
wrote:
> > 1. The inability to stage a conflicted file by clicking the icon is
> >   *very* disruptive. The new menu entry "Stage Working Copy" is
> >   really only a workaround, and it shows.
>
> I can see two ways to fix it:
>
> 1) Allow that icon to work only if the diff is currently displayed,
> and also ask for confirmation if there are any conflict markers
> present.

Good.

>    Problem: What should it do with modify/delete conflicts, which
> don't have any conflict markers?

Stage the file, i.e. pick the 'modify' part (perhaps with confirmation). 
Rationale: That's what the user sees in the diff pane. Additionally, keep 
the "Use local/remote version" entries so that the 'delete' part can be 
chosen from the context menu.

> 2) Much harder: implement complete one-click undo. This involves
> saving information from the index somewhere, and forcing such items to
> remain in the 'staged' list, even if the index isn't different from
> the tree version any more.
>
>    By the way, is there a simple way to re-create a conflict file from
> the saved multistage index entries?

There's 0cf8581e (checkout -m: recreate merge when checking out of unmerged 
index) in 'next'. But that does not address how the unmerged entries get into 
the index.

-- Hannes
