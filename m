From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 12:49:43 +0200
Message-ID: <20071003104943.GA3017@diana.vm.bytemark.co.uk>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id1oy-0007HQ-3O
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbXJCKuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 06:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbXJCKuv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:50:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1613 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbXJCKuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 06:50:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Id1nT-0000ni-00; Wed, 03 Oct 2007 11:49:43 +0100
Content-Disposition: inline
In-Reply-To: <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59820>

On 2007-10-03 12:25:22 +0200, Wincent Colaiuta wrote:

> In any case I think more people need to speak up on the topic so
> that we can find out what most people really think about changing
> the default.

My vote is for changing it.

Both "push the current branch" and "push all branches" have their
uses, and both can be specified explicitly, so no problem there. The
problem arises when a user expects one default but get another. There
are two cases:

  1. "push the current branch" is the default, but the user intended
     to push all branches. She ends up pushing only a subset of what
     she wanted, which is easily fixed once she notices what's
     happened.

  2. "push all branches" is the default, but the user intended to push
     only the current branch. She ends up pushing a superset of what
     she wanted, which is not easily fixed if she can't be sure that
     no one else has pulled from the public repo before she notices
     what's happened.

So it all comes down to case (2) mistakes being much harder to fix
than case (1) mistakes. Therefore, we should change the default, since
doing so makes it safer.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
