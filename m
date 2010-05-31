From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Mon, 31 May 2010 09:10:18 -0400
Message-ID: <AANLkTimJXEg08AlDIbPYsRZFXSDFPhN1SB6OxMyaM5PE@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<20100530003718.GA27024@progeny.tock>
	<AANLkTinNHDZD-9uQjWr8N97tgP1SP9angXlXMUUc673x@mail.gmail.com>
	<20100531124615.GA2864@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Jonathan Callen <abcd@gentoo.org>,
	git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 15:10:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ4l6-0005nD-Tu
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 15:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0EaNKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 09:10:20 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34619 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0EaNKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 09:10:19 -0400
Received: by vws9 with SMTP id 9so718172vws.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=cqjFwPEz2XcTvwtp13hT/cT+uhM9HSZBgOOiyhQK3Bc=;
        b=v4DlxMXS3zuxDsJIBCGO9M6fwAroAwP5yXVujiiyjKAXeKfFWWn2l38gFJR4Po1UAl
         MlsYF0TjPQ+58SJ7mpTR4z5gtIETt8GTG/SXTg5Tn9nOhLcQOlQ7CSMRtdFM7EFsiNM7
         27rNWIT0P2J9425W1zyscF2/McNK4CZ7jyGt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Knb2cAz4AXFtOQuCdIDr4+fsyzE+WrtfU7xFiXtoJp0gp+C8zrn+c1dZHVyCtCtetk
         eU1Er1O3XAaaVLuJYzIyHK8ua3JW34tNK42YaVwyMfqGhe1iDvhxDqyRwtWx+fb82+O9
         H1fPDLCm8Yfd1pVmecqEV8JNvFluN26gOrJK4=
Received: by 10.224.35.38 with SMTP id n38mr148975qad.157.1275311418174; Mon, 
	31 May 2010 06:10:18 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Mon, 31 May 2010 06:10:18 -0700 (PDT)
In-Reply-To: <20100531124615.GA2864@progeny.tock>
X-Google-Sender-Auth: 6Fcf7SZiTrVdu8H-qMux_0aD168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148043>

On Mon, May 31, 2010 at 8:46 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Albert Dvornik wrote:
>
>> For the general case, you'd want
>> =A0 =A0 =A0 =A0tv.tv_sec =3D timeout / 1000;
>> =A0 =A0 =A0 =A0tv.tv_usec =3D 1000 * (timeout % 1000);
>
> Thanks for the catch. =A0Actually, it is not so unlikely that someone
> would ask the autocorrect to wait longer than a second.

Good point, I take back what I said. =3D)

> On Linux this is not an issue, but maybe Interix cares. =A0Posix is
> vague and only says "the timeout period is given in seconds and
> microseconds", staying silent on what the range of valid values is.

Some traditional UNIXes are actually picky about the usec range, or at
least used to be (I seem to recall BSD and/or Solaris, but I really
don't remember for sure, this was a long time ago).

--bert
