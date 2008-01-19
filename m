From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn should default to --repack
Date: Sat, 19 Jan 2008 13:35:57 +0100
Message-ID: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
References: <96C7A3A5-D750-43AB-A8A6-8A3A6D09AF4E@sb.org> <20080118155607.GA21236@diana.vm.bytemark.co.uk> <7vfxwudftz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 13:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGCwW-00054B-Ki
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 13:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYASMgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 07:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYASMgW
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 07:36:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3047 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYASMgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 07:36:22 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JGCvW-00081Z-00; Sat, 19 Jan 2008 12:35:58 +0000
Content-Disposition: inline
In-Reply-To: <7vfxwudftz.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71102>

On 2008-01-18 12:44:08 -0800, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > I believe so too. And nowadays there's "git gc --auto", which was
> > made for occasions such as this, so it should be a breeze to
> > implement. The overhead might be low enough that it can be called
> > after _every_ imported revision.
>
> Careful. I made the same mistake and it had to be corrected with
> e0cd252eb0ba6453acd64762625b004aa4cc162b.
>
> "gc --auto" after every 1000 or so feels like a good default and I
> would agree that would be a real fix to a real usability bug.

I think 1000 might be too high; considering that (at least in my
experience) it takes on the order of 250-500 ms to import a commit,
the gc --auto overhead of maybe 10 ms isn't so bad.

A good compromise might be to run gc --auto after every 10-100
commits, _and_ when the import is done.

However, if gc --auto always takes a lot of time without accomplishing
anything in the presence of too many unreachable loose objects it
might not be a good idea to run it at all, since the use of git-svn
involves frequent rebasing.

> Patches?

Just hot air and noise for now from my end. Sorry.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
