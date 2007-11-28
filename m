From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit hooks
Date: Wed, 28 Nov 2007 11:17:18 +0100
Message-ID: <20071128101718.GA13940@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 11:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [129.240.10.42] (helo=mail-forward.uio.no)
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKJ1-0000u0-0Y
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:38:11 +0100
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxK5G-0007oD-79
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:23:58 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxK51-0001WZ-BU
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXK1KRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 05:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXK1KRa
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 05:17:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4173 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbXK1KRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 05:17:30 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxJyo-0003h9-00; Wed, 28 Nov 2007 10:17:18 +0000
Content-Disposition: inline
In-Reply-To: <20071128093403.GB12977@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 5FED6B8F6154B98905BD2E49478528AD0F2C7B9C
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 73 total 724375 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66284>

On 2007-11-28 10:34:03 +0100, Karl Hasselstr=F6m wrote:

> It would also be convenient with a post-commit hook that turns new
> commits into patches automatically. And gives "git commit --amend"
> the semantics of "stg refresh".

Hmm, so what I'd want for this is a hook that gets called every time a
branch ref is updated (after the update), preferably with the ref name
and its old and new values as arguments (but as long as I get the ref
name, I guess I could just ask git for the sha1s?). Is there such a
hook? I poked around a bit, but couldn't find any.

=46or extra points, I'd like to know what operation caused the ref
update. I'd want to do different things depending on whether the user
did a "commit" or "commit --amend", for example. I could use a
heuristic, but I'd rather not if there's a way to know for sure. (Hmm.
It looks like the reflog messages could be used here. Are they stable
enough?)

Also, if StGit is to set up hooks automatically (commit hooks,
pre-rebase hooks, whatever), it'd be nice to not have to worry about
overwriting any existing hooks the user might have. But git currently
allows only one hook script per hook, right?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
