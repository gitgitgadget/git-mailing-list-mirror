From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 19:04:23 +0400
Message-ID: <20070329150423.GD16739@hermes>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290745n63eca3acn3b8dd271194c20fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwAv-0002Jt-Ei
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbXC2PEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Mar 2007 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbXC2PEN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:04:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57605 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbXC2PEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:04:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so535712uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 08:04:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=SqwdWk2iFB2s92+HVZEGKG+w12Tgq9M9Am1c6Mvtyt0Beyi6mSuUYTPSIhDaGs/AkB9x+ccnP5iDidIakEyL8+Pcu68sINDATCbP4cag2ybJ6teuSVyfWkwNN5pti5oYgCq10YuftphSuVdT7gVPR29xZHa7iaACFgmzqdBYOIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=k3XbRVlTYNUe0XGeox3CWD0GHi2mePutTu1TfA8DYJqrKjqjoC7edu1bxQjOM5yphe9kydysSneSqjIxNezSQi41alb1J+vnyVK44Lyhu/fuRFE5fmde8xa6JG8ziWePjGbztdKB6DqRkroHMU0kSlcLAKEifhj+GRZHrRGyaqU=
Received: by 10.67.19.17 with SMTP id w17mr1502700ugi.1175180650485;
        Thu, 29 Mar 2007 08:04:10 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id o24sm2189855ugd.2007.03.29.08.04.09;
        Thu, 29 Mar 2007 08:04:09 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 19:04:24 +0400 (MSD)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0703290745n63eca3acn3b8dd271194c20fe@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43439>

On Thu, Mar 29, 2007 at 04:45:30PM +0200, Alex Riesen wrote:
> On 3/29/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >
> >Rename conflict... Will see, if I can reproduce it without your repo=
=2E
> >In the mean time, how about
> >

This is no x86_64.
>=20
> Yes, how about -O0 -ggdb stack trace?

#0  0x00002ac9f9029cc2 in memcmp () from /System/Links/Libraries/libc.s=
o.6
#1  0x0000000000402fbc in hashcmp (sha1=3D0x4 <Address 0x4 out of bound=
s>,
    sha2=3D0x570cdc "=EF=BF=BD6Cq=EF=BF=BD\234=EF=BF=BDw:0T=EF=BF=BD=EF=
=BF=BD\177=EF=BF=BD\023p\214Q,") at cache.h:260
#2  0x0000000000402f84 in sha_eq (a=3D0x4 <Address 0x4 out of bounds>, =
b=3D0x570cdc "=EF=BF=BD6Cq=EF=BF=BD\234=EF=BF=BDw:0T=EF=BF=BD=EF=BF=BD\=
177=EF=BF=BD\023p\214Q,")
    at merge-recursive.c:53
#3  0x0000000000405eda in merge_trees (head=3D0x570cb0, merge=3D0x570cd=
8, common=3D0x0, branch1=3D0x7fffb1f6427b "HEAD",
    branch2=3D0x7fffb1f64e6d "merge", result=3D0x7fffb1f63ce8) at merge=
-recursive.c:1115
#4  0x000000000040635f in merge (h1=3D0x560ca0, h2=3D0x560d20, branch1=3D=
0x7fffb1f6427b "HEAD",
    branch2=3D0x7fffb1f64e6d "merge", ca=3D0x55f590, result=3D0x7fffb1f=
63d70) at merge-recursive.c:1249
#5  0x0000000000406826 in main (argc=3D6, argv=3D0x7fffb1f63e88) at mer=
ge-recursive.c:1362
