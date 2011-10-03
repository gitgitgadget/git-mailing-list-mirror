From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 20:52:23 +1100
Message-ID: <CACsJy8Br7hvvNM-e0Qir2R-5vH3uq8b5aPH-JFpUwddo-NG9iQ@mail.gmail.com>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net> <4E8975E7.2040804@viscovery.net>
 <20111003093912.GA16078@sigill.intra.peff.net> <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
 <20111003094730.GA21610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfCl-0007YS-DL
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab1JCJwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 05:52:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36580 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1JCJwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:52:54 -0400
Received: by bkbzt4 with SMTP id zt4so5087577bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e+2alxEBLKy19UrBgCkSRVhD0XvXmZiwPSlN6lYnkDQ=;
        b=CLD5G4SDvcHLUO73JrpFBt0qOscyxa4KlYATWq2VCL3EjPRemWonnNGA3VCuzcieIP
         7hA7AajIhhAH2/jViZnm/pfa9GZW8BCHi0BgY0ehBB32cM1Tp4dQsMsIGRt1lsyn8cZI
         rJJ68nX973F4CdVRuQlJ1ALWsVr79XP1N9+qo=
Received: by 10.204.133.92 with SMTP id e28mr9063496bkt.407.1317635573151;
 Mon, 03 Oct 2011 02:52:53 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Mon, 3 Oct 2011 02:52:23 -0700 (PDT)
In-Reply-To: <20111003094730.GA21610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182646>

On Mon, Oct 3, 2011 at 8:47 PM, Jeff King <peff@peff.net> wrote:
>> To me, just "<service>: access denied" is enough. Not particularly
>> friendly but should be a good enough clue.
>
> Yeah, maybe. Certainly it's better than "the remote end hung up
> unexpectedly".
>
> However, the leakage is still there. You would get "the remote hung up"
> for no-such-repo, and "access denied" for this. Or were you just
> proposing that _all_ errors give "access denied". Certainly it's better
> than just hanging up, too, and there is no leakage there.

All of them. At least it's good to know my request has reached (and
rejected by) the server, not dropped on the floor by some random
firewall along the line.

> It might be nice to default to that, and let sites easily enable
> friendlier messages, though.

I'm thinking of passing "verbose" option back to server to get more
helpful messages, the option would be turned off by default. It's up
to admin to decide (would be actually helpful during deployment test,
for example). Or is it possible already?
-- 
Duy
