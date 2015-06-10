From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Wed, 10 Jun 2015 17:28:48 +0200
Message-ID: <vpqoaknr39r.fsf@anie.imag.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqa8w89d5x.fsf@anie.imag.fr>
	<1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqqa8w7oarl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2i9O-0007qS-SA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbbFJPh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:37:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46077 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365AbbFJP3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:29:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFSk3k026794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 17:28:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFSm78024874;
	Wed, 10 Jun 2015 17:28:48 +0200
In-Reply-To: <xmqqa8w7oarl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 08:15:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 17:28:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AFSk3k026794
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434554929.36746@H8LZjP1Ovaiyygk510F5SA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271308>

Junio C Hamano <gitster@pobox.com> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> I agree, I'd like to put it right after split_at_commas in a separate
>> function "trim_list". Is it a good idea even if the function is one
>> line long ?
>
> Hmph, if I have "A, B, C" and call a function that gives an array of
> addresses, treating the input as comma-separated addresses, I would
> expect ("A", "B", "C") to be returned from that function, instead of
> having to later trim the whitespace around what is returned.

It is actually doing this. But if you have " A,B,C  ", then you'll get
" A", "B", "C  ". But once you're trimming around commas, trimming
leading and trailing spaces fits well with split itself.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
