From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 13:58:01 +0200
Message-ID: <vpq8un9bv06.fsf@anie.imag.fr>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
	<1406799857-28048-4-git-send-email-tanayabh@gmail.com>
	<vpqoaw5epsa.fsf@anie.imag.fr> <53DA2E02.4000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCozw-0003jn-BM
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaGaL6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:58:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51460 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbaGaL6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:58:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBw0gU010867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:58:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBw1np025234;
	Thu, 31 Jul 2014 13:58:01 +0200
In-Reply-To: <53DA2E02.4000408@gmail.com> (Tanay Abhra's message of "Thu, 31
	Jul 2014 17:22:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 13:58:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBw0gU010867
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407412681.25521@bD9kHSfH6hTCNF7JiDfctw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254559>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/31/2014 4:52 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> 
>> I think I deserve a bit of credit here ;-).
>>
>
> Yes, but to show credit would I have to write "from you" or
> "signed-off-by"? :)

Original-patch-by: would be fine.

>> My bad, but this should be die(_("..."));, so that the message can be
>> translated. Not really serious since it's not really meant to be seen by
>> the user, though.
>>
>
> Noted. Though there are not many cases till I have read where error messages are marked
> for translation.

Yes, see my other message.

Overall, there are still many untranslated messages in Git's codebase:

$ git grep 'die(_("' | wc -l
517
$ git grep 'die("' | wc -l 
1247

Part of the reason is that die() was written and used far before the
translation effort has started.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
