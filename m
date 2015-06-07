From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-bisect.sh : create a file if the bisection is
 in old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen
 outside the program without having to read BISECT_TERMS. This will have to
 be changed in further versions if new terms are introduced.
Date: Sun, 7 Jun 2015 21:06:15 +0200 (CEST)
Message-ID: <59937429.257594.1433703975898.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr> <CAP8UFD1OSSxfQOLggRv-VjE-8U=Vg7X5oe_UeFi4_yqOfXvgPA@mail.gmail.com> <1179544255.257552.1433703835857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j franck7 <j_franck7@msn.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Thomas Nguy <thomasxnguy@gmail.com>, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 21:05:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ft4-0000dX-Lu
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 21:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbFGTFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 15:05:34 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:56056 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330AbbFGTFd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2015 15:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B07CB27C4;
	Sun,  7 Jun 2015 21:05:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdE24a0Caew7; Sun,  7 Jun 2015 21:05:31 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9C2922656;
	Sun,  7 Jun 2015 21:05:31 +0200 (CEST)
In-Reply-To: <1179544255.257552.1433703835857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: git-bisect.sh : create a file if the bisection is in old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the program without having to read BISECT_TERMS. This will have to be changed in further versions if new terms are introduced.
Thread-Index: PEyJqIk6u+KNIk/TtsdZ26d8UABjEBifCenP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270978>

Thank you for the feedback. We are trying to apply all of your suggestions, but we would prefer to rebase the history before doing some of them (like renaming variables). 

About the BISECT_OLDNEWMODE file: The current implementation changes almost nothing to revision.c. We thought it was better, even if it needs a new file. The code for bisect uses BISECT_TERMS because 3 states are possible: 'bad/good mode', 'old/new mode', or 'no bisection started' (if BISECT_TERMS doesn't exist). But the other files (like revision.c) don't need all these informations, so we thought it would be good to check if a file exists instead of reusing BISECT_TERMS, which would require reading its content.
