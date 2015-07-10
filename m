From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Fri, 10 Jul 2015 14:18:11 +0200
Message-ID: <vpqd2005hq4.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-4-git-send-email-karthik.188@gmail.com>
	<vpqfv4x792z.fsf@anie.imag.fr>
	<CAOLa=ZRs560_YBVMTpfKBvB1BF6ts+X_JGFTzhp7A_+YsjwqqQ@mail.gmail.com>
	<CAOLa=ZROk=+mW8uVjpuxMVY9NP0eW4yk2Za8xYW5MAFWSGzXRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 14:18:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDXG3-00036D-CL
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 14:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbbGJMST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 08:18:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42761 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbbGJMSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 08:18:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6ACI9lK011740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 10 Jul 2015 14:18:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6ACIBNF005711;
	Fri, 10 Jul 2015 14:18:11 +0200
In-Reply-To: <CAOLa=ZROk=+mW8uVjpuxMVY9NP0eW4yk2Za8xYW5MAFWSGzXRw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 10 Jul 2015 16:31:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 10 Jul 2015 14:18:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6ACI9lK011740
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437135494.17734@0E7iLiWyr1MfQztDyTz6mA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273817>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Fri, Jul 10, 2015 at 4:22 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Thu, Jul 9, 2015 at 6:59 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Add support to sort by version using the "v:refname" and
>>>> "version:refname" option. This is achieved by using the
>>>> 'version_cmp()' function as the comparing function for qsort.
>>>
>>> You should elaborate on why you need this. Given the context, I can
>>> guess that you will need this to implement tag, but for example I first
>>> wondered why you needed both version: and v:, but I guess it comes from
>>> the fact that 'git tag --sort' can take version:refname or v:refname.
>>>
>>> I think this deserves a test and documentation in for-each-ref.txt.
>>
>> I'll add it to "for-each-ref.txt" documentation.
>> About the tests, there are already tests for the same in git-tag.txt and
>> that's the only reason I did not repeat the tests in for-each-ref.
>>
>
> But since the porting is in a later commit, will add tests to for-each-ref.

Yes: to me "it's tested through 'git tag'" is a good argument to do only
a superficial test, check that 'for-each-ref --sort v:refname' activate
the sorting, but no detailed corner-case testing. But not a good
argument to have no test at all on for-each-ref.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
