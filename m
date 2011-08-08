From: Greg KH <greg@kroah.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 14:11:02 -0700
Message-ID: <20110808211102.GA3233@kroah.com>
References: <4E3EF38A.9010307@gmail.com>
 <20110807234634.GA3236@kroah.com>
 <CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
 <D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
 <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
 <20110808204448.GF18294@sigill.intra.peff.net>
 <CACTFLAN1oXHtEtoo7kzvTqaiSv0zvmbkPU703iZsztCWdg4HhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Mack <zonque@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:11:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqX6S-0002Wt-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab1HHVLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 17:11:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34854 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040Ab1HHVLK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 17:11:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 28FFD206EC;
	Mon,  8 Aug 2011 17:11:10 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 08 Aug 2011 17:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=smtpout; bh=+P8evM3Wh2kNaFvVCNa1NowAEGM=; b=CcGt
	rM0cyj9QDC2jGp/ThE9DwEsc+QcRqfIFvPD1xUdJ6jZVQrxB0LAjRt+kq+zAU8Q1
	JJvFBHCDwdk39i8EX0yWKy7RWJ5K3TqYEc+g2E5Vt0aM5lM9uS0YL1kAD524nW/d
	2MTHA6f/nGynhFQvLAEQuMglP5+judEow9ft6SA=
X-Sasl-enc: lkQSS3S1ohwlotveNBKvFSixqYPPlIlyJdi5SpENSi2t 1312837869
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ABB16419EB3;
	Mon,  8 Aug 2011 17:11:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACTFLAN1oXHtEtoo7kzvTqaiSv0zvmbkPU703iZsztCWdg4HhQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178986>

On Mon, Aug 08, 2011 at 11:01:12PM +0200, Daniel Mack wrote:
> On Mon, Aug 8, 2011 at 10:44 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Aug 08, 2011 at 12:58:55PM +0200, Daniel Mack wrote:
> >
> >> On Mon, Aug 8, 2011 at 12:56 PM, David Aguilar <davvid@gmail.com> =
wrote:
> >> > git send-email has a=A0--[no-]signed-off-by-cc option and config=
uration
> >> > variable.=A0--
> >>
> >> I know, but that's not the point. It about having a certain addres=
s
> >> metioned in a ^Cc: line inside the patch and suppress sending off
> >> emails to that specific address. And --suppress-cc currently only
> >> allows categories to be set, not addresses.
> >
> > I'm kind of confused why you would mark an address as "cc", but not=
 cc
> > it. Wouldn't it make sense to call the header something else?
>=20
> Valid point. Even though Greg doesn't have a problem with the current
> procedure as it stands, I see a problem in marking things for "Cc:
> stable@kernel.org" just as a search pattern once they hit the Linux
> mainline tree. Particularily because as it will end up in the
> recipient list with git send-email, stable@ will get all the
> follow-ups and discussions when people blindly hit the Reply-to-all
> button (which we tell them to do). I for one would add
> stable@kernel.org to my .gitconfig and be done with it, without ever
> thinking about it again.

No, that's a good thing, as the stable tree maintainer, I _want_ to see
that discussion to verify that this patch really is something that
should be applied to a stable kernel tree.

Lots of patches have originally been tagged in this manner, added to th=
e
git tree, yet in discussion threads afterward, it's been determined tha=
t
this should not go to the stable tree.  If I hadn't been on that thread
in the first place, I would have missed that.

So again, I have no objection to cc: stable@kernel.org, and in fact,
encourage it.  Don't worry, I can handle the email load :)

thanks,

greg k-h
