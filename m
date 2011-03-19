From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len"
 better
Date: Sun, 20 Mar 2011 01:24:33 +0900
Message-ID: <1300551873.1462.8.camel@leonhard>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop>
	 <20101028075631.GA7690@elte.hu>
	 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
	 <20101028163854.GA15450@elte.hu>
	 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
	 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
	 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
	 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
	 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
	 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
	 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
	 <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
	 <7vvczpff89.fsf@alter.siamese.dyndns.org>
	 <AANLkTimH6ZKkTZ0MiJWzHpZywSy6Hk3caLQ5S+rE0uqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0yxK-0007xL-PI
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1CSQYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:24:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39929 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab1CSQYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 12:24:40 -0400
Received: by iwn34 with SMTP id 34so5023752iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=mECvSn+j6MN9aG295tRdQnebr9RFsEH1GjWsROzcuk4=;
        b=LmWr58fsfFjHfs6gvGXmX+PxUXfbex3gohMCLqBFoIDYbjIoZJID/wgSmFxjt6ebOH
         ZujFOI8G2jnb35j5cJkYIUL5XdV5GLrGvMKrRHBE8MltZ/9Pv0eD/IlMQ7xBG60VCF4m
         JUt5sen5jKhkno6xgw42x4cx0B2+l1yxFMvmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=t6i5TWHfZx5nUO1Y5YzWUS0zzerxi9WwcVMHrJN8Qjwt1ps1AwNlQOheoHt3lJ1UJg
         8/AMdo+7OJx9/FcYTKjCdY9la+Se1eJk7eNI9ugI1fC9HwBdzzXQZZ5dXRVPQvhCehcz
         LPGpERfxR4rLKe3dwKb/K6zeuoxIooHCuyGAw=
Received: by 10.42.29.1 with SMTP id p1mr3497504icc.318.1300551880086;
        Sat, 19 Mar 2011 09:24:40 -0700 (PDT)
Received: from [58.141.205.212] ([58.141.205.212])
        by mx.google.com with ESMTPS id e9sm480497ibb.64.2011.03.19.09.24.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 09:24:38 -0700 (PDT)
In-Reply-To: <AANLkTimH6ZKkTZ0MiJWzHpZywSy6Hk3caLQ5S+rE0uqg@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169446>

2011-03-18 (=EA=B8=88), 21:22 -0400, Jay Soffian:
> On Fri, Mar 11, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > +core.abbrevLength::
> > +       Set the length object names are abbreviated to.  If unspeci=
fied,
> > +       many commands abbreviate to 7 hexdigits, which may not be e=
nough
> > +       for abbreviated object names to stay unique for sufficientl=
y long
> > +       time.
> > +
>=20
> Isn't this the minimum length though? i.e. a longer length is used as
> needed for uniqueness. If so, at least the description is misleading,
> and I'd argue the option name too. Perhaps core.abbrevMinLength?
>=20
> j.

It could confuse what it points is the default length or the minimum.
I'd like to suggest core.defaultAbbrev or core.abbrevDefault.


--=20
Regards,
Namhyung Kim
