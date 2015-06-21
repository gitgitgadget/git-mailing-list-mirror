From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Sun, 21 Jun 2015 15:02:42 +0200 (CEST)
Message-ID: <715613601.681945.1434891762535.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434842273-30945-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1692637261.3463890.1434881256090.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 21 15:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6erx-000370-W0
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 15:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbbFUNA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 09:00:59 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47732 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751988AbbFUNA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 09:00:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 31FE82970;
	Sun, 21 Jun 2015 15:00:56 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjAFf+GhGj6K; Sun, 21 Jun 2015 15:00:56 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 17FE7296C;
	Sun, 21 Jun 2015 15:00:56 +0200 (CEST)
In-Reply-To: <1692637261.3463890.1434881256090.JavaMail.zimbra@imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: +M3vEpJoD3pi1fRp2/fC1zqK+r+ZxXS55u/v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272259>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

> This is the last message I received in the series, and it's labeled
> 07/10. Is that normal?

No, it wasn't, I have seen no error message though... I'll take a look
at that later.  I just sent 0008, 0009 and 0010 but I seems that I've pasted
the wrong line in the in-reply-to... Maybe I need more sleep.

>> We can redirect todo_output to a variable but I've not found better...
>> (Maybe someone has the solution here ?). Also there's no summary at
>> the end of the test (as with other perl tests).
>
> You can get the 1..44 at the end with
 ...
> I would have put parse_mailbox near ident_person because both
> functions are somehow about email.
>
>> +BEGIN { use_ok('Git') }
>> +BEGIN { use_ok('Mail::Address') }
>
> This will fail if Mail::Address is not available. It would be better
> to declare Mail::Address as a prerequisite in t9000-address.sh (like
> what you're already doing for Test::More).

Ok, will do.

Thanks.
