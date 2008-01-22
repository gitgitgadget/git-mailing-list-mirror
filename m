From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 16:21:06 +1300
Message-ID: <46a038f90801211921j777748cfjf080220e98b01fb6@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
	 <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
	 <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
	 <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org>
	 <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
	 <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
	 <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9hv-0004la-LO
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429AbYAVDVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763162AbYAVDVM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:21:12 -0500
Received: from hu-out-0506.google.com ([72.14.214.233]:49295 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761196AbYAVDVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:21:09 -0500
Received: by hu-out-0506.google.com with SMTP id 19so920912hue.21
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 19:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qVFEfpeEmZEOm0yBmRiAM68k7jxL4BtJyZuaZ+4PSX4=;
        b=oD8qkqN+xbqC1AvXADU8jYRxp4e+4qqoCyOAgoHN0lZffBvtPP1HkoIMLg6fK7vvG8LJQB1mo82+Lsu/zc6o8gGErYe0Mulmo7QtjXzfhaH7dHUJO8xj1nD4d0dFpyOFlxJLO6wsqd+nIAD4smWcF29FP5MUyplM/8AViMT8RPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fyvGsdlCayM18m42J/ALmxYCdxA5V0OkbPA6l7+lunJ3dzU2+6qLtugmR1uoz4xzxNCxuR4YngguxEHFhFcRDidtGbXxLa2gFg4rqaHcJMhefuhyAHsuinx4dIMiifFTvdZqOWbjHbNoxprR0JYh8R3xjozSvGbTNDNj2dN6liw=
Received: by 10.66.250.18 with SMTP id x18mr5469087ugh.79.1200972067031;
        Mon, 21 Jan 2008 19:21:07 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 19:21:06 -0800 (PST)
In-Reply-To: <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71408>

On Jan 22, 2008 4:04 PM, Kevin Ballard <kevin@sb.org> wrote:
> Again, I don't think that's the correct solution. What about the
> translation table that was suggested back at the beginning of the
> thread? That would solve the case insensitivity issue as well, whereas
> this NFC "solution" does nothing for that.

Kevin,

you seem to know the problem fairly well. Could you write up a set of
testcases that show the bug? See the "t" directory in the git sources
-- you don't need to learn much about git internals, they are just
shell scripts (mostly, I think there's some perl there too). That
could lead to a good contribution to the project.

... and keep you from telling everyone else that you know better how
to hack a project that you know nothing about ;-)

(...)
> So, what, you're saying git shouldn't do any work at all to try and
> behave nicer on OS X?

Kevin - for your edification, that question is usually referred to as
"trolling" in this place we call the internet. Linus outlined what his
technical plan is, so git will probably do something designed by
someone who knows a thing or two about git's internals. So when you
pretend that he is saying the opposite of what he is saying... well,
people do get upset.

cheers,


m
