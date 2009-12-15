From: Brandon Casey <drafnel@gmail.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 21:59:16 -0600
Message-ID: <ee63ef30912141959g2da1bc65y20b9bdb93a2a8d41@mail.gmail.com>
References: <20091214183337.GA25462@atjola.homenet>
	 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
	 <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
	 <7vhbrtdtth.fsf@alter.siamese.dyndns.org>
	 <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
	 <7vfx7d7zpp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	jk@silentcow.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKOZJ-0004YA-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbZLOD7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 22:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZLOD7T
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:59:19 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:32951 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZLOD7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 22:59:19 -0500
Received: by pzk1 with SMTP id 1so2774145pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 19:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FrYJu0KVeZA9lVjwig5Sh9h2RnNNAnPuwQVNuOmP1QQ=;
        b=JZnnZvMaGtYap+t5Gq3NOvDTXddIFdXQPjmZkaiYjvCKKIG9lFODx8dMPConN4IGa4
         JZqPMtlAPUh/ONuncoFzKUTCm6bR9Bd2D14phjsnl807+N1wahbUWua61vbsmFgyXoJw
         e5QI+8gkYXNmUzLT4yRlev4Y6iMakCD2BsuZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gKSPMugQY8XDNUEOU0HM5rwwsXZsu5a6PuPl1C9mB8Ag3czg80UF35a5D7bvrGnrE4
         oIUeRt1bWMMpiRdpyLfakxYRz9hSkgwGKHyLTazQlcWX6Jq5tgvgPpo7AKxvflAg9iKy
         +KrO8iawTMb1vHsD49rci6N/j0BBsNn134b0w=
Received: by 10.115.84.40 with SMTP id m40mr3811917wal.192.1260849556090; Mon, 
	14 Dec 2009 19:59:16 -0800 (PST)
In-Reply-To: <7vfx7d7zpp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135269>

On Mon, Dec 14, 2009 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Brandon Casey <drafnel@gmail.com> writes:
>
>>> It actually is the norm to use LF as the line terminator in the bod=
y text
>>> in saved messages (and trailing CR as a true part of the payload), =
and
>>> "am" traditionally used that definition. =C2=A0It is meant to read =
from "mbox"
>>> format to begin with.
>>
>> But isn't each email in the mbox file supposed to be RFC-2822 format=
ted
>> anyway?
>
> If you are talking about the same "mbox" I was talking about, which i=
s
> what I see when I peek "/var/mail/junio", then the answer is no.

Yes, that is what I was talking about, but I did not know whether the
individual mails which are separated by "From user@host ..." were
supposed to be in RFC-2822 format or not.

> Their lines are terminated with a LF, and if you insert CR at the end=
 of the
> line it would appear as true payload.

How do you insert CR at the end of the line?  Can you use mutt or
something like it to send a mail which contains a CR?  I have tried,
and I have not been able to do so.  I have tried mutt, mailx, and
sendmail.  For sendmail, I of course constructed the email headers by
hand and piped it through sendmail.  The CRLF in my tests were
converted to LF by the time they reached /var/mail/casey.

> DOSsy boxes can have C:\mail\user
> or whatever that has DOS text, of course, so there is no "supposed to=
 be".
>
> Having said that, it does not matter an iota in the real world if som=
ebody
> declares on _this list_ that it a bug that Thunderbird spits out CRLF=
 text
> in response to "Save As..." =C2=A0on platforms where LF is the natura=
l line
> terminator [*1*].

I'm not sure it is a bug, just a change in behavior.

> Whether it is a bug or not, we still need to help
> people with such a program without breaking others.

I agree.

> I saw "peeking the line ending of the first line" as suggested as a
> solution, and my gut feeling, without thinking too much about it, is
> that it is likely to be the right thing to do, especially if we do
> both the check and the necessary conversion in either mailinfo or eve=
n
> in mailsplit.

Yes, I think it will work as a work-around, unfortunately I cannot
work on implementing this at the moment.  I think the better solution,
if it is not too costly, is to detect the presence of CR and produce a
binary patch that can be sent through email and applied by git-am.

-brandon
