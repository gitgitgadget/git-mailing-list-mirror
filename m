From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about about a trivial merge conflict that git should
 resolve alone
Date: Fri, 23 Oct 2015 16:52:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510231651270.31610@s15462909.onlinehome-server.info>
References: <CAC9WiBj7Vwfjzbik7+d9cxpS=m+_s-CViJ3b4fKAzYQ4ixXfiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 16:53:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpdiN-0004T0-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 16:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbbJWOxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 10:53:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:61462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbbJWOxB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 10:53:01 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0LyzW8-1ac9k13q9A-014Ekq;
 Fri, 23 Oct 2015 16:52:57 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAC9WiBj7Vwfjzbik7+d9cxpS=m+_s-CViJ3b4fKAzYQ4ixXfiw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:knAx0PUacvGwVPkr6/q8hSLGtFfzcEGKLhWdQqpMAz0D/VCndWH
 J1S8wmaJoA3DESakP/wDzl5zzCsHFSYqKNhmZ9gbsPguwRDy7s3UNeIS89kHgVMqyjM7d8G
 M2sbfDsva9fjpEhXXQElbNX2UlVioHmrGHAYObwJNBiMbLBydJ6ec9QJ2wWaNmttzAlmfv3
 cHUwvunirYVr57m+ZCQ1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YAF5ZDeJlEM=:v75T8IAkJRWDiWG+YQVXbD
 TuJVrlt8aTePaZKgMqR95pNCAex9gelSnWV6bKLVx2s2DHmAI9rktMYi55M+bUEPhSeiS2NEK
 OyeLxxpVJm9SGIsfcHh89P6y1fRpom6x0ffclbTEX0q0GYIKUc8wL94MRcE+AOCWF1sQAvV1a
 SCAtqQE4d4O16Q9mHClEkXeqwCyNG2aUIbCIBANY7i5JUVY/QeHDtc2MsbHMnPi6BaOmStOvx
 CfwjdUw3J7wZ3dpkq99wSqcZNyluYc2991lFccYSAsZMZ9fqFp8asWp5tMRYsYjeqqJcQZ9in
 nhkwoi1+FU6k6tzS+1piLgdwjUnpFx3CTjxOQquo2OtyobUDSXh3dSf0H+2u5Nl++IPJdpHI+
 9JLehrVlvit9jYNdA0ElFZaRxSTjY+1Zu50PMcuOi+TMnesf+s5FDWJTGdyA3Wx5ItTlYCEho
 pCXyOq2TsncExagY6RQI6Ml2b3QvXiZJJhEuoBaMB5Vwvelz3ymtE5zOfWedYmTVby3zrZcGB
 MaQFlHH0NS/K4bmXlZLcf9X9LRdSU7M31A8A+E+7dIhGTd/E6mU7V2SHsJIkkYRmQarfP/8gY
 W8Xaa7QQy5devzh+PBFIfGCbNCs6fFZQdIV+0UHHrWIbJwvKMJr0W1kdCHOFoSfkhOfkkjw38
 24Z225fN7pFiaKxzh1qck6U0Rv/mbC0PAQgNKlLoQnob85bIBIzUFHAa4pbPakV/pJBgOe8ZN
 Q4JikSRnBVf47KENpmGjkQjXVN2kqIgYiaLp/LvShaJsemvF+Wn9NsRFXY+ertRdo71P0Wnv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280097>

Hi Francis,

On Fri, 23 Oct 2015, Francis Moreau wrote:

> I have a simple merge conflict use case:
> 
> $ mkdir foo
> $ cd foo/
> $ git init
> $ echo line1 > a
> $ git add .
> $ git commit -q -m init
> $ echo line2 >>a
> $ git commit -a -q -m "add line2"
> $ git checkout -b foo HEAD~1
> $ git cherry-pick -x master
> $ echo line3 >>a
> $ git stage a
> $ git commit -q -m "add line3"
> $ git checkout master
> $ git merge foo
> $ git diff
> diff --cc a
> index c0d0fb4,83db48f..0000000
> --- a/a
> +++ b/a
> @@@ -1,2 -1,3 +1,6 @@@
> line1
> line2
> ++<<<<<<< HEAD
> ++=======
> + line3
> ++>>>>>>> foo
> 
> Why does git think there's a conflict here since the "line2" string
> was added in both branch by the same commit ?

This is intentional, because what actually happens is that Git figures out
that line2 & line3 were added in one branch, but only line2 in the other,
and it helpfully reduces the conflict to the difference between the two.

The rationale is that you do not know which version is correct: was line2
sufficient, or do you really also need line3?

Ciao,
Johannes
