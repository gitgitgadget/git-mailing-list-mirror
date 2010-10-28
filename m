From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: svn repository URL and git
Date: Thu, 28 Oct 2010 21:31:18 +0200
Message-ID: <4CC9CF86.7040307@debugon.org>
References: <loom.20101027T170254-268@post.gmane.org> <4CC845EE.5040602@debugon.org> <loom.20101027T180316-38@post.gmane.org> <loom.20101028T184823-831@post.gmane.org> <20101028190227.GC46314@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: H Krishnan <hetchkay@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ulrich_Sp=F6rlein?= <uqs@spoerlein.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYCE-0008Ix-01
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab0J1Tb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 15:31:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53763 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab0J1Tb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:31:28 -0400
Received: from [192.168.2.7] (p54B972C0.dip.t-dialin.net [84.185.114.192])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MUClm-1P3GUC1m2k-00QUGS; Thu, 28 Oct 2010 21:31:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.14) Gecko/20101006 Thunderbird/3.0.9
In-Reply-To: <20101028190227.GC46314@acme.spoerlein.net>
X-Provags-ID: V02:K0:pDboHSpJbWCGjIdLpLl9hMss+oI+/Fr2Jg60+vLObgQ
 9dQiccNnQd7GQjKfZXIv7GyBOZLJTtQRQkApAgfXpQaKdA6wAC
 DPmiyFPBgeEcx9b9x+rLK2avVfJWIW372b4aXONs5sukJWMZ+/
 Ph6bUi9OEakdM8VzuHzCwdK48Wr+XLvshJAsGYWw9qbH/LTrql
 f5ckmNzlxbX2axFmGyVl9I1gKKHiwcQKqWSwV+H/mQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160213>

On 10/28/2010 09:02 PM, Ulrich Sp=F6rlein wrote:
> On Thu, 28.10.2010 at 16:58:28 +0000, H Krishnan wrote:
>>
>> Hi,
>> I think I resolved this problem by using --rewrite-root as suggested=
=2E I used a=20
>> dummy root during the git-svn clone:
>>
>> git-svn clone --rewrite-root http://git.is.great <myrepo>
>>
>> All my commit messages now have http://git.is.great but I am able to=
 change the=20
>> repository URL and continue.
>>
>> Could this approach be used as an insurance against svn url changes?=
 When=20
>> initializing the repository, we could use --rewrite-root. Subsequent=
ly, if the=20
>> svn repository relocates, we need to edit only .git/config.=20
>=20
> Yes, that's exactly what the rewrite-url was introduced for, you can
> even clone from a local svnsync mirror (iff the UUID matches, you hav=
e
> to setup the mirror in a special way ...).
>=20
> So, every developer must use:
>=20
> $ git svn clone --rewrite-root CANONICAL-URL-NEVER-TO-CHANGE <whateve=
r-url-is-convenient>
>=20
> Oh, and all devs must use the same authormap (or no authormap at all)=
=2E
>=20
> hth,
> Uli

=46YI, I just learned [1] that git-svn even has a --rewrite-uuid option=
=2E

[1] http://www.kernel.org/pub/software/scm/git/docs/git-svn.html

-Mathias
