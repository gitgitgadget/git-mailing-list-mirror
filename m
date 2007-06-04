From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Mon, 4 Jun 2007 18:15:48 +0200
Message-ID: <e5bfff550706040915v3689e8afwb3dffd5d4caf137a@mail.gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
	 <200706040921.55861.andyparkins@gmail.com>
	 <e5bfff550706040420j22852e4btc41a88c79bffc49f@mail.gmail.com>
	 <200706041309.54279.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>,
	"Jan Hudec" <bulb@ucw.cz>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvFDs-0004Lq-NU
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbXFDQPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbXFDQPu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:15:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:30415 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbXFDQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 12:15:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1860300wah
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:15:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EfU/KZ3TIW52q/dFkKy4plAPCqWzNGgpA1kVa6QOhOwCcwfSInfb/zI1YSrxj2UYAnGBDZtEqHsA6q/gck6VCVTczd3SBe825K5m5I0DdATxbdW+cy2IVhCknLrXoi0d99bRJDkgGWZUwgXdVtPT8kpDkW86XPgpsREFNguRXRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n1dG9C1pL98o5v2w9B/GnXmzvK9/35GKgcZgToB2MQ0nbfwe6cY/FG3mW36muErpRdCeiRegLCOemspvd/Gzg2Yt+VFHZ0yNfWAV7q1r5mk360q5pIsiXzXpMbN8PLK7duSCiCTgXa8v0OzjiQLO/xEtwNfDVOnnOHve8W8Jz/w=
Received: by 10.115.76.1 with SMTP id d1mr5020718wal.1180973748508;
        Mon, 04 Jun 2007 09:15:48 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 4 Jun 2007 09:15:48 -0700 (PDT)
In-Reply-To: <200706041309.54279.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49113>

On 6/4/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Monday 2007 June 04, Marco Costalba wrote:
>
> > The tabbed widget is here to stay. I do not plan to remove it. But the
> > tabbed widget is also slower then a well behaved scroll swicth or link
> > clicking.
>
> Ah - I've not explained myself clearly.  What I mean is _another_ tab widget,
> instead of the scroll-to-switch.  It can't possibly be slower, as it's the
> same amount of work for Qt...  So it would look like this (excuse rubbish
> ASCII art):
>
>  +-----------------------------+
>  |                             |
>  | <rev list here>             |
>  |                             |
>  |                             |
>  +-----------------------------+
>  | Log | Patch |               |
>  +-----|       |---------------+
>  | <diff goes here>            |
>  |                             |
>  +-----------------------------|
>
> At the moment, you have a label in the top left of the text window that is
> mouse-clicked to change mode; I'm suggesting replacing that with a tab widget
> as above where you mouse click to change mode.  It's no more operations,
> doesn't include a strange floating label and is a more standard and
> recognisable user interface.
>
> If you still wanted up and down buttons, they could very easily go to the far
> right of the log|patch tabs, similar to the "close" button on the top tabs.
>
>
Andy,

  I have to say that I really like your idea!

Now I really don't know what to do!  :-)

Probably I will create a new branch called andy_gui where I'll
implement your idea, while continue to refine the current approach. As
example one enanchment I would like to implement is to keep the labels
normally hidden and show the top (bottom) one only when user scrolls
to the top (bottom) boundary of the view so that we could resolve two
issues: knowing when a scrolling action will cause a switch (i.e. only
when the corresponding label is visible) and do not have the arrows
when not needed.

Another enanchment could be to have only one link per label instead of
two and right clicking on it to show a popup menu with available
alternatives.

Of course at the end there will remain only one! The winner will be,
of course, chosen by a democratic polling among us.


Comments?


Thanks
Marco

P.S: Your approach is simple and good, the only downside is the screen
estate taken by the tab bar. But I agree it's absolutly not a biggie.
