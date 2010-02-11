From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 18:57:02 -0500
Message-ID: <20100211235702.GA21930@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
 <7vpr4c200i.fsf@alter.siamese.dyndns.org>
 <20100211210445.GA8819@coredump.intra.peff.net>
 <20100211211937.GA12752@coredump.intra.peff.net>
 <76718491002111505u2935381erc376cea862e15801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiuF-0004VF-2P
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab0BKX5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 18:57:05 -0500
Received: from peff.net ([208.65.91.99]:34697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347Ab0BKX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:57:03 -0500
Received: (qmail 23902 invoked by uid 107); 11 Feb 2010 23:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 18:57:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 18:57:02 -0500
Content-Disposition: inline
In-Reply-To: <76718491002111505u2935381erc376cea862e15801@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139644>

On Thu, Feb 11, 2010 at 06:05:18PM -0500, Jay Soffian wrote:

> On Thu, Feb 11, 2010 at 4:19 PM, Jeff King <peff@peff.net> wrote:
> > =C2=A0Automatic cherry-pick failed. =C2=A0After resolving the confl=
icts,
> > =C2=A0mark the corrected paths with 'git add <paths>' or 'git rm <p=
aths>'
> > =C2=A0and commit the result with:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -c HEAD~23
> >
>=20
> Blech, how is this an improvement? Why can't I just say "git
> cherry-pick --continue"?

Because nobody has implemented it yet. ;P

The two improvements here are:

  1. We show what you typed as "git cherry-pick $X", so if you want to
     re-type it, you know it is just "git commit -c $X". This is not
     about speed, but about being more sensible for users to read.

  2. The output is now cut-and-pasteable, so you don't have to type it
     if it is still available in your terminal.

These were meant to make the situation better than it was; I agree that
"git cherry-pick --continue" would be better still.

-Peff
