From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 4 Nov 2011 10:59:08 -0400
Message-ID: <20111104145908.GA3903@thunk.org>
References: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Fri Nov 04 15:59:23 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMLEo-0000r6-Hv
	for lnx-linux-ide@lo.gmane.org; Fri, 04 Nov 2011 15:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab1KDO7V (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Fri, 4 Nov 2011 10:59:21 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:44307 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab1KDO7U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2011 10:59:20 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RMLEc-0007D0-AJ; Fri, 04 Nov 2011 14:59:10 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RMLEa-00019z-Rk; Fri, 04 Nov 2011 10:59:08 -0400
Mail-Followup-To: Ted Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184774>

On Thu, Nov 03, 2011 at 12:09:55PM -0700, Linus Torvalds wrote:
> I personally dislike it, and don't really think it's a wonderful thing
> at all. I really does have real downsides:
> 
>  - internal signatures really *are* a disaster for maintenance. You
> can never fix them if they need fixing (and "need fixing" may well be
> "you want to re-sign things after a repository format change")

Note that a repository format change will break a bunch of other
things as well, including references in commit descriptions ("This
fixes a regression introduced in commit 42DEADBEEF") So if SHA-1 is in
danger of failing in way that would threaten git's use of it (highly
unlikely), we'd probably be well advised to find a way to add a new
crypto checksum (i.e., SHA-256) in parallel, but keep the original
SHA-1 checksum for UI purposes.

>  - they are ugly as heck, and you really don't want to see them in
> 99.999% of all cases.

So we can make them be hidden from "git log" and "gik" by default.
That bit is a bit gross, I agree, but 3rd party verification really is
a good thing, which I'm hoping can be added in a relatively clean
fashion.

						- Ted
