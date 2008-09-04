From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: blame vs annotate?
Date: Thu, 04 Sep 2008 11:09:17 +0200
Message-ID: <vpq7i9smg5e.fsf@bauges.imag.fr>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
	<7v8wu9cd7i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonathan del Strother" <maillist@steelskies.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAte-00025t-MB
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYIDJLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYIDJLw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:11:52 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:38016 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431AbYIDJLw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:11:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m8499iKQ013318;
	Thu, 4 Sep 2008 11:09:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KbAq5-00034w-PE; Thu, 04 Sep 2008 11:09:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KbAq5-0005pJ-Ml; Thu, 04 Sep 2008 11:09:17 +0200
In-Reply-To: <7v8wu9cd7i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 03 Sep 2008 11\:10\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 04 Sep 2008 11:09:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94911>

Junio C Hamano <gitster@pobox.com> writes:

> "Jonathan del Strother" <maillist@steelskies.com> writes:
>
>> What's the difference between 'git blame' & 'git annotate'?  The
>> output is practically identical - it's not obvious when you would use
>> one over the other
>
> In short, don't use git-annotate unless you are an ancient script that was
> written before git-blame was written.  They are functionally equivalent,
> uses the same blame assigning engine, and the only difference is the
> default output format, and blame knows how to mimick annotate output.

Then, does it make sense to apply this?

--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -14,6 +14,10 @@ DESCRIPTION
 Annotates each line in the given file with information from the commit
 which introduced the line. Optionally annotate from a given revision.
 
+This command exists for backward compatibility. If you don't have
+existing scripts using 'git annotate', you should use
+linkgit:git-blame[1] instead.
+
 OPTIONS
 -------
 include::blame-options.txt[]

-- 
Matthieu
