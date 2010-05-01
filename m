From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git daemon on Windows environment
Date: Sat, 1 May 2010 14:17:24 +1000
Message-ID: <r2s2cfc40321004302117h1e9f4068z442b7018dd640abf@mail.gmail.com>
References: <1272532026043-4979038.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 01 06:23:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O84EK-0000v2-M8
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 06:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab0EAEW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 May 2010 00:22:29 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:57061 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab0EAEW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 00:22:28 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 00:22:27 EDT
Received: by qyk13 with SMTP id 13so1319908qyk.1
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+EcqzC8FMrZGrhEeMYkpefMUYHBiygBPHjOYuY3ovh4=;
        b=KDf7Gu90u2E3GetNymcj/94NjuxZwcVuI4u8WyCRU1oXBRfBSWt/jwl49kldt4Pr46
         4R/Hxsyz6419WUynz25/ZhbufcXRt8+kH8goNYYOE2VQRj2MLgKUbXsCbE4iuARFFw57
         Ko4eNOZ2ccTiM2E7jk54xAFCcpR1+6Mf1sndk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U1Tywiq1RZcsF/keVxvcPSjkbk4NO3pZEVUvD/yVZvVlyqn6BWvJIrpWLZ4wTQKhTM
         TTwUOlaYANQ+TynlOGVssJ/224doUbbsOu9NxqDXw3vt2nA8UwBHdoo8OYVTd0FxHj1z
         POkZR3CyDF/MGbCas0mgfHo+Qy6CO5j4ehvug=
Received: by 10.229.237.204 with SMTP id kp12mr576189qcb.27.1272687445087; 
	Fri, 30 Apr 2010 21:17:25 -0700 (PDT)
Received: by 10.229.224.65 with HTTP; Fri, 30 Apr 2010 21:17:24 -0700 (PDT)
In-Reply-To: <1272532026043-4979038.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146076>

On Thu, Apr 29, 2010 at 7:07 PM, santos2010
<santos.claudia2009@googlemail.com> wrote:
>
> Hello,
>
> I tried to install git daemon on a Windows Server 2003 using cygrunsr=
v, but
> got this error:
> cygrunsrv: Error starting a service: QueryServiceStatus: =C2=A0Win32 =
error 1062:
>
> I googled and found a possible fix:
>
> =C2=A0" explicitly add Full Control for the SYSTEM user to
>
> =C2=A0C:\Cygwin
> =C2=A0C:\Cygwin\var
> =C2=A0C:\Cygwin\var\log "
>
> However this didn't help as well.
> Anyone has experience with this installation? Any tips?

I run git-daemon as a Windows service under cygrunsrv and it works
pretty well for me.

I'd double check that you can launch git daemon with the arguments you
have registered with cygrunsrv (use cygrunsrv -LV to see these).

Also, check any output that might be in /var/log/git-daemon.log. Make
sure, of course, that you don't have another copy of git-daemon
running when you start the Windows service.

jon.
