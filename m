From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/7] bisect: replace hardcoded "bad|good" by variables
Date: Mon, 22 Jun 2015 15:47:34 +0200
Message-ID: <vpqvbefc0sp.fsf@anie.imag.fr>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433953472-32572-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpq1thi465i.fsf@anie.imag.fr>
	<134997869.703022.1434976943783.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 22 15:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z724t-0006B4-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 15:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933574AbbFVNrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 09:47:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49486 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933561AbbFVNrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 09:47:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MDlWCK031556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Jun 2015 15:47:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MDlYVm013908;
	Mon, 22 Jun 2015 15:47:34 +0200
In-Reply-To: <134997869.703022.1434976943783.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 22 Jun 2015 14:42:23 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Jun 2015 15:47:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5MDlWCK031556
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435585653.22085@xL2fLUtE+a6Zu4Alb3j+hA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272339>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 
>
>>Being an acceptable ref name is a constraint you have to check (Junio 
>>already mentionned check-ref-format). I think quoting variables makes 
>>sense too 
>
> I don't get how 'git check-ref-format' works exactly. It says it needs 
> at least one slash in the ref name. So it would not be good for bisect 
> terms.

At some point, refs/bisect/$good and refs/bisect/$bad-$sha1 will become
refs, so you should check refs/bisect/$good and refs/bisect/$bad with
check-ref-format (I think the -$sha1 suffix will be accepted by
construction).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
