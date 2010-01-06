From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries user-friendly.
Date: Wed, 06 Jan 2010 20:53:23 +0100
Message-ID: <vpqocl76mdo.fsf@bauges.imag.fr>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
	<7veim3yx5o.fsf@alter.siamese.dyndns.org>
	<vpqtyuz86ny.fsf@bauges.imag.fr>
	<7v8wcbw14f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 20:53:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSbx7-0008Lj-Su
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 20:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706Ab0AFTxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 14:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684Ab0AFTxn
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 14:53:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47579 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702Ab0AFTxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 14:53:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o06JrMR5002096
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 20:53:22 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSbwZ-0000vU-FV; Wed, 06 Jan 2010 20:53:23 +0100
In-Reply-To: <7v8wcbw14f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 Jan 2010 10\:15\:44 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jan 2010 20:53:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o06JrMR5002096
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263412403.33414@D+9flfzgP78svNUOtLM0hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136290>

Junio C Hamano <gitster@pobox.com> writes:

>> # Unmerged paths:
>> #   (use "git add/rm <file>..." as appropriate to mark resolution)
[...]
>  That one line we see above is concise and does mention "rm" as
> well.  Why not use it?

Fine, you convinced me. I was thinking of a longer sentence, but "/rm"
doesn't harm.

>>> I think we should consolidate them all.
>>
>> Right, although "commit" is definitely the most important (dumb users
>> don't need "git merge").
>
> Your "dumb users" don't get the unmerged error from commit, either, if
> they don't need "git merge".

They'd use "pull", not merge. Anyway, I did it for commit, merge,
pull, revert, cherry-pick. I guess we covered the common cases.
The patch seems to have a lot of redundancies, but I think trying to
factor this into helper functions would be much more effort than the
few cut-and-paste that I had to do, since each instance is a slight
variant of each other ...

Patch follows. Let me know in case you prefer to split it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
