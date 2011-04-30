From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH 0/6] gitweb: Improve ctags, introduce categories
Date: Sat, 30 Apr 2011 22:36:29 +0200
Message-ID: <BANLkTi=cckKr3baDZAktAjz8F=JXjQJWiA@mail.gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
	<7v8vuswxqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 22:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGGu6-0007Y7-6R
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 22:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073Ab1D3Ugc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2011 16:36:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51447 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab1D3Ugb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2011 16:36:31 -0400
Received: by pzk9 with SMTP id 9so2584157pzk.19
        for <git@vger.kernel.org>; Sat, 30 Apr 2011 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EyJaKFwORvWIY1kiTI1GLF4lczKuXegPf9r0CWlHeo0=;
        b=Xry/EXifgWs1q/9rZzMAHy8Sd6tjuTXoVg7rKLWZzTQraZMIY4QiwG3uWBBS9K19tL
         9jaKltVvB3YFlpctAn/9WY+Z/tqs/cxcZJjqvoSbfE+6c2Sp9sSDS47qUv25YPuKkX1P
         0YssqvDiD2tgXOEeWIu7TrUkXHK6D3k2pm2wI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ceNdKPctyi+wPzHPiQWxdGad8UGSgSZaHNMwPE8RKySqPkg3DBGUF80E2OooFsGTi2
         mDcpP8MUCOxQFAAlSU5bzgY0hg2g9DGSysC5TS6pU2WzvVNB6z9URyry9bxNrKZswOTB
         O3C6/NgQ6cgblaVokyERmEXnkzBppuoPDAssw=
Received: by 10.142.199.12 with SMTP id w12mr2355868wff.259.1304195789335;
 Sat, 30 Apr 2011 13:36:29 -0700 (PDT)
Received: by 10.142.192.8 with HTTP; Sat, 30 Apr 2011 13:36:29 -0700 (PDT)
In-Reply-To: <7v8vuswxqs.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: h6ydUpg4WVzqLGpj4kL6xNRl1W0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172525>

On 29 April 2011 23:31, Junio C Hamano <gitster@pobox.com> wrote:
> A tangent. It is curious why [PATCH 2/6] alone ended up with an encod=
ed
> "Subject" header, like this:
>
> =C2=A0Subject: =3D?UTF-8?q?=3D5BPATCH=3D202/6=3D5D=3D20gitweb=3D3A=3D=
20Change=3D20the=3D20
> =C2=A0 way=3D20=3D22content=3D20tags=3D22=3D20=3D28=3D27ctags=3D27=3D=
29=3D20are=3D20handled?=3D
>
> The message actually has the above as a long single line, as can be s=
een at
> http://article.gmane.org/gmane.comp.version-control.git/172479/raw
>
> Just being curious.

This seems as the same thing that I reported on 2010-04-25 23:35:49Z,
<http://thread.gmane.org/gmane.comp.version-control.git/145774>. If the=
re's a
character above U+007F in the log message below line #2, the Subject: l=
ine is
garbled. In this case it is, it's the "=C3=B6" in Uwe's name that leads=
 to this
error.

A test to reproduce this is at <https://gist.github.com/378785>, but it=
 seems
as this was fixed between v1.7.4.1-292-ge2a57aa and v1.7.4.1-343-ga91df=
69 ,
probably happened in dc7f96f (Merge branch 'jk/format-patch-multiline-h=
eader').
The patch at <http://article.gmane.org/gmane.comp.version-control.git/1=
72479/raw>
was generated with git-1.7.3, so it would trigger the error in this cas=
e.

Regards,
=C3=98yvind
