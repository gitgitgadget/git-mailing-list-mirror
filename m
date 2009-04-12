From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Sun, 12 Apr 2009 14:45:23 +0200
Message-ID: <vpqfxgevy58.fsf@bauges.imag.fr>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vws9rdmgd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 14:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsz8Q-0002Oy-CV
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 14:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760593AbZDLMsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760420AbZDLMsU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 08:48:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:51213 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760349AbZDLMsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 08:48:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3CCjPSm011779
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 Apr 2009 14:45:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lsz3r-0000l8-I5; Sun, 12 Apr 2009 14:45:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lsz3r-0002dE-Fo; Sun, 12 Apr 2009 14:45:23 +0200
In-Reply-To: <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 11 Apr 2009 12\:22\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 12 Apr 2009 14:45:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116377>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> There's already 'd' to stop staging hunks in a file, but no command to
>> stop the interactive staging (for the current files and the remaining
>> ones). This patch implements this functionality, and binds it to 'q'.
>> ---
>>
>> I'm not familiar at all with the code in git-add--interactive.perl, so
>> my code is mostly cut-and-pasted+adapted from the 'd' command.
>
> You can say 'd' and then ^C, I think.

Yes, you /can/, and that's what I'm doing right now in this situation.
But that's undocumented, not so intuitive (I found out I could do that
after trying ^C alone, which doesn't work, staged content is recorded
on disk at the end of the file only, not after each prompt), ...

I thought the situation was common enough to deserve an explicit
command. The 'd' command is natural for "git add -i" + patch
subcommand, but for "git add -p", I found 'd' mostly useless, and I
really want a "quit" command.

Sure, I can live without it, but if other people would like to have
it, please speak now ;-).

-- 
Matthieu
