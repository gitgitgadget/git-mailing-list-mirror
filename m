From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 12:31:52 -0400
Message-ID: <453656F8.3000504@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87zmbucs86.wl%cworth@cworth.org> <45359F36.6050609@utoronto.ca> <200610181120.49749.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 18 18:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaEKx-0006An-Dk
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 18:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWJRQcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWJRQcD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 12:32:03 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:35541 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1422646AbWJRQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 12:32:00 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaEKg-0000bT-00; Wed, 18 Oct 2006 12:31:55 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610181120.49749.jnareb@gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29245>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
> 
>>Carl Worth wrote:
>>>There are even more important reasons to prefer a series of
>>>micro-commits over a mega-patch than just ease of merging.
>>
>>A bundle isn't a mega-patch.  It contains all the source revisions.  So
>>when you merge or pull it, you get all the original revisions in your
>>repository.
> 
> 
> But what patch reviewer see is a mega-patch showing the changeset
> of a whole "bundle", isn't it?
> [...]

Yes.  Carl was saying that, aside from the issue of what a reviewer
sees, a bundle is bad for other reasons.  I am saying those other
reasons don't apply.  I wasn't addressing the issue of what a reviewer sees.

To me, seeing the individual patches is like reading a book where every
page has a different word on it, and so it's hard to put it together
into a full sentence.  I'm not saying my way is The Right Way, just my
personal preference.

For larger pieces of work, we try to split them up into logical units,
and merge those units independently.

The Bundle format can also support a patch-by-patch output, but we don't
have UI to select that.

> I think it is much better to review series of patches commit by commit;
> besides it allows to correct some inner patches before applying the whole
> series or drop one of patches in series (and it happened from time to time
> on git mailing list).

It's important to remember that bundles represent revisions, not
patches.  When you merge a bundle, you

1. install those revisions into your repository.  These revisions are
   latent, as though they were on another branch.
2. merge the head revision of the bundle into your branch.

Virtually any merge selection process that works with branches would
also work with bundles.  So tweaking before merging is really a matter
of replacing the UI for 2.

> So if git introduces bundles, I think they would take form of series
> of "patch" mails + introductory email with series description (currently
> it is not saved anywhere), shortlog, diffstat and perhaps more metainfo
> like bundle parent (which I think should be email form of branch really),
> tags introduced etc.

The parent in a bundle revision is the revision-id of the parent of that
revision in the branch.  I don't think it's possible to change that
parent id into something else, without changing the meaning of a bundle.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNlb40F+nu1YWqI0RAnxxAJ9ETibey1Qyvz/zVxdGipaHGtnddgCfTtzt
CQUZ2dK64BS5K5WYecFAsfM=
=bJxq
-----END PGP SIGNATURE-----
