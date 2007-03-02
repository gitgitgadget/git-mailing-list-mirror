From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Fri, 2 Mar 2007 17:21:36 +0100
Message-ID: <20070302162136.GA9593@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com> <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNAWA-0000Gx-Cj
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992580AbXCBQVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 11:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992582AbXCBQVr
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:21:47 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4947 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992580AbXCBQVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:21:46 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HNAVk-0002Wk-00; Fri, 02 Mar 2007 16:21:36 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41225>

On 2007-03-02 16:18:41 +0100, Johannes Schindelin wrote:

> On Fri, 2 Mar 2007, Bill Lear wrote:
>
> > On Friday, March 2, 2007 at 10:14:26 (+0100) Karl Hasselstr=F6m
> > writes:
>
> > > Of course, the proper fix is to use a make-like tool that uses
> > > content hashes as well as timestamps to decide if a file has
> > > been updated ...
> >
> > I like this idea...
>
> I don't like it at all. The proper fix is to _not_ change the
> contents of the current working directory, if you don't want to
> change them to begin with.

Well, in a sense, yes. Not overwriting the current state when all you
want to do is peek at some other state is obviously the better fix of
the two.

However, given that your file timestamps have been bumped (without
file content changes), it's a performance bug in your make tool if
this causes it to needlessly rebuild half the known universe. (Fixing
the bug by using content hashes to detect changes may or may not be a
good trade-off, depending on your workflow.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
