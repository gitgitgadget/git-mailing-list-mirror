From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Sat, 17 Mar 2012 21:46:51 +0100
Message-ID: <vpqvcm3vttw.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120316085152.GA22273@ecki> <vpq1uosswwz.fsf@bauges.imag.fr>
	<7vy5r0iwdb.fsf@alter.siamese.dyndns.org>
	<vpqhaxohg3n.fsf@bauges.imag.fr> <20120316214832.GB25092@ecki>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Mar 17 21:47:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S90XN-0007if-17
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 21:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036Ab2CQUrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 16:47:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57800 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344Ab2CQUrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 16:47:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2HKgacn029464
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 17 Mar 2012 21:42:36 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S90Wa-00010V-4j; Sat, 17 Mar 2012 21:46:52 +0100
In-Reply-To: <20120316214832.GB25092@ecki> (Clemens Buchacher's message of
	"Fri, 16 Mar 2012 22:48:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 17 Mar 2012 21:42:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2HKgacn029464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332621762.52904@MQ3lm9uqXDJK6r7/KjAovw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193351>

Clemens Buchacher <drizzd@aon.at> writes:

> On Fri, Mar 16, 2012 at 01:42:36PM +0100, Matthieu Moy wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> >
>> >> I'd count "upstream is not set" as "current and upstream agree on
>> >> 'current'". IOW, use "current", but error out if there's a configured
>> >> upstream that is different.
>> >
>> > And if there is no configured upstream, should it error out, or should it
>> > just push the current one to its own name?
>> 
>> I meant just push the current one to its own name.
>
> Altough in a somewhat rarer case, this has the same problem as
> "current":
>
> git checkout -b master origin/master
> git checkout -b topic master
> git push
>
> If a branch called topic already exists on origin, push will now try to
> update it with the local branch topic. But they do not have any clear
> connection, except for the name.

Yes, but the user can hardly expect anything else here. So, it may be a
(user) mistake, but it's not a surprise.

BTW, 'matching' also has this drawback, and I never saw anyone complain
about it (maybe I didn't listen enough though).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
