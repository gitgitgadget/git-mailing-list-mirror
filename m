From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error message
Date: Thu, 25 Nov 2010 16:56:02 +0100
Message-ID: <vpqbp5diei5.fsf@bauges.imag.fr>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
	<87mxp086k5.fsf_-_@gmail.com>
	<20101123145921.GB3145@sigill.intra.peff.net>
	<87ipzo83o9.fsf@gmail.com> <4CEE2472.5020901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Jeff King <peff@peff.net>, Jeenu V <jeenuv@gmail.com>,
	knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 25 16:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLeEN-0002rN-9o
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab0KYP7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 10:59:14 -0500
Received: from imag.imag.fr ([129.88.30.1]:39223 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab0KYP7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 10:59:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oAPFu2Gw024739
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 25 Nov 2010 16:56:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PLeB0-0004Mu-FI; Thu, 25 Nov 2010 16:56:02 +0100
In-Reply-To: <4CEE2472.5020901@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 25 Nov 2010 09\:55\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 25 Nov 2010 16:56:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162142>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>>>  	if (patch_mode) {
>>>>  		if (reset_type != NONE)
>>>> -			die("--patch is incompatible with --{hard,mixed,soft}");
>>>> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
>>>> +			    "(use \"git checkout -p\" to selectively discard changes in working directory)");
>>>>  		return interactive_reset(rev, argv + i, prefix);
>>>>  	}
>>>
>
> The man page for git-reset points at git-checkout already.
>
> Until we have a "verbosity level" config across all commands, I don't
> favor adding a lot of hints to command error messages.

I agree for "regular output", but this case is an error message that
users should never see. If you see the message, it means you tried a
command that doesn't exist, and I can't imagine a case where this
would be disturbing to get an informative message pointing to the
right command.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
