From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Move "show_all_errors = 1" to setup_unpack_trees_porcelain()
Date: Thu, 02 Sep 2010 18:06:13 +0200
Message-ID: <vpq1v9cgmfe.fsf@bauges.imag.fr>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
	<1283428655-12680-4-git-send-email-Matthieu.Moy@imag.fr>
	<7v8w3k2ldz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrCJl-0006S8-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab0IBQHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:07:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41436 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322Ab0IBQHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:07:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o82G2aRC023401
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 18:02:36 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OrCIn-0003dw-Pk; Thu, 02 Sep 2010 18:06:13 +0200
In-Reply-To: <7v8w3k2ldz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 02 Sep 2010 08\:52\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Sep 2010 18:02:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o82G2aRC023401
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1284048159.47518@qPV9XB0bjXr6QwFZexg/gQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155141>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Not only this makes the code clearer since setting up the porcelain error
>> message is meant to work with show_all_errors, but this fixes a call to
>> setup_unpack_trees_porcelain() in git_merge_trees() which did not set
>> show_all_errors.
>>
>> add_rejected_path() used to double-check whether it was running in
>> plumbing mode. This check was inefficient since it was setting
>> show_all_errors too late for traverse_trees() to see it, and is made
>> useless by this patch. Remove it.
>
> Do you mean inefficient or ineffective?

Ineffective, yes.

<disgression>
I should have listened better during my english courses ;-). Both
words translate to "inefficace" in French, and it's a common mistake
for french people.
</disgression>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
