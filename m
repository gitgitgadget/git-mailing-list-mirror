From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Thu, 2 Apr 2009 06:23:40 +0200
Message-ID: <200904020623.40908.chriscool@tuxfamily.org>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <200904010809.41110.chriscool@tuxfamily.org> <alpine.DEB.1.00.0904011631300.13502@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 06:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpEVM-0003US-4M
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZDBEYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 00:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbZDBEYq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:24:46 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:44578 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbZDBEYp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 00:24:45 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id DB0F44C806E;
	Thu,  2 Apr 2009 06:24:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id BB3EB4C8051;
	Thu,  2 Apr 2009 06:24:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0904011631300.13502@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115438>

Hi,

Le mercredi 1 avril 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Wed, 1 Apr 2009, Christian Couder wrote:
> > Le mardi 31 mars 2009, Johannes Schindelin a =E9crit :
> > > Hi,
> > >
> > > On Tue, 31 Mar 2009, Christian Couder wrote:
> > > > Le lundi 30 mars 2009, Johannes Schindelin a =E9crit :
> > > No, you want to _look up_ sha1s.  And struct decorate is not abou=
t
> > > storing objects, but to attach things to objects.
> >
> > The problem is that I don't have any object to attach things to whe=
n I
> > read the bisect skip refs. I just need to store the sha1 from the s=
kip
> > refs in some sha1 container.
>
> I see, so you do not want to parse the commits just to register them =
as
> skipped.
>
> Fair enough.
>
> But I still think that a hashmap/set would be better suited.
>
> In any case, it should be refactored into something usable in all of
> libgit.a.  You are basically duplicating the grafts code in commit.c,
> sharing that shortcoming that your code would be static again, not
> encouraging reusage.

I agree that binary search functions and related code should be refacto=
red.=20
That's why I added the "Refactor binary search functions" task to the=20
Janitor wiki page (http://git.or.cz/gitwiki/Janitor) a few weeks ago.

I will have a look at that, and perhaps, after that, I will try to make=
=20
things less static, but I think these are some old problems in the code=
=20
base, so new developments should not be hostage of them.

Best reagrds,
Christian.
