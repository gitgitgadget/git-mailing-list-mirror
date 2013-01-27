From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] add: warn when -u or -A is used without filepattern
Date: Sun, 27 Jan 2013 17:10:47 +0100
Message-ID: <vpqtxq28v3s.fsf@grenoble-inp.fr>
References: <vpq1uddoedj.fsf@grenoble-inp.fr>
	<1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v8v7h3vx8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 17:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzUpO-0003is-FG
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 17:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab3A0QLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 11:11:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44771 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab3A0QLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 11:11:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0RGAjfZ025935
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 Jan 2013 17:10:46 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TzUoh-0006BU-JW; Sun, 27 Jan 2013 17:10:47 +0100
In-Reply-To: <7v8v7h3vx8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 25 Jan 2013 11:27:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 27 Jan 2013 17:10:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0RGAjfZ025935
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359907850.97462@x2gJsOwMnYE3ov0rpUY6JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214706>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Most git commands that can be used with our without a filepattern are
>> tree-wide by default, the filepattern being used to restrict their scope.
>> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>>
>> The inconsistancy of 'git add -u' and 'git add -A' are particularly
>
> s/consistan/consisten/;

Thanks, will fix.

> I wonder if we want to say in the message
>
> 	The behaviour of 'git add --all (or -A)'...
>
> otherwise people who typed "git add -A" and got this message with
> just "--all" may go "Huh?" for a brief moment.  I however do not
> think replacing these strings to
>
> 	option_with_implicit_dot = "--all (-A)";
>
> is a solution, given they are goven to _("l10n template %s").

Plus, option_with_implicit_dot is used in cut-and-paste ready commands
below. I can easily add another variable short_option or so to display
both. Ideally, we should use whatever the user had typed, but that does
not seem easy to do with parse-option so I'd say it's overkill.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
