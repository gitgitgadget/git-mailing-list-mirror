From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 01 Mar 2011 19:51:38 +0100
Message-ID: <vpq4o7mfzd1.fsf@bauges.imag.fr>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vei6t4uwa.fsf@alter.siamese.dyndns.org>
	<AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
	<7vy6512rnb.fsf@alter.siamese.dyndns.org>
	<AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
	<7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
	<vpqipw2rixy.fsf@bauges.imag.fr>
	<7vd3maelbh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1b?= =?iso-8859-1?Q?or?= 
	<szeder@ira.uka.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuUj7-0002Ce-LK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 19:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab1CASzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 13:55:11 -0500
Received: from imag.imag.fr ([129.88.30.1]:58938 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab1CASzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 13:55:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p21IpdoM008352
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 19:51:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuUfb-0005lG-4S; Tue, 01 Mar 2011 19:51:39 +0100
In-Reply-To: <7vd3maelbh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Mar 2011 10:40:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 01 Mar 2011 19:51:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168238>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I think promoting "git add -u ." more than a configuration option would
>> reduce the pain.
>
> Yeah, I tend to agree.
>
>> As a user, if I get used to typing "git add -u ." instead of "git add -u", 
>> I get the current behavior regardless of the version of Git, without a
>> warning. Later, when all the machines I word on support the tree-wide
>> "git add -u" (either 1.7.x + some configuration or 1.8.y), I'll use it
>> as a new feature.
>
> Once your users (you as a script writer) have an option to set the
> configuration to participate in the tree-wide party early, you would need
> to update your scripts immediately so that they don't break on them;

But "update" should mean "replace git add -u with git add -u .", which
is the portable way to do the same.

> so the introduction of the configuration becomes a flag-day event.
> Hmph...

The introduction of the config variable is a non-event if you already
use the portable . notation.

>> So, a warning like
>>
>>   warning: the behavior of "git add -u" without pathspec will change in
>>   Git 1.8.0. To keep the current behavior, use this instead:
>>   
>>       git add -u .
>>   
>>   + explanations about the config options as already discussed here
>>
>> would be fine.
>
> Yeah, I think you convinced me that an elaborate configuration wouldn't
> help us at all.  We just keep warning in 1.7.x series when "add -u" didn't
> see any pathspec, and flip the default at 1.8.0
>
> Simpler and cleaner ;-)

I think is still makes sense to have a config variable, so that people
who want the new behavior can get it ASAP. Right after 1.8 is out, I'll
still have machines where I'm too lazy to install a brand new Git, and
I'll want to get the 1.8 goodness for free ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
