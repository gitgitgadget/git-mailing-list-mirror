From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 10:41:19 +0200
Message-ID: <20080410084119.GA8979@diana.vm.bytemark.co.uk>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <32541b130804091008h1a757552o14dd8e937ed19058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:42:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsMf-0007bh-Qq
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYDJIly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 04:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYDJIly
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:41:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4248 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229AbYDJIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:41:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JjsLQ-0002gz-00; Thu, 10 Apr 2008 09:41:20 +0100
Content-Disposition: inline
In-Reply-To: <32541b130804091008h1a757552o14dd8e937ed19058@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79197>

On 2008-04-09 13:08:39 -0400, Avery Pennarun wrote:

> For example, in svn you can talk about
> svn+ssh://reposerver/path/to/repo/branches/foo@1234; it's a single
> "word" that refers to a particular revision on a particular branch
> of a particular server.

Heh, not really. Subversion actually makes this even more confusing
than git does.

The @rev is called a "peg revision", and is different from the
"operative revision" specified with the -r flag. The peg revision is
used in conjunction with a path to specify the file (or directory) you
want, and the operative revision is used to specify which revision of
that file you mean. (This complexity is needed because subversion has
a concept of file identity.)

So

  $ svn cp -r 4711 $REPO/foo@1234 somewhere-else

means "find the file (or directory) that was called 'foo' in revision
1234, then copy revision 4711 of that file to somewhere-else".

See http://svnbook.red-bean.com/en/1.4/svn.advanced.pegrevs.html for
the full story.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
