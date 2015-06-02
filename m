From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 02 Jun 2015 09:45:20 +0200
Message-ID: <vpqa8wiwo33.fsf@anie.imag.fr>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
	<563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakz1dke.fsf@anie.imag.fr>
	<150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 09:45:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzgtM-0002Du-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 09:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbbFBHpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 03:45:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56213 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbbFBHpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 03:45:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t527jJFK018954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2015 09:45:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t527jK8l003505;
	Tue, 2 Jun 2015 09:45:20 +0200
In-Reply-To: <150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 2 Jun 2015 09:23:33 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Jun 2015 09:45:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t527jJFK018954
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433835922.44157@r14A5lOZbNBWA9CjGKK0tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270506>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

>> Ideally, I think we should do a sanity check before starting the rebase,
>> and error out if we encounter an invalid command, a command that should
>> be followed by a valid sha1 and does not, ...
>> 
>> But currently, we do the verification while applying commands, and I
>> don't think there's anything really helpful to do if we encounter a
>> "drop this-is-not-a-sha1" command.
>
> While I agree that doing a sanity check before starting the rebase is
> a better idea, it would not be logic to do so only for the 'drop'
> command, it should be done for all of the various commands (as you
> said, checking if the commands are valid, checking if the SHA-1
> following the command is valid if it was expecting one...).

Yes, that's what I had in mind.

> However I think that it should be in a different patch, changing the
> whole checking system of rebase is not directly linked to the idea of
> the 'drop' command.

Agreed.

Discussions on this list often lead to "Oh, BTW, shall we do XYZ also?",
but you shouldn't take this kind of remark as blocking (as long as XYZ
is not incompatible with your patch, which is the case here).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
