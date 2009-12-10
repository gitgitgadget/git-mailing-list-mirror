From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 14:27:15 +0100
Message-ID: <4B20F733.6010401@drmicha.warpmail.net>
References: <87ljhb87nj.fsf@jondo.cante.net> <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net> <20091210124929.GA444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 14:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIj4l-0002Gf-DM
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 14:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760368AbZLJN2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 08:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759694AbZLJN2b
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 08:28:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44300 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759910AbZLJN2a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 08:28:30 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 16CF6B505F;
	Thu, 10 Dec 2009 08:28:37 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Dec 2009 08:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Gzy+Tmc6YMRV/ftm+9cRzvt73lw=; b=DtV7WG5Yl0REch+Tm5p6BG3ZdI7JN9x/D/iq/8bgWrKBH7AlBUqdcIG3VteyOT0u1JvJ2dRJUok2FHcqyWVkr1yhDsELdQD8GpTiyD5MiE1zGeKs0Uy+Qs/IDYfScNxybq02seSMzz17hiwhJHiUjECQzVHOTN4Cq4HamqEG9VE=
X-Sasl-enc: osOEr7hX4VEd6GNd2qSCeB7HXk0bwEmpoxecFUX33unh 1260451716
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5374820942;
	Thu, 10 Dec 2009 08:28:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <20091210124929.GA444@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135026>

Jeff King venit, vidit, dixit 10.12.2009 13:49:
> On Thu, Dec 10, 2009 at 01:23:43PM +0100, Michael J Gruber wrote:
>=20
>> Print the sha1 of the deleted tag (in addition to the tag name) so t=
hat
>> one can easily recreate a mistakenly deleted tag:
>>
>> git tag -d tagname
>> Deleted tag 'tagname' DEADBEEF
>> git tag 'tagname' DEADBEEF # for lightweight tags
>> git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags
>=20
> I think this is a good idea, and we already do the same for branch
> deletion.
>=20
> I'm not sure your example is right. If "tag -d" always prints out the
> sha1 in the tag ref, can't you just use "git tag 'tagname' DEADBEEF" =
to
> recreate both lightweight and annotated tags? That is, making a
> lightweight tag of an annotated tag's sha1 should just recreate the
> original annotated tag.

While my example is right it is unnecessarily complex. I learned that
through Bj=C3=B6rns and your remark.

> That being said, I am not a fan of the cut-and-paste format. This is =
not
> something that happens so frequently that I think we need to go out o=
f
> our way to save some typing. And for a user seeing this message for t=
he
> first time:
>=20
>   1. It is not immediately obvious to a user seeing this message
>      for this first time exactly what the trailing sha1 means. We
>      already had this discussion with "git branch -d" and decided
>      that "(was DEADBEEF)" was more readable.

So, should we simply go with that then?

Meanwhile, RFCs/PATCHes crossed paths. I take it that Zoltan suggests
giving the same output for force-overwritten existing tags. I beat him
by 11 minutes, though ;)

Michael
