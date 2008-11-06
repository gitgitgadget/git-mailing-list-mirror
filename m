From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: More help needed on merging unrelated repos
Date: Thu, 6 Nov 2008 09:37:51 +0100
Message-ID: <20081106083751.GA10359@diana.vm.bytemark.co.uk>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com> <4910ACCA.7080007@op5.se> <46d6db660811041308o19f1131dm4d49b6703fa6d22b@mail.gmail.com> <4910C6F4.5010407@op5.se> <46d6db660811041430l74d9a100kc15ac46dea8ff63f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 09:39:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky0Op-0004Qx-MD
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 09:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbYKFIiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 03:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYKFIiQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 03:38:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3691 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbYKFIiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 03:38:16 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ky0ND-0002nB-00; Thu, 06 Nov 2008 08:37:51 +0000
Content-Disposition: inline
In-Reply-To: <46d6db660811041430l74d9a100kc15ac46dea8ff63f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100219>

On 2008-11-04 23:30:56 +0100, Christian MICHON wrote:

> note the merge can work, but it's still done in 2 steps. :(
> thanks for suggesting this.

If it had worked, you'd have gotten just one merge commit. What you
want to do is entirely possible, but it seems the high-level commands
were not designed with your use-case in mind.

Another thing you could try is to merge the two branches separately,
getting a history like this:

  p1----\
         \
  p2---A--B
      /
  p3--

And then use grafts to convince git that B has parents p1, p2, and p3
(instead of its actual parents p1 and A). (Grep for "graft" in the
Documentation directory.)

And then use git-filter-branch to rewrite history so that the grafted
history becomes the real history.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
