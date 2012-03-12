From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 17:37:32 +0100
Message-ID: <vpqzkblixmb.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart?= =?iso-8859-1?Q?=EDn?= Nieto 
	<cmn@elego.de>, git@vger.kernel.org, gitster@pobox.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S78GC-0003uL-6A
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab2CLQiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:38:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45652 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2CLQiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:38:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2CGXCtD024435
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 17:33:12 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S78FZ-0006NP-0z; Mon, 12 Mar 2012 17:37:33 +0100
In-Reply-To: <4F5E12A5.6030701@xiplink.com> (Marc Branchaud's message of "Mon,
	12 Mar 2012 11:13:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Mar 2012 17:33:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2CGXCtD024435
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332174796.56387@cZQ0bZmhgnAibI9d78icdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192902>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-03-10 01:16 AM, Michael Haggerty wrote:
>> 
>> I propose that the default should be even stricter: like "current", it
>> would push to an branch with the same name as the current local branch,
>> *but only if that branch already exists on the remote*.  It would only
>> be possible to create a new branch on the remote by calling "git push"
>> with an explicit branch argument.  I believe that such a policy would do
>> the right thing in the cases where the "right thing" is pretty
>> unambiguous, and would require a user decision in other cases.
>
> I haven't thought it through very deeply, but at first glance this seems like
> reasonable default behaviour to me.

I do find it reasonable, but I think 'upstream' has several advantages
over it.

* 'upstream' makes "git push" and "git pull" symmetrical. While there
  are workflows where it is usefull to have "push" and "pull" point to
  different branches, I think it is far more intuitive to have this
  symmetry by default.

* For newbies, the sequence "create an empty repository, clone it,
  commit and push" works like a charm with either 'upstream' or
  'current'. Today, the first push to an empty repository requires
  either saying "git push origin master" or "git push --all", both of
  which sound like black magic to the poor user who did not yet learn
  what 'origin' is and what a branch is.

* 'upstream' makes it easy to create a local topic branch, and let
  'push' send it to the master branch (i.e. have local 'topic-branch'
  pull and push to 'origin/master'). In general, 'upstream' allows
  workflows where you push to branches with either a different name or
  with the same name (by setting the upstream appropriately), but the
  opposite is not true.

That being said, I think the mode you Michael described at least
deserves to exist, even if I disagree that it would be the best default.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
