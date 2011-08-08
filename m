From: Daniel Mack <zonque@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 23:01:12 +0200
Message-ID: <CACTFLAN1oXHtEtoo7kzvTqaiSv0zvmbkPU703iZsztCWdg4HhQ@mail.gmail.com>
References: <4E3EF38A.9010307@gmail.com>
	<20110807234634.GA3236@kroah.com>
	<CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
	<D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
	<CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
	<20110808204448.GF18294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Greg KH <greg@kroah.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqWwo-0006Yt-9K
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab1HHVBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 17:01:13 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33367 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1HHVBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 17:01:13 -0400
Received: by pzk37 with SMTP id 37so8883932pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3ZGI66LNpEt6u68SUGo3MhiS4CP10t/u27P8+YIPwn4=;
        b=ZO9JqAddhcHD94ar9+N8pxlbnlrp6rdUFJ1ini4D/OM+sBDTEauySkv3waR9Bcr/Yu
         37rNa6pKgIyLTC0FqCjaUhk+QvrixxhImyoDNpZwWItZQ4q2BXUv9A8y9B04KN9M08Zt
         +UMm53nRKXVpxnpirsXQSx+3rzjszW7aMB5qQ=
Received: by 10.142.4.11 with SMTP id 11mr899887wfd.356.1312837272729; Mon, 08
 Aug 2011 14:01:12 -0700 (PDT)
Received: by 10.142.194.11 with HTTP; Mon, 8 Aug 2011 14:01:12 -0700 (PDT)
In-Reply-To: <20110808204448.GF18294@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178983>

On Mon, Aug 8, 2011 at 10:44 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 08, 2011 at 12:58:55PM +0200, Daniel Mack wrote:
>
>> On Mon, Aug 8, 2011 at 12:56 PM, David Aguilar <davvid@gmail.com> wr=
ote:
>> > git send-email has a=A0--[no-]signed-off-by-cc option and configur=
ation
>> > variable.=A0--
>>
>> I know, but that's not the point. It about having a certain address
>> metioned in a ^Cc: line inside the patch and suppress sending off
>> emails to that specific address. And --suppress-cc currently only
>> allows categories to be set, not addresses.
>
> I'm kind of confused why you would mark an address as "cc", but not c=
c
> it. Wouldn't it make sense to call the header something else?

Valid point. Even though Greg doesn't have a problem with the current
procedure as it stands, I see a problem in marking things for "Cc:
stable@kernel.org" just as a search pattern once they hit the Linux
mainline tree. Particularily because as it will end up in the
recipient list with git send-email, stable@ will get all the
follow-ups and discussions when people blindly hit the Reply-to-all
button (which we tell them to do). I for one would add
stable@kernel.org to my .gitconfig and be done with it, without ever
thinking about it again.

It's really not a big thing, and we can drop this patch if anyone has
real objections, but as it doesn't break anything for existing use
cases and might help others, why not apply it?


Daniel
