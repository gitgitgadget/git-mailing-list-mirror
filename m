From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 17:13:02 +0100
Message-ID: <cb7bb73a1002060813l451ad669nf9ba2dc4643bbd58@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002061416.29481.jnareb@gmail.com> <cb7bb73a1002060615o261d974cnf347ba5af5ae324b@mail.gmail.com> 
	<201002061534.02972.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 17:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdnHk-0001mL-QJ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 17:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0BFQNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 11:13:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:6872 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0BFQNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 11:13:23 -0500
Received: by ey-out-2122.google.com with SMTP id 25so338512eya.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YqLPd7yJdyi2EAZNPOUMVWUuPGovmqNpmK6gGs3JZYA=;
        b=ai18BT3KfL55ev2etT1y2BcecZbdGGNk4rDaiifebkG3R3RXf5wJmUbSjTUXCxSLHr
         UwAWbCTYXCUj+1paR9AJycQ+/6nDYmtMelBAkM9ujHQS/SYL5GJD5Rcalm+w7vzlYnu3
         meDHm6ZoydhjJw9ASDBBrub7LQQi0qtzSWaCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bzi1UEaCQq9hTuIgeTTiSjqpKgJXhmbZEHoucTz2kMw6ZkhcHIsWA7jj1hh6/+dnjV
         lm9DfNzCUHtW4Jd+xh4JYaW7FL0MJk0ZwrqJfL2zTlCKdejYHEW1fKEA5tt9BAkPxJY7
         t/cKKEPN5i01/Qk54uYrD6JIeApOhN7gYsJJU=
Received: by 10.213.57.10 with SMTP id a10mr275016ebh.68.1265472802115; Sat, 
	06 Feb 2010 08:13:22 -0800 (PST)
In-Reply-To: <201002061534.02972.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139176>

On Sat, Feb 6, 2010 at 3:34 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Giuseppe Bilotta wrote:
>> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>>> On Thu, 4 Jan 2010, Giuseppe Bilotta wrote:
>
> [...]
>>>> =A0# return all refs matching refs/notes/<globspecs> where the glo=
bspecs
>>>> =A0# are taken from the notes feature content.
>>>> =A0sub get_note_refs {
>>>> + =A0 =A0 local $/ =3D "";
>>>> +
>>>
>>> Why it is needed here? =A0Why you want to use empty lines as termin=
ator
>>> (which means reading whole paragraphs), while treating two or more
>>> consecutive empty lines as a single empty line (according to
>>> perlvar(1))?
>>>
>>> If you want to slurp whole file, this should be
>>>
>>> =A0 =A0 =A0 =A0local $/;
>>>
>>> or more explicit
>>>
>>> =A0 =A0 =A0 =A0local $/ =3D undef;
>>
>> Ah, sorry, for some reason I thought "" was the default.
>
> If you wanted to use default value, why set it at all?


Ach, sorry, forgot to reply to the first part of the question. It's
used in a context where $/ is locally set to \0, so it needs to be
reset.

--=20
Giuseppe "Oblomov" Bilotta
