From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue, 9 Feb 2010 19:37:44 +0100
Message-ID: <40aa078e1002091037j226eb911v215a5564cba42142@mail.gmail.com>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	 <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <20100209150650.GA15982@sigill.intra.peff.net>
	 <40aa078e1002090713h7e7d2f93r4cca9649e98db735@mail.gmail.com>
	 <20100209165745.GA21135@coredump.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, gitster@pobox.com,
	git@vger.kernel.org, jwhite@codeweavers.com,
	robertshearman@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neuyh-00032n-5o
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab0BIShr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 13:37:47 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:61844 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab0BIShq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 13:37:46 -0500
Received: by ewy28 with SMTP id 28so4159628ewy.28
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SXRRgWaCRUyU6gTsOW/mBIuEfV6r/n5RTiknpFIZGnM=;
        b=tayQoJ3crfca1K899ZnFLz4VciqCzxO6VuZ46HJbopIm3MrH36Blx8j0ZuoUoAJhul
         rk1hBrsutJWtRhVnn38l/w2944qW+U+3zoPiEWW4f4DjgLfZqIYEoVTrYxJLrNvlSry8
         jsImJJsASHiHKIdHv5aZ3iC/Q3t5vf4pl2Wxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=fw4lGHbcjDB1o9AOqbFxYnuu3G4D3vXZviIpmWF/SKkbR6yyb9GWsyfTef3xUr6yEu
         0MvOnhYtGtQfbhgYv6+vac20fBlZVPZVoaHSo73e11GLKYOtakS0DFAO9nupA8XaKEco
         eBdKoFZKKhB9UebwPibPdm4BffTrsfHZOkcCU=
Received: by 10.216.170.213 with SMTP id p63mr1043104wel.33.1265740664357; 
	Tue, 09 Feb 2010 10:37:44 -0800 (PST)
In-Reply-To: <20100209165745.GA21135@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139430>

On Tue, Feb 9, 2010 at 5:57 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 09, 2010 at 04:13:26PM +0100, Erik Faye-Lund wrote:
>
>> On Tue, Feb 9, 2010 at 4:06 PM, Jeff King <peff@peff.net> wrote:
>> > On Tue, Feb 09, 2010 at 09:09:01PM +0900, Hitoshi Mitake wrote:
>> >
>> >> =A0base64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
22 ++++++++
>> >> =A0base64.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
36 +++
>> >> =A0md5.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
600 +++++++++++++++++++++++++++++++++++++++
>> >> =A0md5.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 61 ++++
>> >> =A0md5_hmac.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0137=
 +++++++++
>> >> =A0md5_hmac.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 36=
 +++
>> >
>> > That's a lot of extra code. Doesn't imap-send already conditionall=
y
>> > compile against openssl for starttls support? Can't we just get al=
l
>> > three of these algorithms from openssl?
>> >
>>
>> I don't think OpenSSL includes SASL-support that is needed for
>> STARTTLS. But it might make sense to use something like GSASL[1]
>> instead of rolling all the SASL-mechanisms ourselves.
>
> Did you mean "SASL-support that is needed for CRAM-MD5"? The SASL nee=
ded
> for that is pretty simple. Hitoshi's patch 3/4 does all of that alrea=
dy
> in less than 100 lines. =A0Using a "real" sasl library might get us m=
ore
> authentication methods than CRAM-MD5, but I don't know that anyone
> necessarily cares about them.
>

No, that's not what I meant. I agree that CRAM-MD5 should be
sufficient, but to be honest I'd already thought that once you have an
SSL connection, plaintext would also be sufficient. So I'm thinking of
this addition as a "hmpf, some server requires stuff that is really
over the top - perhaps we'll have this problem later with other
servers, and we'd be better off just using some well-tested
implementation". But that's kinda philosophical.

> But using openssl to replace the low-level routines in patches 1+2 wo=
uld
> drop almost 1000 lines, and not significantly change his 3/4.
>
> Personally, I don't care either way about using a SASL library. It's =
an
> extra dependency, but one that is optional for this feature. But
> somebody will have to do the work to integrate it, whereas I think us=
ing
> openssl is only a few lines of change. If somebody wants to do that
> work, then great.
>

I agree.


--=20
Erik "kusma" Faye-Lund
