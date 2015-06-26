From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 08:59:03 +0200
Message-ID: <vpqy4j7x8eg.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 08:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Nbb-0006XN-5h
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 08:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbbFZG7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 02:59:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55877 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbbFZG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 02:59:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q6x2JM014798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 08:59:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q6x3YV032277;
	Fri, 26 Jun 2015 08:59:03 +0200
In-Reply-To: <xmqqk2urwjmq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 14:41:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 08:59:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5Q6x2JM014798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435906747.93137@Od1rWygaBJhDfoqO6ipc+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272762>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +------------------------------------------------
>> +git bisect terms <term-new> <term-old>
>> +------------------------------------------------
>
> The mnemonic for "git bisect start bad good" is Bad comes before
> Good (B = 0x42, G = 0x47) and this is same for "new/old", New comes
> before Old (N = 0x4e, O = 0x4f).  "git bisect terms new old" follows
> the same pattern, which is good.  Easy to remember.
>
>> +This command has to be used before a bisection has started. <term-old>
>> +must be associated with the latest revisions and <term-new> with the
>> +ancestors of <term-old>.
>
> Whoa?  This gets new and old mixed up, doesn't it?

Right. I think it was already the case before, but using term1/term2 in
the text made it hard to spot. The new wording is clearer, and makes it
easier to find bugs in the explanations ;-).

>> +Only the first bisection following the `git bisect terms` will use the
>> +terms. If you mistyped one of the terms you can do again `git bisect
>> +terms <term-old> <term-new>`.
>
> This is also the other way around, no?

Indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
