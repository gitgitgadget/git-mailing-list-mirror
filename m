From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 11:41:44 +0200 (CEST)
Message-ID: <2070840481.381260.1433929304815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqbngpl5zu.fsf@anie.imag.fr> <550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqq1thkwg5r.fsf@gitster.dls.corp.google.com> <1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqk2vcat2t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 11:40:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2cV5-00012o-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 11:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbFJJko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 05:40:44 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55502 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850AbbFJJkm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 05:40:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3009C2844;
	Wed, 10 Jun 2015 11:40:40 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kez-ohK+fwPt; Wed, 10 Jun 2015 11:40:40 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1B6592841;
	Wed, 10 Jun 2015 11:40:40 +0200 (CEST)
In-Reply-To: <vpqk2vcat2t.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: simplify the add of new bisect terms
Thread-Index: J2fIGifDnQqK9SX2s2lffP7lwYAxsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271279>

But ENOENT is not a normal case at all. Should we not treat it the same
way as other fopen() errors ? (either going on with default case or
returning an error)

Would :

>	if (!fp) {
>			die("could not read file '%s': %s",
>				filename, strerror(errno));
>	} else {

be ok ?
