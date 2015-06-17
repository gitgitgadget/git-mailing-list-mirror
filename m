From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on
 parse_address_line
Date: Thu, 18 Jun 2015 01:39:40 +0200 (CEST)
Message-ID: <52249185.592562.1434584380271.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqoakejq38.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Thu Jun 18 01:39:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Mv9-0004XP-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 01:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbbFQXiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 19:38:18 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:45368 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091AbbFQXiP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 19:38:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7922F488D4;
	Thu, 18 Jun 2015 01:38:13 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5haxlNneKhlk; Thu, 18 Jun 2015 01:38:13 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5BA7B488C8;
	Thu, 18 Jun 2015 01:38:13 +0200 (CEST)
In-Reply-To: <vpqoakejq38.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email: reduce dependancies impact on parse_address_line
Thread-Index: 4/QvjeIrAXpQjVG6Q4e1vuvTcU5xZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271929>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes

> > +	my $commentrgx=qr/\((?:[^)]*)\)/;
> > +	my $quotergx=qr/"(?:[^\"\\]|\\.)*"/;
> > +	my $wordrgx=qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
> 
> Spaces around = please.
> ...
> > +	foreach my $token (@tokens) {
> > +	    if ($token =~ /^[,;]$/) {
> 
> Here and below: you're indenting with a 4-column offset, it should be 8.

Should have spent more time on the form... Thanks

> The code below is a bit hard to read (I'm neither fluent in Perl nor in
> the RFC ...). A few more comments would help. A few examples below (it's
> up to you to integrate them or not).

Ok, I'll add comments for the hardest parts.
