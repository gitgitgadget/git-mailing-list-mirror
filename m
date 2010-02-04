From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 07:05:56 +0530
Message-ID: <20100204013556.GA2590@atcmail.atc.tcs.com>
References: <20100203204723.GA30157@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncqdz-0001I7-D6
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 02:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061Ab0BDBg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 20:36:26 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:56938 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932983Ab0BDBgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 20:36:25 -0500
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id o141Zunj002871;
	Thu, 4 Feb 2010 07:05:56 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id o141ZuJN002870;
	Thu, 4 Feb 2010 07:05:56 +0530
Content-Disposition: inline
In-Reply-To: <20100203204723.GA30157@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/10354/Wed Feb  3 16:33:21 2010 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138927>

On Thu, Feb 04, 2010 at 09:47:23AM +1300, martin f krafft wrote:
> Dear Sitaram, dear Teemo, dear gitolite-fans,
> 
> Gitolite currently copies hooks to repositories. For upgrades, it
> must thus ensure that all hooks are also upgraded.

I forgot... part of the reason this "copy all hooks over
each time you run install" is also to give people an easy
way to update the hooks when the repo was *copied* from
elsewhere, and not *created* by gitolite in the first place.

Basically I'm paranoid about that "update" hook, without
which the branch level access control doesn't work at all.

So this will still need to be done. Or you'll have to
provide some other command that will sweep through all repos
in the $REPO_BASE and check that the symlink is pointing to
the right place etc etc.

Any other ways of doing this?  I'd rather keep it as is, if
it's OK with you, except for changing the cp to ln of course.
