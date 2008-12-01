From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: A better approach to diffing and merging
Date: Mon, 1 Dec 2008 10:54:49 +0100
Message-ID: <20081201095449.GA30857@diana.vm.bytemark.co.uk>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com> <4931F2DC.CE9B1E35@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Clarke <ian.clarke@gmail.com>, git@vger.kernel.org
To: Brian Dessent <brian@dessent.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L75WA-0002EC-GX
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYLAJzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2008 04:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbYLAJzT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:55:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1977 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbYLAJzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:55:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L75UQ-0008NI-00; Mon, 01 Dec 2008 09:54:50 +0000
Content-Disposition: inline
In-Reply-To: <4931F2DC.CE9B1E35@dessent.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102013>

On 2008-11-29 17:56:44 -0800, Brian Dessent wrote:

> Ian Clarke wrote:
>
> > Provide the merge algorithm with the grammar of the programming
> > language, perhaps in the form of a Bison grammar file, or some
> > other standardized way to represent a grammar.
>
> There's a huge flaw in that approach for C/C++: in order to parse
> C/C++ you have to first preprocess it -- consider the twisty mazes
> that #ifdef/#else/#endif can create. But in order to preprocess
> source code you need a whole heap of extra information that is not
> in the repository (or if it is, cannot be automatically extracted.)

But it's probably not necessary to parse the input files exactly. All
you have to do is parse it well enough that the diff of the parse
trees is interesting.

And in practice, you'd probably also generate the "normal" diff, and
then fall back to that one if the parse tree diff was worse.

> The idea may have value for langauges that are easy to parse and do
> not have all this preprocessor cruft, but I just don't see how it
> would be able to provide anything useful for non-trivial changes to
> real world C/C++, which require human eyes to decipher.

I think it could work. But there would be quite a bit of heuristics
involved to get the "approximate" parsing right, so I'm pretty sure
there's no way to find out without actually trying to build the thing.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
