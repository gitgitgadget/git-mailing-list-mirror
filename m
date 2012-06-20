From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: start warning upcoming default change for push.default
Date: Wed, 20 Jun 2012 20:24:19 +0200
Message-ID: <vpqpq8t96zw.fsf@bauges.imag.fr>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
	<1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehp9x3yz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPbB-0004mY-S5
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab2FTSZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:25:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39610 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932632Ab2FTSZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:25:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5KIO1kU019546
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2012 20:24:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ShPZk-0005rW-7M; Wed, 20 Jun 2012 20:24:20 +0200
In-Reply-To: <7vehp9x3yz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 10:55:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 20 Jun 2012 20:24:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5KIO1kU019546
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340821442.63058@USRnBvak+riYJgWFTn6c7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200314>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure who this wants to help.

The target is for people who may use different versions of Git (e.g.
several installed git on the same machine, several machine, or worse,
several machines with a shared $HOME/.gitconfig). This includes me.

For these people, setting push.default=simple is basically impossible
since Git errors out when encountering such setting (it's not ignored,
it really makes Git die).

> For people who want to anticipate the future, using anything but
> 'simple' is not living in the future and waiting for an additional
> pain coming from the differences between current and simple. If
> current and simple are similar enough that their differences do not
> matter, why wait for simple to be available everywhere and switch the
> default to it, instead of using current as the default in the first
> place?

'simple' is an improvement over 'current' as a default, especially for
beginners, but 'current' is already reasonably good.

So, the long term goal is really to switch to 'simple', but people who
use different versions of Git won't be able to use it before a few
years. These people have several options:

1) Keep push.default unset. This is not acceptable because they don't
   want the big fat warning each time they push.

2) Set push.default to 'matching', to keep the old behavior and squelsh
   the warning. If they go this way, they will never see the default
   change.

3) Set push.default to 'current', in which case they have the same
   behavior as 'simple', except for the safety feature of 'simple'
   (refuse to push when the name doesn't match the upstream). They can't
   expect anything better anyway since they are sometimes using a
   machine which doesn't support 'simple' anyway.

To me, option 3) clearly seems to be the best option. I don't understand
whether you would advise 1), 2), or maybe a 4) that I would have missed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
