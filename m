From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 09 Aug 2006 14:56:36 +0200
Organization: At home
Message-ID: <ebcm1j$6gi$1@sea.gmane.org>
References: <200608091257.19461.jnareb@gmail.com> <7vu04m413f.fsf@assigned-by-dhcp.cox.net> <ebcivb$t6m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 09 14:57:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAncR-0002B1-Kv
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 14:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWHIM5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Aug 2006 08:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWHIM5D
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 08:57:03 -0400
Received: from main.gmane.org ([80.91.229.2]:33240 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750730AbWHIM5B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 08:57:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAnc5-000267-KX
	for git@vger.kernel.org; Wed, 09 Aug 2006 14:56:45 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 14:56:45 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 14:56:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25117>

Jakub Narebski wrote:

> I wonder which version is faster: --full-history, or filter using=20
> diff-tree?
>=20
> ab -n 10 "http://localhost/cgi-bin/gitweb/gitweb.cgi?p=3Dgit.git;a=3D=
history;hb=3Dnext;f=3Dgitweb/gitweb.perl"
> (ApacheBench, Version 2.0.41-dev <$Revision: 1.141 $> apache-2.0) say=
s
>=20
> =A0 Requests per second: =A0 =A00.09 [#/sec] (mean)
> =A0 Time per request: =A0 =A0 =A0 10918.552 [ms] (mean)
> =A0 Time per request: =A0 =A0 =A0 10918.552 [ms] (mean, across all co=
ncurrent requests)
> =A0 Transfer rate: =A0 =A0 =A0 =A0 =A02.13 [Kbytes/sec] received
>=20
> =A0 Connection Times (ms)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min =A0mean[+/-sd] median =A0 =A0 max
> =A0 Connect: =A0 =A0 =A0 =A00 =A0 =A00 =A0 =A0 0.0 =A0 =A0 =A00 =A0 =A0=
 =A0 0
> =A0 Processing: =A08851 10917 2776.1 =A0 9284 =A0 16420
> =A0 Waiting: =A0 =A0 =A0407 =A0457 =A0 =A095.1 =A0 =A0428 =A0 =A0 721
> =A0 Total: =A0 =A0 =A0 8851 10917 2776.1 =A0 9284 =A0 16420

Adding "--remove-empty" (would this change output for git_history much?=
)
changes this to:

  Requests per second:    0.75 [#/sec] (mean)
  Time per request:       1341.702 [ms] (mean)
  Time per request:       1341.702 [ms] (mean, across all concurrent re=
quests)
  Transfer rate:          17.37 [Kbytes/sec] received

  Connection Times (ms)
                min  mean[+/-sd] median   max
  Connect:        0    0   0.0      0       0
  Processing:  1208 1340 206.6   1241    1729
  Waiting:      386  408  36.6    403     510
  Total:       1208 1340 206.6   1241    1729

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
