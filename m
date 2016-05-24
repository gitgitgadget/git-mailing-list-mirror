From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 21:22:39 +0200
Message-ID: <vpqa8jfmfb4.fsf@anie.imag.fr>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
	<1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com>
	<vpq37p74nu1.fsf@anie.imag.fr>
	<CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 21:23:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Hv4-0001FX-QG
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbcEXTXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:23:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43429 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073AbcEXTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:23:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4OJMb4S019744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 24 May 2016 21:22:37 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4OJMdu6030312;
	Tue, 24 May 2016 21:22:39 +0200
In-Reply-To: <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
	(Junio C. Hamano's message of "Tue, 24 May 2016 09:07:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 24 May 2016 21:22:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4OJMb4S019744
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464722559.32917@eIo0XlaD+gM+/4rD8O8Ppg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295525>

Junio C Hamano <gitster@pobox.com> writes:

> On Tue, May 24, 2016 at 5:55 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> So, when trying a forbidden push, Git would deny it and the only way to
>> force the push would be to remove the blacklist from the config, right?
>>
>> Probably the sanest way to go. I thought about adding a "git push
>> --force-even-if-in-blacklist" or so, but I don't think the feature
>> deserves one specific option (hence add some noise in `git push -h`).
>
> Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder
> how this is different from setting pushURL to /dev/null or something
> illegal and replace that phony configuration value when you really need
> to push?

Changing pushURL is something you can do per-repo, but the
whitelist/blacklist could be done user-wide or even system-wide
(typically, if the sysadmin has control on everybody's /etc/gitconfig,
there can be a default policy to prevent accidental push to some URLs).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
