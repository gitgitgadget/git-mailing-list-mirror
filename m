From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Tue, 25 Mar 2008 12:05:59 +0100
Message-ID: <20080325110559.GA10333@diana.vm.bytemark.co.uk>
References: <20080320002604.13102.53757.stgit@yoghurt> <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com> <20080324181225.GC23337@diana.vm.bytemark.co.uk> <b0943d9e0803250346h7405c37egc9ba170a6dcc06bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 12:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6zX-00087G-Du
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 12:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYCYLGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 07:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYCYLGO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 07:06:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1725 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYCYLGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 07:06:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Je6yd-0003JO-00; Tue, 25 Mar 2008 11:05:59 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0803250346h7405c37egc9ba170a6dcc06bf@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78179>

On 2008-03-25 10:46:00 +0000, Catalin Marinas wrote:

> My reason for this is that usually you "goto" a patch to do some
> changes followed by "refresh". If there were local changes, they
> would be included in the refreshed patch since this is the default
> StGIT behaviour. To avoid this, I find myself running "status"
> before any "goto".

Yeah, I can see how that would be irritating. Especially since the
conversion to the new infrastructure is only half done, so that not
all commands behave the same.

> But in git, for committing, you usually need to run "git add" on the
> files or specify "commit -a" explicitly. We would need to change the
> "refresh" behaviour in the same way and, in this case, I would be OK
> with (2) as the default.
>
> I personally prefer the current "refresh" way but maybe because I'm
> used to it. It would be useful to get other users' opinion on this
> UI change. Might not be a bad change since git does this already,
> quilt needs an explicit "add" (anyone knows about guilt?).

I think my preference would be to to what git does: let just "stg
refresh" commit what's in the index, and have "stg refresh -a" or
something to automatically update the index first. (This should be
easy to do, btw -- refresh already has an --index flag.)

In general, I think it's a bad idea to do things differently from git
without a good reason.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
