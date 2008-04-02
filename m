From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: "stg reset --status" doesn't just reset status
Date: Wed, 2 Apr 2008 14:00:26 +0200
Message-ID: <20080402120026.GA17241@diana.vm.bytemark.co.uk>
References: <20080401222124.1b4niqtm0ogw40sk@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 14:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh1ez-0006O2-PI
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 14:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbYDBMBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2008 08:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbYDBMBA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 08:01:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1050 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYDBMBA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 08:01:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jh1dj-0004gU-00; Wed, 02 Apr 2008 13:00:27 +0100
Content-Disposition: inline
In-Reply-To: <20080401222124.1b4niqtm0ogw40sk@webmail.spamcop.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78691>

On 2008-04-01 22:21:24 -0400, Pavel Roskin wrote:

> This time I decided to see what "stg reset --status" actually does,
> and I was unpleasantly surprised that it would do much more that its
> name implies.
>
> It doesn't just reset the status (no idea what it would be, but it
> doesn't sound scary). It removes all local changes. It's essentially
> "git reset --hard". I can easily imagine that some beginner would
> lose valuable changes by following that advice while trying to
> update from the upstream repository.
>
> I would hate to suggest another stg command, as there are too many
> of them already. On the other hand, if "applied" and "unapplied" are
> downgraded to switches for "stg series", we probably could justify
> adding one more command, "stg reset". By the way, the default could
> be to save the changes to a hidden "stash" patch, and the "--hard"
> switch would do a real reset.

(I assume "stg reset --status" is just a typo for "stg status
--reset"?)

I'd be fine with removing status --reset, but since there is currently
no other way to do this in StGit, I expect Catalin would object. (As I
recall, that's precisely what happened when I did try to remove it
some time ago.)

I'm currently (slowly) working on an "stg reset" command that'll be
able to reset the stack to any prior state. It could be made to reset
to the most recent recorded state if no extra argument is given, which
I think would make it do what you want.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
