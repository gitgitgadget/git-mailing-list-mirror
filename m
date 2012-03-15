From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Thu, 15 Mar 2012 09:05:04 +0100
Message-ID: <vpq8vj2mgr3.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<vpqhaxrzh2a.fsf@bauges.imag.fr>
	<CAHkcotgMgqr29WEQfiH+89JVbTAAQyLwscXRtTyrf3JRxEuVbA@mail.gmail.com>
	<vpqhaxrz1c6.fsf@bauges.imag.fr>
	<CAHkcothjDBP+cyGRf--mNgwF5Sp2UiR3Gq1Vb-XwsKmMH_JCvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85gh-00059l-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202Ab2COIF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:05:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60608 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab2COIFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:05:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2F80v2s014854
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Mar 2012 09:00:57 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S85gH-0008ID-Dl; Thu, 15 Mar 2012 09:05:05 +0100
In-Reply-To: <CAHkcothjDBP+cyGRf--mNgwF5Sp2UiR3Gq1Vb-XwsKmMH_JCvA@mail.gmail.com>
	(Dmitry Potapov's message of "Wed, 14 Mar 2012 20:47:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Mar 2012 09:00:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2F80v2s014854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332403262.82342@dxA72JNTcXfVHdFlmp8hqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193196>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Wed, Mar 14, 2012 at 6:47 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Dmitry Potapov <dpotapov@gmail.com> writes:
>>
>>> Not of course. I said above non-fast forward push should not be used by
>>> beginners.
>>
>> Do you mean "beginners should not force non-fast forward push", or
>> "beginners should not use flow where push may be denied because of
>> non-fast forward"?
>
> Of course, the former. I have never said that the centralized workflow
> should never been used. I have only said that it is not scalable and
> lead to problems in larger projects.

Then I don't follow you. The starting point of the discussion was my
rule of thumb about push/pull:

| There's a rule of thumb which works very well for beginners: when "git
| push" tells you to pull before, then pull before. This rule of thumb
| works, but only provided "push" and "pull" are symmetrical.

I can rephrase the end as "... provided 'push' pushes to the same branch
'pull' pulls from" (i.e. provided push.default=upstream).

Can you explain what you disagree with here? Or do you actually agree
with it?

Then, I showed the message of "git push" in the non-fast forward case,
which suggests that the user should pull, and you said:

| I agree that the current diagnostic is not suitable for beginners.

Again, what do you mean? What diagnosis would you suggest, if not
pulling?

>> either shared for one user and multiple machines, or shared
>> between developers?
>
> I am not sure that I understood this part.

I mean that a repository can be shared because multiple developers have
acces to it, or because the same developer has several clones.

>> If you mean that shared repositories are too complex for beginners, my
>> experience is exactly the opposite.
>
> It is not too complex but it is wrong for any more or less serious
> project.

I never argued against distributed development. I'm saying that
centralized development also makes sense, especially with beginners.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
