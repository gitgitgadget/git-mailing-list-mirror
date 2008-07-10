From: Andreas Ericsson <ae@op5.se>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 18:50:03 +0200
Message-ID: <48763DBB.3040708@op5.se>
References: <20080710075327.GD24819@artemis.madism.org> <4875C1CF.1010604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGzNK-0004fY-L6
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYGJQvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 12:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbYGJQvM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 12:51:12 -0400
Received: from mail.op5.se ([193.201.96.20]:44013 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbYGJQvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 12:51:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3343A1B8037C;
	Thu, 10 Jul 2008 18:50:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoIVENCb91wA; Thu, 10 Jul 2008 18:50:41 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id CD1BB1B80383;
	Thu, 10 Jul 2008 18:50:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <4875C1CF.1010604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87992>

Johannes Sixt wrote:
> Pierre Habouzit schrieb:
>>   I'm using it in production for quite a long time now, and I wonder=
 if
>> there is any specific reason why it's not default. Debian activated =
it
>> by default too a couple of weeks ago, which means that it's in
>> production on quite a large scale, and there are no issues reported
>> either. Would a patch making it default be accepted ? It's quite han=
dy
>> given that SMP machines are really pervasive nowadays=E2=80=A6
>=20
> Don't forget to turn it off in the MINGW section in the Makefile sinc=
e we
> don't have pthreads on Windows.
>=20

I started trying that, but ran into problems almost immediately. Enabli=
ng
pthreads by default and disabling it for certain systems means we screw
over those poor sods that have their own config.mak files on systems
where there's no <pthread.h> to include, or where that header file
requires a bunch of other stuff to be in first.

On the one hand, that's not nice.
On the other hand, those who have a config.mak are probably savvy enoug=
h
figure out how to amend it disable threads as well.

Opinions? I'm all for enabling THREADED_DELTA_SEARCH by default. I've
been using it ever since v1.5.4.3-193-g833e3df when using the same
=2Egitconfig on all my systems became a sane thing to do and I haven't
seen any ill effects what so ever from it, but how much can we screw
the build-system in place today, and what other systems would, by
default, require the NO_PTHREADS option in the Makefile?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
