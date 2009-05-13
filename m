From: Andreas Ericsson <ae@op5.se>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 11:11:52 +0200
Message-ID: <4A0A8ED8.8000905@op5.se>
References: <1242205190383-2879913.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: takeshin <admirau@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4AVR-0001In-5b
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbZEMJLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 05:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbZEMJLz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:11:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34215 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZEMJLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 05:11:54 -0400
Received: by fg-out-1718.google.com with SMTP id d23so952748fga.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 02:11:53 -0700 (PDT)
Received: by 10.86.70.3 with SMTP id s3mr950004fga.12.1242205913795;
        Wed, 13 May 2009 02:11:53 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm2764749fge.3.2009.05.13.02.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 02:11:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1242205190383-2879913.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119011>

takeshin wrote:
> Hi,
>=20
> I have following PHPDoc code in files of my repository:
>=20
> /**
>  * Class description
>  * @version 1.2
>  */
>  class Name=E2=80=A6
>=20
> Is there a chance that git could increment this @version automaticall=
y
> on each commit

No, but see GIT-VERSION-GEN and "git help describe" for info on how to
replace such version tags using a script when you cut a release of your
project.

> or stamp the file somehow?
>=20

Yes. It can only do so using the blob id though. Things like this can
be done in CVS and Subversion because
a) CVS and SVN are file-based. The version they write are not the
   version of the *project*, but the version of the file (not even
   remotely the same thing).
b) they do not really support proper branching.

In git (which is snapshot based and supports branching very well indeed=
),
it *could* be done, but it would incur such an enormous performance
penalty when switching branches, creating a new commit or re-writing
history (since every file would have to be altered) that it's never
been considered worth adding.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
