From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 08:23:23 +0100
Message-ID: <20070305072323.GA31169@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com> <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070302162136.GA9593@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO7Y4-0006w7-Re
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXCEHXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbXCEHXm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:23:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3941 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbXCEHXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:23:41 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HO7XX-0008Bt-00; Mon, 05 Mar 2007 07:23:23 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41404>

On 2007-03-02 20:21:17 +0100, Johannes Schindelin wrote:

> On Fri, 2 Mar 2007, Karl Hasselstr=F6m wrote:
>
> > However, given that your file timestamps have been bumped (without
> > file content changes),
>
> There were changes. Only that they have been taken back, but that is
> _another_ change.

Since the content is exactly the same as before, I'd be of the strong
opinion that nothing has changed as far as the make system should be
concerned. But this is getting off-topic, so I'll just agree to
disagree if you do. :-)

> > it's a performance bug in your make tool if this causes it to
> > needlessly rebuild half the known universe. (Fixing the bug by
> > using content hashes to detect changes may or may not be a good
> > trade-off, depending on your workflow.)
>
> Getting dependencies right is sometimes not very easy. I participate
> in projects which have _seriously_ broken dependencies. In these
> cases, I do a quick "touch source.c" to force a recompilation.
>
> You'd break this workaround.
>
> P.S.: yes, I know I could possibly find the object file and remove
> that, too. But finding the source is often easier.

Well, all you'd need is a way to tell the make system to flush its
caches for source.c (or some larger portion of the build, as
necessary). Such as "make-tool --flush-cache source.c".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
