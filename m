From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Tue, 08 Mar 2011 08:14:48 +0100
Message-ID: <4D75D768.1080701@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>	<4D6A6291.8050206@drmicha.warpmail.net>	<7v7hclulz0.fsf@alter.siamese.dyndns.org>	<7v39n9uldp.fsf@alter.siamese.dyndns.org>	<4D6B4F6B.1040209@drmicha.warpmail.net>	<20110228121726.GA5197@sigill.intra.peff.net>	<20110228122335.GB5197@sigill.intra.peff.net>	<7vy650hvwa.fsf@alter.siamese.dyndns.org>	<20110228222352.GC5854@sigill.intra.peff.net>	<7vfwr7hh7f.fsf@alter.siamese.dyndns.org>	<7vy64zg0ms.fsf@alter.siamese.dyndns.org> <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 08:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwrJi-0003Wp-17
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 08:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1CHH0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 02:26:45 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50470 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab1CHH0o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 02:26:44 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 02:26:44 EST
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B2ED20A40;
	Tue,  8 Mar 2011 02:18:15 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 02:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ohv30yMTud5CgA79IzHidZEpnzE=; b=ikgXMcsm8gbhWKFspN5fRVmllAU4HLdquEpH1eVmiQmv+pBSZqkwhiukfQVpMOSeRMXHNw8jmGwINKZwrcExuepm4ghjiQQqGtpCVK8R8Q/bBe2zqXzHfTj/wBJj8x09gFbe1WCnM8ZyaNic+FdW07rMAEajmrpAur1DSQu88PY=
X-Sasl-enc: vwJLdJG49ENUsvFhheI02Xm9QoPJ3fH64mRe3yAuw177 1299568694
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 736EA440781;
	Tue,  8 Mar 2011 02:18:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168635>

Mart S=F5mermaa venit, vidit, dixit 07.03.2011 21:38:
> On Tue, Mar 1, 2011 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> In any case, a minimum patch to give what Mart wanted to see would
>> probably look like this.  I'll leave bugfixes, documentation and tes=
ts to
>> the readers ;-).
>=20
> The minimum looks to be the optimum -- IMHO this is entirely sufficie=
nt,
> thank you very much!
>=20
> What would the bugfixes be (i.e. do you have any doubts about the
> implementation)?
> The change looks quite straightforward, to the point and bug-free to =
my eyes.
>=20
> I try to get to writing tests ASAP.
>=20
> As for the documentation, would the following section be sufficient i=
n
> Documentation/diff-options.txt?
>=20
> -D::
> --irreversible-delete::
> 	Omit file contents when file has been deleted and only

"if the file has"

> 	output the header. This is useful during diff review
> 	but should not be used in actual patches as these would
> 	be non-reversible due to the omitted file contents.

With the current state of git-apply, they could not even be applied, so
maybe:

	but produces patches which can not be applied by linkgit:git-apply[1].

You can revert to the previous description once you've taught git-apply
the new diff header :)

Michael
