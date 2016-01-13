From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase can be 'interactive'
Date: Wed, 13 Jan 2016 13:24:01 +0100
Message-ID: <vpqziw9oefy.fsf@anie.imag.fr>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
	<vpq7fjdyfvu.fsf@anie.imag.fr>
	<alpine.DEB.2.20.1601131302340.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:27:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKWI-0007Xl-54
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbcAMM1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:27:18 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58946 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474AbcAMM1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:27:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u0DCNwsZ027889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Jan 2016 13:23:58 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0DCO1o4013517;
	Wed, 13 Jan 2016 13:24:01 +0100
In-Reply-To: <alpine.DEB.2.20.1601131302340.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jan 2016 13:03:57 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jan 2016 13:23:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0DCNwsZ027889
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453292640.90669@j3nREpPlIwUXq3ObRfhvkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283908>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Matthieu,
>
> On Wed, 13 Jan 2016, Matthieu Moy wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>> What happens if one has branch.*.rebase=interactive, and wants to make
>> an exception? Does
>> 
>>   git pull --rebase=true
>> 
>> cancel the 'interactive' part?
>
> It is the same situation as before (just substitute a
> branch.*.rebase=preserve setting): yes, the config is parsed first, then
> the command line, so the command line wins.
>
>> I guess it is, but if so I think it should be tested and documented.
>
> Is this really necessary, given that the behavior has not changed from
> before?

Well, before your patch, branch.*.rebase=interactive was not possible.
It is not immediately clear to me that --rebase=true can mean "do the
pull with rebasing, but without going interactive", as "do pull with
rebase" and "rebase interactively" could be two independant things.
Reading the current doc does not help much: "When true, rebase the
current branch on top of the upstream branch after fetching" => it does
not say that "true" also specifies which kind of rebase is performed.

Actually, I was about to suggest having --rebase=non-interactive when I
realized it was already there with the syntax --rebase=true.

I can live without it, but I think a documentation improvement would
make things clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
