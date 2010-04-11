From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] More flexible URL patterns for gitweb
Date: Sun, 11 Apr 2010 23:09:35 +0200
Message-ID: <201004112309.37089.jnareb@gmail.com>
References: <1270946429-5366-1-git-send-email-damien@tournoud.net> <m37hodhp3e.fsf@localhost.localdomain> <r2te821df551004111046v2ef3219x5c012af27f2cc974@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Damien Tournoud <damien@tournoud.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 23:10:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O14Pw-0006U3-89
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 23:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab0DKVJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 17:09:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:21085 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab0DKVJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 17:09:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1076854fgg.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dHO57qIYM7bcnnkF4hiNmbKLsdBuU/Y0Rq8znhyNDpw=;
        b=CMFZD76lBrSyuQdChfZsUDP0wVeZYAbJ5IguGVFKS2JOvLuKkQjDBn3VvYUm0i3rYW
         DYp7dyWv8IGFQzPRfxKH4tysbyY9lX4QwnH9xVd/8jIM0Jf8XEEWq0jRemZI7wa4PAj2
         BUUSp/c+cqdp3BgfjR1XlXwPh4hoCh8YTaInM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kDJwDeAvP3Bqvwy5wFmXF7W2J85kcBKqpguatcxENPuFc/mW5Fcp3FV3L64w4S+/Qp
         9iAwXrTaOTMrJXZhAyDAERmIOM8NtC2XxvcRHDhilFf752xll03F8VP/oH4YdidpR5+J
         2ooOCQWH0IQH8FbSScVdPNUaAotjiqk3mAtbA=
Received: by 10.223.21.23 with SMTP id h23mr2211342fab.21.1271020183562;
        Sun, 11 Apr 2010 14:09:43 -0700 (PDT)
Received: from [192.168.1.13] (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id 21sm7189751fks.53.2010.04.11.14.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 14:09:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <r2te821df551004111046v2ef3219x5c012af27f2cc974@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144685>

On Sun, 11 Apr 2010, Damien Tournoud wrote:
> On Sun, Apr 11, 2010 at 7:33 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

> > To not break backward compatibility, wouldn't it be better to check=
 if
> > elements of @git_base_url_list end with ':' or '/', and join base w=
ith
> > project path depending on this condition, i.e.:
> >
> > + =C2=A0 =C2=A0 =C2=A0 @url_list =3D map { m/[/:]$/ ? "$_$project" =
: "$_/$project" } @git_base_url_list
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unless @url_list=
;
> >
> > This means: if base ends with colon ':' or slash '/', concatenate b=
ase
> > and project path, otherwise join them using '/' as field separator.
>=20
> Thanks for the review. Indeed this way sounds better.
>=20
> All this is new to me so I'm not sure what is the way forward. Should
> I publish another patch or would you?

If you don't mind, I'd rather you send updated patch (perhaps as respon=
se
to this email, or staring a separate thread).

Note that you would need to:
1. Perhaps update first line of commit message, i.e. email subject.
   But current version might be good enough; if you don't change the
   subject you should use [PATCH v2] rather than [PATCH] in it.

2. Update commit message, to say that you are modifying the way project
   URLs shown in gitweb are composed out of bases in @git_base_url_list
   and $project, to allow possibility of generating scp-like relative
   URL for SSH access, e.g. 'git@git.example.com:user/repo.git'

3. You might want to put comment about what changed from previous
   version of the patch between "---\n" and diffstat.

4. You would need to update description of @git_base_url_list in
   gitweb/README, e.g. providing example what to put in @git_base_url_l=
ist
   to get 'git@git.example.com:user/repo.git': it is 'git@git.example.c=
om:'

5. Update comment in gitweb.perl above declaration of @git_base_url_lis=
t
   to follow modified way of getting URL from base and $project

6. Make above change in git_summary.


P.S. Thank you for contributing to git.
--=20
Jakub Narebski
Poland
