From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking empty directories
Date: Tue, 1 Feb 2011 19:31:38 +0100
Message-ID: <201102011931.40559.jnareb@gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com> <20110201181509.GA2370@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkL1A-0006Dh-JX
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab1BASbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 13:31:51 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56412 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab1BASbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:31:50 -0500
Received: by wwi17 with SMTP id 17so5086882wwi.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=o7S/nUyC5fTHIDEcBFkfvrNvu/HXOdg3kRGkjcS4PPY=;
        b=uU8VeVvSFdLwEogsCEiYRLVGV+3X4glPpiT0BCWAIs/4khVjMJ6REXE2yR9+MRcXAJ
         5JDEzIh1WaAladbOysk4DuTJUKqzUtAh6U/cRSVJm+4Q2pG0j9rdkAwrCVEXNhLFeZ2K
         MDh8Dk9XvkX1WsBq3DwWBFpwNCMlMRQ+ml8sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=R9Gr/4C+91BaIUJYaUtfFMuzjCkOIg+xfuGWx6esP+Pv5qXe4zt34xT6Lp1ECk7u8h
         X7IaW0zBUtogjTELodI2hznFVtJy5PjdgRIpHWAOjSY7M31maQsf1pKyFEtGr/fEzNIx
         F5V9FjfBVXuAW0AIVqJyWlkdEH1ArPl8udJlg=
Received: by 10.216.46.193 with SMTP id r43mr1025298web.20.1296585109196;
        Tue, 01 Feb 2011 10:31:49 -0800 (PST)
Received: from [192.168.1.13] (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id o33sm11605980wej.13.2011.02.01.10.31.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 10:31:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110201181509.GA2370@LK-Perkele-VI.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165840>

Dnia wtorek 1. lutego 2011 19:15, Ilari Liusvaara napisa=C5=82:
> On Wed, Feb 02, 2011 at 12:54:35AM +0700, Nguyen Thai Ngoc Duy wrote:
> > On Wed, Feb 2, 2011 at 12:28 AM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
> >=20
> > Could it be done with an index extension? Interesting.
> >=20
> > > Certainly one ought to register an extension name or bump the ver=
sion
> > > number to avoid confusing gits that don't know about the feature.
> >=20
> > Index extension with lowercase name are "necessary for correct
> > operation". Older git will abort on unknown required extensions. If
> > you add to the main part of the index, better bump version number.
>=20
> Worse problem than the index: Tree entries. Those are actually transf=
erable
> and IIRC older (current?) git versions don't handle empty subdirector=
ies
> (pointing entry of type directory to empty tree hash) all too well...

What did you mean by "don't handle" here?  The following entry

  040000 tree 22d5826c087c4b9dcc72e2131c2cfb061403f7eb	empty

should be not a problem; empty tree is hardcoded and also shouldn't the=
re
be a problem with such object.  Is the problem when checking out such t=
ree
(writing to index and/or working area)?

> Worse yet, there isn't easy way to break the tree parser to avoid cur=
rent
> git versions from screwing things up (IIRC, when I tested, invalid oc=
tal
> numbers finally broke it, invalid file types didn't do the trick)...

Well, then 1.8.0 version could be good place to break backwards=20
compatibility; we did similar thing when introducing submodule entries,
isn't it?

--=20
Jakub Narebski
Poland
