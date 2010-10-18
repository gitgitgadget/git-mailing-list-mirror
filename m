From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 13:20:43 -0500
Message-ID: <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes> <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes> <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino> <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino> <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
 <20101018181336.GB6877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uKh-0003qv-4x
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab0JRSVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 14:21:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34166 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab0JRSVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 14:21:04 -0400
Received: by gyg13 with SMTP id 13so626993gyg.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E6DiIdpEQlOTMY8zkZpcdoPK4C/Eko/GcFfS7D/6PcE=;
        b=ZuxKeLfdfVz/cfI/TP3sAl79xgWZ/D4qMrJ3LW+TAkt9eA+j52q0+rIrZKIgOzTsUH
         03Eu8Y15vXU0/+VEnW/TisBqMu8RI/WkVdrxmCzPYdsFzL9CgI8+PP9EaMSnqLMF6P5M
         8A5fV9PGHgmXNY+Mrg3NgdUsQEexv9KX+2+1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MhG/wohjLqNIhHb0ygchwf3YmBDB8BmfIp41R6LB8NVaatqjVIYXAd8GCjYPul16co
         Oxf4IuRoEbIqPRAAVRtxZAV94bMcHQ2i6vN4GXS3FqWQrQI4lhw9EbiIqSL/KRryyWY6
         lvj4KRpyPYO+b9nJczdeDtb42n95A/1bEezCQ=
Received: by 10.150.218.21 with SMTP id q21mr7293350ybg.205.1287426063399;
 Mon, 18 Oct 2010 11:21:03 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 11:20:43 -0700 (PDT)
In-Reply-To: <20101018181336.GB6877@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159277>

Heya,

On Mon, Oct 18, 2010 at 13:13, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Log messages could be an annoying special case, though, since people
> edit those a lot. =C2=A0Does svn store the original log message somew=
here?
> (Please forgive my ignorance). =C2=A0If not, I suppose downstream can
> publish refs produced by "git replace" to cope.

=46rom what I've heard basically all meta-data about a commit (includin=
g
author and date!) is mutable. Previously suggested was to stub out the
commit message and user data with placeholders, and drop in the real
information using git notes. I like your suggestion (of using git
replace instead) better. How would we know to use git replace though?
Does the replay API somehow indicate that a revision changed since
last time you looked?

--=20
Cheers,

Sverre Rabbelier
