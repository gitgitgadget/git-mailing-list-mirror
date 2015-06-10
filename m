From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 2/3] git rebase -i: warn about removed commits
Date: Wed, 10 Jun 2015 17:55:48 +0200
Message-ID: <vpqlhfr4kxn.fsf@anie.imag.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433931035-20011-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpqvbevty1f.fsf@anie.imag.fr>
	<1634653813.334490.1433951239962.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iMM-0007TU-KE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbbFJP4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:56:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46637 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964854AbbFJPz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:55:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFtl3S031537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 17:55:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFtmk8025403;
	Wed, 10 Jun 2015 17:55:48 +0200
In-Reply-To: <1634653813.334490.1433951239962.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 10 Jun 2015 17:47:19 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 17:55:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AFtl3S031537
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434556550.60356@ppkSvPhBhWM5QEm5xjYZgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271312>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> > +                        warn_file "$todo".miss
>> 
>> I would find it more elegant with less intermediate files, like
>> 
>> git rev-list $opt <"$todo".miss | while read -r line
>> do
>>         warn " - $line"
>> done
>
> I am not really sure since I also use warn_file to display the bad
> commands and SHA-1 in 3/3.

I noticed this later indeed. But had the function been eg. warn_pipe,
you could have written

git rev-list $opt <"$todo".miss | warn_pipe

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
