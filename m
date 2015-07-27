From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git am" and then "git am -3" regression?
Date: Mon, 27 Jul 2015 10:09:43 +0200
Message-ID: <vpqmvyiauns.fsf@anie.imag.fr>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<20150726052100.GA31790@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 10:10:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJdU9-0005zH-5q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 10:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbbG0IJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 04:09:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46861 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbbG0IJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 04:09:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6R89glg003773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 10:09:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6R89hCC006499;
	Mon, 27 Jul 2015 10:09:43 +0200
In-Reply-To: <20150726052100.GA31790@peff.net> (Jeff King's message of "Sun,
	26 Jul 2015 01:21:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Jul 2015 10:09:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6R89glg003773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438589383.93305@56vsxrTwX01pYrOF7gXRgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274663>

Jeff King <peff@peff.net> writes:

> Yeah, having to worry about two implementations of "git am" is a real
> pain. If we are close on merging the builtin version, it makes sense to
> me to hold off on the am.threeway feature until that is merged. Trying
> to fix the ordering of the script that is going away isn't a good use of
> anybody's time.

So, the best option seems to be:

1) Revert d96a275 (git-am: add am.threeWay config variable, 2015-06-04)

2) Include the C port of d96a275 together with tests and docs verbatim
   from d96a275 into Paul's series.

Actually, doing 1) is probably a good idea anyway, there's no reason to
hold the release for such minor feature.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
