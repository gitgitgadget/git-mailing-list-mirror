From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Tue, 16 Jun 2015 23:18:53 +0200 (CEST)
Message-ID: <183774662.562924.1434489533064.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr> <1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr> <835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqoakh74fw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 23:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4yEl-0006yf-H9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 23:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbbFPVRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 17:17:36 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:37606 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754493AbbFPVRe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2015 17:17:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 40ECB488C1;
	Tue, 16 Jun 2015 23:17:32 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXCkSPsBzMhT; Tue, 16 Jun 2015 23:17:32 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2A109488BC;
	Tue, 16 Jun 2015 23:17:32 +0200 (CEST)
In-Reply-To: <vpqoakh74fw.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: MLOHC3/k5Vz9uj42mzCpKaSgo4JXgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271798>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

># terms_defined is 0 when the user did not define the terms explicitely
># yet. This is the case when running 'git bisect start bad_rev good_rev'
># before we see an explicit reference to a term.
>terms_defined=0

The thing is:
'git bisect reset
git bisect new HEAD
(autostart ?) y'

is strictly equivalent to

'git bisect reset
git bisect start
git bisect new HEAD'

In both case terms_defined value would be 0 while we kinda know that a
term has been used. It just that in the code it is not taken in account yet.
I don't really mind doing the change but I'm just pointing out that it can be
confusing.

Thanks.
