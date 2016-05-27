From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Fri, 27 May 2016 11:06:54 +0200
Message-ID: <vpq4m9juaxd.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
	<vpqh9dmfy5k.fsf@anie.imag.fr>
	<xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
	<vpqeg8q5b6f.fsf@anie.imag.fr>
	<xmqqr3cqypg6.fsf@gitster.mtv.corp.google.com>
	<vpq8tyyt2fv.fsf@anie.imag.fr>
	<e678afcb-b378-9829-fae4-1f1ed38ee593@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Fri May 27 11:07:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Djd-0002m1-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 11:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbcE0JHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 05:07:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60754 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690AbcE0JHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 05:07:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4R96rU9013816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 May 2016 11:06:54 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4R96sAR003092;
	Fri, 27 May 2016 11:06:54 +0200
In-Reply-To: <e678afcb-b378-9829-fae4-1f1ed38ee593@grenoble-inp.org> (Samuel
	GROOT's message of "Thu, 26 May 2016 02:08:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 27 May 2016 11:06:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4R96rU9013816
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464944816.66342@Qz5j6T5V8hOGT3UNqide5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295743>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> On 05/25/2016 08:31 PM, Matthieu Moy wrote:
>> So, a possible UI would be:
>>
>>   git send-email --in-reply-to=<id> => just set In-Reply-To: field.
>>
>>   git send-email --in-reply-to=<file> => set In-Reply-To, To and Cc.
>>
>>   git send-email --in-reply-to=<file> --cite => in addition, add the
>>     body of the message quoted with '> '.
>>
>>   git send-email --in-reply-to=<id> --fetch => fetch and do like <file>
>>     using the default configuration for fetch.
>
> We designed a similar UI, except for the --fetch option:
>
> We wanted to try to fetch the email from a distant server (e.g. gmane)
> if that server address was set in the config file, and populate the
> To:/Cc: fields.
>
> If the file cannot be downloaded, or server address not set, just fill
> the Reply-to header.

I'm not sure this is right. I'd typically configure gmane in my
user-wide config file, so I'd have it configured all the time, but I may
not always want to fetch from it (e.g. replying to a message which is
not on a mailing-list, or if gmane is down, or ...).

Fetching by default would clearly work in most cases, but for the few
remaning cases it may be painful for the user if the only way to disable
fetching is to remove the configuration from the config file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
