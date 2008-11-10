From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: pull --preserve-merges
Date: Mon, 10 Nov 2008 13:05:18 -0600
Organization: Exigence
Message-ID: <20081110130518.3eb64ceb.stephen@exigencecorp.com>
References: <20081107160138.aa96405c.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, fg@one2team.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 20:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzc5t-0003lj-0t
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYKJTFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbYKJTFW
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:05:22 -0500
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:48324 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbYKJTFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:05:22 -0500
Received: from relay16.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay16.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 325FA1B4750;
	Mon, 10 Nov 2008 14:05:21 -0500 (EST)
Received: by relay16.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 2F38F1B475B;
	Mon, 10 Nov 2008 14:05:19 -0500 (EST)
In-Reply-To: <20081107160138.aa96405c.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100544>


> Awhile ago I brought up wanting to have a "rebase with preserve merges"
> option for `git pull`:
>
> http://thread.gmane.org/gmane.comp.version-control.git/96513
>
> Andreas had a patch to help by supporting manually typing out `git pull
> --rebase --preserve-merges`:
>
> http://thread.gmane.org/gmane.comp.version-control.git/96593
>
> And then I did another small copy/paste patch on top to add a config
> setting of `branch.<name>.preservemerges` much like the existing
> `branch.<name>.rebase`.

I just noticed the `branch.<name>.mergeoptions` flag in the merge docs.
Instead of having both `branch.<name>.rebase` and `.preservemerges`, and
possibly even more config parameters for whatever other people what to
configure as well, would something like `branch.<name>.pulloptions` be a
better idea?

In our case, we could then set all the `branch.<name>.pulloptions` to
"--rebase --preserve-merges" (likely via a post-checkout hook) and be
happy with `git pull` "just working".

Adding pulloptions would make the patch a little bit trickier, for me
to implement anyway, and I assume the rebase flag would have to stay
for backwards compatibility, but if a pulloptions config parameter
approach would be more acceptable than an explicit preservemerges
config (and hence more likely to get the patches accepted), I'd be
willing to work on that.

Thanks,
Stephen
