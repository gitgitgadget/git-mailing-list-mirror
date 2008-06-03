From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH v2 2/2] Make old sha1 optional with git update-ref -d
Date: Tue, 3 Jun 2008 08:49:57 +0200
Message-ID: <20080603064957.GA6701@diana.vm.bytemark.co.uk>
References: <20080602233244.26087.51827.stgit@yoghurt> <20080602233453.26087.52259.stgit@yoghurt> <7vk5h73w2i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3QMc-000435-RA
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 08:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYFCGua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 02:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbYFCGua
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 02:50:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1617 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYFCGu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 02:50:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K3QLF-0002tn-00; Tue, 03 Jun 2008 07:49:57 +0100
Content-Disposition: inline
In-Reply-To: <7vk5h73w2i.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83621>

On 2008-06-02 22:51:33 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > Giving the old sha1 is already optional when changing a ref, and
> > it's quite handy when running update-ref manually. So make it
> > optional for deleting a ref too.
>
> "Handy" is not a very good reason when talking about plumbing
> command like update-ref that takes an extra parameter for safety of
> the last step in read, operate, verify-and-update sequence.
>
> Although it is not a reason _bad enough_ to make your patch a bad
> idea, perhaps you should rethink the problem at the same time?
> Whatever you are trying to do cannot be done without manually
> invoking update-ref directly by the end user, perhaps that needs to
> be addressed?

I need this from time to time when experimenting with StGit -- or,
more precisely, when cleaning up afterwards in case it didn't go so
well. Packed refs means I can't safely just edit/delete files under
=2Egit/refs anymore, so I use update-ref instead. And having to use the
safety belt every time is just plain tedious. I'd say this is a
perfect example of when using the plumbing by hand is really what you
want.

(In this kind of situation, branch -D often doesn't work since my ref
isn't under refs/heads, and besides I really don't want any of it's
smarts right then -- I want to delete a ref, nothing more.)

Better suggestions welcome, of course.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
