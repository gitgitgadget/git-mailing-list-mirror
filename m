From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Fri, 25 May 2012 11:15:10 +0200
Message-ID: <vpqfwaotye9.fsf@bauges.imag.fr>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
	<20120524182110.GE3161@sigill.intra.peff.net>
	<vpq7gw1z8rb.fsf@bauges.imag.fr>
	<20120524200122.GA18936@sigill.intra.peff.net>
	<7vtxz5ut84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, roucherj <roucherj@telesun.imag.fr>,
	git@vger.kernel.org, kim-thuat.nguyen@ensimag.fr,
	pavel.volek@ensimag.fr, javier.roucher-iglesias@ensimag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 11:15:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXqcR-0001Qd-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 11:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab2EYJPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 05:15:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52875 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab2EYJP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 05:15:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4P9740o030557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 11:07:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXqc3-0002Yc-1h; Fri, 25 May 2012 11:15:11 +0200
In-Reply-To: <7vtxz5ut84.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 24 May 2012 15:09:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 May 2012 11:07:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4P9740o030557
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338541630.39372@BG83f1HMG1eb8Scz2+dm3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198471>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, May 24, 2012 at 09:20:08PM +0200, Matthieu Moy wrote:
>>
>> +This document describes two interfaces: the C API that the credential
>> +subsystem provides to the rest of git, and the protocol that git uses to
>> +communicate with system-specific "credential helpers". If you are
>> +writing git code that wants to look up or prompt for credentials, see
>
> Don't you "prompt" yourself?  The above sounds as if you are delegating
> both looking up and prompting to the helper.

It seems I misunderstood how it worked, indeed. I thought the prompting
could also be done by the helper (it seems sensible if you're going to
use your desktop's keyring to also allow the desktop's GUI for prompting
for example).

Looking closely at the code, credential_fill either delegates fetching
data to the remote helper, or does the prompting. IOW, the prompting is
done behind the C API anyway, but most likely from credential.c than
from the external helper. Is that understanding correct?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
