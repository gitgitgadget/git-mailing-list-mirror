From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Tue, 25 Aug 2015 22:06:51 +0200
Message-ID: <vpqvbc3t9no.fsf@anie.imag.fr>
References: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
	<xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUKUw-0000us-BD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbbHYUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 16:07:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47539 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbbHYUHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:07:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7PK6nAu007546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 25 Aug 2015 22:06:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7PK6pln021165;
	Tue, 25 Aug 2015 22:06:51 +0200
In-Reply-To: <xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Aug 2015 11:50:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Aug 2015 22:06:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7PK6nAu007546
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441138009.4704@Y9J57NkL7VQ1FDo046TuUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276566>

Junio C Hamano <gitster@pobox.com> writes:

> A less ambitious option might be:
>
>   3. Invent "%(refname:<some magic>)" format similar to
>      %(refname:short) but does your thing depending on the prefix
>      refs/heads/ and refs/remotes/.

Actually, this is the option I suggest offline.

> but that will not work if the difference between local and remote
> format is not merely textual (e.g. paint them in different color).

Hmm, yes, colors would be difficult to get with this solution. Perhaps a
%(refname:autoprefix,autocolor) that would pick the color and do the
textual rendering?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
