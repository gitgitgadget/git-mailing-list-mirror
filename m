From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/8] Makefile: add NEEDS_RESOLV to optionally add -lresolv 
	to compile arguments
Date: Sat, 6 Jun 2009 20:02:19 -0500
Message-ID: <ee63ef30906061802m4153b9e6i1b289897f2f7f52a@mail.gmail.com>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
	 <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
	 <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
	 <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
	 <m3y6s54y8g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	David Syzdek <david@syzdek.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 03:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD7Jr-0004K4-Qg
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 03:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZFGBde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 21:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbZFGBdd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 21:33:33 -0400
Received: from mail-qy0-f177.google.com ([209.85.221.177]:39381 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZFGBdc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 21:33:32 -0400
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jun 2009 21:33:32 EDT
Received: by qyk7 with SMTP id 7so826417qyk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G5qgO9rYWCyh5dr+lcp7FZRNm7erSs/HSC8vorCXpjQ=;
        b=Q1AKPu8yUH4w5gYW9uDbfRT0xyLbSQyp7YIJhZ9qTpIq2T00A4BZZ3qys/gWAcOdEW
         5SwpIFSQ8H3npM7NLllPOfmDNSZ+3OKMmmW9PPTBN8TYDD6IMSIprk30Zcau2WlB++PO
         scUTu6CtnZPi0SKoIqNAk6d5qmMohfvtU/rHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oyWX0eVGmD2Mu7cjrzg2fLdZCsS3lX5OKLbj2ZMXpU/8ADqU5993Ub4YJaKFT/jUi8
         ATz71RQfw9pWPbLOpEE1hFUC4om0nVP2NTBn5nF5g3CcjR6a5McbCuzXeWO7GTkmAhi1
         MAUDFO28+XwnT0pi727nvQKyUfwkZbQB8utWg=
Received: by 10.220.98.17 with SMTP id o17mr3024036vcn.86.1244336539353; Sat, 
	06 Jun 2009 18:02:19 -0700 (PDT)
In-Reply-To: <m3y6s54y8g.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120950>

On Sat, Jun 6, 2009 at 2:29 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> This library is required on Solaris when compiling with NO_IPV6 sinc=
e
>> hstrerror resides in libresolv. =C2=A0Additionally, Solaris 7 will n=
eed it,
>> since inet_ntop and inet_pton reside there too.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>> =C2=A0Makefile | =C2=A0 11 ++++++++++-
>> =C2=A01 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index baa05f5..40642f7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -95,6 +95,10 @@ all::
>> =C2=A0# Define NEEDS_SOCKET if linking with libc is not enough (SunO=
S,
>> =C2=A0# Patrick Mauritz).
>> =C2=A0#
>> +# Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not =
enough.
>> +# Notably on Solaris hstrerror resides in libresolv and on Solaris =
7
>> +# inet_ntop and inet_pton additionally reside there.
>> +#
>> =C2=A0# Define NO_MMAP if you want to avoid mmap.
>> =C2=A0#
>> =C2=A0# Define NO_PTHREADS if you do not have or do not want to use =
Pthreads.
>
> Could you please add this build configuration variable to configure.a=
c
> and config.mak.in, to be able to autodetect this situation?

I'll take a look at it, but autoconf is not a strong suit of mine.
Plus, I doubt I will actually be able to test anything on the
platforms I have access to that need to set NEEDS_RESOLV, since any
autoconf installation is likely to be very old.

> CC-ed Ralf Wildenhues and David Syzdek (who hopefully can produce
> autoconf patch to squash with this one).

Yes please. :)

=46YI:
Solaris 7 needs -lresov since inet_ntop and inet_pton reside there.
Additionally, since NO_IPV6 is set, hstrerror is called in connect.c
and hstrerror also resides in libresolv.

On more modern Solaris, inet_ntop and inet_pton reside somewhere else,
and since NO_IPV6 does not need to be set, -lresolv is not needed.

-brandon
