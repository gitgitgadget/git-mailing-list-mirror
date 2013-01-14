From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Error:non-monotonic index after failed recursive "sed" command
Date: Mon, 14 Jan 2013 20:13:24 +0100
Message-ID: <vpqobgrpoh7.fsf@grenoble-inp.fr>
References: <CAMoGvRKkSZqcoGtiebu6tuPndzOjQ1=JgQHb+iusAHpUbA2HbA@mail.gmail.com>
	<50F3F852.8060800@viscovery.net>
	<7v622zbn3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	George Karpenkov <george@metaworld.ru>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupTr-00066c-2b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab3ANTNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:13:38 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54978 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156Ab3ANTNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:13:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0EJ1Etl006530
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2013 20:01:14 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TupTI-0006HS-FZ; Mon, 14 Jan 2013 20:13:24 +0100
In-Reply-To: <7v622zbn3s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 14 Jan 2013 11:06:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 14 Jan 2013 20:01:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0EJ1Etl006530
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358794876.69126@0g9v5JGPdjH8bXMssCpqSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213519>

Junio C Hamano <gitster@pobox.com> writes:

> Everybody seems to be getting an impression that .idx is the only
> thing that got corrupt.  Where does that come from?

It's the only thing that appear in the error message. This does not
imply that it is the only corrupt thing, but gives a little hope that it
may still be the case.

Actually, I thought the "read-only" protection should have protected
files in object/ directory, but a little testing shows that "sed -i"
gladly accepts to modify read-only files (technically, it does not
modify it, but creates a temporary file with the new content, and then
renames it to the new location). So, the hope that pack files are
uncorrupted is rather thin unfortunately.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
