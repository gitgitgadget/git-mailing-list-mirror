From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 21:07:57 +0200
Message-ID: <20071010190757.GP23810@genesis.frugalware.org>
References: <20071010015545.GA17336@lapse.madduck.net> <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org> <20071010102528.GB20390@lapse.madduck.net> <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org> <20071010154831.GA19226@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifgux-0003vi-3Y
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbXJJTIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXJJTIR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:08:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35139 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbXJJTIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:08:16 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IfguZ-00033W-6s
	from <vmiklos@frugalware.org>; Wed, 10 Oct 2007 21:08:11 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8F6BA13A40EE; Wed, 10 Oct 2007 21:07:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071010154831.GA19226@old.davidb.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60527>


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2007 at 08:48:31AM -0700, David Brown <git@davidb.org> wrote:
> On Wed, Oct 10, 2007 at 08:25:15AM -0700, Linus Torvalds wrote:

> >Yes, *some* SCM's have tried to do that. In particular, the ones that are "patch-based" tend to think that patches are "identical" regardless of where they are, and while re-ordering of them is a special event, it's not somethign that changes the fundamental 'ID' of the patch.

> >For example, I think the darcs "patch algebra" works that way.

> >It's a really horrible model. Not only doesn't it scale, but it leads to various very strange linkages between patches, and it fails the most important part: it means that merges get different results just because people are doing the same changes two different ways.

> Actually, specifically darcs, different merges _always_ result in the same
> data.  It's a fundamental part of is patch algebra.  No matter what order
> you apply a given set of patches, even with conflicts and reordering, you
> always get the same result, or no result.  Conflicts are "resolved" by
> inserting conflict markers in the file, ordered by the patch ID.  It
> doesn't matter which order you apply them in, you get the same markers.
> Then there will be a merge patch which fixes the markers that someone could
> apply, no matter what order the applied the previous patches.

> Darcs breaks down in a few places, though.

>   - The no result.  Sometimes, it just can't figure out how to reorder
>     patches.  Even worse, occasionally, the implementation will fail to
>     terminate try to figure this out.  There isn't much to do at this
>     point, except manually apply the patch, hence generating a new patch
>     ID.

>   - It doesn't scale well.

> The strange linkages between patches could be thought of as a feature,
> since it is basically constraining the order that the patches can be
> applied in.

> There is a darcs-git project that tries to do the darcs things on top of
> git.

> Dave
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

thanks,
- VMiklos

--v541l457l4DThMFo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHDSMNe81tAgORUJYRAogcAJ9dsdQtpHTe8KEz1XhwpjDcBEq3AACggkXl
iROXhoVkogDQOnIijWB5PmY=
=Vq0L
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
