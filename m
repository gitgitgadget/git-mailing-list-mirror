From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] send-email quote issues
Date: Mon, 15 Jun 2015 15:03:54 +0200 (CEST)
Message-ID: <999870154.509851.1434373434414.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <330077615.505681.1434367014434.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqmw011a22.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 15:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4U2K-0000Ci-L5
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 15:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbbFONCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 09:02:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:46494 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbbFONCn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2015 09:02:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E268C2823;
	Mon, 15 Jun 2015 15:02:40 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sP6De4BzBjpp; Mon, 15 Jun 2015 15:02:40 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D2C96278B;
	Mon, 15 Jun 2015 15:02:40 +0200 (CEST)
In-Reply-To: <vpqmw011a22.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email quote issues
Thread-Index: UqpxFI6hwC4ZGRKG2y7cDLrfHEGg4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271683>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes

> I would say that using parse_address_line is good for consistancy in Git 
> anyway. If the behavior of parse_address_line is broken on some 
> corner-cases, then it should be fixed anyway. 

Ok, but I don't know what fixed means in these particular cases.
Actually the problem when we have a quote in a name is: Is this a
delimiter or is this an ascii char?

Currently the problem is solved by saying : it's an ascii char
unless there is two quotes aroung all the name (modulo minor
things). So if I write:

--to='"Jane, Kararina" Doe <jdoe@example.com>'

they are considered characters. Which means that this is
different than:

--to='"Jane, Kararina Doe" <jdoe@example.com>'

Is this expected?
