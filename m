From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: escape double quotes and LF in file names
Date: Thu, 29 Nov 2012 17:57:51 +0100
Message-ID: <vpq624omjn4.fsf@grenoble-inp.fr>
References: <1354192413-9959-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5hkqsut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te7Rr-0007l0-VM
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2K2Q6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:58:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:42969 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2K2Q6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:58:36 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qATGmHFo000727
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 17:48:19 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Te7Qt-0008HI-NI; Thu, 29 Nov 2012 17:57:51 +0100
In-Reply-To: <7vy5hkqsut.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 29 Nov 2012 08:25:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Nov 2012 17:48:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qATGmHFo000727
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354812503.06088@WqVRgYpt2bUPeQD1fAL8SA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210845>

Junio C Hamano <gitster@pobox.com> writes:

>> +sub fe_escape_path {
>> +    my $path = shift;
>> +    $path =~ s/"/\\"/g;
>> +    $path =~ s/\n/\\n/g;
>> +    return $path;
>> +}
>
> Is this sufficient?
>
> My reading of the big comment at the beginning of fast-import.c is
> that you would also want to quote each backslash;

Nice catch, thanks.

Also, I was lacking the double-quotes around $path. In my defense, I had
only read the doc, not the code, and git-fast-import.txt was less
complete than fast-import.c. New patch follows, fixing the doc too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
