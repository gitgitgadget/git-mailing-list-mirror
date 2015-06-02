From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 2 Jun 2015 09:23:33 +0200 (CEST)
Message-ID: <150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqqvbf7757q.fsf@gitster.dls.corp.google.com> <563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqoakz1dke.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 09:23:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzgY1-0002wJ-GG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 09:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbbFBHXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 03:23:38 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60850 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753440AbbFBHXg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 03:23:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9A88B27B6;
	Tue,  2 Jun 2015 09:23:32 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THGrTynxdFx4; Tue,  2 Jun 2015 09:23:32 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 885D82788;
	Tue,  2 Jun 2015 09:23:32 +0200 (CEST)
In-Reply-To: <vpqoakz1dke.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: wKs3QPpQ1IfF0fVUHNsHg+Wc49SKXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270504>

> Ideally, I think we should do a sanity check before starting the reba=
se,
> and error out if we encounter an invalid command, a command that shou=
ld
> be followed by a valid sha1 and does not, ...
>=20
> But currently, we do the verification while applying commands, and I
> don't think there's anything really helpful to do if we encounter a
> "drop this-is-not-a-sha1" command.

While I agree that doing a sanity check before starting the rebase is
a better idea, it would not be logic to do so only for the 'drop'
command, it should be done for all of the various commands (as you
said, checking if the commands are valid, checking if the SHA-1
following the command is valid if it was expecting one...).

However I think that it should be in a different patch, changing the
whole checking system of rebase is not directly linked to the idea of
the 'drop' command.

R=C3=A9mi
