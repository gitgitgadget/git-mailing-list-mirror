From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 15:46:28 +0200
Message-ID: <AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 15:46:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdQD-0001Su-14
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab0E0Nqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 09:46:33 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:58479 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab0E0Nqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 09:46:32 -0400
X-Greylist: delayed 2917 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2010 09:46:31 EDT
Received: by wyb36 with SMTP id 36so178870wyb.11
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=SkclasIjUzh8BezwB3PIVXRY5Si1zFpG3BU/Tgob6Ck=;
        b=UYDL34xQLfnMyOZC+CNPn27Z4fR62EmNqaSCsDEZXsxk+SirJKJM9Ty1Rq5H+6Ovfn
         qS1nbwuRIhDDTf9K3E8t4zaE6YsHiYtVp9jiYS9/Jbu1SaKA21yj9uzyA2gDbE4xJFmm
         Q67HVCBpH6F7eA9ZlmoCKUnUmVt9nEoXY8sAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=uo3CSljpFMnQrglpFSoQdoObtG4/TUqKsa17ChdkxJZ/65zxDFCa8lrNksmDu8iBMe
         Lnggu4f8taA7uN9/m+SbEaQgq8rYa5gPFaSPvIVpoIIg2kZYNeksojOtC69TgzHARXDH
         5zenQsvtWAc7gZ6iRkPkHtLLCYYQJYGtMdcAs=
Received: by 10.227.129.15 with SMTP id m15mr9808662wbs.170.1274967989977; 
	Thu, 27 May 2010 06:46:29 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 06:46:28 -0700 (PDT)
In-Reply-To: <AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147856>

On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>> =A0<kusmabite@googlemail.com> wrote:
>> =A0> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gma=
il.com> wrote:
>> =A0>> Implement the subset of poll() semantics needed by git in term=
s of
>> =A0>> select(), for use by the Interix port. =A0Inspired by commit 6=
ed807f
>> =A0>> (Windows: A rudimentary poll() emulation, 2007-12-01).
>> =A0>>
>> =A0>
>> =A0> A possible problem with this approach is that the maximum numbe=
r of
>> =A0> file descriptors poll can handle limited by RLIMIT_NOFILE, wher=
eas the
>> =A0> maximum number of file descriptors select can handle is limited=
 by
>> =A0> FD_SETSIZE.
>> =A0>
>> =A0> I don't think this is a big problem in reality, though - both v=
alues
>> =A0> seem to be pretty high in most implementations. And IIRC git-da=
emon is
>> =A0> the only one who needs more than 2, and it doesn't even check
>> =A0> RLIMIT_NOFILE.
>> =A0>
>>
>>
>> To be clear: I think this strategy is the best option (at least for
>> =A0non-Windows, where select() might be our only option).
>>
>> =A0But perhaps you should include a check along the lines of this:
>>
>> =A0if (nfds > FD_SETSIZE)
>> =A0 =A0 =A0 =A0 return errno =3D EINVAL, error("poll: nfds must be b=
elow %d", FD_SETSIZE);
>>
>> =A0Just so we can know when the code fails :)
>
> Well, per your own FD_SET example, the FD_SETSIZE on windows
> means different thing than FD_SETSIZE on old-style bitmap-based
> select() implementation.
>
> On Unix, it's max fd number + 1, on windows it's max count.
>

Are you sure this applies for all Unix, not just some given Unix-y syst=
em?

> RLIMIT_NOFILE - I don't see why it is relevant here, as you
> get error on open() when you cross the limit. =A0So how can you
> pass more than that meny fds to select()/poll()?
>

Good point, this was my bad.

--=20
Erik "kusma" Faye-Lund
