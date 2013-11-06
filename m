From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Wed, 06 Nov 2013 22:49:30 +0100
Message-ID: <vpq1u2tb3px.fsf@anie.imag.fr>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 22:50:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeAzI-0004RY-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 22:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab3KFVuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 16:50:01 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36298 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662Ab3KFVuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 16:50:00 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rA6LnZbv021243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Nov 2013 22:49:35 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rA6LnVGl031311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 6 Nov 2013 22:49:37 +0100
In-Reply-To: <xmqqk3gl8id0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Nov 2013 11:01:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Nov 2013 22:49:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rA6LnZbv021243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1384379379.88839@hSXbBgBT9U9UFW7IP58N6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237372>

Junio C Hamano <gitster@pobox.com> writes:

> That is true, but does it justify giving a misleading information in
> the advice message?

Clearly, yes. Trying to be exhaustive here is not a good idea, we'd end
up rewritting the man page, and then users won't read the message
because it's too long.

> Specifically:
>
>>> +   "When push.default is set to 'matching', git will push all local branches\n"
>>> +   "to the remote branches with the same (matching) name.
>
> invites those who do not read documentation to mistake it with using
> an explicit "refs/heads/*:refs/heads/*" refspec.

Yes, but those who want to know the exact behavior should read the doc.
That's life.

>>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>>> +   "branch to the same remote branch used by git pull.   A push will\n"
>>> +   "only succeed if the remote and local branches have the same name.\n"
>
> while you can see that it is not telling a lie if you read it twice,
> "will only succeed if" feels somewhat roundabout.
>
> 	... push only the current branch back to the branch of the
> 	same name, but only if 'git pull' is set to pull from that
> 	branch. Otherwise the push will fail.
>
> might be an improvement, but I dunno.

I do not see much difference actually. I tend to prefer the original
version: to me the expected behavior is to make push and pull
essentially symetrical, and the fact that it fails if the branch is
named differently is a safety feature comming on top of that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
