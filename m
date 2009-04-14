From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Tue, 14 Apr 2009 22:44:02 +0200
Message-ID: <vpqtz4rynhp.fsf@bauges.imag.fr>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vws9rdmgd.fsf@gitster.siamese.dyndns.org>
	<vpqfxgevy58.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpZg-0001l5-0G
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbZDNUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbZDNUsH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:48:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:64126 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622AbZDNUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:48:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3EKiB1O026727
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2009 22:44:11 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LtpUA-0003kc-SU; Tue, 14 Apr 2009 22:44:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LtpUA-0005Ie-Q7; Tue, 14 Apr 2009 22:44:02 +0200
In-Reply-To: <vpqfxgevy58.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun\, 12 Apr 2009 14\:45\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 14 Apr 2009 22:44:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116569>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> There's already 'd' to stop staging hunks in a file, but no command to
>>> stop the interactive staging (for the current files and the remaining
>>> ones). This patch implements this functionality, and binds it to 'q'.
>>> ---
>>>
>>> I'm not familiar at all with the code in git-add--interactive.perl, so
>>> my code is mostly cut-and-pasted+adapted from the 'd' command.
>>
>> You can say 'd' and then ^C, I think.
>
> Yes, you /can/, and that's what I'm doing right now in this situation.
> But that's undocumented, not so intuitive (I found out I could do that
> after trying ^C alone, which doesn't work, staged content is recorded
> on disk at the end of the file only, not after each prompt), ...
>
> I thought the situation was common enough to deserve an explicit
> command. The 'd' command is natural for "git add -i" + patch
> subcommand, but for "git add -p", I found 'd' mostly useless, and I
> really want a "quit" command.
>
> Sure, I can live without it, but if other people would like to have
> it, please speak now ;-).

I think everybody agree that the intention of the patch is good (well,
several pro, and no real counter-argument). I'll send an updated
version with documentation soon, but I'd appreciate review and
comments on the code.

I'm not really happy with the fact that I mainly cut-and-pasted code
from the "d" command, but OTOH, that's already how the code is today
(huge if/elsif/... with similar elsif blocks for each command).

-- 
Matthieu
