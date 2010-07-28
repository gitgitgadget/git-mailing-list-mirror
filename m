From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rev-list: accept --format without argument
Date: Wed, 28 Jul 2010 18:29:56 +0200
Message-ID: <vpqy6cvwovv.fsf@bauges.imag.fr>
References: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vlj8v7ftw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:30:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9Ws-0003B2-Vd
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab0G1Qap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 12:30:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52864 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab0G1Qap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:30:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6SGS9tc007697
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 18:28:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe9W0-0005kE-72; Wed, 28 Jul 2010 18:29:56 +0200
In-Reply-To: <7vlj8v7ftw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 28 Jul 2010 09\:04\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 18:28:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6SGS9tc007697
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280939291.93971@hmFQDL9pFk2MTyTsreUqaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152098>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The documentation says the syntax is --format[='<format>'], match it in
>> the implementation.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Not that it's terribly usefull, but better be consistant ...
>
> Hmm, I do not care too deeply either way as I do not expect anybody sane
> to have used, nor learn from this patch and start using, --format without
> any formatting specification, but it somehow feels that this patch takes
> consistency the wrong way.

The other way would be stg like:

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index d78e121..9b6f389 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,5 +1,5 @@
 --pretty[='<format>']::
---format[='<format>']::
+--format='<format>'::
 
        Pretty-print the contents of the commit logs in a given format,
        where '<format>' can be one of 'oneline', 'short', 'medium',

But I'd say it's simpler to be able to say "--format is an alias for
--pretty" than "--format is an alias for --pretty _except that ..._".

And actually,

git rev-list --format

is not that stupid if you read it as "list revisions and do some
formatting as you do it".

(but I don't care much either ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
