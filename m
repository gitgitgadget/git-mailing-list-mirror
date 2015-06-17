From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 10/10] send-email: suppress meaningless whitespaces in from field
Date: Wed, 17 Jun 2015 16:54:04 +0200
Message-ID: <vpqr3pal71v.fsf@anie.imag.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1434551525-24709-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EjI-0004iS-SH
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbbFQOyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:54:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58101 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165AbbFQOyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 10:54:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5HEs3rE013207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 16:54:03 +0200
Received: from anie.imag.fr (ensi-vpn-247.imag.fr [129.88.57.247])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5HEs4vM011754;
	Wed, 17 Jun 2015 16:54:04 +0200
In-Reply-To: <1434551525-24709-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Wed, 17 Jun 2015 16:32:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 16:54:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5HEs3rE013207
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435157646.84638@uGN7Pzn5ZQm7RTBcJZJTUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271852>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

>  if (defined $sender) {
> +	$sender =~ s/^\s+|\s$//g;

I would say \s+ also for the second \s. Not really different, but it
feels wrong to iterate the substitution as many times as there are
trailing spaces to remove.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
