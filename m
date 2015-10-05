From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Mon, 05 Oct 2015 08:40:05 +0200
Message-ID: <vpqbncd6coq.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-4-git-send-email-Karthik.188@gmail.com>
	<vpqwpv49so7.fsf@grenoble-inp.fr>
	<CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com>
	<vpqfv1q5xop.fsf@grenoble-inp.fr>
	<xmqq1tda1njq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZizRg-0005gP-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 08:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbJEGkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 02:40:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39365 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbbJEGkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 02:40:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t956e5ij025682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 5 Oct 2015 08:40:05 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t956e5fH023455;
	Mon, 5 Oct 2015 08:40:05 +0200
In-Reply-To: <xmqq1tda1njq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 04 Oct 2015 11:44:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 05 Oct 2015 08:40:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t956e5ij025682
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444632009.35694@tMsab4COfHgRdolXpPAUBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279037>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>>>> This adds %(path) and %(path:short) atoms. The %(path) atom will print
>>>>> the path of the given ref, while %(path:short) will only print the
>>>>> subdirectory of the given ref.
>>>>
>>>> What does "path" mean in this context? How is it different from
>>>> %(refname)?
>>>>
>>>> I found the answer below, but I could not guess from the doc and commit
>>>> message. Actually, I'm not sure %(path) is the right name. If you want
>>>> the "file/directory" analogy, then %(dirname) would be better.
>>>>
>>>
>>> Noted will change.
>>
>> Note: I don't completely like %(dirname) either. I'm convinced it's
>> better than %(path), but there may be a better option.
>
> Is that a derived form of the refname, just like %(refname:short)
> that is 'master' for a ref whose %(refname) is 'refs/heads/master'
> is a derived form of %(refname), and ":short" is what tells the
> formatting machinery what kind of derivation is desired?
>
> If so would %(refname:dir) & %(refname:base) be more in line with
> the overall structure?

Yes, indeed much better. It's still about the refnames, so a specialized
version of %(refname) makes much more sense than a new atom.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
