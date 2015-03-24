From: <mdconf@seznam.cz>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 13:46:27 +0100 (CET)
Message-ID: <1PE.3lxh4.2cruo5kZ0hh.1L4LoZ@seznam.cz>
References: <CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
	<47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
	<CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
	<CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
	<CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com>
Mime-Version: 1.0 (szn-mime-2.0.3)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 13:46:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaOEA-0001h9-GP
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 13:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbbCXMqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 08:46:34 -0400
Received: from smtp2.seznam.cz ([77.75.76.43]:45157 "EHLO smtp2.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbbCXMqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 08:46:33 -0400
Received: from email.seznam.cz
	by email-smtpc15b.ng.seznam.cz (email-smtpc15b.ng.seznam.cz [10.23.14.195])
	id 40b0ea7a982a1acf430f508a;
	Tue, 24 Mar 2015 13:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
	t=1427201188; bh=FqIaYmC6jk96VrG42Pn+wrvYNU9wG1DVUs3IPrH5cUA=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:References:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding;
	b=m9ET+B/xh77FFDh+mXUymWsogTcosAay0T+ks+G+vvMi5MViDCGSxUlsTg/0TLGYp
	 rsR+ICNp4ZZbtM9wxm3nV8tq1xnFkXqT6MF7y0PuzkKkXYv+Vl8E7w75EzT0s9cQ4U
	 RN4Vd2saUpGrHdaNgdzAE5kOt+HVtAHolbrmLE0I=
Received: from ip-94-113-145-153.net.upcbroadband.cz
	(ip-94-113-145-153.net.upcbroadband.cz [94.113.145.153])
	by email.seznam.cz (szn-ebox-4.4.270) with HTTP;
	Tue, 24 Mar 2015 13:46:27 +0100 (CET)
X-Mailer: szn-ebox-4.4.270
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266183>

Hi Duy, Eric,

thx a lot. So net net - I can't really achieve this. It feels like some=
thing very basic and simple so pretty surprising but guess that's what =
it is :)

Normally, I'd expect that the functionality will behave like with simil=
ar other blacklist/whitelist functionalities in Linux - that the more s=
pecific definition overrides the less specific one. And when there are =
2 on the same level then one (include or exclude) has the priority by d=
efault...

Anyways, what I am still not clear on is how come that including just t=
he 'single level folder' work?

Duy, you wrote:

"This is true. To elaborate, if we have to recurse in excluded director=
ies so that we can include some back, then the reason for excluding is =
already defeated as we may need to traverse the entire directory struct=
ure. However in this particular case where we do know in advance that o=
nly certain directories may have "re-include" rules, e.g. "db", "report=
s" or "scripts", we could keep going for a while."

=2E.. so according to that it sounds like including /db, /reports, /scr=
ipts should actually also NOT work. But it does work - i.e. when I add =
the following:

# exclude
/*

# except
!/db
!/reports
!/scripts

then any content within those 3 directories (and their sub directories)=
 is included and not ignored...

It ONLY does not work when I add more levels - e.g.:

!/reports/something

In this case neither /reports nor /reports/something or any sub directo=
ry is included.

Martin


---------- P=C5=AFvodn=C3=AD zpr=C3=A1va ----------
Od: Duy Nguyen=20
Komu: Eric Sunshine=20
Datum: 24. 3. 2015 10:40:33
P=C5=99edm=C4=9Bt: Re: Git ignore help

On Tue, Mar 24, 2015 at 8:55 AM, Eric Sunshine  wrote:
>> e.g. "db", "reports" or "scripts", we could keep going for a while. =
I
>> think I attempted to do this in the past and failed (don't remember
>> exactly why). Maybe I'll try again some time in future.
>
> I also was pretty sure that you had attempted this, but couldn't find
> a reference to it, so I didn't mention it in my response. However,
> with some more digging, I finally located it[1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/259870

Thank you. I only looked at my repo and no branch name suggested it
(if only there is google search for a git repository..). So I gave up
because of performance reasons again but that was for enabling it
unconditionaly. If we enable it via a config variable and the user is
made aware of the performance implications, I guess it would be ok. So
it's back in my back log.
--=20
Duy