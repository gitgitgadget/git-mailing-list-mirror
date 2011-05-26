From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git EOL Normalization
Date: Wed, 25 May 2011 23:02:35 -0700 (PDT)
Message-ID: <m3y61uxan2.fsf@localhost.localdomain>
References: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
	<29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
	<BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 08:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPTee-0003O7-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 08:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058Ab1EZGCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 02:02:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40788 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1EZGCi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 02:02:38 -0400
Received: by wya21 with SMTP id 21so232601wya.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 23:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=FLJe9p96eGlFVi1LG3ai8htJ0JgpCR4o3XN3VE3ZZGg=;
        b=UglsG1/CDRP8Q//w9+IfUkZzQzA4OXciv88/X0yN/1ZJzTZ6ex7sJ4nOp8rv3BU1xn
         Q7j8NM8F3BKLpvPf6y2qSb41+NGwT4ihbbaxbFTyf6nxllwDq7n/x51POFV5JN5fDqrA
         O0vxVea8k8Gg0O0cLJF3fm6RIw8tE1E5kc5v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=kyG5xicXDi1giW/jPtYs+V+JV4ZFkSHPDBQ14MeKIDX0TWHmzNFzzTQoDgbj47UI2o
         hJJUeUBrcE8XGBXVbyrBE0VZ/rdfydQbYTXravlPCORhalxj5G27SBCHovBYkc7eLkBI
         lopMWMTP+Z/mn40yRh2yXvXJ53JihDZfdF8B8=
Received: by 10.216.79.10 with SMTP id h10mr407805wee.20.1306389757351;
        Wed, 25 May 2011 23:02:37 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id k16sm157888wed.8.2011.05.25.23.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 23:02:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4Q62Pt9020203;
	Thu, 26 May 2011 08:02:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4Q629l0020193;
	Thu, 26 May 2011 08:02:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174496>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Wed, May 25, 2011 at 7:20 PM, Stephen Bash <bash@genarts.com> wrot=
e:
> >
> > The open questions for me are:
> > =A01) what is the actual text file detection algorithm?
> > =A02) what is the autocrlf LF/CRLF detection algorithm?
> > =A03) how does autocrlf handle mixed line endings? (either in the w=
orking copy or repo)
>=20
> Git looks at the text attribute of a file. If it is set or unset then=
 it
> treats the file as text or binary accordingly. If the text attribute =
is
> 'auto', or it is unspecified but core.autocrlf is true, then git uses
> heuristics to detect text files.
>=20
> Currently, the following heuristics are used:
>=20
> A file is considered as text if it does not have '\0' or a bare CR, a=
nd
> the number of non-printable characters is less than 1 in 128.
>=20
> Non-printable characters are DEL (127) and anything less than 32 exce=
pt
> CR, LF, BS, HT, ESC and FF.

I think git examines only first block of a file or so.  The heuristic
to detect binary-ness of a file is, as I have heard, the same or
similar to the one that GNU diff uses.

See also `perldoc -f -X`, description of "-T" and "-B" switches,
though this might differ somewhat in detection and thresholds.
=20
> Also, to avoid problems with autocrlf=3Dtrue when someone has already=
 put
> a text file with CRLF, CRLF->LF conversion happens only if the tracke=
d
> file in the index does not have any CR.

See also documentation of `core.safecrlf` config variable (defaults to
true IIRC).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
