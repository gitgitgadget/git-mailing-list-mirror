From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Tue, 27 Jun 2006 01:20:41 +0200
Message-ID: <200606270120.42031.jnareb@gmail.com>
References: <20060622220201.19132.67536.stgit@machine.or.cz> <e7g079$8qt$1@sea.gmane.org> <20060623124539.GM21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jun 27 01:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0OH-0003Nv-UJ
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbWFZXUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Jun 2006 19:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933252AbWFZXUx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:20:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:14760 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933256AbWFZXUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 19:20:41 -0400
Received: by nf-out-0910.google.com with SMTP id m19so653040nfc
        for <git@vger.kernel.org>; Mon, 26 Jun 2006 16:20:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZXZMndSkaMR/poW6kQtfNBlHi0IVccokO1SUBtNkGdBueCXXL+2M9LPreN1bBN67VgrUwS/R9g7gntNHKnG2hhzKbqh4cxox01HcdlPR9jzWV3lnqIra4CJ8FDnFbSAQgq6ApTYatKSTWKu7n3DW/A32WeIAf/tcFt+dV53icmU=
Received: by 10.48.163.7 with SMTP id l7mr5128364nfe;
        Mon, 26 Jun 2006 16:20:40 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id m15sm2011518nfc.2006.06.26.16.20.38;
        Mon, 26 Jun 2006 16:20:39 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20060623124539.GM21864@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22694>

Dnia pi=B1tek 23. czerwca 2006 14:45, napisa=B3e=B6:
> Dear diary, on Fri, Jun 23, 2006 at 08:03:23AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Perhaps Git.pm should provide also generic, pure Perl (and slower)
>> fallback implementation (when for some reason we cannot compile XS).
>=20
> I fiercely want to avoid this if there is any other possible way to g=
o
> about it - this is a path to hell of massive code duplication and
> additional work, as the number of routines will grow. If it is questi=
on
> of spending many developer-hours uselessly duplicating code in a way
> that'll be much slower than possible anyway OR building with -fPIC...=
 ;-)

I have thought about reimplementing only the parts which are in XS. In =
C
one would probably write

#if can_asm
 asm (...)
#else
 /* C code equivalent */
#endif

In addition to allowing use of Git.pm for people who cannot compile=20
Git.xs, it would be helpful I guess in Git.pm development.

--=20
Jakub Narebski
Poland
