From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 13:20:55 +0100
Message-ID: <476669A7.1050407@viscovery.net>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net> <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site> <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com> <Pine.LNX.4.64.0712171151490.9446@racer.site> <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:22:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ez4-0002wy-LV
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935839AbXLQMVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 07:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935675AbXLQMVE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:21:04 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27239 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935719AbXLQMVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 07:21:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4Ey8-0002j6-Ij; Mon, 17 Dec 2007 13:21:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AC639546; Mon, 17 Dec 2007 13:20:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <57245FA1-361B-4333-B490-A2CC99ED4F9C@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68554>

Wincent Colaiuta schrieb:
> El 17/12/2007, a las 12:57, Johannes Schindelin escribi=F3:
>=20
>> Hmm.  There is some chicken-and-egg problem here (I read the thread,=
 but
>> did not really see a problem, as I assumed that _other_ tests would
>> assure
>> that "git diff --no-index" works as expected).
>>
>> But as at least one released version of GNU diff has a pretty seriou=
s
>> bug,
>> I would rather not rely too much on diff.  (BTW this was the reason =
I
>> wanted --no-index so badly.)
>>
>> So yeah, the second "diff" cannot be "git diff".  Maybe "cmp", but n=
ot
>> "git diff".
>=20
> Well cmp would be fine as well, seeing all we want is a boolean "is t=
his
> the same or not" answer. (I'm not familiar with the GNU diff bug you
> speak of, but was it so bad that it couldn't even get *that* answer r=
ight?)

Heh, there's at least one distribution out there (Suse 10.1) that comes=
 with
a *cmp* that doesn't get that answer right if its output is connected t=
o
/dev/null, which is the case when you simply 'make test'.

-- Hannes
