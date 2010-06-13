From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't 
	access location
Date: Sun, 13 Jun 2010 13:23:39 +0800
Message-ID: <AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
References: <1276390106819-5173157.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ddw_music <jamshark70@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 07:28:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONfkY-000695-1a
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 07:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab0FMFXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jun 2010 01:23:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46573 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0FMFXj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jun 2010 01:23:39 -0400
Received: by iwn9 with SMTP id 9so2020673iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 22:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=499S/fvC3yQS9AHnDg3O2e3uXTcNmNnM4aRHJC0it+g=;
        b=fvl4HwhMr5xEKIV/6hmVNqvVNRyux2WrMa/CwiwEgCirP5P8NTwx4VUAoogr4l2uXA
         UQw9aI4lCwwa18c/CZW+2MYFZJzazOVGAI7EQj1oIcaapR0FsHWS6pw+JMIkEdd56Zet
         bqToESg42Xb87iR1M9SyeyPww4KPn65nwJiV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jsuQeumDfYKRufWCDXXuXYNzn6A51yCvPMRyP9mdiXGXfzkKPBhl/QtgobeG6HoEUg
         zwN9Req/Eh46wsKe8xoSz20MlXkU3HvMMpM0D6aVWTSaU4m9BbE0G7vC8ZIB5jWXMq5s
         qmOiFyL5y13Y19oJp7jT/v0nPZsEh5sPLlEQc=
Received: by 10.231.155.131 with SMTP id s3mr3997549ibw.2.1276406619200; Sat, 
	12 Jun 2010 22:23:39 -0700 (PDT)
Received: by 10.231.31.141 with HTTP; Sat, 12 Jun 2010 22:23:39 -0700 (PDT)
In-Reply-To: <1276390106819-5173157.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149037>

On Sun, Jun 13, 2010 at 8:48 AM, ddw_music <jamshark70@gmail.com> wrote=
:
>[snip]
>
> DAVLockDB "/usr/local/apache2/temp/DAV.lock"
>
> =A0<Location /git/kc>
> =A0 =A0 DAV on
> =A0 =A0 AuthType Basic
> =A0 =A0 AuthName "Git"
> =A0 =A0 AuthUserFile /usr/local/apache2/conf/passwd.git
> =A0 =A0 Require valid-user
> =A0</Location>
>
> - chmod -R ugo+w ~/Sites/git
>
> git clone works.
>
> git push... fails. The remote machine says that it couldn't access th=
e
> location. Apache's access log shows:
>
> "PROPFIND /~dewdrop/git/kc/ HTTP/1.1" 404 288

Where are you pushing to? Look at your <Location> again - you
configured Apache to look out for '/git/kc/', not '/~dewdrop/git/kc/'.

I'm assuming the <Location> isn't nested in something else, that is.

--=20
Cheers,
Ray Chuan
