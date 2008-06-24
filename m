From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Tue, 24 Jun 2008 07:12:04 +0200
Message-ID: <20080624051204.GA1760@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se> <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer> <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se> <alpine.DEB.1.00.0806201359320.6439@racer> <Pine.LNX.4.64.0806230732120.31319@ds9.cixit.se> <Pine.LNX.4.64.0806231543580.31319@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0qH-0006bY-TZ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYFXFM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 01:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYFXFM0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:12:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4749 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYFXFMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:12:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KB0p2-0000f7-00; Tue, 24 Jun 2008 06:12:04 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806231543580.31319@ds9.cixit.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85991>

On 2008-06-23 15:46:11 +0100, Peter Karlsson wrote:

> Peter Karlsson:
>
> > That might work. My problem is the non-linearity of the data I
> > want to import. But I might be able to massage the import-tars
> > output before I feed it to git-fast-import to describe the history
> > I need it to.
>
> I ended up making a script that converted a description file that
> described the hierarchy of versions and generated a fast-import file
> from it. Good to have so that I could move stuff around a bit to
> make up a version tree that looked somewhat reasonable (a lot of
> cross-directory copying has been going on here, and no-one knows
> which version is which).

A bit too late now, but ... another thing you could have done is make
a straight linear import =E0 la import-tars, and then modified the
parentage with grafts until it looked good; and then finally use
filter-branch to make the grafts part of the "real" history.

The advantage of this approach is that you can edit the parentage
almost interactively, which should be the best approach given that you
have a small number of commits and have to guess their relationships.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
