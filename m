From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Thu, 09 Jun 2016 08:01:30 +0200
Message-ID: <vpqbn3ayk79.fsf@anie.imag.fr>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-2-tom.russello@grenoble-inp.org>
	<xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
	<f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org>
	<xmqqvb1jmzly.fsf@gitster.mtv.corp.google.com>
	<3090c61c-533b-7119-f5e4-7d99e62f6da4@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, e@80x24.org, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:01:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAt2L-0002X9-DY
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 08:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423203AbcFIGBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 02:01:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55009 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161826AbcFIGBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 02:01:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5961TE6017400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 08:01:29 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5961UcR026297;
	Thu, 9 Jun 2016 08:01:30 +0200
In-Reply-To: <3090c61c-533b-7119-f5e4-7d99e62f6da4@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 18:46:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 09 Jun 2016 08:01:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u5961TE6017400
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466056894.4715@L6lW/Mm5qpeS6LgSzM8eVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296870>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> On 06/08/2016 06:09 PM, Junio C Hamano wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>
>>> Actually we had issues when trying to refactor send-email's email
>>> parsing loop [1]. Email addresses in output file `commandeline1` in
>>> tests weren't sorted the same way as the reference file it was
>>> compared to. E.g.:
>>>
>>>   !nobody@example.com!
>>>   !author@example.com!
>>>   !one@example.com!
>>>   !two@example.com!
>>
>> And the reason why these addresses that are collected from the same
>> input (i.e. command line, existing e-mail fields, footers, etc.) are
>> shown in different order in your implementation is...?
>
> It's not shown in different order in our implementation, it's just a
> leftover of my refactor attempt [1].

I think the refactoring makes sense, but having this patch as PATCH 1/6
in a series about --in-reply-to confuses reviewers: they would expect
this patch to be useful to the others in the series.

If you have "reply to a message in a file" ready without the
refactoring, and a mostly ready refactoring, then I think it makes sense
to have two patch series, the first being only "reply to a message in a
file". If the refactoring itself is not ready, you may send a separate
series "tests clean up" and explain on the cover-letter that it's, well,
only a test clean up.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
