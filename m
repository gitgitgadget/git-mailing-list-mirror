From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 05 Oct 2015 08:54:17 +0200
Message-ID: <vpq4mi56c12.fsf@grenoble-inp.fr>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	<vpq1tdb83nt.fsf@grenoble-inp.fr>
	<xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
	<1443981968.3520.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>,
	Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:54:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZizfW-0002QL-1M
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 08:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbJEGyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 02:54:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39648 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbbJEGyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 02:54:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t956sHUY029640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 5 Oct 2015 08:54:17 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t956sH3q023811;
	Mon, 5 Oct 2015 08:54:17 +0200
In-Reply-To: <1443981968.3520.5.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Sun, 04 Oct 2015 20:06:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 05 Oct 2015 08:54:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t956sHUY029640
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444632860.69521@elQoVBACxcalll5iPBp98g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279038>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On zo, 2015-10-04 at 10:46 -0700, Junio C Hamano wrote:
>> One final question.  Which configuration file does the CI use when
>> running a PR-initiated test?  The one already in the repository
>> i.e. the target of the proposed pull, or the one that is possibly
>> updated by the PR?
>>
>> I am wondering if that can be an avenue for a possible mischief.
>
> The latter. And it can, as it can enable notifications.

OK, so an attacker can send emails (by faking one of the repository
owner's identity on a commit, and then submitting a pull-request for
this commit). But such attacker could already send emails via GitHub to
all repository watchers (not just owners) by sending pull-requests. Or
by using his mailer.

Other than that, Travis-CI uses a container-based infrastructure to
ensure clean and independent builds. So, an attacker could trigger a
build doing "rm -fr /" or whatever without impacting other builds.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
