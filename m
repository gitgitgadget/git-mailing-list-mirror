From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: introduce localtime feature
Date: Thu, 17 Mar 2011 23:30:00 +0100
Message-ID: <201103172330.07332.jnareb@gmail.com>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost> <m3d3lq57vw.fsf@localhost.localdomain> <AANLkTi=+aAeV4mx4YTHw4rWZahLS0tnjXsDLEgoAj9-o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 23:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Li7-0008JR-0d
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 23:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1CQWaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 18:30:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33833 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1CQWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 18:30:20 -0400
Received: by wwa36 with SMTP id 36so4141634wwa.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=W3tWkYyrL8N62GIKDl2eiVvcUte+7+vFZ+nMxz0fLYg=;
        b=o1514WBOQZ1p10/5PcJvZBwDv0HREzWUio8WhCDJ06EbL/L8f9McdBj6xKlvrwvs87
         v9FYueJUeVff+3/WBTNta/vgOttPlGKiEstOUPvLv8UHbbHq6HyOrmfJAh/1EugOr2oC
         ITmmx2j+B1dWWq8kAmNAYzC6fFZhDg4gU9pUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AM0bAa2fIuCKny1fhXfabpy2jfOQ6F5tXctttCsqeyC9ArrRFUcNN6ajIib3bCQr5S
         PBKC+td45DQtxn9vmyaE1rt8858c6gwEu46S+6kkFs2a7zumGbL2bp95BjdCMMqQFusW
         buREUbWKkjogGqnXtHFNA7XFZR1aw4DgVpegA=
Received: by 10.227.98.9 with SMTP id o9mr362377wbn.25.1300401018889;
        Thu, 17 Mar 2011 15:30:18 -0700 (PDT)
Received: from [192.168.1.13] (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id ed10sm930509wbb.32.2011.03.17.15.30.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 15:30:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=+aAeV4mx4YTHw4rWZahLS0tnjXsDLEgoAj9-o@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169284>

On Thu, Mar 17, 2011 at 21:12, Kevin Cernekee wrote:
> On Thu, Mar 17, 2011 at 4:01 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

> > This does not describe why would one want such way of displaying
> > timestamps, and which views would be affected.
> >
> > BTW. should it be timezone of web server (machine where gitweb is
> > run), or local time of author / committer / tagger as described in =
the
> > timezone part of git timestamp?
>=20
> The case I am currently trying to improve is the one in which all
> developers are at a single site.
>=20
> In the open source world it is common to have developers scattered al=
l
> over the globe, so some of them will inevitably have to perform
> timezone conversions.
>=20
> But Git is becoming a popular tool in the private sector and it is
> common to have most/all contributors based in a single office.  In th=
e
> latter case, it is helpful to display the local timezone instead of
> GMT.  This also helps make the data more readable by program managers
> and other non-developers who have an interest in tracking the project=
=2E

Such explanation should in my opinion be present in the proposed commit
message.  Good commit message should explain not only what the change i=
s
intent to do (to catch when implementation and intent differs), but als=
o
whys behind the change (to find whether commit is worth having).

The above nicely explains why and when such feature would be useful,
=20
> > Why project specific override is not supported? =C2=A0I think it mi=
ght make
> > sense to enable this feature on project-by-project basis; some
> > projects might be dispersed geographically, some might not.
>=20
> Mostly ease of testing.  I did not need it for any of my projects.

You mean that for your instance of gitweb all projects were single
office (not dispersed geographically), so for you enabling it site-wide
was enough, isn't it?
=20
> It turned out to be a simple change, and it is in v2.

Thanks.

> The cases I tested were:=20
>=20
> default 0
> default 1
> override 1, project unset
> override 1, project 0
> override 1, project 1

Well, I think the non-overridden / overridden feature we have tested qu=
ite
well.  BTW did you add test for 'localtime' feature to t9500 test?  Per=
haps
it is not strictly necessary, though...

> > Is it still an RFC 2822 conformant date? =C2=A0If it is not, then a=
bove
> > change is invalid, and we have to implement this feature in differe=
nt
> > way.
>=20
> I believe it is still valid.
>=20
> Original date: Thu, 17 Mar 2011 02:11:05 +0000
> New date: Wed, 16 Mar 2011 19:11:05 -0700
> Sample date from RFC 2822 Appendix A: Fri, 21 Nov 1997 09:55:06 -0600

Thanks.

> > Hmmm... I wonder if it wouldn't be better to print both times (perh=
aps
> > reversed) in this case...
>=20
> I have submitted a third patch which does this.

Note that we print localtime (time in author / committer / tagger timez=
one)
to be able to mark given time as "atnight", so one can easily see commi=
ts
and tags which needs more careful review because they were made 4 AM or
something.

If you reverse the direction you still should make sure that "atnight"
styling applies to localtime.

--=20
Jakub Narebski
Poland
