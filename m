From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Mon, 26 Jul 2010 09:16:27 +0200
Message-ID: <201007260916.27306.trast@student.ethz.ch>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com> <20100726033634.GA30877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Geoff Russell <geoffrey.russell@gmail.com>, <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 09:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdHvN-0002s9-SC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 09:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0GZHQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 03:16:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:33448 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816Ab0GZHQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 03:16:27 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 09:16:25 +0200
Received: from thomas.localnet (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 09:16:25 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <20100726033634.GA30877@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151812>

Jonathan Nieder wrote:
> +Incorporates changes from a remote repository into the current
> +branch.  In its default mode, a `git pull` is shorthand for
> +`git fetch` followed by `git merge FETCH_HEAD`.

In my ears, "a `git pull` is..." sounds weird.  I would remove the
'a'.  But maybe it's just my non-native English hard(ly) at work...

> -*Warning*: Running 'git pull' (actually, the underlying 'git merge')
> -with uncommitted changes is discouraged: while possible, it leaves you
> -in a state that is hard to back out of in the case of a conflict.
[...]
> +See linkgit:git-merge[1] for details, including how conflicts
> +are presented and handled.  To cancel a conflicting merge,
> +use `git reset --merge`.
> +
> +If any of the remote changes overlap with local uncommitted changes,
> +the merge will be automatically cancelled and the work tree untouched.
> +It is generally best to get any local changes in working order before
> +pulling or stash them away with linkgit:git-stash[1].

There's a slight risk with it because people might read this version
of the manpage online and then conclude that it is safe to try a merge
with uncommitted changes, only to find that their git-reset doesn't
support --merge yet.  Or worse, verify that their git-reset has
--merge by a quick test (1b5b465 is in 1.6.2) but then find that it
does not help with backing out of a merge (e11d7b5 is only in 1.7.0!).

Then again, who reads these manpages anyway?  And we shouldn't let old
versions get in the way of having consistent and up-to-date docs.  So,

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
