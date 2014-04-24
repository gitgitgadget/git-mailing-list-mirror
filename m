From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase: fix probable reflog typo
Date: Thu, 24 Apr 2014 08:21:13 +0200
Message-ID: <vpqzjjb1c4m.fsf@anie.imag.fr>
References: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ywxoos.fsf@anie.imag.fr>
	<53582f33385bc_24448772ec57@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdD2B-0003DN-5f
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 08:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbaDXGVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 02:21:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42907 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbaDXGVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 02:21:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3O6LDgU012624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Apr 2014 08:21:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3O6LD6L005056;
	Thu, 24 Apr 2014 08:21:13 +0200
In-Reply-To: <53582f33385bc_24448772ec57@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 16:22:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Apr 2014 08:21:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3O6LDgU012624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398925274.26205@sNpzf+Yr01Em5tFGHLZSkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246941>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Commit 26cd160 (rebase -i: use a better reflog message) tried to produce
>> > a better reflog message, however, it seems a statement was introduced by
>> > mistake.
>> >
>> > 'comment_for_reflog start' basically overides the GIT_REFLOG_ACTION we
>> > just set.
>
>> So, one needs to reset $GIT_REFLOG_ACTION to what it used to be if is it
>> to be used later. However, it seems to me that the "comment_for_reflog
>> start" is used only for this checkout command. If so, there's no need
>> for the "comment_for_reflog start" before the if statement either.
>
> Exactly. But if this variable is only meant for this command, it should be
> `VAR=VAL command`, that would make it clear without the need of a comment.

I don't understand. Are you suggesting to replace the shell function
"output" with an external command? If not, which command would you want
to call here?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
