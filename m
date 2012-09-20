From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Fri, 21 Sep 2012 00:00:09 +0200
Message-ID: <505B91E9.7060208@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx> <7v1uhzkpcc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 00:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEonb-0000oY-MK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 00:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab2ITWAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 18:00:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:43049 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2ITWAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 18:00:33 -0400
Received: from [192.168.2.105] (p4FFDB529.dip.t-dialin.net [79.253.181.41])
	by india601.server4you.de (Postfix) with ESMTPSA id 59A0DEC;
	Fri, 21 Sep 2012 00:00:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7v1uhzkpcc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206099>

Am 18.09.2012 23:12, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>>                                           Windows    Info-ZIP unzip
>>                              7-Zip PeaZip builtin Linux msysgit Wind=
ows
>> 7-Zip 9.20                      0      0      46    26      43      =
43
>> PeaZip 4.7.1 win64              0      0      46    26      42      =
42
>> Info-ZIP zip 3.0 Linux          0      0      72     0      43      =
43
>> Info-ZIP zip 3.0 Windows       45     45     n/a     0      43      =
43

> It is kind of surprising that "Windows builtin" has very poor score
> extracting from the output of Zip tools running on Windows (I am
> looking at 46, 46 and n/a over there).  If you tell it to create an
> archive from its disk and then extract from it, I wonder what would
> happen.

I didn't include it as a packer because it refused to archive the=20
pangrams directory due to illegal characters in one of the filenames.=20
When I just tried a bit harder, I had to delete all but 14 files with=20
Latin script, accents etc. before I could zip the directory.  I'll=20
include these results in the next round.

It uses codepage 850 on my system (MSDOS Latin 1).  I don't expect this=
=20
to be portable.

> Does this result mean that practically nobody uses Zip archive with
> exotic letters in paths on that platform?  I am not talking about
> developers and savvy people who know where to download third-party
> Zip archivers and how to install them.  I am imagining a grandma who
> received an archive full of photos of her grandchild in her Outlook
> Express or GMail inbox, clicked the attachment to download it, and
> is trying to view the photo inside.

Not necessarily.  Photos often have names like img_0123.jpg etc., which=
=20
are handled just fine.  And all family members probably use the same=20
codepage on their computers, so they're less likely to run into this=20
problem.

By the way, I found this bug asking for codepage support in unzip:

   https://bugs.launchpad.net/ubuntu/+source/unzip/+bug/580961

Multiple codepages seem to be used for ZIP files in the wild, none of=20
them are supported by unzip on Linux, which only accepts ASCII or UTF-8=
=2E

Ren=C3=A9
