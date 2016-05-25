From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Wed, 25 May 2016 08:29:43 +0200
Message-ID: <vpqh9dmfy5k.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed May 25 08:29:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5SKH-0001ER-I8
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 08:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbcEYG3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 02:29:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59452 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbcEYG3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 02:29:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4P6Tg2g006287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 25 May 2016 08:29:42 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4P6ThV3007613;
	Wed, 25 May 2016 08:29:43 +0200
In-Reply-To: <b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 25 May 2016 01:31:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 25 May 2016 08:29:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4P6Tg2g006287
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464762584.19099@9zuI4IfB8fpzKgBle5T8Ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295562>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> On 05/23/2016 10:00 PM, Matthieu Moy wrote:
>
>> Your --quote-mail does two things:
>>
>> 1) Populate the To and Cc field
>>
>> 2) Include the original message body with quotation prefix.
>>

[...]

>> * If --compose is not given, don't send a cover-letter but cite the body
>>   as comment in the first patch.
>
> Then should the option imply `--annotate`, to let the user edit the
> patch containing the quoted email?

Actually, I'm not sure what the ideal behavior should be. Perhaps it's
better to distinguish 1) and 2) above, and have two options
--reply-to-email=<file> doing 1), and --quote doing 2), implying
--compose and requiring --reply-to-email.

That would be more flexible, but that would require two new options, and
I also like to keep things simple.

In any case, quoting the message without replying to it does not make
sense (especially if you add instructions to trim it: the user would not
even see it). So it its current form, I'd say --quote-email should imply
--annotate.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
