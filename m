From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: can I get only the list of merges?
Date: Mon, 10 Jul 2006 19:41:46 +0200
Message-ID: <E1FzzlS-0003JE-9C@moooo.ath.cx>
References: <20060710192622.70c51a81.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 19:42:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzzlf-0004kT-OS
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 19:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWGJRlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 13:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWGJRlu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 13:41:50 -0400
Received: from moooo.ath.cx ([85.116.203.178]:56992 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1422730AbWGJRlt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 13:41:49 -0400
To: Diego Calleja <diegocg@gmail.com>
Mail-Followup-To: Diego Calleja <diegocg@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060710192622.70c51a81.diegocg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23629>

Diego Calleja <diegocg@gmail.com> wrote:
> Hi, git-log and git-rev-list and friends have a --no-merges option. However,
> I need the contrary functionality: a sort of "--only-merges" way of getting
> the log? (that is, without parsing manually the git-log output)

Perhaps something like this?  It finds all commits with more than one
parent (I dunno if there are any other commits that have more than one
parent)
git-rev-list --parents HEAD | \
grep -E '^([a-z0-9]{40} ){2}[a-z0-9]{40}' | \
cut -d ' ' -f 1
