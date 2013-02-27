From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 6/6] git-send-email: use git credential to obtain password
Date: Wed, 27 Feb 2013 15:20:35 +0100
Message-ID: <vpqhakx4z4c.fsf@grenoble-inp.fr>
References: <cover.1360677646.git.mina86@mina86.com>
	<cover.1360677646.git.mina86@mina86.com>
	<32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 15:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAhsg-0007AB-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 15:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130Ab3B0OUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 09:20:50 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49052 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760117Ab3B0OUt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 09:20:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1REKX8p025178
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Feb 2013 15:20:33 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UAhs3-0005iH-BP; Wed, 27 Feb 2013 15:20:35 +0100
In-Reply-To: <32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Tue, 12 Feb 2013 15:02:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Feb 2013 15:20:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1REKX8p025178
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362579636.96488@VuwA2QAQy2dy27jRZ0OoEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217205>

Michal Nazarewicz <mpn@google.com> writes:

> +	$auth = Git::credential({
> +		'protocol' => 'smtp',
> +		'host' => join(':', $smtp_server, $smtp_server_port),

At this point, $smtp_server_port is not always defined. I just tested
and got

Use of uninitialized value $smtp_server_port in join or string at
git-send-email line 1077.

Other than that, the whole series looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
