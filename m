From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] rev-list: remove last static vars used in "show_commit"
Date: Thu, 9 Apr 2009 05:11:08 +0200
Message-ID: <200904090511.08242.chriscool@tuxfamily.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org> <20090407040854.4338.40055.chriscool@tuxfamily.org> <49DC54DC.3060408@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrkib-00043L-Fl
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 05:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbZDIDMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 23:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbZDIDMU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 23:12:20 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:50948 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465AbZDIDMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 23:12:18 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 6CD054C8044;
	Thu,  9 Apr 2009 05:12:08 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 32E0D4C802F;
	Thu,  9 Apr 2009 05:12:06 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49DC54DC.3060408@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116137>

Le mercredi 8 avril 2009, Paolo Bonzini a =E9crit :
> >  	struct rev_info revs;
> > +	struct rev_list_info info;
> >  	int reaches =3D 0, all =3D 0;
> >
> > +	memset(&info, 0, sizeof(info));
> > +	info.revs =3D &revs;
>
> Would it make sense to embed the struct rev_info entirely in the new
> struct, without going through a pointer?

Perhaps, I will have a look.

The downside is that the struct rev_info may be initialized twice if we=
=20
still use "memset(&info, 0, sizeof(info))" as it is also initialized=20
in "init_revisions".

Thanks,
Christian.
