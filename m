From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Tue, 31 Mar 2009 08:45:23 +0200
Message-ID: <200903310845.23674.chriscool@tuxfamily.org>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <200903300526.12978.chriscool@tuxfamily.org> <alpine.DEB.1.00.0903300951460.7534@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 08:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoXlc-0004WZ-FU
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 08:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725AbZCaGq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 02:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZCaGq3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 02:46:29 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:59022 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbZCaGq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 02:46:28 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id D01AA4B006B;
	Tue, 31 Mar 2009 08:46:19 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id E8FB44B0015;
	Tue, 31 Mar 2009 08:46:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903300951460.7534@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115226>

Hi,

Le lundi 30 mars 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 30 Mar 2009, Christian Couder wrote:
> > Le jeudi 26 mars 2009, Junio C Hamano a =E9crit :
> > >
> > > I've learned to suspect without reading a qsort() callback that d=
oes
> > > not derefence its arguments.  Is this doing the right thing?
> >
> > I think so.
>
> I suspect something much worse: you are trying to build a list of sha=
1s
> of commits that need to be skipped, later to look up every commit via
> binary search.
>
> But it has been proven a lot of times that using a hash set is superi=
or
> to that approach, and even better: we already have the framework in p=
lace
> in the form of struct decorate.

I had a look, and "struct decorate" can be used to store objects, but I=
 want=20
to store only sha1s.

Regards,
Christian.
