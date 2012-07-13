From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 10:48:18 +0200
Message-ID: <vpq1ukg82st.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 10:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpbYE-0001b8-7c
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 10:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab2GMIsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 04:48:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33833 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab2GMIs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 04:48:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6D8kr5j026264
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2012 10:46:53 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SpbXv-00069B-G9; Fri, 13 Jul 2012 10:48:19 +0200
In-Reply-To: <7vwr28agcq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 12 Jul 2012 13:12:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 13 Jul 2012 10:46:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6D8kr5j026264
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342774014.90878@/ob5IGh/2AUzV2RukPhwuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201395>

Junio C Hamano <gitster@pobox.com> writes:

> But is it really true that we want to error out on missing HOME if
> we have usable XDG stuff?

Anyone else have an opinion on this?

In short, the question is whether

  export XDG_CONFIG_HOME=some-existing-dir
  unset HOME
  git config foo.baz boz

should die("$HOME is unset") or use the XDG config file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
