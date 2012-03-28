From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to git_snapshot().
Date: Wed, 28 Mar 2012 22:45:49 +0100
Message-ID: <201203282345.49673.jnareb@gmail.com>
References: <20120328164513.GA4389@odin.tremily.us> <7vr4wcv8v4.fsf@alter.siamese.dyndns.org> <20120328192750.GA6909@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0gq-00035Y-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758516Ab2C1Vpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 17:45:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35732 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145Ab2C1Vpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:45:49 -0400
Received: by wibhq7 with SMTP id hq7so1388812wib.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vZsq+l6EOszNnqogLe0xouz5vDIujw5dRDpIlynj7vM=;
        b=UCGLwNGPQZ6agt12CLBBNsjHkJKQh1/1yTNxnizwk24mm70N7IGQfqUQ4+gfPkH9EH
         Z3CS5npBLfWw3OWGKT9P+vHCP2y8oaKrpZtGEazGRRZZnLNxhw8jK3FvylrAqXGDnISC
         E+7FmPceWaMMX1KCiHmSD2xZRdZA+DnBm8lBTSZ1+3oTBI3P7CeaCMPehsTRVplUBtyq
         HDz5wRP0miGdYHSfswSIgDOVW9r1JsUxv6AIJqDuofrX9IKrUiT62ErcaVzqbzOkS7zP
         jToNUug/DgwBfQx4zemY8KbEjwkrBWTzYYdAtY6YS517ShkaKsHfL7PPKgDkVUzw3GC6
         lHag==
Received: by 10.180.101.231 with SMTP id fj7mr1602527wib.15.1332971148516;
        Wed, 28 Mar 2012 14:45:48 -0700 (PDT)
Received: from [192.168.1.13] (euy254.neoplus.adsl.tpnet.pl. [83.20.196.254])
        by mx.google.com with ESMTPS id ea6sm30970054wib.5.2012.03.28.14.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 14:45:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120328192750.GA6909@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194205>

On Wed, 28 Mar 2012, W. Trevor King wrote:
> On Wed, Mar 28, 2012 at 12:11:27PM -0700, Junio C Hamano wrote:
> > "W. Trevor King" <wking@drexel.edu> writes:
> >=20
> > > Grr.  Thanks.  I'm getting lots of rebase practice on this patch =
set,
> > > but I'm still missing things=E2=80=A6
> >=20
> > How do you "rebase"?
> >=20
> > It often is the easiest to check out the tip of the previous iterat=
ion,
> > fix all issues that were brought up in the working tree, eyeball th=
e
> > output from "git diff HEAD" to make sure you addressed all the comm=
ents,o
> > and then make separate commits, using "add -p" to sift the fix-ups
> > according to which commit in the previous round they need to update=
=2E
> >=20
> > And then finally you run "rebase -i" to squash these fix-ups in.
>=20
> Ah, that makes a lot of sense.  I had been running `rebase -i`,
> editing the earlier commits, and using `commit -a --amend` to squash
> them on.  The problem with that approach is that you need to check th=
e
> changes vs the previous release before each amend, while with your
> suggestion there's a single diff to look through.

BTW. I personally use StGit (a patch management interface on top of git=
)
instead of interactive rebase.  Just in case, and to be able to write
differences to previous version, I use git-format-patch to generate
patches to a subdirectory, e.g. mdir.gitweb.v7/, and compare with previ=
ous
version.

--=20
Jakub Narebski
Poland
