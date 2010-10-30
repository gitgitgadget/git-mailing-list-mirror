From: demerphq <demerphq@gmail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sat, 30 Oct 2010 11:52:54 +0200
Message-ID: <AANLkTi=EPN+NrcTFP_wjmE_-VQk=bEo2UdMJOJ1uVNwB@mail.gmail.com>
References: <4B1168D4.5010902@syntevo.com>
	<4B11AD43.3070307@gmail.com>
	<4B123C80.30607@syntevo.com>
	<4B14CA79.6040408@syntevo.com>
	<4B14D381.3010706@viscovery.net>
	<4B14DA1A.4060505@syntevo.com>
	<4B14E934.9090304@viscovery.net>
	<4B150747.2030900@syntevo.com>
	<m3k4x6na81.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Singer <thomas.singer@syntevo.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 11:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC87f-0005jq-KQ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 11:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab0J3Jw5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 05:52:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62040 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab0J3Jwz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 05:52:55 -0400
Received: by vws13 with SMTP id 13so1027440vws.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AMl9+3qV0XKrNdKop86qEyXghiwhNrBsTzZprNZ29Zg=;
        b=lbxXhaH0m/fLz3bvi6xe7ogNI4aKTUFAEFkyzeAt963Hejh4Mm1TR9y7+72cnZ3Pdi
         trX93my94a3A11SjXcZUypSuvnS51cHzvCLpXI7ZE5LaeDK7gpEqHEFSejKzJDs+NVGu
         FtOkrxwPQCAG2XTHBK3Vmzlk81aNmgYv+W5q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tqds2DDUJuo8LpYTvL5T8i8wzH1JjoNBxBLWfwUw8OVUcXqj0csAhbX/rtnR76KXjr
         M6nLm46f7ExwcLgavwh8IpaXeQRU6uhNv/qakfItccB2lwY5jFWGKpx8A6SEMzkeB4Uc
         WvBHQZfmxGDn2EOTZwBn/VrCBH0QIxmE8Dkxk=
Received: by 10.224.80.133 with SMTP id t5mr811644qak.117.1288432374292; Sat,
 30 Oct 2010 02:52:54 -0700 (PDT)
Received: by 10.229.228.136 with HTTP; Sat, 30 Oct 2010 02:52:54 -0700 (PDT)
In-Reply-To: <m3k4x6na81.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160397>

On 1 December 2009 18:24, Jakub Narebski <jnareb@gmail.com> wrote:
> Thomas Singer <thomas.singer@syntevo.com> writes:
>
>> Johannes Sixt wrote:
>>> Thomas Singer schrieb:
>>>>
>>>> Is it a German Windows limitation, that far-east characters are no=
t
>>>> supported on it (but work fine on a Japanese Windows), are there d=
ifferent
>>>> (mysys)Git versions available or is this a configuration issue?
>>>
>>> It is a matter of configuration.
>>>
>>> Since 8 bits are not sufficient to support Japanese alphabet in add=
ition
>>> to the German alphabet, programs that are not Unicode aware -- such=
 as git
>>> -- have to make a decision which alphabet they support. The decisio=
n is
>>> made by picking a "codepage".
>>>
>>> On German Windows, you are in codepage 850 (in the console). The fi=
lenames
>>> =A0(that actually are in Unicode) are converted to bytes according =
to
>>> codepage 850 *before* git sees them. If your filenames contain Hira=
gana,
>>> they are substituted by the "unknown character" marker because ther=
e is no
>>> place for them in codepage 850.
> [...]
>
>>> Corollary: Stick to ASCII file names.
>>>
>>> There have been suggestions to switch the console to codepage 65001
>>> (UTF-8), but I have never heard of success reports. I'm not saying =
it does
>>> not work, though.
>>
>> Thanks for the detailed explanation. I know the differences between =
bytes
>> and characters and the needed *encoding* to convert from one to anot=
her, but
>> I did not know how Git handles it. I'm quite surprised, that -- as I
>> understand you -- msys-Git (or Git at all?) is not able to handle al=
l
>> characters (aka unicode) at the same time. I expected it would be be=
tter
>> than older tools, e.g. SVN.
>
> The problem is not with Git, as Git is (currently) agnostic with
> respect to filename encoding; for Git filenames are opaque NUL ('\0)
> terminated binary data. =A0There is some infrastructure to convert
> between filename encodings and other filename quirks (like
> case-insensivity), though...

"You can use whatever encoding you want. So long as it looks like a
standard UNIX filename."






--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
