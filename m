From: Ray Lee <ray@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 18:22:45 -0700
Organization: http://madrabbit.org/
Message-ID: <1113960166.29444.102.camel@orca.madrabbit.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	 <20050418122011.GA13769@abridgegame.org>
	 <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
	 <1113874991.23938.113.camel@orca.madrabbit.org>
	 <7i7jizyy4i.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: darcs-devel@darcs.net, git@vger.kernel.org,
	Kevin Smith <yarcs@qualitycode.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 03:19:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO3rV-0005jF-EC
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDTBWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDTBWu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:22:50 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:18407 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261179AbVDTBWs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 21:22:48 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id 1C4594C0844; Tue, 19 Apr 2005 18:22:47 -0700 (PDT)
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7i7jizyy4i.fsf@lanthane.pps.jussieu.fr>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 at 10:22 +0200, Juliusz Chroboczek wrote:
> > > Aye, that will require some metadata on the git side (the hack,
> > > suggested by Linus, of using git hashes to notice moves won't work).
> 
> > So, why won't it work?
> 
> Because two files can legitimately have identical contents without
> being ``the same'' file from the VC system's point of view.
> 
> In other words, two files may happen to have the same contents but
> have distinct histories.

Eh, let's not talk using integral/summation view across all the patches
that ever could have come in against the file. We're hamstringing
ourselves if we do that, and it's not what darcs does. darcs looks at a
differential view of the changes, and for a mv, it looks at it when it
happens.

darcs does a "darcs mv" to commit a "file move patch" to whatever
logging or patch repository it keeps below the surface.

The equivalent in git would be to have a given tree, move a file via
bash's mv, and then checkpoint a new tree. (I'm sure there's details in
there, but that's plumbing, and what we have Petr for.)

A differential comparison of the two trees shows no content changed, but
a file label was modified. Ergo, a rename occurred.

QED.

~r.

