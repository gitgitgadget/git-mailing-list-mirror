From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [patch 12/16] host-OSF1.patch
Date: Tue, 27 Apr 2010 16:48:53 +0200
Message-ID: <p2rd2d39d861004270748q57802106gdd394cba68ce5ae7@mail.gmail.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
	 <20100427135904.486582000@mlists.thewrittenword.com>
	 <l2jd2d39d861004270710w8e5416d5iad3fa7497e620733@mail.gmail.com>
	 <20100427143912.GB36271@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 16:49:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6m5u-0000Mw-UT
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab0D0Os4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 10:48:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:24369 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0D0Osz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 10:48:55 -0400
Received: by ey-out-2122.google.com with SMTP id d26so1187794eyd.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wGi85UBOnKCOT102x5e43H9E1RBNIDZMHBV4Bg2apmE=;
        b=OUry4Tb0Op/FvE2E732xyxZ8WMqJ4NCj3yCMjFfsmgCPC3O4E1kq95l3GgqwHPLhOD
         C1M3qx4MhKGmJtr/EW93B2LUEGoQZcdBPGcqA+1cbZ71/++cuiTelGideRYpAq4wPflr
         9NbZ9bLFXg0AKfl0nkJoqZqIoALocCsl41fqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZpSspMics0PvNoKv8BkEXhIa8FF7Zk2wKKxrMUFxlkiz/02qJtStPRyAh7MppefJbj
         KKlPufRcVDp1sewB2L2v5VeXi2psDLi7HFI69Ieusc8lLvFV7jsHNf9jxkti2Sy+u8JL
         czDPQvBkuvO1FZj0GVwcxnWuiIElSXKYgtRGc=
Received: by 10.239.189.14 with SMTP id r14mr16256hbh.133.1272379733597; Tue, 
	27 Apr 2010 07:48:53 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Tue, 27 Apr 2010 07:48:53 -0700 (PDT)
In-Reply-To: <20100427143912.GB36271@thor.il.thewrittenword.com>
X-Google-Sender-Auth: e1aa908f79fa592f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145923>

On Tue, Apr 27, 2010 at 16:39, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> On Tue, Apr 27, 2010 at 04:10:56PM +0200, Tor Arntsen wrote:

>> but (ref. a patch I sent earlier, in its
>> first revision) I needed several other changes in order to compile o=
n
>> 5.1 (I also needed those you have above), e.g.
>> -D_POSIX_C_SOURCE=3D1 NO_STRCASESTR =3D YesPlease NO_STRTOUMAX =3D Y=
esPlease
>> NO_STRLCPY =3D YesPlease NO_MEMMEM =3D YesPlease NO_UINTMAX_T =3D Ye=
sPlease
>> NO_C99_FORMAT =3D YesPlease
>> and
>> NO_TCLTK =3D YesPlease
>
> Indeed, I don't mean to imply that this patch is all that is needed
> for OSF1, merely that the changes it contains benefit only OSF1.

I see. In that case, as I have verified that those changes are indeed
necessary for OSF1:

Acked-by: Tor Arntsen <tor@spacetec.no>

> Please bear in mind that I build using configure, and may have missed
> something necessary for a make-only driven build.

Ah, Ok, that would explain it. I too found that with ./configure fewer
changes were needed. The patch I was working on I tested both with and
without configure.  If your patch goes in I could follow up with the
changes needed for when not using configure, if you don't wish to
tacke that.

>> because V5.1 comes with tcl/tk 8.2 and gitk refuses to start with
>> anything older than 8.4.
>> I had some other too, but those could be worked around by building a=
nd
>> installing own versions of iconv, openssl, zlib, python, expat.
>
> Ack. =A0And since that is our business, we do indeed build git agains=
t
> our own packages of relatively cutting edge releases of prerequisite
> OS software on all our hosts (including all of the above).
>
> Cheers,
> --
> Gary V. Vaughan (gary@thewrittenword.com)

-Tor
