From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 1/2] status: give more information during rebase -i
Date: Wed, 03 Jun 2015 19:20:16 +0200
Message-ID: <vpqh9qobtf3.fsf@anie.imag.fr>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CLO-0005bh-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965520AbbFCRU2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 13:20:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45306 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbbFCRUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:20:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HKDod008610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 19:20:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HKG3U011073;
	Wed, 3 Jun 2015 19:20:16 +0200
In-Reply-To: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Wed, 3 Jun 2015
 10:35:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 19:20:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53HKDod008610
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433956816.9798@3V6mtqGldgOfuh43xAHf7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270702>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +	if (!fclose(fp))
> +		strbuf_detach(&buf, NULL);
> +	else
> +		strbuf_release(&buf);

Why these two cases? Aren't you leaking the buffer when calling
strbuf_detach and ignoring its return value?

(In general, there's not much to do when fclose fails actually)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
