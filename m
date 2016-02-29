From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016 Microproject
Date: Mon, 29 Feb 2016 16:04:37 +0100
Message-ID: <vpqpovfblru.fsf@anie.imag.fr>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
	<56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
	<56D2C828.6010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 16:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaPNP-0006Qt-HC
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 16:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbcB2PEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 10:04:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58071 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbcB2PEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 10:04:42 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1TF4aWr012174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 29 Feb 2016 16:04:36 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1TF4bnK024625;
	Mon, 29 Feb 2016 16:04:37 +0100
In-Reply-To: <56D2C828.6010901@gmail.com> (Sidhant Sharma's message of "Sun,
	28 Feb 2016 15:42:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Feb 2016 16:04:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1TF4aWr012174
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457363078.03377@1LtINNW+7sJSgtFyHb4Knw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287842>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> Hi,
>> I didn't see anything going on for this one, but you may want to
>> double-check with the ml's archives.
>>
> I checked the archives and there doesn't seem to be any active work on this.
> I made the required changes and ran the test suite. Though all the
> tests pass, there still are two queries I have.
> First, I'm not quite sure what to put in the help message for the
> options (--quiet, --stateless-rpc, --advertise-refs and
> --reject-thin-pack-for-testing).

They are currently undocumented. We sometimes have explicitly
undocumented options (PARSE_OPT_HIDDEN) when they are used only
internally to avoid polluting the end-user's UI.

In this case, the command is anyway not meant for end-users so I think
it would make sense to document them, but not necessarily within the the
microproject.

> Second, regarding the reject-thin-pack-for-testing option, currently
> when the option is entered, `fix_thin` is unset
> (https://github.com/git/git/blob/master/builtin/receive-pack.c#L1736).
> But using `OPT_BOOL(...)` for the same, the variable would instead be
> set when the option is given. I think one solution can be to invert
> `fix_thin` after calling `parse_options`. Am I going right so far?
> Suggestions and corrections welcome.

Or use OPT_SET_INT(..., 0) on a variable initialized to 1.

> Should I make a patch for this and submit it for discussion on the mailing list?

On this list, it is indeed often more efficient to say "here's what I'm
done. Any comments?" than "here's what I'm about to do".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
