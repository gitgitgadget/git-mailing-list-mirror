From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Hello All and Seeking Information
Date: Mon, 24 Nov 2008 23:57:21 -0800
Message-ID: <492BAFE1.5010904@pcharlan.com>
References: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 08:58:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4soh-0003q4-9o
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 08:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbYKYH5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 02:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYKYH5X
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 02:57:23 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:60013 "EHLO
	swarthymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751025AbYKYH5W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 02:57:22 -0500
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a7.g.dreamhost.com (Postfix) with ESMTP id B0D81DE52F;
	Mon, 24 Nov 2008 23:57:21 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101652>

Tim Visher wrote:
> there are some issues that I can't wrap my head around, such as how
> you can guarantee that all developers are working on the same
> code-base without a central repo.

You can have a central repo that represents the official lines of
development (branches, but "official" branches), and each developer
has local copies of those branches so they can compare their own work
against them.

If you don't have a central repo, then the developers can keep local
copies of other developers' branches when they're interested in them,
and compare their work against those.

Using the git project as an example, when you clone from
git://git.kernel.org/pub/scm/git/git.git you will find "remote
branches" origin/master, origin/maint, etc.  They're stored locally in
your repo; the name "remote" only refers to the fact that at one time
(when you last cloned or fetched) they corresponded to branches in the
origin repo.  You can list your copies of these branches with "git
branch -r".  You can freshen them to agree with the origin with "git
fetch origin".

Your local branches ("local" referring to the fact that they exist
_only_ locally), listed by "git branch", are what you develop on.

After you do "git fetch", you can compare your local branches against
your copies of the remote branches to see if the remote repo has new
work you haven't yet incorporated into your local branches.  You can
also compare against them to see if you have work they don't.

So each developer can compare what they have against what others have,
and keep things in sync as much as they wish to (and no more), fairly
easily.

--Pete
