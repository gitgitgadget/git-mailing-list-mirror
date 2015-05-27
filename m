From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Wed, 27 May 2015 13:38:22 +0200
Message-ID: <vpqy4ka5jyp.fsf@anie.imag.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<loom.20150527T105315-517@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 13:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxZfL-0006W6-EL
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 13:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbE0Li1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 07:38:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39432 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbbE0Li0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 07:38:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4RBcLfE016393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2015 13:38:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4RBcMar016280;
	Wed, 27 May 2015 13:38:22 +0200
In-Reply-To: <loom.20150527T105315-517@post.gmane.org> (Stephen Kelly's
	message of "Wed, 27 May 2015 08:54:55 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 May 2015 13:38:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4RBcLfE016393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433331501.87674@ANczdrKCvTAMeUsJBRCu7g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270041>

Stephen Kelly <steveire@gmail.com> writes:

> Galan R=E9mi <remi.galan-alfonso <at> ensimag.grenoble-inp.fr> writes=
:
>
>>=20
>> Check if commits were removed (i.e. a line was deleted) or dupplicat=
ed
>> (e.g. the same commit is picked twice), can print warnings or abort
>> git rebase according to the value of the configuration variable
>> rebase.checkLevel.
>
> I sometimes duplicate commits deliberately if I want to split a commi=
t in
> two. I move a copy up and fix the conflict, and I know that I'll stil=
l get
> the right thing later even if I make a mistake with the conflict
> resolution.

The more I think about it, the more I think we should either not warn a=
t
all on duplicate commits, or have a separate config variable.

It's rare to duplicate by mistake, and when you do so, it's already eas=
y
to notice: you get conflicts, and you can git rebase --skip the second
occurence. Accidentally dropped commits are another story: it's rather
easy to cut-and-forget-to-paste, and the consequence currently is silen=
t
data loss ...

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
