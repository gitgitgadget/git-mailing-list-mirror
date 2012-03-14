From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward errors
Date: Wed, 14 Mar 2012 14:00:38 +0100
Message-ID: <vpqobrzgww9.fsf@bauges.imag.fr>
References: <20120313232256.GA49626@democracyinaction.org>
	<7vobrzst7n.fsf@alter.siamese.dyndns.org>
	<20120314121434.GB28595@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christopher Tiwald <christiwald@gmail.com>,
	git@vger.kernel.org, peff@peff.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Mar 14 14:02:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7nqI-00039h-HL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 14:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304Ab2CNNBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 09:01:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52910 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863Ab2CNNBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 09:01:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2ECuYhs006684
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 13:56:34 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7nol-0001LP-Fp; Wed, 14 Mar 2012 14:00:39 +0100
In-Reply-To: <20120314121434.GB28595@in.waw.pl> ("Zbigniew
	\=\?utf-8\?Q\?J\=C4\=99drzejewski-Szmek\=22's\?\= message of "Wed, 14 Mar 2012
 13:14:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Mar 2012 13:56:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2ECuYhs006684
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332334597.65222@dW6T8ZOJjNcHmQpQcMqArw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193103>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> I think that having three different config keys for the three
> different advices makes sense, because the advices will be displayed
> at different times.

I don't think it really makes sense to be such fine-grained. We already
have 6 different advices, so an advance user who do not want them need
to set these 6 variables. I think we want to keep this number relativel=
y
low.

The advice messages do not point explicitely to the way to disable them=
,
so users who know how to set advice.* are users who know a little about
configuration files, and who read the docs. Instead of having too
fine-grained configuration variables, we can have a better doc,
explaining shortly the 3 possible cases under advice.nonfastforward in
config.txt. The user who disable the advice can read the doc (I usually
think that "users don't read documentation" is a better assumption, but
since the user knows about the name of the variable, it is OK here).

Also, if I read correctly the patch, the old variable is left in the do=
c
and in advice.{c,h}, but is no longer used. This means old-timers who
have set it will see the message poping-up again after they upgrade,
which I think is inconveinient for them.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
