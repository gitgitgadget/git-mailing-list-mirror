From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 22:43:36 +0200
Message-ID: <vpqy55jogzr.fsf@anie.imag.fr>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
	<vpqbo2guff7.fsf@anie.imag.fr>
	<xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
	<87hac7hmrb.fsf@mcs.anl.gov>
	<xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
	<87zjpzg592.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Oct 23 22:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ5Nj-0002rc-HT
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 22:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab3JWUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 16:50:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43885 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3JWUuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 16:50:12 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9NKhZFI007279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Oct 2013 22:43:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9NKha1V013077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 23 Oct 2013 22:43:36 +0200
In-Reply-To: <87zjpzg592.fsf@mcs.anl.gov> (Jed Brown's message of "Wed, 23 Oct
	2013 14:24:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Oct 2013 22:43:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9NKhZFI007279
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1383165816.51332@P/XbO4fPrBDxBeN0ki1g5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236553>

Jed Brown <jed@59A2.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jed Brown <jed@59A2.org> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>> I suspect that it would be too late for 2.0 we want to do sometime
>>>> early next year, though.
>>>
>>> How would you manage transition from the current behavior?  Warning
>>> people to explicitly use "." or ":/" during some interim period sounds
>>> worse than just switching the default behavior.
>>
>> "How would I"?
>>
>> You're asking that question only because you omitted too much from
>> the quote ;-)
>
> I meant that if the proposed migration plan were to be "just change it
> and people will learn" (because anything more gradual would actually be
> worse for users) then is it really too late for Git-2.0?

That may be an option. In the case of "git add -u", it was a bit more
complicated, since a badly used "git add" somehow looses data (not very
serious, you may only loos the index). So, saying after the fact "oh, by
the way, I messed up the index" was not a very good transition plan.

In the case of "grep", I'm starting to get convinced that it's OK to do
so, because the user can basically re-run grep with the right argument
if needed.

The warning could be de-activable with an advice.* option.

Again, no strong opinion here, but that seems workable to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
