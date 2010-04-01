From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git
 repo somewhere?
Date: Wed, 31 Mar 2010 21:35:26 -0500
Message-ID: <20100401023526.GA20916@progeny.tock>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
 <20100331025626.GA13501@progeny.tock>
 <20100331025856.GB13501@progeny.tock>
 <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Eric Blake <eblake@redhat.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 04:41:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxALG-0001bo-3D
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 04:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0DAClB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 22:41:01 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:44742 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0DAClA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 22:41:00 -0400
Received: by ywh2 with SMTP id 2so553237ywh.33
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7EcffCxljrwN4UeDqHdVZKnETvkprrOlTbAJ+BvCyNM=;
        b=CQj1IFuERH/i4W4xcyUIgfI2rt0AS6s21BbZxdry3W3I903nTSyp03zrB/pvcwgS1H
         N8PuC/VA90km0pygN6pGNvYKZtIKDppkP84lIJ1kroP4U2FIx9o6uO6iDKlR+5tScCSw
         ObFEEAMMaMJoIlERlTwTKEg+dvByc4oGRTXGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x7q8PGUP6vu9zG6NCx6utd31y3S/Mtl580jUTXdVvXSrjdwMpRGfHUO1Jm+Vh3aSBM
         hgGi+XgOcmOVrklgwxM7QBQLkYwvb93Dc8MktPYsJGiiNv6LOalxKNymhZIubp/BPMMl
         GxGuZDfcn/H1gy0/2ND8GYAMEvfkmVobDEKMo=
Received: by 10.90.5.24 with SMTP id 24mr856973age.47.1270089301960;
        Wed, 31 Mar 2010 19:35:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm28906iwn.13.2010.03.31.19.35.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 19:35:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143705>

Jon Seymour wrote:

> What I was looking for was a git repo that contains a branch with the
> patches that the cygwin folks mutate the official git release with.

To clarify, I didn=E2=80=99t realize the Cygwin folks needed a patch at=
 all.
Oh well, theory and practice.

I just fetched the packaging.

  http://mirror.mcs.anl.gov/cygwin/release/git/git-1.6.6.1-1-src.tar.bz=
2

gitk - work around stderr redirection on Cygwin

  The description of this patch suggests it is meant to work around
  the old Tcl/Tk version.  In that case, maybe stock gitk should learn
  a workaround.  I don=E2=80=99t think it is supposed to require more r=
ecent
  Tcl/Tk than 8.4.

  Unfortunately, I cannot find a relevant changelog entry.  Maybe
  this is a Windows-specific bug?  http://wiki.tcl.tk/2620
  describes a similar problem.

gitk - convert gitk-path to Windows if on Cygwin

  This patch seems reasonable, and it only affects Cygwin.  I think it
  looks reasonable for inclusion in stock gitk, though others might
  disagree.

Documentation/Makefile

  Adds --unsafe to the asciidoc command line.  Why?

Makefile

  Stops disabling so many features, since Cygwin has come a long way.
  This looks worth applying upstream.  The conservative thing to do
  would be to test $(uname -r), but since it is easy to bring a
  Cygwin installation up to date and hard to figure out the appropriate
  versions, it might make sense to make this change unconditionally.

  A worrisome one is NO_MMAP.  Was that problem ever understood?  Maybe
  v1.6.3-rc0~133 (MinGW: implement mmap, 2009-03-13) contains some clue=
s
  (just a hope).  The message for v1.5.0-rc1~182 (Set NO_MMAP for Cygwi=
n
  by default, 2006-12-27) indicates that it=E2=80=99s filesystem-specif=
ic,=20

Makefile: all:: perl/perl.mak

  Should be unnecessary. The scripts should pull it in already.

Makefile: setting INSTALLDIRS=3Dvendor in the perl/perl.mak target

  Should be unnecessary.  Make passes on variable settings from the
  command line to submakes already.

git-gui/Makefile:

  Change to Cygwin-specific part.  Probably applicable upstream.

Thoughts?
Jonathan
