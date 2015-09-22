From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 21:40:37 +0300
Message-ID: <20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:40:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSUp-0006o3-3X
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934244AbbIVSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:40:50 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54545 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151AbbIVSkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:40:43 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t8MIebAO029924;
	Tue, 22 Sep 2015 21:40:38 +0300
In-Reply-To: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278413>

On Tue, 22 Sep 2015 14:32:19 -0400
Josh Boyer <jwboyer@gmail.com> wrote:

> Please CC me as I'm not subscribed.
> 
> I was hoping someone could help me with the revision shorthand to get
> the commit sha of a commit N commits after the initial commit.

What happens if right after the initial commit, there have been five
branches created -- with no common commits except for the initial one?

That's the core limitation of the data model Git uses (and arguably any
other DVCS system): all commits form a directed acyclic graph.
The "directed" in that construct means that child commits contain a
link to their parent commit (or commits) but not vice-versa.

Hence, given any particular commit, you're able to trace all of its
ancestry, but the reverse is not possible.
