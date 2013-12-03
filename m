From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 3 Dec 2013 19:33:01 +0100
Message-ID: <20131203183301.GB4629@sandbox-ub>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de>
 <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
 <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
 <xmqqzjopsk9b.fsf@gitster.dls.corp.google.com>
 <20131129223845.GA31636@sandbox-ub>
 <3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnuoq-0005Jo-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335Ab3LCSfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 13:35:32 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:41305 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3LCSf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:35:26 -0500
Received: from [77.20.33.19] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VnumO-0006Zi-32; Tue, 03 Dec 2013 19:35:21 +0100
Content-Disposition: inline
In-Reply-To: <3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238710>

Hi,

On Mon, Dec 02, 2013 at 03:55:36PM -0800, Nick Townsend wrote:
>=20
> On 29 Nov 2013, at 14:38, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > FYI, I already started to implement this lookup of submodule paths =
early
> > this year[1] but have not found the time to proceed on that yet. I =
am
> > planning to continue on that topic soonish. We need it to implement=
 a
> > correct recursive fetch with clone on-demand as a basis for the fut=
ure
> > recursive checkout.
> >=20
> > During the work on this I hit too many open questions. Thats why I =
am
> > currently working on a complete plan[2] so we can discuss and defin=
e how
> > this needs to be implemented. It is an asciidoc document which I wi=
ll
> > send out once I am finished with it.
> >=20
> > Cheers Heiko
> >=20
> > [1] http://article.gmane.org/gmane.comp.version-control.git/217020
> > [2] https://github.com/hvoigt/git/wiki/submodule-fetch-config
>=20
> It seems to me that the question that you are trying to solve is
> more complex than the problem I faced in git-archive, where we have a
> single commit of the top-level repository that we are chasing.=20
> Perhaps we should split the work into two pieces:
>=20
> a. Identifying the complete submodule configuration for a single comm=
it, and
> b. the complexity of behaviour when fetching and cloning recursively =
(which=20
>     of course requires a.)

You are right the latter (b) is a separate topic. So how about I extrac=
t the
submodule config parsing part from the mentioned patch and you can then
use that patch as a basis for your work? As far as I understand you onl=
y
need to parse the .gitmodules file for one commit and then lookup the
submodule names from paths right? That would simplify matters and we ca=
n
postpone the caching of multiple commits for the time when I continue o=
n b.

> I=E2=80=99m very happy to work on the first, but the second seems to =
me to require more
> understanding than I currently possess. In order to do this it would =
help to have a
> place to discuss this. I see you have used the wiki of your fork of g=
it on GitHub.
> Is that the right place to solicit input?

I only used that to collect all information into one place. I am not
sure if thats actually necessary for the .gitmodules parsing you need.

I think we should discuss everything related to the design and patches
here on the list. If you have questions regarding my code I am also
happy to answer that via private mail.

Cheers Heiko
