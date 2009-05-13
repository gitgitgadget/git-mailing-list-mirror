From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update @version in file
Date: Wed, 13 May 2009 02:42:06 -0700 (PDT)
Message-ID: <m3iqk5l4ps.fsf@localhost.localdomain>
References: <1242205190383-2879913.post@n2.nabble.com>
	<4A0A8ED8.8000905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: takeshin <admirau@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 13 11:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Ayo-00058J-5W
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbZEMJmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 05:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756974AbZEMJmJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:42:09 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:63173 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbZEMJmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 05:42:08 -0400
Received: by pxi29 with SMTP id 29so185849pxi.33
        for <git@vger.kernel.org>; Wed, 13 May 2009 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hIqgri4xcE90+GdkHqurWy4A3MsRS7pOu92gRFxlTEQ=;
        b=iLSpMJJqsX5EjWfJWPN5Rc97xB8P1R99NQqZni4CSD4IMm8OLQDSqigz1+YXmhb2be
         hMs3Nx0lOG3DhExnzfKfrHDpyIXyshtiT32CkNYqUWjIMnXSku0ZBFyum1l1UaMEmbVX
         gBCdjp34O8GMYsXHEuQfib1nJNQeSvfdnl8uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=NunAknBRz1v8SpeAQhDOcGtOn/3SAiSKLx8+5nYsWbfzlbCs4/Vh2UR3fkp2UEMwWN
         ys+y1yoAze/CYPcFTDjRhJhaO3FGLXR6Kg0cgJg8QBO39+3gukrGzlYHdLJ/d+Ljzfnk
         NXEkWVziklnZsGv8F3YRAprguiZTU0jpM9wDo=
Received: by 10.114.159.16 with SMTP id h16mr696599wae.35.1242207727417;
        Wed, 13 May 2009 02:42:07 -0700 (PDT)
Received: from localhost.localdomain (abwb156.neoplus.adsl.tpnet.pl [83.8.225.156])
        by mx.google.com with ESMTPS id m27sm3604009pof.16.2009.05.13.02.42.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 02:42:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4D9g0DE009412;
	Wed, 13 May 2009 11:42:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4D9fpT1009408;
	Wed, 13 May 2009 11:41:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A0A8ED8.8000905@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119015>

Andreas Ericsson <ae@op5.se> writes:
> takeshin wrote:

> > Hi,
> > I have following PHPDoc code in files of my repository:
> > /**
> >  * Class description
> >  * @version 1.2
> >  */
> >  class Name=C9
> > Is there a chance that git could increment this @version
> > automatically
> > on each commit
>=20
> No, but see GIT-VERSION-GEN and "git help describe" for info on how t=
o
> replace such version tags using a script when you cut a release of yo=
ur
> project.
>=20
> > or stamp the file somehow?
> >
>=20
> Yes. It can only do so using the blob id though.=20

See documentation of `ident` attribute in gitattributes(5) manpage.

Well, you can always use `export-subst` gitattribute to make
git-archive do keyword expansion, and there you can use things like
date or decoration (tag / version).

> Things like this can be done in CVS and Subversion because
> a) CVS and SVN are file-based. The version they write are not the
>    version of the *project*, but the version of the file (not even
>    remotely the same thing).
> b) they do not really support proper branching.
>=20
> In git (which is snapshot based and supports branching very well inde=
ed),
> it *could* be done, but it would incur such an enormous performance
> penalty when switching branches, creating a new commit or re-writing
> history (since every file would have to be altered) that it's never
> been considered worth adding.

You can cobble something together using "smudge" (to do keyword
expansion) and "clean" (to store files with keywords not expanded in
git repository) filters, see `filter` attribute in gitattributes(5).
But I am not sure it is worth it.

HTH
--=20
Jakub Narebski
Poland
ShadeHawk on #git
