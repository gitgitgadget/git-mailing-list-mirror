From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] introduce git root
Date: Sun, 30 Nov 2014 12:58:54 +0100
Message-ID: <vpqoaro99xd.fsf@anie.imag.fr>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Arjun Sreedharan <arjun024@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 12:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv39k-0002Ap-QQ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 12:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbaK3L7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 06:59:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53977 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbaK3L7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 06:59:05 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sAUBwrNO002949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Nov 2014 12:58:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sAUBwsFc005090;
	Sun, 30 Nov 2014 12:58:54 +0100
In-Reply-To: <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	(Arjun Sreedharan's message of "Sun, 30 Nov 2014 10:05:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 30 Nov 2014 12:58:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sAUBwrNO002949
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1417953537.43212@dolTj4GUu0g7w08rFkHfFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260447>

Arjun Sreedharan <arjun024@gmail.com> writes:

> On 30 November 2014 at 04:38, Philip Oakley <philipoakley@iee.org> wrote:
>> From: "Arjun Sreedharan" <arjun024@gmail.com>
>>>
>>> This introduces `git root` which outputs the root directory
>>> (the directory that contains .git).
>>> The same can be accomplished by `git rev-parse --show-toplevel`.
>>> `git root` is much more intuitive and easy to remember.
>>> All it does is set the arguments for rev-parse
>>
>>
>> This may be better as an alias.
>> I've added it to my aliases list.
>>
>
> I know that. I am suggesting this to be a built-in command, without having the
> need to add as an alias.

Indeed, suggesting people to add an alias does not solve the
discoverability issue. git rev-parse --show-toplevel is not just long,
it's just not the place where people would look for (it's neither about
revision nor about parsing, so clearly, "rev-parse" is not a good place
to host the feature in the UI).

If we were to rewrite Git from scratch, then I would be all for having a
"git root" command. Given that we already have rev-parse
--show-toplevel, and that we'll have to keep it anyway for backward
compatibility, I'm a bit more hesitant ("Git is hard to use because it
doesn't have enough commands" is not a complain I hear so often ;-) ),
but still mostly positive.

If we go this way, then the documentation must be updated too. I think
the doc should still recommend "git rev-parse --show-toplevel" for
scripting until Git versions implementing "git root" are widely deployed
enough.

Also, there are other options of git rev-parse which should be dealt
with: at least --show-cdup (could be eg. "git root --relative") and
--show-prefix, but probably also others from the "Options for Files" in
the man of git-rev-parse.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
