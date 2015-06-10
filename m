From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 7/7] send-email: suppress leading and trailing
 whitespaces before alias expansion
Date: Wed, 10 Jun 2015 11:30:15 +0200 (CEST)
Message-ID: <1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqa8w89d5x.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 11:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2cKN-0001o8-0A
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 11:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbbFJJ3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 05:29:38 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47919 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754129AbbFJJ3c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 05:29:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2E9252844;
	Wed, 10 Jun 2015 11:29:30 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gfj-qh0W4U0a; Wed, 10 Jun 2015 11:29:30 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1D8052841;
	Wed, 10 Jun 2015 11:29:30 +0200 (CEST)
In-Reply-To: <vpqa8w89d5x.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: suppress leading and trailing whitespaces before alias expansion
Thread-Index: fxQ7TJ4VBiDDC56RFdE9vtVgFkdS2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271278>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, once you have this, PATCH 6/7 becomes useless, right? (at
> least, the test passes if I revert it)

> It seems to me that doing this space trimming just once, inside or right
> after split_at_commas would be clearer.

You're right, I put it twice because of there's occurrences of
sanitize_address which are not associated with expand_aliases, but it
seems that it's all taken care of separately in different regexp. So
there's no point to 6/7.

I agree, I'd like to put it right after split_at_commas in a separate
function "trim_list". Is it a good idea even if the function is one
line long ?
