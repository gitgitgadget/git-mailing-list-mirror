From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 00:24:10 +0100
Message-ID: <200701170024.10640.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701162337.32759.jnareb@gmail.com> <Pine.LNX.4.63.0701162352400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 00:23:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xef-0005BB-5z
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 00:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXAPXXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXAPXXr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 18:23:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:28271 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbXAPXXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 18:23:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1833898uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 15:23:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ze8zohjgPLTr+aWnM4Pelt3FexILogPZgPTevhQ48/cqWSWrE0fkG8yl/Tb5zzNOxa9P1Jk4b1NAqsqSoQ2xoJ8rkH3ne8Gc1K3ODcn06sQ9mDeRTykuzQN0Kv7oaMkRP8Sq48dINqbajuvkpYJvWspQzOxUNgyHZwX7ioRRjLs=
Received: by 10.67.19.13 with SMTP id w13mr8487192ugi.1168989825065;
        Tue, 16 Jan 2007 15:23:45 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id l33sm7810601ugc.2007.01.16.15.23.44;
        Tue, 16 Jan 2007 15:23:44 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701162352400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36982>

Dnia wtorek 16. stycznia 2007 23:56, Johannes Schindelin napisa=B3:
>=20
> On Tue, 16 Jan 2007, Jakub Narebski wrote:

>> Well, the idea I had was to have --dump switch to git-repo-config to=
=20
>> dump init file as if it was created by git-repo-config invocations,=20
>> without any hand editing (canonical format).
>=20
> My point still stands: if you already parse the user-friendly format,=
 why=20
> not dump a parse friendly format? If it weren't for those darn non-al=
nums=20
> in the keys, out put of "git repo-config -l" would be perfectly=20
> acceptable.
>=20
> So, how about a "git repo-config --dump" which outputs a stream of NU=
L=20
> separated keys and values? This should be really easy to "parse", and=
=20
> there are no ambiguities: No key or value can contain a NUL.

Good idea, although "\n" would work as well as NUL.

The only problem is with "key without value" case, i.e. something like

  [section]
  	noval

which shows as

  section.noval

in "git repo-config -l" output (note missing '=3D' !), and I guess diff=
ers
for some case from

  [section]
  	noval =3D=20

--=20
Jakub Narebski
Poland
