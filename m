From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 10:03:22 +0200
Message-ID: <vpqk2vcat2t.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
	<1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2azA-0000nQ-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbbFJIDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:03:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbbFJIDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 04:03:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5A83M2H005559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 10:03:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A83MnK014004;
	Wed, 10 Jun 2015 10:03:22 +0200
In-Reply-To: <1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Louis-Alexandre Stuber's message of "Wed, 10 Jun 2015 09:15:37 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 10:03:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A83M2H005559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434528205.8997@YMkYh4eSo4kAIgp9ENJE4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271271>

Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:

>> That is very different from ENOENT, which is an expected error when
>> you are not using a customized terms.
>
> But in the current state, we are going to create bisect_terms even if
> the bisection is in bad/good mode.

Which means that in normal cases, you'll either succeed to open it, or
get ENOENT. We're talking about unexcepted cases (you don't have
permission to read it because it's not your file, because you messed up
with a chmod, or whatever reason).

I don't expect a tool to consider that an unreadable file is equivalent
to no file at all. If something's wrong, as a user, I expect a helpful
message telling me what's wrong, to give me a clue on how to solve it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
