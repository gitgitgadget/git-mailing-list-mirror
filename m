From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] Re: Using VC build git (split patch)
Date: Sun, 30 Aug 2009 22:16:15 +0200
Message-ID: <40aa078e0908301316m68258630oe84c0e9b6191332b@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <4A899FDB.8080308@gmail.com>
	 <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
	 <a4c8a6d00908301236l4394a471vb83ed2befda3a91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhqp5-0006eD-Ft
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbZH3UQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZH3UQP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:16:15 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:52231 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbZH3UQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 16:16:14 -0400
Received: by qw-out-2122.google.com with SMTP id 8so913750qwh.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XxvHW4g+Zur6fTljLb0KudJS0Pp53F61nJHyZ/eV/Ck=;
        b=Nvuv2ydCZawm6XEPpzoM3v6igYoPJG03EIfF7sPnz9yMxiG72LtLe3qb7CgkskqFaN
         /FAvW/S5RHV1TplhyQu3Kg0iMUPDZIri+rN4iIgmGTh11R4dTC91ioK2f2U0xp75I137
         1k8AB5vIGNDOCiEYg9HPRrCPWrn2wuJe8S6GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xCZYtKVW12+MVF90+t8wGy1DQfMs8YSZ5sd714M8Yp++m9pa2jKkzHxm7uIDMo8wWP
         dXmdc1oNTXW+aH+SwxH2kihqF0M8J750UjWoRpNnb/drZKK5t+VsQFSAyVRujb/cLLmR
         pjpjXbRXooyfaKj5BCa9UmJ8C0Y0lkfJoaVS0=
Received: by 10.224.36.140 with SMTP id t12mr2849709qad.339.1251663375952; 
	Sun, 30 Aug 2009 13:16:15 -0700 (PDT)
In-Reply-To: <a4c8a6d00908301236l4394a471vb83ed2befda3a91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127428>

On Sun, Aug 30, 2009 at 9:36 PM, Thiago Farina<tfransosi@gmail.com> wro=
te:
> Error =A0 2635 =A0 =A0error LNK2019: unresolved external symbol _sock=
etpair
> referenced in function _imap_open_store imap-send.obj =A0 imap-send
>
> Anyone faced this problem before?

Yes. imap-send isn't supported on windows, since it uses
posix-functions that aren't available in msvcrt. The Makefile system
excludes it for MinGW-builds. Is it added to the vcproj-files?

Any patches that adds a working socketpair()-function (or even better,
IMO: rewrite the code so socketpair isn't needed) would of course be
very welcome. I'd love to have a working imap-send on windows :)

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
