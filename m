From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Thu, 18 Jun 2015 19:29:35 +0200
Message-ID: <vpqvbelylfk.fsf@anie.imag.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqqioam58kz.fsf@gitster.dls.corp.google.com>
	<989982277.592587.1434584914349.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqh9q56yaf.fsf@anie.imag.fr>
	<1444764681.621777.1434640131682.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ddR-0007Hs-3d
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 19:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbbFRR3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 13:29:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33025 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbbFRR3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 13:29:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5IHTXIH028916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2015 19:29:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5IHTZXJ005990;
	Thu, 18 Jun 2015 19:29:35 +0200
In-Reply-To: <1444764681.621777.1434640131682.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 18 Jun 2015 17:08:51 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 18 Jun 2015 19:29:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5IHTXIH028916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435253373.98257@YHTBe2WwURljgQqdMVUyEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272030>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

>> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>> 
>> > I've some more tests, maybe I should put them all in this post ?
>> 
>> Yes, please post as much as you have. Ideally, this should be
>> automatically tested, but if you don't have time to write the automated
>> tests, at least having a track of what you did on the list archives can
>> help someone else to do it.
>
> It may not be easily readable without colors, so there are the scripts
> at the end.

Cool. Then almost all the work is done to get an automated test. Next
step would be to add the tests itself in the code. I would do that by
adding a hidden --selfcheck option to git send-email that would compare
Mail::Address->parse($string); and split_addrs($string); for all your
testcases, and die if they do not match. Then calling it from the
testsuite would be trivial.

I can do that on top of your series if you don't have time.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
