From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add  callbacks.
Date: Wed, 17 Oct 2007 00:44:05 -0400
Message-ID: <20071017044405.GV13801@spearce.org>
References: <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx> <20071016165045.GB13946@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 06:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii0lb-0001QB-9T
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 06:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbXJQEoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 00:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXJQEoM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 00:44:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56242 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXJQEoL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 00:44:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii0lL-0004MA-NO; Wed, 17 Oct 2007 00:44:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D745420FBAE; Wed, 17 Oct 2007 00:44:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071016165045.GB13946@artemis.corp>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61330>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Oct 16, 2007 at 04:38:36PM +0000, Ren=C3=A9 Scharfe wrote:
> > Pierre Habouzit schrieb:
> > > This bit is to allow to aggregate options with arguments together=
 when
> > > the argument is numeric.
> > >=20
> > >     +#if 0
> > >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> > >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> > >     +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->op=
t, 10);
> > >     +			return 0;
> > >     +		}
> > >     +#endif
> >=20
> > I don't like it, it complicates number options with unit suffixes (=
e.g.
> > --windows-memory of git-pack-objects).
=2E..
>   This is a very strong argument _against_ this chunk IMO.

Since everyone (including myself) is apparently strongly against this
hunk I removed it when I cherry-picked this series from Pierre into
my tree.  The series will be in my pu tonight, but minus this hunk.

--=20
Shawn.
