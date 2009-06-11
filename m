From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch 
	to be merge
Date: Thu, 11 Jun 2009 23:30:50 +0200
Message-ID: <adf1fd3d0906111430m28ef712axd55942b19505a5b3@mail.gmail.com>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
	 <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0906090029s2aa7fe19j7b1005997d70b92c@mail.gmail.com>
	 <adf1fd3d0906090107w994de3chb39071e5911a59ae@mail.gmail.com>
	 <7veittrete.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0906090150k575c538ds28cd8c1a96909e9e@mail.gmail.com>
	 <adf1fd3d0906090516l6b1d5ec1rdc78ffffa116b765@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 23:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErrO-0003vX-Sd
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 23:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZFKVav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbZFKVau
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 17:30:50 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63336 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbZFKVat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2009 17:30:49 -0400
Received: by bwz9 with SMTP id 9so1737701bwz.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 14:30:50 -0700 (PDT)
Received: by 10.204.63.143 with SMTP id b15mr2932545bki.8.1244755850631; Thu, 
	11 Jun 2009 14:30:50 -0700 (PDT)
In-Reply-To: <adf1fd3d0906090516l6b1d5ec1rdc78ffffa116b765@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121364>

2009/6/9 Santi B=E9jar <santi@agolina.net>:
> 2009/6/9 Santi B=E9jar <santi@agolina.net>:
>> 2009/6/9 Junio C Hamano <gitster@pobox.com>:
>>> Santi B=E9jar <santi@agolina.net> writes:
>>>
>>>>> git pull --rebase tags v1.6.0
>>>>
>>>> In fact: git pull --rebase remote tags v1.6.0
>>>>
>>>> But this still works because oldremoteref defaults to defaults_mer=
ge.
>>>> So the only behavior change is when a remote branch is
>>>> rebased/retagged, and you have worst problems then. I think noone =
used
>>>> the rebased functionality in this way, so I don't think it is wort=
h to
>>>> support it. But if someone think it is important I'll do it.
>>>
>>> I personally do not think supporting such a form of input is absolu=
tely
>>> necessary. =A0Even though technically it might be a regression, if =
it is so
>>> rare a form, we can simply say "this strange form used to work, but=
 now it
>>> does not; you can use this form instead to do the same thing", and =
move
>>> on.
>>
>> OK.
>>
>
> At the end it was a little patch to get this corner case working. Her=
e
> it is the patch to squash (I'll send later a proper patch mail, with =
a
> test).
>
> And this additional sentence in the commit log:
>
> No behavior changes. The new function behaves like the old code used =
in
> "git pull --rebase".
>

At the end the original code does not handle this case, as it asumes
that the rebase ref is a remote commit in refs/remotes/$origin/$ref.
So the new code behaves exactly like the old one. I'll send all again
with an updated commit message explaining all this.

Santi
