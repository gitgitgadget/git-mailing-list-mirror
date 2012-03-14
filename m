From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Auto-matching upstream branches by name
Date: Wed, 14 Mar 2012 10:10:52 +0100
Message-ID: <vpq8vj3zgwz.fsf@bauges.imag.fr>
References: <1kgwl7x.5pilu08h6t2eM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com (Junio C Hamano), peff@peff.net (Jeff King),
	marcnarc@xiplink.com (Marc Branchaud),
	mhagger@alum.mit.edu (Michael Haggerty),
	cmn@elego.de (Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto),
	git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Wed Mar 14 10:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7kF3-00067i-TF
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 10:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab2CNJL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 05:11:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37588 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932446Ab2CNJL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 05:11:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2E96RMB010381
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 10:06:28 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7kEP-0002lj-If; Wed, 14 Mar 2012 10:10:53 +0100
In-Reply-To: <1kgwl7x.5pilu08h6t2eM%lists@haller-berlin.de> (Stefan Haller's
	message of "Tue, 13 Mar 2012 21:01:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Mar 2012 10:06:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2E96RMB010381
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332320791.03084@gFpEklf+U9XrqsZRRrG0kQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193091>

lists@haller-berlin.de (Stefan Haller) writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> Actually, I'm starting to wonder if the whole "upstream" thing should
>> not be deactivated by default, and replaced with a simpler mechanism
>> like "pull.default", similar to what "push.default" does today. Then,
>> users could set "pull.default=current", and "git pull" would pull a
>> branch with the same name remotely. Or users could set
>> "pull.default=upstream" and get what Git does today.
>
> Yes, this is pretty similar to what I had in mind, in the last paragraph
> of this message:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

Indeed, yes.

> But it's not just about pull versus push. If you make them both work
> with same-name branches automatically, you still need to make "status"
> and "branch -vv" aware of that too, so that they can report whether you
> are ahead or behind your, well, "upstream".  "git log @{u}" would be
> nice as well in this mode.
>
> So I think that "pull.default" is not the best option to use for this;
> maybe something like "branch.automatchupstreambyname" or some such.

I'd call that 'upstream.default' actually.

> (It's really a separate discussion from the push.default question
> though, so I'm changing the subject.)

Separate, but related. If Git had this behavior as default, I'd
recommend 'current' without hesitation. I'm starting to be convinced
that the whole 'upstream' stuff is confusing for non-expert, but it is
for pull as much as it is for push.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
