From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v6 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue, 23 Jun 2015 22:58:23 +0200
Message-ID: <87d20mm9ao.fsf@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1435091416-9394-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqfv5ijh20.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7VIb-0002Ai-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbFWU61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:58:27 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:43126 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881AbbFWU61 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:58:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 083A8292F;
	Tue, 23 Jun 2015 22:58:25 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDwG-i34MUNQ; Tue, 23 Jun 2015 22:58:24 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E10AE292E;
	Tue, 23 Jun 2015 22:58:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D868F20DC;
	Tue, 23 Jun 2015 22:58:24 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ok873SVp1V5X; Tue, 23 Jun 2015 22:58:24 +0200 (CEST)
Received: from Groseille (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 6039F20DA;
	Tue, 23 Jun 2015 22:58:24 +0200 (CEST)
In-Reply-To: <vpqfv5ijh20.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	23 Jun 2015 22:39:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272517>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Your git send-email does not seem to like PATCHes 08-10/10 ;-).
>
> Up to PATCH 07, the series looks good.

Yes, I get "Too many recipients" error... If I specify
--no-signoff-by-cc then this is also aborted but I get no error (at
least I've not seen it last time...). If I rerun git send-email with
only one patch, it works (even if there is no difference with the
number of recipient a priori). I'll investigate asap, not
sure it's a bug, maybe It's just me !
