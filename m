From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 08 Mar 2012 18:46:02 +0100
Message-ID: <4F58F05A.1010606@lsrfire.ath.cx>
References: <1331165362-78065-1-git-send-email-brodie@sf.io> <20120308055520.GB7643@sigill.intra.peff.net> <7vpqcnfvhs.fsf@alter.siamese.dyndns.org> <20120308071559.GF7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:46:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hPu-0003bn-QA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab2CHRqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 12:46:13 -0500
Received: from india601.server4you.de ([85.25.151.105]:39046 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2CHRqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:46:13 -0500
Received: from [192.168.2.105] (p579BE4A1.dip.t-dialin.net [87.155.228.161])
	by india601.server4you.de (Postfix) with ESMTPSA id 6070B2F8037;
	Thu,  8 Mar 2012 18:46:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120308071559.GF7643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192622>

Am 08.03.2012 08:15, schrieb Jeff King:
> On Wed, Mar 07, 2012 at 10:38:07PM -0800, Junio C Hamano wrote:
>
>>> ... However, prefix_pathspec does a lot of magic parsing;
>>> it's unclear to me whether this is all in support of properly
>>> adding the prefix, or if its side effects are important.
>>
>> These "magic" are for things like :(root)/path that will explicitly
>> refuse the prefix when run from a subdirectory.
>
> Yeah, that was my impression. In that case, I would think we could ge=
t
> rid of the get_pathspec call entirely, as it is purely about fixing-u=
p
> prefixes, and we know that we have none.

Yes, I think you're right.  Not sure why I didn't do that in ebfbdb34,=20
when that empty prefix was introduced instead.

Ren=C3=A9
