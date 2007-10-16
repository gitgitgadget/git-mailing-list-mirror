From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add
 callbacks.
Date: Tue, 16 Oct 2007 19:04:47 +0200
Message-ID: <4714EF2F.70506@lsrfire.ath.cx>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx> <Pine.LNX.4.64.0710161742040.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpr8-0000CB-1I
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbXJPRE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 13:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXJPRE7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:04:59 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49787
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753990AbXJPRE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 13:04:58 -0400
Received: from [10.0.1.201] (p57B7EF1C.dip.t-dialin.net [87.183.239.28])
	by neapel230.server4you.de (Postfix) with ESMTP id 4AA50873B9;
	Tue, 16 Oct 2007 19:04:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710161742040.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61215>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Tue, 16 Oct 2007, Ren? Scharfe wrote:
>=20
>> Pierre Habouzit schrieb:
>>> This bit is to allow to aggregate options with arguments together w=
hen
>>> the argument is numeric.
>>>
>>>     +#if 0
>>>     +		/* can be used to understand -A1B1 like -A1 -B1 */
>>>     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
>>>     +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->opt,=
 10);
>>>     +			return 0;
>>>     +		}
>>>     +#endif
>> I don't like it, it complicates number options with unit suffixes (e=
=2Eg.
>> --windows-memory of git-pack-objects).
>=20
> Why?  It only means that you cannot say -W10mxabc instead of -W10m xa=
bc. =20
>=20
> Remember: this is a special case for OPT_INTEGER.  Nothing to do with=
=20
> OPT_SIZE, which you'd probably implement as a callback.

You mean I need to take a look at the actual patch to get a bit more
context? ;-)  Now that I did, I retract my comment.

Pierre, FYI: I didn't see your patches coming through the NNTP gateway
of gmane.org, which is my way of reading this list.  Its web interface
doesn't show them, either, so it's probably not caused by my news reade=
r.

Ren=E9
