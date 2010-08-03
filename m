From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 09:39:08 +0200
Message-ID: <201008030939.09999.jnareb@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <m3hbjcptyr.fsf@localhost.localdomain> <7vy6coiqdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 09:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgC5W-0002pM-OF
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 09:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0HCHi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 03:38:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57659 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0HCHi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 03:38:56 -0400
Received: by fxm14 with SMTP id 14so1878658fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YAhm1gOEZcw0RWmypyBlva4uuYyE5YpCLatHNtBWPzA=;
        b=mNZiFQsSqJUMeq5rG1B5WKT0VU04/W92lJ6ColDYZzCx3z+IwnWYxBZbBxmoWYxJ/L
         jKOzwA5t0+yAzCW9k6aipuqt/U7iVCtG4B7ClzcFgrFEOgpIbxYUWU5m7gBULA0U7HVl
         jNVRGJtMBbqJ7DNwoZNqOatTgorHCoDrdS10U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nqldWSeh+Q7/qsJ48bgIf+Y1BrrwAQP8ZRYflLRkwFARHdKRCLulGHDWbsJ+6jHiz8
         yDkJh2ho5criQiA1wvIU74jLPw2BOW8pIubvL4UDv0AmV2D5i5HZS8ROgeK39XiPpbhu
         39XAb4SD6yGBXe17TnrVFSwQ9pRAcfK2V6N7E=
Received: by 10.223.119.136 with SMTP id z8mr6842158faq.63.1280821135263;
        Tue, 03 Aug 2010 00:38:55 -0700 (PDT)
Received: from [192.168.1.13] (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id q17sm2356005faa.45.2010.08.03.00.38.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 00:38:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy6coiqdt.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152489>

Dnia wtorek 3. sierpnia 2010 00:47, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > The headers inside commit (and tag) objects are stored in text form=
,
> > so they are not limited to 32-bit value.  You would have to use sys=
tem
> > that has 64-bit time_t, or patch git.
>=20
> I thought the internal representation of our time was "unsigned long"=
, no?
> How can you represent anything before Unix epoch?

time_t is signed long.  Besides, git uses textual representation, its
just a matter of putting minus sign.  We can always fall back to
low level git-hash-object.

I'm just not sure if 'git commit' can work with dates prior to Unix
epoch.  I guess that git has some sanity checks that flies in the face
of such ab)use of git.

Refrences:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[1] time(p) manpage
[2] http://en.wikipedia.org/wiki/Unix_epoch#Representing_the_number
[3] http://en.wikipedia.org/wiki/Time_t

--=20
Jakub Narebski
Poland
