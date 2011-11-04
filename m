From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Fri, 4 Nov 2011 23:05:07 +0700
Message-ID: <CACsJy8C1JxoCsCoGW8kOVEtOGUjAUGL0G68qLEZ484yRJGgAkA@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
 <20111031090717.GA24978@elie.hsd1.il.comcast.net> <20111102220614.GB14108@sigill.intra.peff.net>
 <7vwrbigna7.fsf@alter.siamese.dyndns.org> <20111102232735.GA17466@sigill.intra.peff.net>
 <CAJo=hJtt8vjB5oU+tEabN2AS7c-24bMHNwQSoWtZYtjjrR3d7Q@mail.gmail.com>
 <20111103024248.GA9492@sigill.intra.peff.net> <CAJo=hJt2kU10r5rq23qgimtW8dmzu-N92vjO_hNBbVVsKSpDmg@mail.gmail.com>
 <20111104085633.GA13924@ecki> <4EB3B1E7.7080507@viscovery.net> <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	netroby <hufeng1987@gmail.com>,
	Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 17:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMMH3-00038f-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 17:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615Ab1KDQFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 12:05:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45135 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab1KDQFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 12:05:39 -0400
Received: by bke11 with SMTP id 11so2074099bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hm2ipoiuiIO+oVMacdPNdNL4j4auX5Ok92etJfmlGAM=;
        b=K8g9BgP6zIT6Mlyaxl01z/VlgboxTJXDwxCIVyQ8lH94CErOqdWd87eweCqefdWrhe
         KzrC8jPaDEzRP1AYlr96hQxS4rV2/wSNSmorpDekGbcccqissYwp4kx1QEawCSlXjva9
         jos3mnwKJ51xxqDmYqDVYvGm7putG5KxIAM6A=
Received: by 10.204.143.74 with SMTP id t10mr1773383bku.45.1320422738128; Fri,
 04 Nov 2011 09:05:38 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Fri, 4 Nov 2011 09:05:07 -0700 (PDT)
In-Reply-To: <CAJo=hJtsiEEHA33CQn1MCvb7vFv7uEF+U292YgBa7EWv7P8Jng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184784>

2011/11/4 Shawn Pearce <spearce@spearce.org>:
> By the time you get done with all of that, your "ticket" might as well
> be the name of a pack file. And your "resume information" is just a
> pack file itself. Which would be very expensive to recreate.

I'll deal with initial clone case only here. Can we make git protocol
send multiple packs, then send on-disk packs one by one together with
pack SHA1? This way we do not need to recreate anything. If new packs
are created during cloning, git client should be able to construct
"have" list from good packs and fetch updates from server again.
-- 
Duy
