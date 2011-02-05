From: "George V. Reilly" <george@reilly.org>
Subject: Re: git-svn bug: Could not unmemoize function `lookup_svn_merge' ...
Date: Sat, 5 Feb 2011 10:32:20 -0800
Message-ID: <AANLkTikW2jgPfO_tsdzuD6pZJAJMQPezMr7ZQvgWtkFY@mail.gmail.com>
References: <AANLkTi=14DKGzotpZT66dG93uWHhpCa526C8F7Zk_REa@mail.gmail.com>
	<AANLkTi=QrGK_-iJAnuKONs5WkjtKorg3wPBKdw+qWjTU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plmvw-0001LL-Sh
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab1BEScY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 13:32:24 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37323 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab1BEScW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 13:32:22 -0500
Received: by yxt3 with SMTP id 3so1299924yxt.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=l9E0gVFVkPGJsncksrHnE+rROV3CtIxDTTiYx5KD/IY=;
        b=wFnH8ZNKrqfyTBQK8tFnnaN4ntvu9zD3pdSRS8kefw2uIg0P8ahHWtun6TBMvygZVB
         gd5B2q1lrmJ87F2QevDNoIti2CYdEn6DbrSAxRY3rWqF9WTQ0dJyu2I3gAZzGNW9MqvA
         4vv3Un9KfZLLXoSLvA+tM/LJmFDxXz8P9LSwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xIZofhl+h5sLoa1T2Ie0GmpBkdksKxNEsknXqLQ4De4b2rsK2zKp73tlJPckV2RT6S
         ohZti6P5BHHRITdul6Sib1Gyosl4X+kqd/10UMGbnXo7Q+NDdtHosHFOLCpCRLOTJLV1
         Rvknhil6Sr0kMozFg8UU9jjye3Y00aYE+NAyI=
Received: by 10.100.255.7 with SMTP id c7mr597672ani.146.1296930740963; Sat,
 05 Feb 2011 10:32:20 -0800 (PST)
Received: by 10.100.14.5 with HTTP; Sat, 5 Feb 2011 10:32:20 -0800 (PST)
In-Reply-To: <AANLkTi=QrGK_-iJAnuKONs5WkjtKorg3wPBKdw+qWjTU@mail.gmail.com>
X-Google-Sender-Auth: 5-mug7ahuGBFtH3pFeLW9jhr9Wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166106>

On Mon, Dec 27, 2010 at 9:37 PM, George V. Reilly <george@reilly.org> w=
rote:
> Using git version 1.7.3.2 on OS X 10.6.5 against the Subversion
> repository at work, I got
>
> =C2=A0 =C2=A0georger@George-Reillys-MacBook-Pro-17:~/src/wc-git$ git =
svn rebase
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 CoBranding/Resource=
s/USA7/Resources.resx
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 CoBranding/Resource=
s/Resources.csproj
> =C2=A0 =C2=A0Byte order is not compatible at ../../lib/Storable.pm (a=
utosplit
> into ../../lib/auto/Storable/_retrieve.al) line 380, at
> /System/Library/Perl/5.10.0/Memoize/Storable.pm line 21
>
> =C2=A0 =C2=A0Could not unmemoize function `lookup_svn_merge', because=
 it was
> not memoized to begin with at /usr/local/git/libexec/git-core/git-svn
> line 3194
> =C2=A0 =C2=A0END failed--call queue aborted at
> /usr/local/git/libexec/git-core/git-svn line 39.
>
> The error was repeatable.
>
> I managed to get past it by using the git-svn Perl script from Git 1.=
6.5.7,
> per http://kerneltrap.org/mailarchive/git/2010/1/13/20137, and invoki=
ng it thus:
>
> =C2=A0 =C2=A0$ perl -I /usr/local/git/lib/perl5/site_perl/ ~/temp/git=
-svn.pl rebase

After being absent for a month, the problem recurred. I upgraded to Git=
 1.7.4,
but it still occurs, albeit at line 3197 of git-svn.

Once again, the git-svn 1.6.5.7 works past it.
--
/George V. Reilly=C2=A0=C2=A0george@reilly.org=C2=A0 Twitter: @georgevr=
eilly
http://www.georgevreilly.com/blog=C2=A0=C2=A0http://blogs.cozi.com/tech
