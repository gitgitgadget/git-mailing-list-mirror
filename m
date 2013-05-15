From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 18:27:52 +0200
Message-ID: <vpqhai4fbsn.fsf@grenoble-inp.fr>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 18:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UceZB-000240-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 18:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759115Ab3EOQ2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 12:28:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36829 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758986Ab3EOQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 12:28:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4FGRoec008178
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 18:27:50 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UceYT-0007xl-0O; Wed, 15 May 2013 18:27:53 +0200
In-Reply-To: <7vy5bgckr4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 08:42:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 15 May 2013 18:27:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FGRoec008178
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369240075.73833@9DBL7MQIz07ywKby8/BlkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224421>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Many tutorials tell the users to set color.ui=auto as a very first step.
>> These tutorials would benefit from skiping this step and starting the
>> real Git manipualtions earlier. Other beginners do not know about
>> color.ui=auto, and may not discover it by themselves, hence live with
>> black&white outputs while they may have prefered colors.
>>
>> A few people (e.g. color-blind) prefer having no colors, but they can
>> easily set color.ui=never for this (and googling "disable colors in git"
>> already tells them how to do so).
>
> The above two paragraphs do not make a good justification [*1*].
> The former can just as easily websearch for "enable colours in git"

I disagree: I do not know anyone who would be really harmed by colors
(and such users would most likely have a terminal configured without
colors I guess), so although I can imagine some people feeling less
comfortable, disabling colors can be deferred to much later in the
learning process.

When I teach Git to students (a relatively short tutorial), I currently
ask them to type a ~/.gitconfig containing color.ui=auto before anything
else. If this was the default, I would skip this completely from the
beginner-oriented doc, and I would mention color.ui=never only to people
complaining about colors. It's really about _skipping_ the color-related
stuff from the newbie docs, not about reverting them.

Also, as my message points out, with "disabled by default", many people
do not know that it is possible to have it, hence won't google for
anything related to colors. There's no symmetry either here: with colors
enabled by default, people will know that Git can use colors.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1009bfc..97550be 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -913,11 +913,12 @@ color.ui::
>>  	as `color.diff` and `color.grep` that control the use of color
>>  	per command family. Its scope will expand as more commands learn
>>  	configuration to set a default for the `--color` option.  Set it
>> +	to `false` or `never` if you prefer Git commands not to use
>> +	color unless enabled explicitly with some other configuration
>> +	or the `--color` option. Set it to `always` if you want all
>> +	output not intended for machine consumption to use color, to
>> +	`true` or `auto` (this is the default since Git 2.0) if you
>> +	want such output to use color when written to the terminal.
>
> OK, so this is planned for 2.0?

We've lived without this for years, so I'd say it can wait untill Git
2.0. It may give a "Wow" effect to some users when upgrading ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
