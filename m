From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 13:33:48 +0100
Message-ID: <20070305123348.GB3481@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070302162136.GA9593@diana.vm.bytemark.co.uk> <200703051213.52513.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 13:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOCO3-0005NS-Cm
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 13:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbXCEMdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 07:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXCEMdw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 07:33:52 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4561 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbXCEMdv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 07:33:51 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HOCNw-0000wa-00; Mon, 05 Mar 2007 12:33:48 +0000
Content-Disposition: inline
In-Reply-To: <200703051213.52513.andyparkins@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41441>

On 2007-03-05 12:13:50 +0000, Andy Parkins wrote:

> On Friday 2007 March 02 16:21, Karl Hasselstr=F6m wrote:
>
> > However, given that your file timestamps have been bumped (without
> > file content changes), it's a performance bug in your make tool if
>
> Actually, git is as good as it could reasonably get in this regard.

I know.

> Let's say you did this:
>
>  git checkout branch1
>  git checkout branch2
>  git checkout branch1
>
> Git will only touch the timestamps of files that are different
> between the branches.

Yes.

> The fact that you've changed back from branch2 to branch1 is the
> bone of contention - how is git meant to know that you haven't done
> a compilation while you were on branch2 and hence changed the files
> that untracked files depend on? The /only/ sane thing it can do is,
> in both cases, update changed files to have the current time.

Yes, that's the only sane thing.

My point isn't that _git_ should know that I haven't compiled stuff.
My point is that my make tool should realize that even though the
file's timestamp has changed since last rebuild, the contents haven't
changed (or, to be precise, they're identical to what they were), and
so there's no need to rebuild.

Now, obviously "make" isn't such a make tool, since it goes only by
timestamps.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
